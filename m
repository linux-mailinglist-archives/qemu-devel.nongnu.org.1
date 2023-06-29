Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A165742247
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 10:35:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEn7d-000549-8U; Thu, 29 Jun 2023 04:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEn7Z-00052G-3a
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:35:21 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEn7X-00079H-7M
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 04:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BioDtAbl64WLDKUchyQIuzmyV6lgIE1fJtVAZhMKS5g=; b=Ro1cbSmuq/656nTEAgB76VGOc7
 ie1Q+BIXI0IqZPBLHxVm0ITN5KApMBH3coKjDPMYn+0uaHQvvv8bywYpHRX2lZ5vw8l0mX1Sx/2Xj
 P7BVfJQbfkxR08H84xVOc0Pq8+FOAF50T6DUv7TiItYBZdTKXM73broyLPlxuYORoLuakPi5UzOWe
 4WPpv1pGuod1b3zrucHI6T9JrVdGmD7Q+m39dBKJmBBODrARN0BtYhMkW8XPAseszMIm6Zzsyo8OS
 VM1tVELQYM2/456lL5mjazJ/0+LWAZ/7zYoK+hh3oH1ETY+xbLO4KcwCtN7lA4Y42m57QqMAvgBq2
 AAgubq6bkCCBm9yd8sAmMgYa4BLa/fsw3NeMJ7YMbDf5lOCIc0Rq9RjTZhr0jmq8AUPgKi4cGy62f
 WDYOlJfU74o9BS1yhGVJpiJKetwSKgkXBlV2RgJXGGew4uF8P9W9YTZfZqqSwUhb+9XpSSN47qZe9
 yyTODFwdOQHaECRaKThpYgdO8z9rHpqeggl+P0B8Tx8iTu8HXKxKvAdFRanhcuPn5hXYA2HpKFVgb
 HazHDBVOMrGiA+XwAKwGCBEE+ul2ZKfrLx2K36o3PwpaI4Kvvdl5TbS5OOmjD35GfqDwIGGpkZNAG
 /viimgq77olcWYQ783Q+q/gCEUr+xz5nxTFf7FfHI=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=[10.8.0.6])
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qEn7L-000AgK-L2; Thu, 29 Jun 2023 09:35:08 +0100
Message-ID: <4128426b-0737-9fa1-b69a-8d3021ca1711@ilande.co.uk>
Date: Thu, 29 Jun 2023 09:35:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
References: <20230627130231.1614896-1-marcandre.lureau@redhat.com>
 <20230627130231.1614896-34-marcandre.lureau@redhat.com>
 <8d3e6b12-80d1-8900-3b1f-115be40f1fb1@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <8d3e6b12-80d1-8900-3b1f-115be40f1fb1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PULL 33/33] ui/dbus: use shared D3D11 Texture2D when possible
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 29/06/2023 08:40, Richard Henderson wrote:

