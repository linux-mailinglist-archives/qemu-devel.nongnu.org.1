Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 968A47E826C
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 20:27:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1X9C-0003yR-Ox; Fri, 10 Nov 2023 14:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r1X99-0003yE-VN
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 14:26:27 -0500
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r1X97-0006No-Tb
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 14:26:27 -0500
Received: from fwd72.aul.t-online.de (fwd72.aul.t-online.de [10.223.144.98])
 by mailout05.t-online.de (Postfix) with SMTP id 2A333AA0A;
 Fri, 10 Nov 2023 20:25:51 +0100 (CET)
Received: from [192.168.211.200] ([93.236.156.187]) by fwd72.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1r1X8Y-16QQXh0; Fri, 10 Nov 2023 20:25:50 +0100
Message-ID: <a7d86b70-a6d4-4329-9ce5-065e59016e32@t-online.de>
Date: Fri, 10 Nov 2023 20:25:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/5] ui/gtk-egl: Check EGLSurface before doing scanout
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org
References: <20231107093035.2746581-1-marcandre.lureau@redhat.com>
 <20231107093035.2746581-3-marcandre.lureau@redhat.com>
 <70f25677-768c-4e64-9f14-36264fb6dcce@t-online.de>
Content-Language: en-US
In-Reply-To: <70f25677-768c-4e64-9f14-36264fb6dcce@t-online.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1699644350-3B7FD95D-C62E97D5/0/0 CLEAN NORMAL
X-TOI-MSGID: 5ed42aa8-69f0-449b-b003-a0e932db2ee6
Received-SPF: pass client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

>> From: Antonio Caggiano <quic_acaggian@quicinc.com>
>>
>> The first time gd_egl_scanout_texture() is called, there's a possibility
>> that the GTK drawing area might not be realized yet, in which case its
>> associated GdkWindow is NULL. This means gd_egl_init() was also skipped
>> and the EGLContext and EGLSurface stored in the VirtualGfxConsole are
>> not valid yet.
>>
>> Continuing with the scanout in this conditions would result in hitting
>> an assert in libepoxy: "Couldn't find current GLX or EGL context".
>>
>> A possible workaround is to just ignore the scanout request, giving the
>> the GTK drawing area some time to finish its realization. At that point,
>> the gd_egl_init() will succeed and the EGLContext and EGLSurface stored
>> in the VirtualGfxConsole will be valid.
>>
>> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
>> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Message-Id: <20231016123215.2699269-1-quic_acaggian@quicinc.com>
>> ---
>>  ui/gtk-egl.c | 17 ++++++++++++-----
>>  1 file changed, 12 insertions(+), 5 deletions(-)
> Hi Antonio,
>
> this patch breaks the QEMU guest display on my system. QEMU was started
> with ./qemu-system-x86_64 -machine q35 -device
> virtio-vga-gl,xres=1280,yres=768 -display gtk,zoom-to-fit=off,gl=on. I
> can see the OVMF boot screen and then GRUB. After Linux was started,
> plymouth normally shows the OVMF boot logo and a rotating spinner. With
> your patch the guest screen is black and shows 'Display output is not
> active.'. It seems the guest works without issues. I can use ssh to log
> in and I can't find any obvious errors in the guest log files. The host
> uses a GNOME desktop under X11.
>
> If I revert this patch everything works as expected.
>
> With best regards,
> Volker
>
> Cc: Michael Tokarev
> This will affect Stable-7.2.7 and Stable-8.1.3.
>
>> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>> index a1060fd80f..3e8d1c1d02 100644
>> --- a/ui/gtk-egl.c
>> +++ b/ui/gtk-egl.c
>> @@ -243,12 +243,19 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
>>      vc->gfx.h = h;
>>      vc->gfx.y0_top = backing_y_0_top;
>>  
>> -    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>> -                   vc->gfx.esurface, vc->gfx.ectx);
>> +    if (!vc->gfx.esurface) {
>> +        gd_egl_init(vc);
>> +        if (!vc->gfx.esurface) {
>> +            return;
>> +        }
>> +
>> +        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>> +                       vc->gfx.esurface, vc->gfx.ectx);
>>  
>> -    gtk_egl_set_scanout_mode(vc, true);
>> -    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
>> -                         backing_id, false);
>> +        gtk_egl_set_scanout_mode(vc, true);
>> +        egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
>> +                             backing_id, false);
>> +    }
>>  }
>>  
>>  void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,

I can see the mistake. I'll write a patch to fix it.

With best regards,
Volker




