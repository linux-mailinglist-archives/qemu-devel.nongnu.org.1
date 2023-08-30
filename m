Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D78A078D758
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:56:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbNXg-0006A0-6Z; Wed, 30 Aug 2023 11:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbNXa-000698-Jz
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:55:34 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbNXX-0006SV-1Y
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:55:34 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99de884ad25so779531766b.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693410929; x=1694015729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wJLaW1UMImf4Qb1R8FBHSE+cZL7WeevyG3rMjc904ZY=;
 b=GNTgrVWYqkYXd/HP2qPHvq9/qndXyFvVxy23tDcY/5JpaMnBvH1+G+J14lXW+H+MdV
 pJf6+HpVZj6leCe9zej6KaQkMQWWM58NzUjjaa0imhOmB+aFnPmK32VZ4oPOU/jxWHaK
 +lcSrJnF1tLhHWrQPzJ3XaPIWmX3CKpVLnXfXfIwRa3n0X7scPPWr35EirTRA8/NG5h+
 vkgNBWH39Ary+r09fy4l1R+LvCKBn2Rg6VcCNVGpTL9Jkbai50mhYu1hVZIcPTYOns3F
 sz3q74uvq72bsk3UhMX/gxbWToY39+DXAD82wZ0bqBMe7C7zFt31tmFtU2cOLMpWp6L6
 uvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693410929; x=1694015729;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wJLaW1UMImf4Qb1R8FBHSE+cZL7WeevyG3rMjc904ZY=;
 b=JTyPsT3ZDPtdaWiLuj7DkOzsGh0S+tJNfhWR/kOJ5eSVFI/x6Ka7tiXDt9BkwFp3fM
 GO3BerJL3a97SByeUdXkVyuj3OiwVloetEPeCJRr5w9gZNSFHAlDYM19xKYXst7f0oye
 rThStCMbfB5qpf6z0ITK9SCKKiA6Tu6tnPQTCtGZrOr0vmHbfvYFaJiCPht1m+vN3EWf
 I27x7ChHQOUC8/+fPkG6x+jUHHMUaqYoneMmGmXxj6Q1Ta6WrmdZYuFAQ2mD/wj7KzUZ
 F3Ts29G+BaAWlyXOQu9I6BehghvtaUbWot3C9JdDv9ljISPY5D48UNNTa3xVX8i/ANBU
 cEJg==
X-Gm-Message-State: AOJu0YwPTHU3G/e7Xxd+Z/uwxWFWvOKKazEXUT0LAg0Uk67kgGZRx/Dd
 VYtJGieuEnhLNdKbwpmzk9xc5w==
X-Google-Smtp-Source: AGHT+IFLKq34d7bkOSoromYYvtj0GnKiKtZK+gjWGHuhn0JcipWwyZ7ICLNbNHxjCxxRLTQE6UR4Qw==
X-Received: by 2002:a17:907:7610:b0:9a1:b84d:fa58 with SMTP id
 jx16-20020a170907761000b009a1b84dfa58mr2128537ejc.1.1693410929149; 
 Wed, 30 Aug 2023 08:55:29 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a170906354b00b00992bea2e9d2sm7331760eja.62.2023.08.30.08.55.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 08:55:28 -0700 (PDT)
Message-ID: <fa0b84b4-f513-0667-eca2-e8dd70ae677a@linaro.org>
Date: Wed, 30 Aug 2023 17:55:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 51/67] build-sys: add optional "pixman" feature
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20230830093843.3531473-1-marcandre.lureau@redhat.com>
 <20230830093843.3531473-52-marcandre.lureau@redhat.com>
 <784947c2-3b2a-6452-b009-c4a21fd67d0a@linaro.org>
