Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AC22A7AAE13
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 11:32:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjcVf-0004iA-TC; Fri, 22 Sep 2023 05:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVc-0004hm-9I
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjcVZ-0003Kx-1e
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 05:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695375091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=f6T5xkc6K5Jbf+F7+1K1E6rofklZd9i/dq5EzjPVi7M=;
 b=WylOcb99zo6+chtQMb+ds18+gd1hNG3Chty+SRWKmMHGwJIgk/vp3MaOivflZivQyKgaal
 SPttlfYBSkl45XWSmj27FAsk6Nh5VXIll8xrTOJBuofT1sh7ItsOdrtJJ4elXjy8qZaiwc
 z0NSnWf9WH6rkMt4uCHkUvMg6yc5bl0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-h6woUnHuOx6US8ky3V_UkQ-1; Fri, 22 Sep 2023 05:31:29 -0400
X-MC-Unique: h6woUnHuOx6US8ky3V_UkQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40525249280so15240755e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 02:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695375088; x=1695979888;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f6T5xkc6K5Jbf+F7+1K1E6rofklZd9i/dq5EzjPVi7M=;
 b=PabHRJ5l22u7C0rbPyKDlJ5Emwh30yUHPU8hBmmZZzipzKsuSMvXt+D9PXCXAJt9TR
 8jbIY9907XEn9wshsiCR/Hl1yq9kTjpQkNsQsmBWqiv3+k3vgKKW3Z+2o3JwgCeh+NQs
 aStir391cRr1m9/rCtPRLyCHztOAPng9DdYPybbsVGIaInUZ3jYL3vtI83e1X4sYrxD6
 OprcnugscO2ad9fSdlKEhxYCRC0Al9rnpgUxF3tVKeoE3D5jlnBhBOW+9NU70UYEYDcF
 Q0iIBx4bNrX+Ldy9JRmC5TXRi13v6JFyMAvp43R0K0OpINirwsY2W4ji64yz0fbOHKLo
 NNWw==
X-Gm-Message-State: AOJu0YxPVWHcVdYHiXj2fkszgJT8Z9JeJlJL+Q12GZi1Yybg16RIgpju
 xxYEudtYeoNRgPA2sqMk8lQJ5fW+ezIzE3pGQJ65pC70q0BdfTjxKRD3y0OykrdVYusnKISI6fE
 +ierLgQneUtNr4UIT/aDEnTY4Ywlbap5Pj9VXjutjWeC2TqtlHUSFh+SIRUzAd8TEmhuqI2/CVw
 M=
X-Received: by 2002:adf:f84e:0:b0:31c:804b:5ec3 with SMTP id
 d14-20020adff84e000000b0031c804b5ec3mr6901030wrq.67.1695375088296; 
 Fri, 22 Sep 2023 02:31:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi/wxg0lS3hBibHCptxBLMxT+7xR7xDMmknMWT9B3N4hhyhejux999snBefmW8H8e8RQho3w==
X-Received: by 2002:adf:f84e:0:b0:31c:804b:5ec3 with SMTP id
 d14-20020adff84e000000b0031c804b5ec3mr6901009wrq.67.1695375087825; 
 Fri, 22 Sep 2023 02:31:27 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff90c000000b0031fb91f23e9sm3957226wrr.43.2023.09.22.02.31.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 02:31:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/12] Audio, i386 patches for 2022-09-22
Date: Fri, 22 Sep 2023 11:31:13 +0200
Message-ID: <20230922093126.264016-1-pbonzini@redhat.com>
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

The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:

  Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qemu-tpm into staging (2023-09-13 13:41:57 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 5930ce1943065b3d7b2687da0b53c1cd1da86cf7:

  audio: Require AudioState in AUD_add_capture (2023-09-21 10:42:43 +0200)

----------------------------------------------------------------
* add host ticks function for RISC-V
* target/i386: Export GDS_NO bit
* target/i386: add support for bit 56 of MSR_IA32_VMX_BASIC
* drop -audiodev-help and QEMU_AUDIO_* environment variables
* require -audiodev for VNC audio

----------------------------------------------------------------
LIU Zhiwei (1):
      qemu/timer: Add host ticks function for RISC-V

Martin Kletzander (8):
      hw/input/tsc210x: Extract common init code into new function
      hw/audio: Simplify hda audio init
      hw/audio/lm4549: Add errp error reporting to init function
      hw/display/xlnx_dp.c: Add audiodev property
      tests/qtest: Specify audiodev= and -audiodev
      audio/spiceaudio: Fail initialisation when not using spice
      ui/vnc: Require audiodev= to enable audio
      audio: Require AudioState in AUD_add_capture

Paolo Bonzini (2):
      target/i386: enumerate bit 56 of MSR_IA32_VMX_BASIC
      audio: remove QEMU_AUDIO_* and -audio-help support

Pawan Gupta (1):
      target/i386: Export GDS_NO bit to guests

 audio/alsaaudio.c                       |   1 -
 audio/audio.c                           |  63 ++--
 audio/audio.h                           |   1 -
 audio/audio_int.h                       |   3 -
 audio/audio_legacy.c                    | 591 --------------------------------
 audio/coreaudio.m                       |   1 -
 audio/dbusaudio.c                       |   1 -
 audio/dsoundaudio.c                     |   1 -
 audio/jackaudio.c                       |   1 -
 audio/meson.build                       |   1 -
 audio/noaudio.c                         |   1 -
 audio/ossaudio.c                        |   1 -
 audio/paaudio.c                         |   1 -
 audio/pwaudio.c                         |   1 -
 audio/sdlaudio.c                        |   1 -
 audio/sndioaudio.c                      |   1 -
 audio/spiceaudio.c                      |   3 +-
 audio/wavaudio.c                        |   1 -
 docs/about/deprecated.rst               |  16 +-
 docs/about/removed-features.rst         |  12 +
 hw/audio/hda-codec.c                    |  32 +-
 hw/audio/intel-hda.c                    |   4 +-
 hw/audio/intel-hda.h                    |   2 +-
 hw/audio/lm4549.c                       |   3 +-
 hw/audio/lm4549.h                       |   3 +-
 hw/audio/pl041.c                        |   2 +-
 hw/display/xlnx_dp.c                    |   6 +
 hw/input/tsc210x.c                      |  68 ++--
 include/qemu/timer.h                    |  22 ++
 qemu-options.hx                         |  10 -
 scripts/kvm/vmxcap                      |   1 +
 softmmu/vl.c                            |   4 -
 target/i386/cpu.c                       |   3 +-
 target/i386/cpu.h                       |   1 +
 tests/qtest/es1370-test.c               |   3 +-
 tests/qtest/fuzz/generic_fuzz_configs.h |   6 +-
 tests/qtest/intel-hda-test.c            |  15 +-
 ui/vnc.c                                |  10 +-
 38 files changed, 142 insertions(+), 755 deletions(-)
 delete mode 100644 audio/audio_legacy.c
-- 
2.41.0


