function varargout = GUI_breath_analysis5(varargin)
% GUI_BREATH_ANALYSIS5 MATLAB code for GUI_breath_analysis5.fig
%      GUI_BREATH_ANALYSIS5, by itself, creates a new GUI_BREATH_ANALYSIS5
%      that analyzes the nasal flow signal from the .mat files generated
%      from the wrapper function. The sampling frequency is defaulted to
%      40Hz. If needed to be changed, function axis3_indexes.m has to be
%      changed accordingly
%
%      H = GUI_BREATH_ANALYSIS5 returns the handle to a new GUI_BREATH_ANALYSIS5 or the handle to
%      the existing singleton*.
%
%      GUI_BREATH_ANALYSIS5('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_BREATH_ANALYSIS5.M with the given input arguments.
%
%      GUI_BREATH_ANALYSIS5('Property','Value',...) creates a new GUI_BREATH_ANALYSIS5 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_breath_analysis5_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_breath_analysis5_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

%Defined variables:
%      handles.S stores the data loaded from the filename

%      handles.counter = counter; this designates which breath the axis1 is 
%      focusing on

%      handles.type = S.type_cell; this designates the type of the breath
%      of interest

%      handles.window = 30; this is a global variable designating the length of the display
%      window in axis3

%      handles.stage_on    this is the boolean designating wether the stage highlight bar is
       %on or now; stage_on = -1 =>"OFF", 1 =>"ON"
       
%      handles.c_s      this is the coutner of the start breath of axis3
%      used for updating the window

%      handles.c_e      this is the counter for the end breath of axis3
%      used for updating the windwo

% Last Modified by GUIDE v2.5 03-Mar-2015 10:39:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_breath_analysis5_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_breath_analysis5_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUI_breath_analysis5 is made visible.
function GUI_breath_analysis5_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_breath_analysis5 (see VARARGIN)

% Choose default command line output for GUI_breath_analysis5
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_breath_analysis5 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_breath_analysis5_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function textbox1_Callback(hObject, eventdata, handles)
% hObject    handle to textbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox1 as text
%        str2double(get(hObject,'String')) returns contents of textbox1 as a double


% --- Executes during object creation, after setting all properties.
function textbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Textbox2_Callback(hObject, eventdata, handles)
% hObject    handle to Textbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Textbox2 as text
%        str2double(get(hObject,'String')) returns contents of Textbox2 as a double


% --- Executes during object creation, after setting all properties.
function Textbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Textbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.mat', 'Pick a segment');
    if isequal(filename,0) || isequal(pathname,0)
       disp('User pressed cancel')
    else
       %initial setup
       S = load(filename);
       handles.filename = filename;
       %this counts which breath the pointer is on
       counter = 1;
       handles.S=S;
       handles.counter = counter;     
       handles.type = S.type_cell;
       %this is a global variable designating the length of the display
       %window in axis3
       handles.window = 30;
       %this is the boolean designating wether the stage highlight bar is
       %on or now
       handles.stage_on = 0; % stage_on = -1 =>"OFF", 1 =>"ON"
       
       %set textbox
       set(handles.textbox1, 'String', length(S.t_cell));
       set(handles.Textbox2, 'String', counter);
       set(handles.textbox4, 'String', handles.window);
       
       %set listbox
       if strcmp(handles.type(counter),'Unknown')
           v = 1;
       elseif strcmp(handles.type(counter),'Normal')
           v = 2;
       elseif strcmp(handles.type(counter),'Intermediate')
           v = 3;
       else
           v = 4;
       end
       
       set(handles.listbox1,'Value',v);
       
       %set axes1
       axes(handles.axes1);       
       plot(S.t_cell{counter},S.p_cell{counter})
       ylim([0,max(S.p_cell{counter})]);
              
       %set axes 3
       axes(handles.axes3);  
       [i_s,i_e,~,c_e] = axis3_indexes(S.t,counter,handles.window,S.t_cell,0);%c_e is the end counter
       %zero pad the time axis to make the window display consistent
       [t_out,p_out] = zero_pad(S.t(i_s:i_e),S.p(i_s:i_e),handles.window,1);
       plot(t_out, p_out) %plot half of a minute of data
       %get the max y value so that the vertical bar can be established
       ylim([0,max(p_out)]);
       yL = get(gca,'YLim');
       %plot the red vertical bar designating the point of interst
       line([S.t_cell{counter}(round(end/2)),S.t_cell{counter}(round(end/2))],[yL(1),yL(2)],'Color','r','LineWidth',2);
       %plot the horizontal bar designating the zero flow line
       hline = refline(0,0); %plot reference line at 0
       set(hline,'Color','k')
       axis tight
       %update the counters 
       handles.c_e = c_e;
       handles.c_s = 1;
    end
    
    % Update handles structure
    guidata(hObject, handles);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO): this is used to decrement
% the breath. and if necessary, make new plot on axis3. 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
counter = handles.counter;
counter = counter -1;
S = handles.S;

if counter == 0
    ME = MException('This is the beginning already, try something else');
    throw(ME);