> On 6/27/23 15:02, marcandre.lureau@redhat.com wrote:
>>   static void dbus_update_gl_cb(GObject *source_object,
>> -                           GAsyncResult *res,
>> -                           gpointer user_data)
>> +                              GAsyncResult *res,
>> +                              gpointer user_data)
>>   {
>>       g_autoptr(GError) err = NULL;
>>       DBusDisplayListener *ddl = user_data;
>> +    bool success;
>> +
>> +#ifdef CONFIG_GBM
>> +    success = qemu_dbus_display1_listener_call_update_dmabuf_finish(
>> +        ddl->proxy, res, &err);
>> +#endif
>> +
>> +#ifdef WIN32
>> +    success = qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish(
>> +        ddl->d3d11_proxy, res, &err);
>> +    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
>> +#endif
>> -    if (!qemu_dbus_display1_listener_call_update_dmabuf_finish(ddl->proxy,
>> -                                                               res, &err)) {
>> +    if (!success) {
>>           error_report("Failed to call update: %s", err->message);
>>       }
> 
> With neither CONFIG_GBM nor WIN32, success is not set:
> 
> ../alt/ui/dbus-listener.c:199:10: error: variable 'success' is uninitialized when 
> used here [-Werror,-Wuninitialized]
>      if (!success) {
>           ^~~~~~~

I'm seeing something similar to this on my builds of git master this morning:

cc -m64 -mcx16 -Ilibcommon.fa.p -Iui -I../ui -I/usr/include/pixman-1 
-I/usr/include/libpng16 -I/usr/include/spice-server -I/usr/include/spice-1 
-I/usr/include/p11-kit-1 -I/usr/include/SDL2 -I/usr/include/libmount 
-I/usr/include/blkid -I/usr/include/glib-2.0 
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/gio-unix-2.0 
-I/usr/include/slirp -I/usr/include/gtk-3.0 -I/usr/include/at-spi2-atk/2.0 
-I/usr/include/at-spi-2.0 -I/usr/include/dbus-1.0 
-I/usr/lib/x86_64-linux-gnu/dbus-1.0/include -I/usr/include/cairo 
-I/usr/include/pango-1.0 -I/usr/include/fribidi -I/usr/include/harfbuzz 
-I/usr/include/atk-1.0 -I/usr/include/uuid -I/usr/include/freetype2 
-I/usr/include/gdk-pixbuf-2.0 -I/usr/include/vte-2.91 -I/usr/include/cacard 
-I/usr/include/nss -I/usr/include/nspr -I/usr/include/PCSC -I/usr/include/libusb-1.0 
-fdiagnostics-color=auto -Wall -Winvalid-pch -Werror -std=gnu11 -O0 -g 
-fstack-protector-strong -Wundef -Wwrite-strings -Wmissing-prototypes 
-Wstrict-prototypes -Wredundant-decls -Wold-style-declaration -Wold-style-definition 
-Wtype-limits -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers 
-Wempty-body -Wnested-externs -Wendif-labels -Wexpansion-to-defined 
-Wimplicit-fallthrough=2 -Wmissing-format-attribute -Wno-missing-include-dirs 
-Wno-shift-negative-value -Wno-psabi -isystem 
/home/build/src/qemu/git/qemu/linux-headers -isystem linux-headers -iquote . -iquote 
/home/build/src/qemu/git/qemu -iquote /home/build/src/qemu/git/qemu/include -iquote 
/home/build/src/qemu/git/qemu/host/include/x86_64 -iquote 
/home/build/src/qemu/git/qemu/host/include/generic -iquote 
/home/build/src/qemu/git/qemu/tcg/i386 -pthread -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 
-D_LARGEFILE_SOURCE -fno-strict-aliasing -fno-common -fwrapv -fPIE -D_DEFAULT_SOURCE 
-D_XOPEN_SOURCE=600 -DNCURSES_WIDECHAR=1 -D_REENTRANT -DSTRUCT_IOVEC_DEFINED -MD -MQ 
libcommon.fa.p/ui_dbus-listener.c.o -MF libcommon.fa.p/ui_dbus-listener.c.o.d -o 
libcommon.fa.p/ui_dbus-listener.c.o -c ../ui/dbus-listener.c
../ui/dbus-listener.c: In function ‘dbus_call_update_gl’:
../ui/dbus-listener.c:210:26: error: unused variable ‘ddl’ [-Werror=unused-variable]
   210 |     DBusDisplayListener *ddl = container_of(dcl, DBusDisplayListener, dcl);
       |                          ^~~
At top level:
../ui/dbus-listener.c:180:13: error: ‘dbus_update_gl_cb’ defined but not used 
[-Werror=unused-function]
   180 | static void dbus_update_gl_cb(GObject *source_object,
       |             ^~~~~~~~~~~~~~~~~
../ui/dbus-listener.c: In function ‘dbus_update_gl_cb’:
../ui/dbus-listener.c:199:9: error: ‘success’ is used uninitialized in this function 
[-Werror=uninitialized]
   199 |     if (!success) {
       |         ^~~~~~~~
cc1: all warnings being treated as errors
ninja: build stopped: subcommand failed.


ATB,

Mark.


