Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C547B1527
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 09:39:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qllaQ-0004jN-1q; Thu, 28 Sep 2023 03:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaO-0004hd-2B
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qllaF-00064a-FC
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 03:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695886633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=V+zXvMgKOXou0u5sPIkvOiaTaEXdC4/qR9hqP8mzpz0=;
 b=F3uW9PR4KBprTjA4JPGrkhxZfRXDZHLBLnWq/sJ/Eqxt5fWGDbdiEeocDvOiol2f5nzWUT
 9g3RZSbELsp9jN1B1qxi4qbP5quz3BaWkNtkXupyR8fs7aQQ1AxbMFb7H7uEUMLkuCblUK
 d9XR90G8p+n3PhvpQEKrPTXjW0FE1yk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-W-n0JPfkNDS_-EoIYZh4EQ-1; Thu, 28 Sep 2023 03:37:09 -0400
X-MC-Unique: W-n0JPfkNDS_-EoIYZh4EQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-51d981149b5so9688307a12.3
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 00:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695886627; x=1696491427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V+zXvMgKOXou0u5sPIkvOiaTaEXdC4/qR9hqP8mzpz0=;
 b=Ec4OKN/C3BvRd+CLsGLzQ9Krc3z3FrohqqPhXeVXeH7Yj6c0YmudxU0XrdOdtSGoQq
 qFERYUa99TBi35mvQCiq2aPbyOkXfS2HiocUz3nnY01oBcwKTZ0d0oFKy7cYMlmA9zuS
 f2FZ7YIVMIkrHCjWz7GculoiV2uSeqo22yxo19AkOehpLiN9mNRnLD32BfapVvXGHZNZ
 eDyVCrse5se52KX2QtIxsCsNYSKI1C1GhTHv8dLbq0xihcq2dWwbcutyWiLA+n5diCnH
 o64pr1fO3qxceQaFenfp3h0eIpr1xJkRu0ezT6t6OoYP++bHwm+VxEvZo+XVvmRPFyZN
 Rsng==
X-Gm-Message-State: AOJu0YxxvG81r2eA0jAqFnhd878s1Qc9vWl1G87o7zoHLaKgjqyLSHbJ
 GuWz24/COOY7JvMU/VfXL3hSQ045BpMZ0Hqc3iB+kS+9xCH+TuILi5UEyUpIKUEWtRj+2sK2Zr5
 xeOJdCPwT6EhGT4TTPmrnNwea2oQNU3vEfibv1HGagRzWjftSTOANBW+365JNHKqGAYum9Kzc5W
 E=
X-Received: by 2002:aa7:d489:0:b0:533:97c:8413 with SMTP id
 b9-20020aa7d489000000b00533097c8413mr460974edr.25.1695886627599; 
 Thu, 28 Sep 2023 00:37:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaWEYAIOe677qH0E++ze25FsYVnzEndFMfma/r6RhBaoCdCOnmES/lx7p1z+nfXm24oYY4AQ==
X-Received: by 2002:aa7:d489:0:b0:533:97c:8413 with SMTP id
 b9-20020aa7d489000000b00533097c8413mr460951edr.25.1695886627173; 
 Thu, 28 Sep 2023 00:37:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 d15-20020aa7d68f000000b005333922efb0sm9255540edr.78.2023.09.28.00.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Sep 2023 00:37:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v2 00/13] Cleanup deprecated audio features, take 2
Date: Thu, 28 Sep 2023 09:36:44 +0200
Message-ID: <20230928073705.871327-1-pbonzini@redhat.com>
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

v1->v2:
- do not expose audio encoding feature if VNC audio is not enabled [Daniel]
- add hint to error messages when -audiodev and default backend are mixed
- context changes due to shadowed variable fixes


Martin Kletzander (4):
  audio: Require AudioState in AUD_add_capture
  Introduce machine property "audiodev"
  hw/arm: Support machine-default audiodev with fallback
  hw/ppc: Support machine-default audiodev with fallback

Paolo Bonzini (9):
  ui/vnc: Require audiodev= to enable audio
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
 audio/audio.c                    | 213 +++++------
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
 ui/vnc.c                         |  14 +-
 ui/vnc.h                         |   2 +
 59 files changed, 391 insertions(+), 841 deletions(-)
 delete mode 100644 audio/audio_legacy.c

-- 
2.41.0


