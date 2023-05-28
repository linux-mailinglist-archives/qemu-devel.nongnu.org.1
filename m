Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B16EB713B5E
	for <lists+qemu-devel@lfdr.de>; Sun, 28 May 2023 19:44:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3KQh-0008SW-0A; Sun, 28 May 2023 13:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q3KQc-0008S7-0H
 for qemu-devel@nongnu.org; Sun, 28 May 2023 13:43:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1q3KQa-000329-58
 for qemu-devel@nongnu.org; Sun, 28 May 2023 13:43:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8853D8F2E;
 Sun, 28 May 2023 20:43:33 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 148B17F78;
 Sun, 28 May 2023 20:43:33 +0300 (MSK)
Message-ID: <25c2b472-eb1a-b5c3-2ff4-f47136a91525@tls.msk.ru>
Date: Sun, 28 May 2023 20:43:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/19] Ui patches
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, berrange@redhat.com,
 Eric Blake <eblake@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>, Erico Nunes <ernunes@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, =?UTF-8?Q?Volker_R=c3=bcmelin?=
 <vr_qemu@t-online.de>
References: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230528132016.3218152-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.093,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

28.05.2023 16:19, marcandre.lureau@redhat.com wrote:
> 
>    https://gitlab.com/marcandre.lureau/qemu.git tags/ui-pull-request
> 
> ----------------------------------------------------------------
> UI queue
> 
> - virtio: add virtio-multitouch device
> - sdl: various keyboard grab fixes
> - gtk: enable multi-touch events
> - misc fixes

 From the patch description it looks like quite a few patches should be
applied to -stable:

01/19 ui/gtk: fix passing y0_top parameter to scanout
02/19 ui/gtk: use widget size for cursor motion event
03/19 ui/gtk-egl: fix scaling for cursor position in scanout mode
04/19 ui/sdl2: fix surface_gl_update_texture: Assertion 'gls' failed
05/19 ui/dbus: fix compilation when GBM && !OPENGL
10/19 ui/sdl2: Grab Alt+Tab also in fullscreen mode
11/19 ui/sdl2: Grab Alt+F4 also under Windows
12/19 ui/sdl2: disable SDL_HINT_GRAB_KEYBOARD on Windows

This one is questionable because while it (apparently) fixes an issue,
it uses somewhat undocumented way to do that:

06/19 win32: wrap socket close() with an exception handler

Am I right about the -stable thing?

Please add "Cc: qemu-stable@nongnu.org" tag for subsequent patches
which you think are worth to backport to previous/stable qemu release(s).

Thanks!

/mjt

> ----------------------------------------------------------------
> 
> Bernhard Beschow (2):
>    ui/sdl2: Grab Alt+Tab also in fullscreen mode
>    ui/sdl2: Grab Alt+F4 also under Windows
> 
> Erico Nunes (3):
>    ui/gtk: fix passing y0_top parameter to scanout
>    ui/gtk: use widget size for cursor motion event
>    ui/gtk-egl: fix scaling for cursor position in scanout mode
> 
> Marc-André Lureau (6):
>    ui/sdl2: fix surface_gl_update_texture: Assertion 'gls' failed
>    ui/dbus: fix compilation when GBM && !OPENGL
>    win32: wrap socket close() with an exception handler
>    virtio-gpu: add a FIXME for virtio_gpu_load()
>    gtk: add gl-area support on win32
>    ui/dbus: add a FIXME about texture/dmabuf scanout handling
> 
> Mauro Matteo Cascella (1):
>    ui/cursor: make width/height unsigned 16-bit integer
> 
> Sergio Lopez (6):
>    virtio-input: generalize virtio_input_key_config()
>    ui: add the infrastructure to support MT events
>    virtio-input: add a virtio-mulitouch device
>    virtio-input-pci: add virtio-multitouch-pci
>    ui: add helpers for virtio-multitouch events
>    ui/gtk: enable backend to send multi-touch events
> 
> Volker Rümelin (1):
>    ui/sdl2: disable SDL_HINT_GRAB_KEYBOARD on Windows
> 



