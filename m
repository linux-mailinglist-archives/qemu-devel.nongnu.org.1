Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8165271EEEC
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:27:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kHN-0005DW-QJ; Thu, 01 Jun 2023 11:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francesco.cagnin@gmail.com>)
 id 1q4kHB-0005Cm-Pl; Thu, 01 Jun 2023 11:31:45 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <francesco.cagnin@gmail.com>)
 id 1q4kH7-0005C0-D7; Thu, 01 Jun 2023 11:31:44 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4f505aace48so1276256e87.0; 
 Thu, 01 Jun 2023 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685633496; x=1688225496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=p72RA+8GXwdkLdVlA+tnuDPDfu6/yeYSBXfafrXnF5o=;
 b=HgDn4ukhbbLu9lXjkowJURHL8518TUroXKkTYMczQwDl5sV44cudMr0WyNkQirdVIb
 I9s81zVV4gr2+9tIP8TsRjpdkJiRT/gVS7ExXe09QMCPEQ0GLx+P712y5EUfouUvppoT
 x8+gfBV6vHx/aDUIOHVB+mZQeMau4helQHFCgsG0JK90JRJErGQhj0o9yUDLqORsOtwg
 kT92ZJT9uwa2VaH0OiGOGw6CMG07pzHdOIDfGmd7+7Qg7mmbaTjgJGUGVEhD+Yvx5d/m
 Qdzqt8VrljQuVtx2lZzXxfQ5YLdYYwxrzVqG2V/zRu3VCsgOi3qi2UR4Ugw/nV9YS2Rr
 uKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685633496; x=1688225496;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p72RA+8GXwdkLdVlA+tnuDPDfu6/yeYSBXfafrXnF5o=;
 b=LDVVNKCCPUHgfqVp0u/iHsi7OIhaNTjOsSZ3IiqvXmcSNLZPN9tbxf2wmu5dX6QhjS
 Bo5nUFsRVe4Y4fOk2criyAKeMPQi4zr11LrtNt7ylx9ZT093C3KYEPF13TPQc49UgeLS
 oQXb4zorJWf04M0Av4EAAnsiYfgCpSpWLPb2zGjOTd56ft/XCpxaOyGcBaZMhOL7k+5M
 5q5KWU5VUnRvMiT90yMmgmzd6Vwb+J588DJeEsHJtxB5BlT/6MbE1txKLlGlzd0bTNvn
 5HL2IUz+Z2B08cQT32DjXGG7twReAvwq2Q9tX1kZa1t/NZS9Y+HSExpy/TnEAaWtYzDD
 /X4Q==
X-Gm-Message-State: AC+VfDzW97M0VkUNSOtZyD9ufRMOGBwCHL1wf3dYhZoBDuPfjr+h8Xue
 gVG2ziBPX4VV7s9QEIiCP1w4IllR4Y0Vfw==
X-Google-Smtp-Source: ACHHUZ4z3y7qFT1oPOQbFbSTY5jH1I6ez/RorZij6tQ8g8Vwa4Cqa28k5joZLtdNbxI9qekf7dwfAw==
X-Received: by 2002:ac2:4357:0:b0:4f3:b883:fc4e with SMTP id
 o23-20020ac24357000000b004f3b883fc4emr161087lfl.43.1685633495477; 
 Thu, 01 Jun 2023 08:31:35 -0700 (PDT)
Received: from omega.guest.bzh.qb (177.23.22.93.rev.sfr.net. [93.22.23.177])
 by smtp.gmail.com with ESMTPSA id
 l14-20020a1ced0e000000b003f4289b18a7sm2763975wmh.5.2023.06.01.08.31.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Jun 2023 08:31:34 -0700 (PDT)
From: francesco.cagnin@gmail.com
X-Google-Original-From: fcagnin@quarkslab.com
To: qemu-devel@nongnu.org
Cc: mads@ynddal.dk, dirty@apple.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, agraf@csgraf.de, pbonzini@redhat.com,
 alex.bennee@linaro.org, philmd@linaro.org,
 Francesco Cagnin <fcagnin@quarkslab.com>
Subject: [PATCH v5 0/4] Add gdbstub support to HVF
Date: Thu,  1 Jun 2023 17:31:03 +0200
Message-Id: <20230601153107.81955-1-fcagnin@quarkslab.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=francesco.cagnin@gmail.com; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Francesco Cagnin <fcagnin@quarkslab.com>

This patch series aims to add gdbstub support to HVF (the 'QEMU accelerator
on macOS that employs Hypervisor.framework') on Apple Silicon hosts.

The proposed implementation, structured like the KVM counterpart, handles
single-stepping, software breakpoints, hardware breakpoints and hardware
watchpoints.

The patch has been most recently tested working on a macOS Ventura 13.4
ARM64 host and a Linux kernel 5.19 guest with the test script
'tests/guest-debug/test-gdbstub.py' (slightly updated to make it work with
Linux kernels compiled on macOS, see
https://gitlab.com/qemu-project/qemu/-/issues/1489).

This version of the patch should fix previously reported issues on
multi-cores guests. No other issues are known.

The patch has been tested on top of QEMU v8.0.1 dabb418.

v5:
* Split patch into multiple commits (as per suggestion on v4)
* Update `hvf_arm_init_debug()` so it's not called multiple times on SMP
  guests (as per suggestion on v4)
* Fix add `hvf_arch_set_traps()` to enable/disable exiting the guest on all
  vCPUs
* Fix share a single `hvf_sw_breakpoints` across all vCPUs
* Fix add missing `QTAILQ_INIT()` for `hvf_sw_breakpoints`

Francesco Cagnin (4):
  arm: move KVM breakpoints helpers
  hvf: handle access for more registers
  hvf: add breakpoint handlers
  hvf: add guest debugging handlers for Apple Silicon hosts

 accel/hvf/hvf-accel-ops.c | 119 ++++++
 accel/hvf/hvf-all.c       |  23 ++
 include/sysemu/hvf.h      |  37 ++
 include/sysemu/hvf_int.h  |   2 +
 target/arm/hvf/hvf.c      | 750 +++++++++++++++++++++++++++++++++++++-
 target/arm/hvf_arm.h      |   7 +
 target/arm/hyp_gdbstub.c  | 253 +++++++++++++
 target/arm/internals.h    |  50 +++
 target/arm/kvm64.c        | 276 --------------
 target/arm/meson.build    |   3 +-
 target/i386/hvf/hvf.c     |  33 ++
 11 files changed, 1274 insertions(+), 279 deletions(-)
 create mode 100644 target/arm/hyp_gdbstub.c

-- 
2.40.1