In-Reply-To: <784947c2-3b2a-6452-b009-c4a21fd67d0a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 30/8/23 17:48, Philippe Mathieu-Daudé wrote:
> On 30/8/23 11:38, marcandre.lureau@redhat.com wrote:
>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>
>> Set CONFIG_PIXMAN accordinly.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   meson.build       | 6 ++++--
>>   Kconfig.host      | 3 +++
>>   meson_options.txt | 2 ++
>>   3 files changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/meson.build b/meson.build
>> index 98e68ef0b1..3bd7046099 100644
>> --- a/meson.build
>> +++ b/meson.build
>> @@ -836,8 +836,8 @@ if 'ust' in get_option('trace_backends')
>>                        method: 'pkg-config')
>>   endif
>>   pixman = not_found
>> -if have_system or have_tools
>> -  pixman = dependency('pixman-1', required: have_system, 
>> version:'>=0.21.8',
>> +if not get_option('pixman').auto() or have_system or have_tools
>> +  pixman = dependency('pixman-1', required: get_option('pixman'), 
>> version:'>=0.21.8',
>>                         method: 'pkg-config')


>> diff --git a/meson_options.txt b/meson_options.txt
>> index aaea5ddd77..89654fd77d 100644
>> --- a/meson_options.txt
>> +++ b/meson_options.txt
>> @@ -216,6 +216,8 @@ option('l2tpv3', type : 'feature', value : 'auto',
>>          description: 'l2tpv3 network backend support')
>>   option('netmap', type : 'feature', value : 'auto',
>>          description: 'netmap network backend support')
>> +option('pixman', type : 'feature', value : 'auto',
>> +       description: 'pixman support')
>>   option('slirp', type: 'feature', value: 'auto',
>>          description: 'libslirp user mode network backend support')
>>   option('vde', type : 'feature', value : 'auto',
> 
> Apparently missing:
> 
> -- >8 --
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-buildoptions.sh
> index 9da3fe299b..16957ea9f0 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -146,6 +146,7 @@ meson_options_help() {
>     printf "%s\n" '  pa              PulseAudio sound support'
>     printf "%s\n" '  parallels       parallels image format support'
>     printf "%s\n" '  pipewire        PipeWire sound support'
> +  printf "%s\n" '  pixman          pixman support'
>     printf "%s\n" '  png             PNG support with libpng'
>     printf "%s\n" '  pvrdma          Enable PVRDMA support'
>     printf "%s\n" '  qcow1           qcow1 image format support'
> @@ -397,6 +398,8 @@ _meson_option_parse() {
>       --disable-parallels) printf "%s" -Dparallels=disabled ;;
>       --enable-pipewire) printf "%s" -Dpipewire=enabled ;;
>       --disable-pipewire) printf "%s" -Dpipewire=disabled ;;
> +    --enable-pixman) printf "%s" -Dpixman=enabled ;;
> +    --disable-pixman) printf "%s" -Dpixman=disabled ;;
>       --with-pkgversion=*) quote_sh "-Dpkgversion=$2" ;;
>       --enable-png) printf "%s" -Dpng=enabled ;;
>       --disable-png) printf "%s" -Dpng=disabled ;;
> ---

Many files fail to build when using --disable-pixman here:

[39/51] Compiling C object libcommon.fa.p/ui_curses.c.o
FAILED: libcommon.fa.p/ui_curses.c.o
In file included from ../../ui/curses.c:37:
In file included from include/ui/console.h:4:
include/ui/qemu-pixman.h:12:10: fatal error: 'pixman.h' file not found
#include <pixman.h>
          ^~~~~~~~~~

Full list:

