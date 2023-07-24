Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3A75FD83
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 19:24:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNzHx-0002O9-0p; Mon, 24 Jul 2023 13:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qNzHu-0002Nl-L8
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:24:02 -0400
Received: from mailout06.t-online.de ([194.25.134.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1qNzHs-0006EV-GN
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 13:24:02 -0400
Received: from fwd87.dcpf.telekom.de (fwd87.aul.t-online.de [10.223.144.113])
 by mailout06.t-online.de (Postfix) with SMTP id 6AA6F13BBD;
 Mon, 24 Jul 2023 19:23:55 +0200 (CEST)
Received: from [192.168.211.200] ([79.208.26.246]) by fwd87.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1qNzHj-0BW80n0; Mon, 24 Jul 2023 19:23:51 +0200
Message-ID: <21be961c-27dc-c8c2-5d3d-f12d9fa53eb5@t-online.de>
Date: Mon, 24 Jul 2023 19:23:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 06/19] ui/gtk: set scanout-mode right before scheduling draw
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20230717124545.177236-1-marcandre.lureau@redhat.com>
 <20230717124545.177236-7-marcandre.lureau@redhat.com>
 <b0edec9a-e3a4-edad-c492-a71dc78d7253@t-online.de>
 <282e81f9-6521-4225-7ee5-1ae84cdf31e2@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
In-Reply-To: <282e81f9-6521-4225-7ee5-1ae84cdf31e2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1690219431-FCEFC704-A6FA3B3B/0/0 CLEAN NORMAL
X-TOI-MSGID: 271c2d2c-55e8-4d17-8dfe-4f9f70993f58
Received-SPF: none client-ip=194.25.134.19; envelope-from=vr_qemu@t-online.de;
 helo=mailout06.t-online.de
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

Am 24.07.23 um 06:47 schrieb Kim, Dongwon:
> Hi there,
>
> I guess removing this line would have been causing the problem. Can 
> you add this line back and test it?
>
> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
> index eee821d73a..98b3a116bf 100644
> --- a/ui/gtk-egl.c
> +++ b/ui/gtk-egl.c
> @@ -242,7 +242,6 @@ void gd_egl_scanout_texture(DisplayChangeListener 
> *dcl,
>       eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>                      vc->gfx.esurface, vc->gfx.ectx);
>   -    gtk_egl_set_scanout_mode(vc, true);
>       egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, 
> backing_height,
>                            backing_id, false);
>   }
>
> Thanks!
>

Adding back this line fixes the black guest screen when running the host 
under X11. For Wayland I had to add back the similar line in 
ui/gtk-gl-area.c.

With best regards,
Volker

> On 7/20/2023 11:53 PM, Volker Rümelin wrote:
>> Am 17.07.23 um 14:45 schrieb marcandre.lureau@redhat.com:
>>> From: Dongwon Kim<dongwon.kim@intel.com>
>>>
>>> Setting scanout mode is better to be done very last minute
>>> right because the mode can be reset anytime after it is set in
>>> dpy_gl_scanout_texture by any asynchronouse dpy_refresh call,
>>> which eventually cancels drawing of the guest scanout texture.
>>
>> Hi Dongwon,
>>
>> this patch breaks the QEMU guest display on my system. QEMU was 
>> started with ./qemu-system-x86_64 -machine q35 -device 
>> virtio-vga-gl,xres=1280,yres=768 -display gtk,zoom-to-fit=off,gl=on. 
>> I can see the OVMF boot screen and then GRUB. After Linux was 
>> started, plymouth normally shows the OVMF boot logo and a rotating 
>> spinner. With your patch the guest screen stays black and I see a 
>> text cursor in the upper left corner. It seems the guest works 
>> without issues. I can use ssh to log in and I can't find any obvious 
>> errors in the guest log files. I tested on a host GNOME desktop under 
>> X11 and again under Wayland. In both cases the result is a black 
>> guest screen.
>>
>> With best regards,
>> Volker
>>
>>> Cc: Gerd Hoffmann<kraxel@redhat.com>
>>> Cc: Marc-André Lureau<marcandre.lureau@redhat.com>
>>> Cc: Vivek Kasireddy<vivek.kasireddy@intel.com>
>>> Signed-off-by: Dongwon Kim<dongwon.kim@intel.com>
>>> Acked-by: Marc-André Lureau<marcandre.lureau@redhat.com>
>>> Message-ID:<20230706183355.29361-1-dongwon.kim@intel.com>
>>> ---
>>>   ui/gtk-egl.c     | 2 +-
>>>   ui/gtk-gl-area.c | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>>> index eee821d73a..98b3a116bf 100644
>>> --- a/ui/gtk-egl.c
>>> +++ b/ui/gtk-egl.c
>>> @@ -242,7 +242,6 @@ void 
>>> gd_egl_scanout_texture(DisplayChangeListener *dcl,
>>>       eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>>>                      vc->gfx.esurface, vc->gfx.ectx);
>>>   -    gtk_egl_set_scanout_mode(vc, true);
>>>       egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, 
>>> backing_height,
>>>                            backing_id, false);
>>>   }
>>> @@ -353,6 +352,7 @@ void gd_egl_flush(DisplayChangeListener *dcl,
>>>       if (vc->gfx.guest_fb.dmabuf && 
>>> !vc->gfx.guest_fb.dmabuf->draw_submitted) {
>>>           graphic_hw_gl_block(vc->gfx.dcl.con, true);
>>>           vc->gfx.guest_fb.dmabuf->draw_submitted = true;
>>> +        gtk_egl_set_scanout_mode(vc, true);
>>>           gtk_widget_queue_draw_area(area, x, y, w, h);
>>>           return;
>>>       }
>>> diff --git a/ui/gtk-gl-area.c b/ui/gtk-gl-area.c
>>> index 4513d3d059..28d9e49888 100644
>>> --- a/ui/gtk-gl-area.c
>>> +++ b/ui/gtk-gl-area.c
>>> @@ -264,7 +264,6 @@ void 
>>> gd_gl_area_scanout_texture(DisplayChangeListener *dcl,
>>>           return;
>>>       }
>>>   -    gtk_gl_area_set_scanout_mode(vc, true);
>>>       egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, 
>>> backing_height,
>>>                            backing_id, false);
>>>   }
>>> @@ -284,6 +283,7 @@ void 
>>> gd_gl_area_scanout_flush(DisplayChangeListener *dcl,
>>>       if (vc->gfx.guest_fb.dmabuf && 
>>> !vc->gfx.guest_fb.dmabuf->draw_submitted) {
>>>           graphic_hw_gl_block(vc->gfx.dcl.con, true);
>>>           vc->gfx.guest_fb.dmabuf->draw_submitted = true;
>>> +        gtk_gl_area_set_scanout_mode(vc, true);
>>>       }
>>> gtk_gl_area_queue_render(GTK_GL_AREA(vc->gfx.drawing_area));
>>>   }
>>


