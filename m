Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B69C9C2DCE
	for <lists+qemu-devel@lfdr.de>; Sat,  9 Nov 2024 15:41:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9mdD-0006W2-E8; Sat, 09 Nov 2024 09:40:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t9mdA-0006Ub-L1
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 09:40:04 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1t9md8-0005Vm-Cr
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 09:40:04 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1731163188; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UTWWUE9lj2hSujBncoF17jMhQ49YIMABbjGu4Km0ugRHXrP0AZMzgattFLz8jH+sj9QCIsmZ4ieU+QeAg4hG0X6R8kWssGX+0Js7Qx8QF/ym9IfoA2ZK8q754SM1r4GFfIMrY0DIlJNeETovIAXIigRBQegUqXiuZnXkYuZ494s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1731163188;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1/yNvL5S0IL/Uno4KjIuBfsocAtPnFQxRkrpX/xr5U8=; 
 b=CYofPBpQdM6AQlQOxG4uU82kOFMEqZZOjDomZupTL0868LQVXBYE++pGTTR3jrW4fSjNR/KzNQqq7qx3ZtyjLqT3X4uJ+3n2GTM0knUtAQUHb95PycCi7BA6tiO2jbYzYzWKoHNT68WRylZ1UpyzNrleGPfuf4sKYL7tjkFHCYs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731163188; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=1/yNvL5S0IL/Uno4KjIuBfsocAtPnFQxRkrpX/xr5U8=;
 b=iVqrbe79nU1NKxoB1m2pn3q+hI5rzsD6MrsbtgGY2rqua/+8rd1bQ1kmldc+Zi5B
 markeZ5FcLIkuc8/dBBrSTGP1+bWCBHez/DrI8JWvxGrgJi3zVxYQb1Fk5p9gSo2jwe
 EfxDta0g5KTgCQBjKQ/AXcIgRBRwSr9a1gf4xqwU=
Received: by mx.zohomail.com with SMTPS id 1731163187010703.8894353999366;
 Sat, 9 Nov 2024 06:39:47 -0800 (PST)
Message-ID: <88efab50-c925-4f0d-9b40-fbde2a049810@collabora.com>
Date: Sat, 9 Nov 2024 17:39:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] ui/sdl2: Implement dpy dmabuf functions
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Alyssa Ross <hi@alyssa.is>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stefano Stabellini <stefano.stabellini@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Honglei Huang <honglei1.huang@amd.com>, Julia Zhang <julia.zhang@amd.com>,
 Chen Jiqian <Jiqian.Chen@amd.com>, Rob Clark <robdclark@gmail.com>,
 Yiwei Zhang <zzyiwei@chromium.org>, Sergio Lopez Pascual <slp@redhat.com>
References: <20241024233355.136867-1-dmitry.osipenko@collabora.com>
 <20241024233355.136867-3-dmitry.osipenko@collabora.com>
 <d800f856-cdf4-4573-8fd6-6a8e1434090a@daynix.com>
 <5494be03-9bdb-4ec4-8c45-2c92f7591ae1@collabora.com>
 <3d027b41-f0c7-4807-934c-395bfe507e09@daynix.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <3d027b41-f0c7-4807-934c-395bfe507e09@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/9/24 13:07, Akihiko Odaki wrote:
> On 2024/11/09 15:52, Dmitry Osipenko wrote:
>> Accidentally missed this email a week ago. Thanks again for all the
>> reviews!
>>
>> On 10/31/24 10:32, Akihiko Odaki wrote:
>> ...
>>>>    +# libx11 presents together with SDL or GTK libs on systems that
>>>> support X11
>>>> +xlib = dependency('x11', required: false)
>>>
>>> There is a line saying:
>>> x11 = dependency('x11', method: 'pkg-config', required: gtkx11.found())
>>>
>>> Please reuse it.
>>
>> I've seen this option and choose not to use it because despite the brief
>> 'X11' name, it's about X11 support specifically for GTK and not SDL.
>>
>> Though, we can use this GTK/X11 for now and improve Meson dependencies
>> later on because in practice GTK is enabled for all distro-built QEMUs.
>> Will switch to it in v3.
> 
> I think you can just remove "if gtkx11.found()" to use it for SDL.

Right, thanks.

>> ...
>>>>    +static void sdl2_set_hint_x11_force_egl(void)
>>>> +{
>>>> +#if defined(SDL_HINT_VIDEO_X11_FORCE_EGL) && defined(CONFIG_OPENGL)
>>>> && \
>>>> +    defined(CONFIG_XLIB)
>>>> +    Display *x_disp = XOpenDisplay(NULL);
>>>> +    EGLDisplay egl_display;
>>>> +
>>>> +    if (!x_disp) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    /* Prefer EGL over GLX to get dma-buf support. */
>>>> +    egl_display = eglGetDisplay((EGLNativeDisplayType)x_disp);
>>>> +
>>>> +    if (egl_display != EGL_NO_DISPLAY) {
>>>> +        /*
>>>> +         * Setting X11_FORCE_EGL hint doesn't make SDL to prefer 11
>>>> over
>>>
>>> s/prefer 11 over/prefer X11 over/
>>>
>>> Personally, I'm more concerned whether setting that hint will make an
>>> invalid argument error or something.
>>
>> There are no known side effects from setting that hint for QEMU and
>> libsdl code looks sane. AFAICT, EGL is not enabled by default in SDL
>> only because there are older SDL applications that use GLX features and
>> they will be broken if SDL will switch to EGL by default.
>> > Technically, should be possible to make SDL use EGL on demand, like
> only
>> when QEMU runs with enabled native-context for example. But there is no
>> point in doing that today since there are no known problems with the EGL
>> hint, IMO. We will be able to address problems if somebody will report a
>> bug.
>>
> 
> I was thinking of scenarios where X11 is not used. A convincing scenario
>  of failure is that SDL emits an error for the flag and stops working.
> The fact that this code just works implies it is not the case, but it's
> worth noting if you leave a comment anyway.

We check X11 presence using XOpenDisplay() and hint won't be set if Xorg
is unavailable.

For the case of XWayland, there is already a comment in this patch
telling that flag has no effect on Wayland. Will extend this comment,
thanks.

-- 
Best regards,
Dmitry

