Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC67727ED8
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 13:33:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7DsK-0004H1-H2; Thu, 08 Jun 2023 07:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7DsI-0004Gs-FM
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 07:32:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quic_acaggian@quicinc.com>)
 id 1q7DsG-0000n4-8A
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 07:32:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 358BQYWL031842; Thu, 8 Jun 2023 11:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cKT+ART2RF2Gz1+y4NZQXZD/QkLZUSckgM0o1hRAFmg=;
 b=Jac/rPE3IqxWXoVuMDlvzXHfECsdaO8icESFK1ALVbHhR4SX8LrXqTPh/I1/+ck5YOhC
 uPDbczCSJY9LJOUQiIQUGPdKPlUp9BsgBUptl9uJ2zMBUY4WSnampnYo2ivDcKtG1zO7
 Tf0alYmsdXpQPjilS9fm90JZEufWno1lmca6MJCXkM0DemV9xwBlKG2fvi6kuKF25I66
 oq8n/7RN7s39P4NiKorOtqHf3CiMSz3y4H5g/L7v34xYCT89l/IjrIsU3rGZOVT1eJdp
 DuQdEDOnAQXmiy8j2hoHvr8gSt1SPWEOkRlHHy6HUotkZF0aTZhNlaPn0yAWgDlRrJd0 2w== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3r36pdruah-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Jun 2023 11:32:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com
 [10.47.97.35])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 358BWCsk028641
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 Jun 2023 11:32:12 GMT
Received: from [10.251.41.210] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 8 Jun 2023
 04:32:10 -0700
Message-ID: <f64e93e3-20d2-06a8-3784-999087ea6996@quicinc.com>
Date: Thu, 8 Jun 2023 13:32:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH] ui/sdl2: Allow high-dpi
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
CC: <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
References: <20230607090434.53682-1-quic_acaggian@quicinc.com>
 <CAMxuvaxGSdtO-i+ktzE3YpndfuhWCDoR6JqEoautt10adGXndg@mail.gmail.com>
From: Antonio Caggiano <quic_acaggian@quicinc.com>
In-Reply-To: <CAMxuvaxGSdtO-i+ktzE3YpndfuhWCDoR6JqEoautt10adGXndg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: B4eYcyGTsdXQjC6wbAiKkWqrgF12o4S_
X-Proofpoint-ORIG-GUID: B4eYcyGTsdXQjC6wbAiKkWqrgF12o4S_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_08,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080099
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=quic_acaggian@quicinc.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Marc-André,

On 07/06/2023 12:21, Marc-André Lureau wrote:
> Hi Antonio
> 
> On Wed, Jun 7, 2023 at 1:05 PM Antonio Caggiano <quic_acaggian@quicinc.com>
> wrote:
> 
>> Add the SDL_WINDOW_ALLOW_HIGHDPI flag when creating a window and get the
>> drawable size instead of the window size when setting up the framebuffer
>> and the viewport.
>>
>>
> What does this actually change?

The sdl2-gl backend does not work properly on high-DPI windows. [0]
My understanding is that by allowing high-DPI, SDL creates a framebuffer 
with the right size in pixels which might be different than the size of 
the window. [1]
I believe we just need to use the framebuffer size for GL viewport and 
texture, by retrieving it with SDL_GL_GetDrawableSize.

> What about non-gl display, Mouse motion, and display resize?

 From what I can see by testing the SDL2 renderer, it seems to handle 
all of this transparently, so there is nothing we need to do in sdl2-2d.

Same for mouse motion, which I believe is using window "screen coordinates".

Display resize is a bit weird for a bunch of frames, but then it fixes 
itself.

[0] 
https://user-images.githubusercontent.com/6058008/244368628-329241dc-267d-452f-b8ce-816ae1623131.png
[1] https://wiki.libsdl.org/SDL2/SDL_GetWindowSize#remarks

> 
> thanks
> 
> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
>> ---
>>   ui/sdl2-gl.c | 4 ++--
>>   ui/sdl2.c    | 2 +-
>>   2 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/ui/sdl2-gl.c b/ui/sdl2-gl.c
>> index bbfa70eac3..251b7d56d6 100644
>> --- a/ui/sdl2-gl.c
>> +++ b/ui/sdl2-gl.c
>> @@ -53,7 +53,7 @@ static void sdl2_gl_render_surface(struct sdl2_console
>> *scon)
>>       SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>>       sdl2_set_scanout_mode(scon, false);
>>
>> -    SDL_GetWindowSize(scon->real_window, &ww, &wh);
>> +    SDL_GL_GetDrawableSize(scon->real_window, &ww, &wh);
>>       surface_gl_setup_viewport(scon->gls, scon->surface, ww, wh);
>>
>>       surface_gl_render_texture(scon->gls, scon->surface);
>> @@ -239,7 +239,7 @@ void sdl2_gl_scanout_flush(DisplayChangeListener *dcl,
>>
>>       SDL_GL_MakeCurrent(scon->real_window, scon->winctx);
>>
>> -    SDL_GetWindowSize(scon->real_window, &ww, &wh);
>> +    SDL_GL_GetDrawableSize(scon->real_window, &ww, &wh);
>>       egl_fb_setup_default(&scon->win_fb, ww, wh);
>>       egl_fb_blit(&scon->win_fb, &scon->guest_fb, !scon->y0_top);
>>
>> diff --git a/ui/sdl2.c b/ui/sdl2.c
>> index 9d703200bf..c9c83815ca 100644
>> --- a/ui/sdl2.c
>> +++ b/ui/sdl2.c
>> @@ -95,7 +95,7 @@ void sdl2_window_create(struct sdl2_console *scon)
>>       }
>>   #ifdef CONFIG_OPENGL
>>       if (scon->opengl) {
>> -        flags |= SDL_WINDOW_OPENGL;
>> +        flags |= SDL_WINDOW_OPENGL | SDL_WINDOW_ALLOW_HIGHDPI;
>>       }
>>   #endif
>>
>> --
>> 2.40.0
>>
>>
> 

Cheers,
Antonio

