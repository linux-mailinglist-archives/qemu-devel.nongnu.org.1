Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8287A1DAD
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:48:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7J1-00062X-Ne; Fri, 15 Sep 2023 07:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qh7Ix-0005yD-Fi
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:48:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qh7Ir-0004PY-Bh
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:48:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694778484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=baQaguqmJ8fxBKT0ReK4WJRQlSZeoJ1kiWH/H24eV6g=;
 b=i0GeloJAgSykjMhzUinROB+R/qoT9Nj3u+JMyee2N56igrrKRWz4JFJSvGboAg9KILp4GE
 OnNdSpqGMrN0uw0vO4ND02SFKfyK8U0tE4uZgi9PKL2Dr0ywkDkCQIpiu01y6BAnvrHkTy
 qGbXosIf4rJBeXlzHgpjhGTOf4Nxr4Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-boETqAIJM3-VijDoMVt-ug-1; Fri, 15 Sep 2023 07:48:03 -0400
X-MC-Unique: boETqAIJM3-VijDoMVt-ug-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-402ff13f749so15664765e9.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 04:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694778482; x=1695383282;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=baQaguqmJ8fxBKT0ReK4WJRQlSZeoJ1kiWH/H24eV6g=;
 b=s3gH1GtO/8xXthw9b7ATi3E5rtCGXYbPTGo+o6xNz4VLS/oMlF6r7Fr8wsm3ZkPSmS
 ICGOdQbOI6OrSooRoz46CZ/ns216vgWq+6Y97pN4pxmAzsUwfPHktzEvuEwFezyeXZv2
 lyoRxhcubQ84CcppFTwNFsDb7SJsqizMytXp+fWlUgJAM7TLI3IupMNrKlicm0p6bwGK
 wCclvjjaV175OvVw1H+lO58Z5hphNHkXs4b034fjYBbio2KipVi6FAYvg3Y20DGaU24m
 n8LKs8LG0GjZI2VrOuSyIBwLGi28c1FLnpmSdwnooWciUbdJPDoNTKp3lCu5+5Um5qut
 wg8w==
X-Gm-Message-State: AOJu0YyaSwL2HnqgaxNJGw18YpdOta6bni8FXR/Is57lJ2u5nUmirk8y
 tBwNMtTORq4LTEuGxiSze1swsTRrtFCkp/lAhn6hzznvx+35lF38EopaBcHilpJK4ymjlzAD0RH
 qFpgDsHKX7LwJ9PA=
X-Received: by 2002:a1c:790b:0:b0:401:b493:f7c1 with SMTP id
 l11-20020a1c790b000000b00401b493f7c1mr1292441wme.35.1694778482426; 
 Fri, 15 Sep 2023 04:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWvdtB6y7Zf967RcjTzPH7sQ4As/CakUSMOaN4wNW1fI5PRaQw74W+sUBg6iT27ODykF6Izg==
X-Received: by 2002:a1c:790b:0:b0:401:b493:f7c1 with SMTP id
 l11-20020a1c790b000000b00401b493f7c1mr1292420wme.35.1694778482126; 
 Fri, 15 Sep 2023 04:48:02 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 q5-20020a5d6585000000b0031f5f0d0be0sm4274663wru.31.2023.09.15.04.48.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 04:48:01 -0700 (PDT)
Message-ID: <48e669f3-4fae-e3cd-b436-7f2c989b879a@redhat.com>
Date: Fri, 15 Sep 2023 13:47:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 00/18] RFC: Remove deprecated audio features
Content-Language: en-US
To: Martin Kletzander <mkletzan@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, libvir-list@redhat.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Yanan Wang <wangyanan55@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?=
 <hpoussin@reactos.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 Alexander Bulekov <alxndr@bu.edu>, Bandan Das <bsd@redhat.com>,
 qemu-arm@nongnu.org, Jan Kiszka <jan.kiszka@web.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-ppc@nongnu.org
References: <cover.1650874791.git.mkletzan@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <cover.1650874791.git.mkletzan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 4/25/22 10:21, Martin Kletzander wrote:
> I wanted to deal with https://bugzilla.redhat.com/2043498 and I got a
> suggesstion that removing deprecated features could actually make it
> easier to propagate the error.  In the end (last patch) it turns out the
> error is still just reported with error_fatal, so it probably is not
> really needed, but I really wanted to dig into QEMU more and learn some
> of the internals for quite some time now.  So I used the opportunity.
> The one-liner ended up being an 18 patch series which was, for someone
> who has just one commit in QEMU codebase, a pretty challenging task.
> Although I tried my best to do things properly, I am not sure whether I
> handled everything correctly, hence the RFC.

Rebased and queued what's left...  It took a while. :)

