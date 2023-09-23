Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4897ABF07
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Sep 2023 10:57:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjyQ4-0002l6-0h; Sat, 23 Sep 2023 04:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyQ1-0002kg-En
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjyPz-0000V7-03
 for qemu-devel@nongnu.org; Sat, 23 Sep 2023 04:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695459313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=csVGsEw1/5bN80i4P+PsVXfG0TWl2b/bBH5kJ8aUmBk=;
 b=fefJSVpsnBUjmsjuOzzNest4AnUCf8jwm+ujyGrlgaHeaXrHlhbD+VBxInYtkvA5L+y4jV
 bNryPiURKYJhrh7S0w8lG4UW+v1iiZAMxjryDGvqgnRNt1i7pNJbh53ruT58Y87S7/4nFr
 LRcfwBs/6uOP4PtOPE5SUsvr1DZjIeU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-aoyuWC87Oj2t1V5hkezqew-1; Sat, 23 Sep 2023 04:55:11 -0400
X-MC-Unique: aoyuWC87Oj2t1V5hkezqew-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5041a72d2edso4596042e87.1
 for <qemu-devel@nongnu.org>; Sat, 23 Sep 2023 01:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695459309; x=1696064109;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=csVGsEw1/5bN80i4P+PsVXfG0TWl2b/bBH5kJ8aUmBk=;
 b=ha+SG08j3G/zv5/cNf4qYW6+7qP7rfBqSNIDYixQYRCh6bW6OxviPXkUWs6taPTSNz
 +ksUMx6H8/wzlQlubPUE8wl2EwkMHsd8ge62lIGZozvBXigCu/apwJ1Uy68KTTDBGJIG
 vSqM6jsBdrdERU3YkycGWr2vyQNESbHNw02hYQsDbR03IqWF51+lf4UpX1AzNXzHBiGZ
 +FWSfTYu02f038Y2esh2Jkxpobw59BSbS2718O/Nn08pPVziXGn/nqjpzz3kW9qenlah
 Iz27oISxMV6oIVZpcKrYCjK3FczSLJRCD9b6imMtkuSGa+TISB7WbtBIh1HdaUuptb0v
 VMLg==
X-Gm-Message-State: AOJu0YwJcNAREHRaJXecwZ/zB7rkfJgcpLAXWhUG+pDKwmcP5udNSWMu
 xWOuEQtSTAmT0UwRJ3nSxfrbZIdvlKWnhkObSHnAOTDXcDYGFGsDZoQcwn/P9hOJyGVNadT3tCp
 yH24Fww5rjuPKudBlGW3YiJEuChlA6W2CtI68bJeXClniuFnw7JwC2vXqqBixqRTQv/l51WRqLd
 I=
X-Received: by 2002:a05:6512:31c3:b0:500:79a6:38d4 with SMTP id
 j3-20020a05651231c300b0050079a638d4mr1916283lfe.40.1695459309447; 
 Sat, 23 Sep 2023 01:55:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwG5uIPoK+ctktK4KxzWsHDwib4t08NN9vr+EyT+resv7R0OT/LfkmE5hmHWNggDPKT07nNA==
X-Received: by 2002:a05:6512:31c3:b0:500:79a6:38d4 with SMTP id
 j3-20020a05651231c300b0050079a638d4mr1916266lfe.40.1695459308926; 
 Sat, 23 Sep 2023 01:55:08 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 z8-20020adfd0c8000000b00317a29af4b2sm6413774wrh.68.2023.09.23.01.55.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Sep 2023 01:55:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: mkletzan@redhat.com,
	vr_qemu@t-online.de,
	balaton@eik.bme.hu
Subject: [PATCH 00/13] Cleanup deprecated audio features, take 2
Date: Sat, 23 Sep 2023 10:54:53 +0200
Message-ID: <20230923085507.399260-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When sending v1 of the "Support machine-default audiodev" series,
Zoltan suggested keeping the default audio backends, so I am sending a
reduced version of the pull request.

In this version the QEMU_AUDIO_* options go away, but it is still
possible to pick a default audio backend from the list provided to
--audio-drv-list.  The code is still simplified a lot compared to
having all the legacy parsing code and the -audio-help function.
I had to keep QEMU_AUDIO_DRV=none because it is used by libqtest;
a possibility for the future could be to add a "-audio none" option
without a model.  For now I kept this setting as it is a subset of the
previous accepted values, and it can be deprecated separately.

