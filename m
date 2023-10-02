Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 601A17B558D
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKMv-0008ET-Sp; Mon, 02 Oct 2023 10:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMt-0008Df-Tv
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnKMs-0003fx-9z
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:57:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696258673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CnH6x0QUvLgXDZzVEAniQq71B20DhlyGduHVqA7OZg4=;
 b=Z/UcRQiH0Udvmu3HLuxMpBjDtzW0fA3fRjt+Q1RStYsrWN0bXsq2A6k15aStD7I0L1hzHB
 0pzN2tfCuK/rmUdzC0LH0KyN7eKFvQ5eEWJ7wSa/vp8Nz49hTCRLrP9L2MLATptlh/CEYD
 pTDYrkL8FYBYM73mTO3yilDJsP0M81g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-cQTOohRmNbuK71x8LCpLLg-1; Mon, 02 Oct 2023 10:57:32 -0400
X-MC-Unique: cQTOohRmNbuK71x8LCpLLg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9b2e030e4caso311246366b.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258650; x=1696863450;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CnH6x0QUvLgXDZzVEAniQq71B20DhlyGduHVqA7OZg4=;
 b=gKPsrjoSP6+C/ukMuPxW41lED2lHmHizxeVEnyH4eqDBnDmy1w7/o1hqcUKgOsbNP+
 UyONnyuS4WRijwZtxBl6qn9loe4MssvoATCnzDVaXE6HxWpcHL4CmVj6zOYy8aD6SqsY
 DYmYnOrY90R65m+t7l37naUyu6T+i8R4mS/cbwPZzIojKtqSVKA9y99EDowfUZPAmkoR
 Kg1lENvWS0qyXJVITyG2MitUV/qOMdKy0gqsy0hsfe/iCfcNgz4r3URZsWdNgqOvTv5m
 cFdXSlB93d3MeocVwD6UDBtklz3DuKORNaQpKTym6LO6RjcybhOmhdU/40+WVZAoGQts
 kv1g==
X-Gm-Message-State: AOJu0Yw5RSX4EJ3/jujZXwNW4x2JHblR/Nx9j+DX7YI0RctBeVjnKksG
 Z10RJmVflqxiVh2puLtmw2RaaP8r6qo1wr1vrwB3x8xmuG8GtPwbS966sebCnCvoy4qYynUAQ6V
 9HcoiOpwSsECGudYZodcYRfHfNaEHb3Zoqm0cajiKnkroBryJeRsk68QQVPbmESMY6qlAjFW/5O
 o=
X-Received: by 2002:a17:906:225c:b0:9a1:f1b2:9f2e with SMTP id
 28-20020a170906225c00b009a1f1b29f2emr10854538ejr.2.1696258650653; 
 Mon, 02 Oct 2023 07:57:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtxoJp872SpJhZgElrSs4cjcMhWKvw4v7s5zAa/pdUzFhWqo6vT+exiBWTnW4lQW+B35k4hQ==
X-Received: by 2002:a17:906:225c:b0:9a1:f1b2:9f2e with SMTP id
 28-20020a170906225c00b009a1f1b29f2emr10854509ejr.2.1696258650116; 
 Mon, 02 Oct 2023 07:57:30 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 lw3-20020a170906bcc300b009ae0042e48bsm17087876ejb.5.2023.10.02.07.57.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:57:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
Subject: [PATCH v4 00/13] Cleanup deprecated audio features, take 2
Date: Mon,  2 Oct 2023 16:57:14 +0200
Message-ID: <20231002145728.87958-1-pbonzini@redhat.com>
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

Patch 12 cleans up error propagation up to the realize functions
of the devices, so that error messages are nicer when patch 13
forbids usage of default audio backends with -nodefaults.

Paolo

v3->v4: for now, always allow default audiodev backend even
        together with -audiodev.  The new plan is to first improve
        -audio so that it can create a default audiodev backend,
        and only then remove the possibility to use the first
        -audiodev as the default audiodev backend.

        do not use error_report+abort

Martin Kletzander (5):
  audio: Require AudioState in AUD_add_capture
  Introduce machine property "audiodev"
  hw/arm: Support machine-default audiodev with fallback
  hw/ppc: Support machine-default audiodev with fallback
  audio: propagate Error * out of audio_init

Paolo Bonzini (8):
  ui/vnc: Require audiodev= to enable audio
  audio: allow returning an error from the driver init
  audio: return Error ** from audio_state_by_name
  audio: commonize voice initialization
  audio: simplify flow in audio_init
  audio: remove QEMU_AUDIO_* and -audio-help support
  vt82c686 machines: Support machine-default audiodev with fallback
  audio: forbid default audiodev backend with -nodefaults

 audio/alsaaudio.c                |   3 +-
 audio/audio-hmp-cmds.c           |   6 +-
 audio/audio.c                    | 246 ++++++-------
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
 58 files changed, 419 insertions(+), 856 deletions(-)
 delete mode 100644 audio/audio_legacy.c

-- 
2.41.0