else
    axes(handles.axes1);
    plot(S.t_cell{counter},S.p_cell{counter});
    ylim([0,max(S.p_cell{counter})]);
    set(handles.Textbox2, 'String', counter);
    if strcmp(handles.type(counter),'Unknown')
        v = 1;
    elseif strcmp(handles.type(counter),'Normal')
        v = 2;
    elseif strcmp(handles.type(counter),'Intermediate')
        v = 3;
    else
        v = 4;
    end
    set(handles.listbox1,'Value',v);
    %label the current waveform
    axes(handles.axes3);
     yL = get(gca,'YLim');

     if counter >= handles.c_s
        line([S.t_cell{counter}(round(end/2)),S.t_cell{counter}(round(end/2))],[yL(1),yL(2)],'Color','r','LineWidth',2);
        line([S.t_cell{counter+1}(round(end/2)),S.t_cell{counter+1}(round(end/2))],[yL(1),yL(2)],'Color',[1,1,1],'LineWidth',2);
     else
        [i_s,i_e,c_s,c_e] = axis3_indexes(S.t,counter,handles.window,S.t_cell,-1);
        [t_out,p_out] = zero_pad(S.t(i_s:i_e),S.p(i_s:i_e),handles.window,2);
        plot(t_out, p_out) %plot half of a minute of data
        ylim([0,max(p_out)])
        yL = get(gca,'YLim');
        line([S.t_cell{counter}(round(end/2)),S.t_cell{counter}(round(end/2))],[yL(1),yL(2)],'Color','r','LineWidth',2);
        hline = refline(0,0); %plot reference line at 0
        set(hline,'Color','k');
        axis tight
        handles.c_s = c_s;
        handles.c_e = c_e;
    end
end

handles.counter = counter;
guidata(hObject, handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
counter = handles.counter;
counter = counter + 1;
S = handles.S;


if counter > length(S.t_cell)
    ME = MException('out of range');
    throw(ME)
else
    axes(handles.axes1);
    plot(S.t_cell{counter},S.p_cell{counter});
    ylim([0,max(S.p_cell{counter})]);    
    set(handles.Textbox2, 'String', counter);
    
    %determine the value of the list box, returning 1 if the first entry, 2
    % the second, and so on
    if strcmp(handles.type(counter),'Unknown')
        v = 1;
    elseif strcmp(handles.type(counter),'Normal')
        v = 2;
    elseif strcmp(handles.type(counter),'Intermediate')
        v = 3;
    else
        v = 4;
    end
    set(handles.listbox1,'Value',v);
    %label the current waveform
    axes(handles.axes3);
    yL = get(gca,'YLim');
    %plot the vertical bar to indicate the current wave
    %check if the vertical bar goes out of the window
    if counter < handles.c_e
        line([S.t_cell{counter}(round(end/2)),S.t_cell{counter}(round(end/2))],[yL(1),yL(2)],'Color','r','LineWidth',2);
        line([S.t_cell{counter-1}(round(end/2)),S.t_cell{counter-1}(round(end/2))],[yL(1),yL(2)],'Color',[1,1,1],'LineWidth',2);
    else
        [i_s,i_e,c_s,c_e] = axis3_indexes(S.t,counter,handles.window,S.t_cell,1);
        [t_out,p_out] = zero_pad(S.t(i_s:i_e),S.p(i_s:i_e),handles.window,1);
        plot(t_out, p_out) %plot half of a minute of data
        ylim([0,max(p_out)])
        yL = get(gca,'YLim');
        line([S.t_cell{counter}(round(end/2)),S.t_cell{counter}(round(end/2))],[yL(1),yL(2)],'Color','r','LineWidth',2);
        hline = refline(0,0); %plot reference line at 0
        set(hline,'Color','k');
        axis tight
        handles.c_s = c_s;
        handles.c_e = c_e;
    end
end

handles.counter = counter;
guidata(hObject, handles);


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO): this is used to display the
% type of the breath being analysed
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1
v = get(handles.listbox1,'Value');
if v==1
    handles.type{handles.counter} = 'Unknown';
elseif v==2
    handles.type{handles.counter} = 'Normal';
elseif v==3
    handles.type{handles.counter} = 'Intermediate';    
else 
    handles.type{handles.counter} = 'Flattened';
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO): this is used to save the
% annotated results
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
filename = handles.filename;
type_cell = handles.type;
save(filename,'type_cell','-append');
guidata(hObject,handles);


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
t_value = get(handles.textbox3,'String');
t_value = str2num(t_value);
S = handles.S;
%check if fallen in the range
if t_value < S.t(1) || t_value > S.t(end)
        disp('out of range');
else
    for ii = 1:length(S.t_cell)
        temp = S.t_cell{ii};
        if ~isempty(temp)&&temp(1)>t_value           
            axes(handles.axes1);       
            plot(S.t_cell{ii-1},S.p_cell{ii-1})
            %ylim([0,max(S.p_cell{ii})]);
            %update type and current number
            handles.counter = ii;
            v = v_listbox(handles.type(ii));
            set(handles.listbox1,'Value',v);
            set(handles.Textbox2, 'String', ii);            
            break
        end
    end
end
guidata(hObject,handles);

function textbox3_Callback(hObject, eventdata, handles)
% hObject    handle to textbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox3 as text
%        str2double(get(hObject,'String')) returns contents of textbox3 as a double


% --- Executes during object creation, after setting all properties.
function textbox3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO): this is the scale bar used to
% scale up or down the window size
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
slider_value = get(handles.slider1,'Value');
window = 7.5*slider_value + 15;
handles.window = window;
set(handles.textbox4,'String',window);
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);    
end



function textbox4_Callback(hObject, eventdata, handles)
% hObject    handle to textbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textbox4 as text
%        str2double(get(hObject,'String')) returns contents of textbox4 as a double


% --- Executes during object creation, after setting all properties.
function textbox4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