At the end of this series, all devices can be configured with
-audiodev.  Therefore, I decided to forbid mixing the default
audio backend with audiodevs or with -nodefaults.

Patches 1-2 are Martin's patches that didn't end up in the previous
pull request.

Patches 3-4 change audio.c to use Error ** a bit more.

Patches 5-7 introduce the minimal code to create a default audio
backend.

Patches 8-11 introduce a machine property "audiodev" and plumb
it into all machines with an embedded sound card.

Patches 12-13 forbid some not-so-sensible usage of default
audio backends.

Paolo

Based-on: <20230922154228.304933-1-pbonzini@redhat.com>

Martin Kletzander (5):
  ui/vnc: Require audiodev= to enable audio
  audio: Require AudioState in AUD_add_capture
  Introduce machine property "audiodev"
  hw/arm: Support machine-default audiodev with fallback
  hw/ppc: Support machine-default audiodev with fallback

Paolo Bonzini (8):
  audio: allow returning an error from the driver init
  audio: return Error ** from audio_state_by_name
  audio: commonize voice initialization
  audio: simplify flow in audio_init
  audio: remove QEMU_AUDIO_* and -audio-help support
  vt82c686: Support machine-default audiodev with fallback
  audio: forbid mixing default audiodev backend and -audiodev
  audio: forbid default audiodev backend with -nodefaults

 audio/alsaaudio.c                |   3 +-
 audio/audio-hmp-cmds.c           |   6 +-
 audio/audio.c                    | 207 +++++------
 audio/audio.h                    |   5 +-
 audio/audio_int.h                |   7 +-
 audio/audio_legacy.c             | 591 -------------------------------
 audio/audio_template.h           |   9 +-
 audio/coreaudio.m                |   3 +-
 audio/dbusaudio.c                |   3 +-
 audio/dsoundaudio.c              |   3 +-
 audio/jackaudio.c                |   3 +-
 audio/meson.build                |   1 -
 audio/noaudio.c                  |   3 +-
 audio/ossaudio.c                 |  12 +-
 audio/paaudio.c                  |   8 +-
 audio/pwaudio.c                  |  17 +-
 audio/sdlaudio.c                 |   6 +-
 audio/sndioaudio.c               |   3 +-
 audio/spiceaudio.c               |   5 +-
 audio/wavaudio.c                 |   3 +-
 docs/about/deprecated.rst        |  16 +-
 docs/about/removed-features.rst  |  12 +
 hw/arm/integratorcp.c            |  11 +-
 hw/arm/musicpal.c                |  11 +-
 hw/arm/nseries.c                 |   4 +
 hw/arm/omap2.c                   |   7 +-
 hw/arm/palm.c                    |   2 +
 hw/arm/realview.c                |  12 +
 hw/arm/spitz.c                   |  17 +-
 hw/arm/versatilepb.c             |   8 +
 hw/arm/vexpress.c                |   5 +
 hw/arm/xlnx-zcu102.c             |   6 +
 hw/arm/z2.c                      |  15 +-
 hw/audio/ac97.c                  |   6 +-
 hw/audio/adlib.c                 |   6 +-
 hw/audio/cs4231a.c               |   6 +-
 hw/audio/es1370.c                |   5 +-
 hw/audio/gus.c                   |   6 +-
 hw/audio/hda-codec.c             |   5 +-
 hw/audio/lm4549.c                |   8 +-
 hw/audio/pcspk.c                 |   4 +-
 hw/audio/sb16.c                  |   6 +-
 hw/audio/via-ac97.c              |   6 +-
 hw/audio/wm8750.c                |   5 +-
 hw/core/machine.c                |  33 ++
 hw/core/qdev-properties-system.c |  16 +-
 hw/display/xlnx_dp.c             |   6 +-
 hw/input/tsc210x.c               |   7 +-
 hw/isa/vt82c686.c                |   2 +
 hw/mips/fuloong2e.c              |  13 +-
 hw/ppc/pegasos2.c                |  10 +-
 hw/ppc/prep.c                    |   7 +
 hw/usb/dev-audio.c               |   5 +-
 include/hw/boards.h              |   7 +
 qemu-options.hx                  |  10 -
 softmmu/vl.c                     |   4 -
 ui/dbus.c                        |   3 +-
 ui/vnc.c                         |  13 +-
 58 files changed, 381 insertions(+), 842 deletions(-)
 delete mode 100644 audio/audio_legacy.c

-- 
2.41.0


