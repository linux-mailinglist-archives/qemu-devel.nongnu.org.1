Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FE47B6458
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 10:36:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnao7-0001wd-Go; Tue, 03 Oct 2023 04:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnao3-0001r9-Ok
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnanz-0000HR-MI
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696321859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D6fw09Kf9GPVR8f7bn+iUVpahmXhjD5MEFM0D73U+KY=;
 b=KVv+DgPWf5RfoLfKUX/tggck+JVl8FaMLYtSO43CflkDNIcyB9r23N4STxiUpBZFMSLhfs
 B7OadBocirNoxQxCgaTccX46lq/qfV/tuTrZS1hZ+QHnnGg69g3Hsx/UYtPnn9ZIIDEmzK
 giZ3MMrPBncrmUytFU51ImYnxcqgJcI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-S1LvWbxaOn-gPutWj14sCw-1; Tue, 03 Oct 2023 04:30:46 -0400
X-MC-Unique: S1LvWbxaOn-gPutWj14sCw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5349289a704so463968a12.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 01:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696321844; x=1696926644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D6fw09Kf9GPVR8f7bn+iUVpahmXhjD5MEFM0D73U+KY=;
 b=hiSrnQQcjQTxlomYB6tqNZsph6YcE/wY+N7Kym4DUGd4ClhdJi3FKNnM6GJlGswpKF
 PEFwSAJ0rlAreCLG8VfiJlEqhzf1Wc6wDcvrcea/TGgfUhTnnX7Ttig89+0Q561VMHME
 32JF5wj0osm8hYux4O2BRzV3XgpRCv/pFDKPv+j5LJe8fB9+mfHfDKDeg8at8GjoWmIo
 fQjKBbpd2yRHCv3bwnaMbdngviTgv2lQIWnMMeBIQs0QZVmAXLk/VhMh5cLMfixSPFe9
 ynEEpYXN09t223ldVzEOv5ek4oA9C5rNC3UzwflVe+kEXvcs6P/tQ5/u+aU016zL6W/1
 nt6w==
X-Gm-Message-State: AOJu0Yxk7tRz1d/zCKB6XjWodrIqxEGYBbqukX0z/XA3M9jhe54fAEgF
 SYfENNdpV7ygnVHXSz5n5M2CdOHb1Vzi2McPMEWFpSr5K+kC4XTTerLpq97F46HfzJSXBNfE0s6
 vGHr9mm58diN1gX1NL0O6j43gUuq8NnowX/FyX+qDCITevwtulC8OHTzq60XQd3/UGzIjhRmUo9
 0=
X-Received: by 2002:aa7:ca46:0:b0:52c:e607:3866 with SMTP id
 j6-20020aa7ca46000000b0052ce6073866mr11671406edt.32.1696321844692; 
 Tue, 03 Oct 2023 01:30:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHETRFyogKxyjSuMBo0Bt9rYJRGAk6MN5rN1wuyyr/X5bW2F3tVJVUnA9IyqW0YgkvdaylAVg==
X-Received: by 2002:aa7:ca46:0:b0:52c:e607:3866 with SMTP id
 j6-20020aa7ca46000000b0052ce6073866mr11671381edt.32.1696321844154; 
 Tue, 03 Oct 2023 01:30:44 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 k16-20020aa7c050000000b005386541f612sm486448edo.3.2023.10.03.01.30.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 01:30:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] Audio, build system, misc fixes for 2023-10-03
