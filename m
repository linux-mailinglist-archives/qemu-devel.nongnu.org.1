Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C40637B2E6E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:53:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9ED-0005qX-Ff; Fri, 29 Sep 2023 04:52:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9E9-0005fS-Bl
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qm9DS-0005hf-RW
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:51:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695977477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kHEZ+pzx1p8t7AdOUHZD1CmveD4+CwETJRsptq9P3rs=;
 b=Bb1c5SGRBePiP6pi8zjjb6opiHSUq8zTC4lpHMlvk1Nqac1NYDB1i9tOcxTRTdT7hNkVH1
 EUJVCsRKBpIqmaiYs7NQB5Grkqqmas5aJZ7/SLk/cmNcBv2CQxx0XQebin5yA8W0dHX3GS
 czvSaW8imeqSz6ddeX2ILouu/cGOx+E=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-lBgYDjPMMvqR8Jhu0X3Ksg-1; Fri, 29 Sep 2023 04:51:16 -0400
X-MC-Unique: lBgYDjPMMvqR8Jhu0X3Ksg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a5d86705e4so1212706766b.1
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 01:51:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695977474; x=1696582274;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kHEZ+pzx1p8t7AdOUHZD1CmveD4+CwETJRsptq9P3rs=;
 b=WJGymg5BJc5l1aFr9OrETsUO+XmRHPwLC9jNPbvXz1F5f/U+3JMYQ4KpAatyZ4U6UU
 t//sBy/C8bc+t+LckyUc2ZkDTWfh69YZ6SQmMR9BWarYWkJAuUJpbkDvK21Sr/1TacnB
 SbEy8FzhlbEbXdbqhbDIMUjiK8NFHFk2yTmvgI42L72YngMIdRxBEtXp/wX+oXIjNtGZ
 1sX3wkdn+WQz2mOWwh02wwB1RdIPnO34koYhVKBfmq9dNdqbQeFlojSTmwQbxoSEqafQ
 2R/JfDSMcjwD3vhAAT90oPtaE9EtH/kR4N3/GD2JC25oM+cXnSO/FCnWOB0Xyrvs4L8P
 iOTQ==
X-Gm-Message-State: AOJu0YyKYAoJR/YVUihURPR/j5SMu4vxE8HKTHghruH2iyoGTKphHAeP
 1isHNtrer93WCcxq4xtNoFn82qKOnV9X33DoJFdNCFw5UjkCAQj7eTRDCYrU+8SA6tahhMNUpQr
 JC0BmhSeO8VQCtwuU7YsjCg/nheNSR5lrrsPCzol8kOhjHEFUD9OdIQKos14I09hSIyTwHf7XDK
 U=
X-Received: by 2002:aa7:d8d6:0:b0:52c:8a13:2126 with SMTP id
 k22-20020aa7d8d6000000b0052c8a132126mr3152460eds.37.1695977474506; 
 Fri, 29 Sep 2023 01:51:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzr1M2zqS2lYNKVN09PwniK5uSkc71zclNISD94WaYcFTlr2t4ymtCJqQfdA1EWuMOJfnBTQ==
X-Received: by 2002:aa7:d8d6:0:b0:52c:8a13:2126 with SMTP id
 k22-20020aa7d8d6000000b0052c8a132126mr3152442eds.37.1695977474056; 
 Fri, 29 Sep 2023 01:51:14 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 j6-20020aa7ca46000000b0052889d090bfsm10889837edt.79.2023.09.29.01.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 01:51:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	balaton@eik.bme.hu
Subject: [PATCH v3 00/14] Cleanup deprecated audio features, take 2
Date: Fri, 29 Sep 2023 10:50:53 +0200
Message-ID: <20230929085112.983957-1-pbonzini@redhat.com>
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

Patch 14 is an Error** propagation cleanup to avoid giving
Markus a heart attack if he ever looks at this code.  Or
at least moderating the intensity.

Paolo

v1->v2:
- do not expose audio encoding feature if VNC audio is not enabled [Daniel]
- add hint to error messages when -audiodev and default backend are mixed
- context changes due to shadowed variable fixes

v2->v3:
- adjust comment on "char *audiodev" field of MachineState
- use error_fatal instead of error_abort in OMAP and TSC210x's calls
  to AUD_register_card
- redo vt82c686 patches to remove aliased audiodev property
- fix leak in audio_driver_init when msg == false
- add patch to use Error in audio_init

Martin Kletzander (4):
  audio: Require AudioState in AUD_add_capture
  Introduce machine property "audiodev"
  hw/arm: Support machine-default audiodev with fallback
  hw/ppc: Support machine-default audiodev with fallback

Paolo Bonzini (10):
  ui/vnc: Require audiodev= to enable audio
  audio: allow returning an error from the driver init
  audio: return Error ** from audio_state_by_name
  audio: commonize voice initialization
  audio: simplify flow in audio_init
  audio: remove QEMU_AUDIO_* and -audio-help support
  vt82c686: Support machine-default audiodev with fallback
  audio: forbid mixing default audiodev backend and -audiodev
  audio: forbid default audiodev backend with -nodefaults
  audio: propagate Error out of audio_driver_init

 audio/alsaaudio.c                |   3 +-
 audio/audio-hmp-cmds.c           |   6 +-
 audio/audio.c                    | 228 ++++++------
 audio/audio.h                    |   7 +-
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
 hw/mips/fuloong2e.c              |  15 +-
 hw/ppc/pegasos2.c                |  12 +-
 hw/ppc/prep.c                    |   7 +
 hw/usb/dev-audio.c               |   5 +-
 include/hw/boards.h              |   9 +
 qemu-options.hx                  |  10 -
 softmmu/vl.c                     |   8 +-
 ui/dbus.c                        |   3 +-
 ui/vnc.c                         |  14 +-
 ui/vnc.h                         |   2 +
 58 files changed, 403 insertions(+), 854 deletions(-)
 delete mode 100644 audio/audio_legacy.c

-- 
2.41.0


