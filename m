Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5A880258F
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Dec 2023 17:39:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9pTZ-00058t-F9; Sun, 03 Dec 2023 11:37:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r9pTX-00058e-9Z; Sun, 03 Dec 2023 11:37:47 -0500
Received: from mailout11.t-online.de ([194.25.134.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1r9pTV-0003zJ-C7; Sun, 03 Dec 2023 11:37:47 -0500
Received: from fwd83.aul.t-online.de (fwd83.aul.t-online.de [10.223.144.109])
 by mailout11.t-online.de (Postfix) with SMTP id 896D73890;
 Sun,  3 Dec 2023 17:37:40 +0100 (CET)
Received: from [192.168.211.200] ([93.236.147.152]) by fwd83.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1r9pTP-0Eagu90; Sun, 3 Dec 2023 17:37:39 +0100
Message-ID: <f084cf3f-f9ad-4810-8ed7-8cc0583a4e47@t-online.de>
Date: Sun, 3 Dec 2023 17:37:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 8.2] ui/gtk-egl: move function calls back to regular
 code path
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Antonio Caggiano <quic_acaggian@quicinc.com>,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 qemu-stable@nongnu.org
References: <20231111104020.26183-1-vr_qemu@t-online.de>
 <CAMxuvayBODa5TnVYxYj5herX9EeWxTteNp3a83z-r9KHyfRHLw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <CAMxuvayBODa5TnVYxYj5herX9EeWxTteNp3a83z-r9KHyfRHLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1701621459-ABFFC99C-4A734DCB/0/0 CLEAN NORMAL
X-TOI-MSGID: 1e3b61ad-a906-4925-b80f-b5a3cf5e668f
Received-SPF: pass client-ip=194.25.134.85; envelope-from=vr_qemu@t-online.de;
 helo=mailout11.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 13.11.23 um 09:26 schrieb Marc-André Lureau:
> Hi
>
> On Sat, Nov 11, 2023 at 2:40 PM Volker Rümelin <vr_qemu@t-online.de> wrote:
>> Commit 6f189a08c1 ("ui/gtk-egl: Check EGLSurface before doing
>> scanout") introduced a regression when QEMU is running with a
>> virtio-gpu-gl-device on a host under X11. After the guest has
>> initialized the virtio-gpu-gl-device, the guest screen only
>> shows "Display output is not active.".
>>
>> Commit 6f189a08c1 moved all function calls in
>> gd_egl_scanout_texture() to a code path which is only called
>> once after gd_egl_init() succeeds in gd_egl_scanout_texture().
>> Move all function calls in gd_egl_scanout_texture() back to
>> the regular code path so they get always called if one of the
>> gd_egl_init() calls was successful.
>>
>> Fixes: 6f189a08c1 ("ui/gtk-egl: Check EGLSurface before doing scanout")
>> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Hi Marc-André,

as the de facto maintainer of the ui directory, could you please send a
pull request for this patch for 8.2-rc3?

With best regards,
Volker

>> ---
>>  ui/gtk-egl.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/ui/gtk-egl.c b/ui/gtk-egl.c
>> index cd2f176502..3af5ac5bcf 100644
>> --- a/ui/gtk-egl.c
>> +++ b/ui/gtk-egl.c
>> @@ -249,14 +249,14 @@ void gd_egl_scanout_texture(DisplayChangeListener *dcl,
>>          if (!vc->gfx.esurface) {
>>              return;
>>          }
>> +    }
>>
>> -        eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>> -                       vc->gfx.esurface, vc->gfx.ectx);
>> +    eglMakeCurrent(qemu_egl_display, vc->gfx.esurface,
>> +                   vc->gfx.esurface, vc->gfx.ectx);
>>
>> -        gtk_egl_set_scanout_mode(vc, true);
>> -        egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
>> -                             backing_id, false);
>> -    }
>> +    gtk_egl_set_scanout_mode(vc, true);
>> +    egl_fb_setup_for_tex(&vc->gfx.guest_fb, backing_width, backing_height,
>> +                         backing_id, false);
>>  }
>>
>>  void gd_egl_scanout_dmabuf(DisplayChangeListener *dcl,
>> --
>> 2.35.3
>>