Date: Tue,  3 Oct 2023 10:30:17 +0200
Message-ID: <20231003083042.110065-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit 36e9aab3c569d4c9ad780473596e18479838d1aa:

  migration: Move return path cleanup to main migration thread (2023-09-27 13:58:02 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 9f8cf356723702272af124e621e4c0e9805c8e22:

  audio: forbid default audiodev backend with -nodefaults (2023-10-03 10:29:40 +0200)

----------------------------------------------------------------
* fix from optionrom build
* fix for KVM on Apple M2
* introduce machine property "audiodev"
* ui/vnc: Require audiodev= to enable audio
* audio: remove QEMU_AUDIO_* and -audio-help support
* audio: forbid using default audiodev backend with -audiodev and -nodefaults
* remove compatibility code for old machine types
* make-release: do not ship dtc sources
* build system cleanups

----------------------------------------------------------------
Akihiko Odaki (1):
      accel/kvm/kvm-all: Handle register access errors

Fabiano Rosas (1):
      optionrom: Remove build-id section

Mark Cave-Ayland (3):
      esp: use correct type for esp_dma_enable() in sysbus_esp_gpio_demux()
      esp: restrict non-DMA transfer length to that of available data
      scsi-disk: ensure that FORMAT UNIT commands are terminated

Martin Kletzander (5):
      audio: Require AudioState in AUD_add_capture
      Introduce machine property "audiodev"
      hw/arm: Support machine-default audiodev with fallback
      hw/ppc: Support machine-default audiodev with fallback
      audio: propagate Error * out of audio_init

Paolo Bonzini (14):
      e1000: remove old compatibility code
      pc: remove short_root_bus property
      make-release: do not ship dtc sources
      meson: clean up static_library keyword arguments
      Makefile: build plugins before running TCG tests
      crypto: only include tls-cipher-suites in emulators
      ui/vnc: Require audiodev= to enable audio
      audio: allow returning an error from the driver init
      audio: return Error ** from audio_state_by_name
      audio: commonize voice initialization
      audio: simplify flow in audio_init
      audio: remove QEMU_AUDIO_* and -audio-help support
      vt82c686 machines: Support machine-default audiodev with fallback
      audio: forbid default audiodev backend with -nodefaults

 accel/kvm/kvm-all.c              |  32 ++-
 audio/alsaaudio.c                |   3 +-
 audio/audio-hmp-cmds.c           |   6 +-
 audio/audio.c                    | 246 ++++++++--------
 audio/audio.h                    |   7 +-
 audio/audio_int.h                |   7 +-
 audio/audio_legacy.c             | 591 ---------------------------------------
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
 crypto/meson.build               |   3 +-
 docs/about/deprecated.rst        |  16 +-
 docs/about/removed-features.rst  |  12 +
 gdbstub/meson.build              |   4 +-
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
 hw/core/machine.c                |  33 +++
 hw/core/qdev-properties-system.c |  16 +-
 hw/display/xlnx_dp.c             |   6 +-
 hw/input/tsc210x.c               |   7 +-
 hw/mips/fuloong2e.c              |  15 +-
 hw/net/e1000.c                   |  79 ++----
 hw/nvram/meson.build             |   6 +-
 hw/pci-host/i440fx.c             |   8 -
 hw/pci-host/q35.c                |   7 -
 hw/ppc/pegasos2.c                |  12 +-
 hw/ppc/prep.c                    |   7 +
 hw/scsi/esp.c                    |   5 +-
 hw/scsi/scsi-disk.c              |   4 +
 hw/usb/dev-audio.c               |   5 +-
 include/hw/boards.h              |   9 +
 include/hw/pci-host/q35.h        |   1 -
 meson.build                      |  14 +-
 pc-bios/optionrom/Makefile       |   2 +-
 qemu-options.hx                  |  10 -
 scripts/archive-source.sh        |   2 +-
 scripts/make-release             |   2 +-
 softmmu/vl.c                     |   8 +-
 tcg/meson.build                  |   4 +-
 tests/Makefile.include           |   2 +-
 tests/meson.build                |   5 +-
 tests/plugin/meson.build         |  18 +-
 ui/dbus.c                        |   3 +-
 ui/vnc.c                         |  14 +-
 ui/vnc.h                         |   2 +
 76 files changed, 515 insertions(+), 958 deletions(-)
 delete mode 100644 audio/audio_legacy.c
-- 
2.41.0


