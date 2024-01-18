Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A0C831911
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:24:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRRg-0003Et-6S; Thu, 18 Jan 2024 07:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRY-0003CK-0f
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRW-0005Uf-AV
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qF914P68stMrMoYU0sKD1ACAG2aCBgiOmkQWOqNYFzw=;
 b=HIpb4xst3mJsSylX7B5ppFRmP9FmePk0SmR5zxvUtidTIGFuZQhVtPbmqFaXb653/7ee4e
 nm1iW1WFT2gapEuQz5b3uvUZfGmwVDMYO6LMo8SRulgBg7gXXtL8GHCfE3oBb9M3jClDEz
 bOd9T2cMXquHBPB8wA9MhE+/h62RjFQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-bW6hz2YJOgC7_Piu4F5dEA-1; Thu, 18 Jan 2024 07:24:20 -0500
X-MC-Unique: bW6hz2YJOgC7_Piu4F5dEA-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-50ec9529001so9413147e87.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580658; x=1706185458;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qF914P68stMrMoYU0sKD1ACAG2aCBgiOmkQWOqNYFzw=;
 b=esmX+lAntaQp/jSMyVdY8eNaJFL+YPCWypdpMVnyEMoi5Z54zNluAmAwoEUGJ7DTRJ
 Md44mwNpvEq4qly3ePXDObY/KtdOB+54HERXfdBfeTqy7sD7XbJ1wjDlMYCx7FrLWhj+
 3/FcfvrqNnsgQMZ0o3eNCMWpLPkzTY+gEJCFFN8uXTN9gRvV2QzD2neQ9bbIP6L9xnJ9
 IDXgymBBaOa3E1XUvA1f1V4SGwY1ZIC7OcssPwPLkcw+ES/QSsuXPuKILiM05ryiuxpL
 i39WgjVhPbaxNmOkVeUxh/BfJic2RDsYu7TZSLWiAj9eD5Xz4FeAddMlYwcvEdKuN80I
 Ai8A==
X-Gm-Message-State: AOJu0Ywn+ksvDro3kpuBcheXrro2Aif849rMwoxDCpCJV0VCTVkt1hUO
 FI6vsRwMUFZegmVj84Sa9eqEiNTmTAPwZiiPc7T5w5xH1lVOsvxjtmBs62rZ5iMRYaB0oO2eGDy
 wZ+zFzv2i2G1JumSNi1eOmC6hjAgBuBMPllvdt82D06G29WS7qk96ci7Kr/kPvkXt/fwGFkBfda
 8ce8xqAXtG2SDjY1ipr1TLxOklOjw0MwZ9HrHw
X-Received: by 2002:a05:6512:3e1e:b0:50e:db50:3b84 with SMTP id
 i30-20020a0565123e1e00b0050edb503b84mr561632lfv.100.1705580658145; 
 Thu, 18 Jan 2024 04:24:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9mj0DYOVQi9YQL/RJgdoUnN0Q73PH88x/BllvhmwcqV9T+FRavm8AbJcOuYo4Srg2Gyb1+A==
X-Received: by 2002:a05:6512:3e1e:b0:50e:db50:3b84 with SMTP id
 i30-20020a0565123e1e00b0050edb503b84mr561627lfv.100.1705580657736; 
 Thu, 18 Jan 2024 04:24:17 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 u26-20020a17090626da00b00a2ed3049392sm1993811ejc.82.2024.01.18.04.24.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:17 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/16] VGA, x86 TCG, misc changes for 2024-01-18
Date: Thu, 18 Jan 2024 13:24:00 +0100
Message-ID: <20240118122416.9209-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e393c:

  Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad/qemu into staging (2024-01-12 14:02:53 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 379652e967b32ac905056bf723b54298b2f79a51:

  tests/tcg: Don't #include <inttypes.h> in aarch64/system/vtimer.c (2024-01-18 10:43:51 +0100)

----------------------------------------------------------------
* vga: implement odd/even and byte/word/doubleword modes more accurately
* vga: implement horizontal pel panning
* KVM: add class property to configure KVM device node to use
* fix various bugs in x86 TCG PC-relative translation
* properly align huge pages on LoongArch
* cleanup patches

----------------------------------------------------------------
Bibo Mao (1):
      qemu/osdep: Add huge page aligned support on LoongArch platform

Daan De Meyer (1):
      Add class property to configure KVM device node to use

Ilya Leoshkevich (1):
      tests/tcg: Don't #include <inttypes.h> in aarch64/system/vtimer.c

Paolo Bonzini (11):
      vga: use common endian swap macros
      vga: introduce VGADisplayParams
      vga: mask addresses in non-VESA modes to 256k
      vga: implement horizontal pel panning in graphics modes
      vga: optimize horizontal pel panning in 256-color modes
      vga: reindent memory access code
      vga: use latches in odd/even mode too
      vga: sort-of implement word and double-word access modes
      io_uring: move LuringState typedef to block/aio.h
      target/i386: pcrel: store low bits of physical address in data[0]
      remove unnecessary casts from uintptr_t

Richard Henderson (1):
      target/i386: Do not re-compute new pc with CF_PCREL

guoguangyao (1):
      target/i386: fix incorrect EIP in PC-relative translation blocks

 hw/display/vga-helpers.h          | 121 +++++++---
 hw/display/vga_int.h              |  18 +-
 hw/display/vga_regs.h             |   4 +
 include/block/aio.h               |   8 +-
 include/block/raw-aio.h           |   1 -
 include/qemu/osdep.h              |   8 +
 include/sysemu/kvm_int.h          |   1 +
 accel/kvm/kvm-all.c               |  25 +-
 block/io_uring.c                  |   6 +-
 hw/display/cirrus_vga.c           |  28 +--
 hw/display/vga.c                  | 468 ++++++++++++++++++++------------------
 hw/vfio/common.c                  |   4 +-
 target/i386/sev.c                 |   8 +-
 target/i386/tcg/tcg-cpu.c         |  20 +-
 target/i386/tcg/translate.c       |  11 +-
 tests/tcg/aarch64/system/vtimer.c |   2 +-
 util/fdmon-io_uring.c             |   2 +-
 qemu-options.hx                   |   8 +-
 18 files changed, 438 insertions(+), 305 deletions(-)
-- 
2.43.0