Paolo

> Martin Kletzander (18):
>    hw/audio: Remove -soundhw support
>    hw/input/tsc210x: Extract common init code into new function
>    hw/audio: Simplify hda audio init
>    hw/audio/lm4549: Add errp error reporting to init function
>    tests/qtest: Specify audiodev= and -audiodev
>    ui/vnc: Require audiodev=
>    Introduce machine's default-audiodev property
>    audio: Add easy dummy audio initialiser
>    hw/display/xlnx_dp.c: Add audiodev property
>    hw/input/tsc210x.c: Support machine-default audiodev with fallback
>    hw/arm: Support machine-default audiodev with fallback
>    hw/ppc: Support machine-default audiodev with fallback
>    audio: Make AUD_register_card fallible and require audiodev=
>    audio: Require AudioState in AUD_add_capture
>    audio: Be more strict during audio backend initialisation
>    audio: Remove legacy audio environment variables and options
>    audio: Remove unused can_be_default
>    audio/spiceaudio: Fail initialisation when not using spice
> 
>   audio/alsaaudio.c                             |   1 -
>   audio/audio.c                                 | 204 +++----
>   audio/audio.h                                 |   5 +-
>   audio/audio_int.h                             |   1 -
>   audio/audio_legacy.c                          | 555 ------------------
>   audio/coreaudio.m                             |   1 -
>   audio/dbusaudio.c                             |   1 -
>   audio/dsoundaudio.c                           |   1 -
>   audio/jackaudio.c                             |   1 -
>   audio/meson.build                             |   1 -
>   audio/noaudio.c                               |   1 -
>   audio/ossaudio.c                              |   1 -
>   audio/paaudio.c                               |   1 -
>   audio/sdlaudio.c                              |   1 -
>   audio/spiceaudio.c                            |   3 +-
>   audio/wavaudio.c                              |   1 -
>   docs/about/deprecated.rst                     |  24 -
>   docs/about/removed-features.rst               |  27 +
>   docs/qdev-device-use.txt                      |  21 +-
>   docs/replay.txt                               |   2 +-
>   hw/arm/integratorcp.c                         |   8 +-
>   hw/arm/musicpal.c                             |   8 +-
>   hw/arm/omap2.c                                |  11 +-
>   hw/arm/realview.c                             |   3 +
>   hw/arm/spitz.c                                |  10 +-
>   hw/arm/versatilepb.c                          |   3 +
>   hw/arm/vexpress.c                             |   3 +
>   hw/arm/xlnx-zcu102.c                          |   4 +
>   hw/arm/z2.c                                   |  12 +-
>   hw/audio/ac97.c                               |   9 +-
>   hw/audio/adlib.c                              |   9 +-
>   hw/audio/cs4231a.c                            |   8 +-
>   hw/audio/es1370.c                             |   8 +-
>   hw/audio/gus.c                                |   6 +-
>   hw/audio/hda-codec.c                          |  37 +-
>   hw/audio/intel-hda.c                          |  25 +-
>   hw/audio/intel-hda.h                          |   2 +-
>   hw/audio/lm4549.c                             |   7 +-
>   hw/audio/lm4549.h                             |   3 +-
>   hw/audio/meson.build                          |   1 -
>   hw/audio/pcspk.c                              |  15 +-
>   hw/audio/pl041.c                              |   2 +-
>   hw/audio/sb16.c                               |   9 +-
>   hw/audio/soundhw.c                            | 177 ------
>   hw/audio/wm8750.c                             |   5 +-
>   hw/core/machine.c                             |  23 +
>   hw/display/xlnx_dp.c                          |  12 +-
>   hw/input/tsc210x.c                            |  79 ++-
>   hw/ppc/prep.c                                 |   4 +
>   hw/usb/dev-audio.c                            |   5 +-
>   include/hw/audio/soundhw.h                    |  15 -
>   include/hw/boards.h                           |   1 +
>   qemu-options.hx                               |  37 --
>   .../codeconverter/test_regexps.py             |   1 -
>   softmmu/qdev-monitor.c                        |   2 -
>   softmmu/vl.c                                  |  10 -
>   tests/qtest/ac97-test.c                       |   3 +-
>   tests/qtest/es1370-test.c                     |   3 +-
>   tests/qtest/fuzz/generic_fuzz_configs.h       |   6 +-
>   tests/qtest/intel-hda-test.c                  |  15 +-
>   ui/vnc.c                                      |  15 +-
>   61 files changed, 329 insertions(+), 1140 deletions(-)
>   delete mode 100644 audio/audio_legacy.c
>   delete mode 100644 hw/audio/soundhw.c
>   delete mode 100644 include/hw/audio/soundhw.h
> 