$ ninja libcommon.fa -k 0 2>&1 | grep -F FAILED
FAILED: libcommon.fa.p/ui_input-legacy.c.o
FAILED: libcommon.fa.p/ui_cursor.c.o
FAILED: libcommon.fa.p/ui_qemu-pixman.c.o
FAILED: libcommon.fa.p/ui_kbd-state.c.o
FAILED: libcommon.fa.p/ui_input.c.o
FAILED: libcommon.fa.p/ui_ui-qmp-cmds.c.o
FAILED: libcommon.fa.p/ui_console.c.o
FAILED: libcommon.fa.p/ui_vdagent.c.o
FAILED: libcommon.fa.p/ui_console-vc.c.o
FAILED: libcommon.fa.p/ui_ui-hmp-cmds.c.o
FAILED: libcommon.fa.p/ui_util.c.o
FAILED: libcommon.fa.p/ui_vnc-enc-zlib.c.o
FAILED: libcommon.fa.p/ui_vnc-enc-hextile.c.o
FAILED: libcommon.fa.p/ui_vnc-auth-vencrypt.c.o
FAILED: libcommon.fa.p/ui_vnc.c.o
FAILED: libcommon.fa.p/ui_vnc-enc-tight.c.o
FAILED: libcommon.fa.p/ui_vnc-ws.c.o
FAILED: libcommon.fa.p/ui_vnc-jobs.c.o
FAILED: libcommon.fa.p/ui_vnc-clipboard.c.o
FAILED: libcommon.fa.p/ui_vnc-enc-zrle.c.o
FAILED: libcommon.fa.p/ui_vnc-auth-sasl.c.o
FAILED: libcommon.fa.p/ui_cocoa.m.o
FAILED: libcommon.fa.p/hw_char_escc.c.o
FAILED: libcommon.fa.p/hw_core_sysbus-fdt.c.o
FAILED: libcommon.fa.p/hw_display_ramfb.c.o
FAILED: libcommon.fa.p/hw_display_g364fb.c.o
FAILED: libcommon.fa.p/hw_display_ramfb-standalone.c.o
FAILED: libcommon.fa.p/hw_display_jazz_led.c.o
FAILED: libcommon.fa.p/hw_display_cirrus_vga_isa.c.o
FAILED: libcommon.fa.p/hw_display_cirrus_vga.c.o
FAILED: libcommon.fa.p/hw_display_pl110.c.o
FAILED: libcommon.fa.p/hw_display_ssd0303.c.o
FAILED: libcommon.fa.p/hw_display_ssd0323.c.o
FAILED: libcommon.fa.p/hw_display_blizzard.c.o
FAILED: libcommon.fa.p/hw_display_framebuffer.c.o
FAILED: libcommon.fa.p/hw_display_vga-mmio.c.o
FAILED: libcommon.fa.p/hw_display_exynos4210_fimd.c.o
FAILED: libcommon.fa.p/hw_display_bochs-display.c.o
FAILED: libcommon.fa.p/hw_display_vga-pci.c.o
FAILED: libcommon.fa.p/hw_display_vga-isa.c.o
FAILED: libcommon.fa.p/hw_display_vmware_vga.c.o
FAILED: libcommon.fa.p/hw_display_omap_dss.c.o
FAILED: libcommon.fa.p/hw_display_bcm2835_fb.c.o
FAILED: libcommon.fa.p/hw_display_tc6393xb.c.o
FAILED: libcommon.fa.p/hw_display_pxa2xx_lcd.c.o
FAILED: libcommon.fa.p/hw_display_cg3.c.o
FAILED: libcommon.fa.p/hw_display_tcx.c.o
FAILED: libcommon.fa.p/hw_display_sm501.c.o
FAILED: libcommon.fa.p/hw_display_macfb.c.o
FAILED: libcommon.fa.p/hw_display_next-fb.c.o
FAILED: libcommon.fa.p/hw_display_vga.c.o
FAILED: libcommon.fa.p/hw_display_xlnx_dp.c.o
FAILED: libcommon.fa.p/hw_display_omap_lcdc.c.o
FAILED: libcommon.fa.p/hw_display_artist.c.o
FAILED: libcommon.fa.p/hw_dma_xlnx_dpdma.c.o
FAILED: libcommon.fa.p/hw_input_hid.c.o
FAILED: libcommon.fa.p/hw_input_ads7846.c.o
FAILED: libcommon.fa.p/hw_input_adb-mouse.c.o
FAILED: libcommon.fa.p/hw_input_lm832x.c.o
FAILED: libcommon.fa.p/hw_input_ps2.c.o
FAILED: libcommon.fa.p/hw_input_stellaris_input.c.o
FAILED: libcommon.fa.p/hw_input_tsc2005.c.o
FAILED: libcommon.fa.p/hw_input_pxa2xx_keypad.c.o
FAILED: libcommon.fa.p/hw_input_virtio-input-hid.c.o
FAILED: libcommon.fa.p/hw_input_tsc210x.c.o
FAILED: libcommon.fa.p/hw_misc_applesmc.c.o
FAILED: libcommon.fa.p/hw_misc_bcm2835_property.c.o
FAILED: libcommon.fa.p/hw_usb_dev-hid.c.o
FAILED: libcommon.fa.p/hw_usb_dev-wacom.c.o
FAILED: libcommon.fa.p/hw_arm_bcm2835_peripherals.c.o
FAILED: libcommon.fa.p/chardev_msmouse.c.o
FAILED: libcommon.fa.p/chardev_wctablet.c.o
FAILED: libcommon.fa.p/softmmu_vl.c.o
FAILED: libcommon.fa.p/ui_curses.c.o
FAILED: libcommon.fa.p/ui_sdl2-2d.c.o
FAILED: libcommon.fa.p/ui_sdl2-input.c.o
FAILED: libcommon.fa.p/ui_sdl2.c.o
FAILED: libcommon.fa.p/hw_display_virtio-gpu-base.c.o
FAILED: libcommon.fa.p/hw_display_virtio-gpu.c.o
FAILED: libcommon.fa.p/hw_display_virtio-gpu-udmabuf-stubs.c.o
FAILED: libcommon.fa.p/hw_display_virtio-gpu-pci.c.o
FAILED: libcommon.fa.p/hw_display_virtio-vga.c.o
FAILED: libcommon.fa.p/hw_s390x_virtio-ccw-gpu.c.o


