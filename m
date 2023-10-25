Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2627D6DA8
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 15:51:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qveHM-0001UJ-Aa; Wed, 25 Oct 2023 09:50:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveH4-0001Jd-9I
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:22 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qveGy-0002rD-OG
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 09:50:18 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1caa7597af9so38204795ad.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 06:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1698241810; x=1698846610; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=2HMf3AR10cl+PzngJ1uOsf+MFiWEg4nwUHAbK5K49AI=;
 b=jNK4LIp3DT+EMvB9mLsZ2s2oMlCGl5/j+eN1YEP3MRxdGyek+Va8rmjn2Q36KDghmP
 xREEF5tXCbuBQlpHRmJSKWlohYJrMh/aGOoSrGDxSy6xyn4uDqzIg0bQ2jO5hwOh6GyP
 ZotvIPSQLS4eZ38WVRyxg5uZjDulbyKq6JL2A1qjH82avMTbTU+DYXv1Bxudyc3kkBDZ
 Y7eGP29IspxCQzyKvLdvCl8NLv5gxDcy3+6SPeXjUg5PgsB29eu3UYeHE86sVfwBQBL0
 pZDRQT/pwyriD/e1Cd+HQebz5eguidXMQmjH+tM5+98/0CmlAo8libqjS+/YGXs/nxRb
 yIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698241810; x=1698846610;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2HMf3AR10cl+PzngJ1uOsf+MFiWEg4nwUHAbK5K49AI=;
 b=mvcZuvhkuxqN40TwxCzLPgMpHaRKEZzwehCRJtOPs0AlNcJI/wAOOFe3x6cCuRWquD
 WnAQN/7Sv8ncG1xmVrpqZt+bw/2VdVq0ETOt+sMsMxQ768jxM21ICpSRr/NsFc4TU/gZ
 fCnZEp/XZqvRpe0IjOhaXO0pAWW9NiqOGTXJ2yrZOujxGfNIP4dMaFjE7bEWb6WUFTLv
 lw3bd5mSzWRiMmND02GWY7scm6T6hHkhi5a2c8yY9qyrNkw47mZz1P/b6FtB6BKOoQkp
 ZY0gfBjFVqEAA9i1El0Sb7Tocg32bDLeimWmOV7vQaTFzgqwkteRemDYTpgABVxKjK5N
 Ta1Q==
X-Gm-Message-State: AOJu0YzkdEamy6mDEgpD3gQfcxhrpUNoYkeAsAguZ2MnPbjG0FopY/ML
 oaSBX5tMImwP4FJM3KJ8QZxwygLNSc+socpGSxk=
X-Google-Smtp-Source: AGHT+IFHH0y8B38KIQA9MFa59YmUHVZdrEbO2rLwcZ4fSdtZd7HLe1/UNpysMw2SPxUOflL4NQa20w==
X-Received: by 2002:a17:902:facb:b0:1c9:c46c:71fc with SMTP id
 ld11-20020a170902facb00b001c9c46c71fcmr9590828plb.59.1698241809790; 
 Wed, 25 Oct 2023 06:50:09 -0700 (PDT)
Received: from grind.. ([191.255.2.33]) by smtp.gmail.com with ESMTPSA id
 jw4-20020a170903278400b001ca485b8515sm9252548plb.91.2023.10.25.06.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 06:50:09 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v4 0/9] RVA22U64 profile support
Date: Wed, 25 Oct 2023 10:49:52 -0300
Message-ID: <20231025135001.531224-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Based-on: 20231023153927.435083-1-dbarboza@ventanamicro.com
("[PATCH v3 0/4] riscv: zicntr/zihpm flags and disable support")

Hi,

This version has changes based on feedback from Drew and Zhiwei in v3.

Most notable changes:

- profiles flags now have the same weight as individual extension,
  meaning that left-to-right ordering will change the resulting
  configuration;

- warnings are no longer being shown if the user disables a profile.
  We'll make a documentation note about why disabling a profile is an
  advanced feature instead of warning users simply because they set a
  single flag to 'off';

- warnings are being shown if the user disables a mandatory extension of
  a profile the user is enabling. This will cover the scenario where the
  user is disabling an extension by mistake or, if it's intentional, the
  user can safely ignore it;

- RVG is being handled closer to a profile. This is something that we
  decided to do here, in patch 8, to keep consistent with what we're
  doing with profiles in patch 9. This means that we're now throwing
  warnings if the user set g=true and then disabled a G extension
  (IMAFD_zicsr_zifencei) in the command line. 

Series is based on top of:

[PATCH v3 0/4] riscv: zicntr/zihpm flags and disable support

Patches missing acks: 3, 7, 8, 9

Changes from v3:
- patch 1:
  - added RVI in the profile definition
- patch 3:
  - removed disable profile warning from set() callback
  - mandatory extensions from a profile that are enabled/disabled has the same
    priority as individual extensions that are enabled/disabled. Left-to-right
    ordering matters for the final result
- patch 6:
  - change profile misa bits priority to be the same as regular misa bits set
    in the command line
- patch 7 (new):
  - add hash helpers
- patch 8 (new):
  - honor user choice for RVG MISA bits
- patch 9 (new):
  - throw user warnings if profile extensions are disabled in the command line 
- v3 link: https://lore.kernel.org/qemu-riscv/20231020223951.357513-1-dbarboza@ventanamicro.com/

Daniel Henrique Barboza (9):
  target/riscv: add rva22u64 profile definition
  target/riscv/kvm: add 'rva22u64' flag as unavailable
  target/riscv/tcg: add user flag for profile support
  target/riscv/tcg: add MISA user options hash
  target/riscv/tcg: add riscv_cpu_write_misa_bit()
  target/riscv/tcg: handle profile MISA bits
  target/riscv/tcg: add hash table insert helpers
  target/riscv/tcg: honor user choice for G MISA bits
  target/riscv/tcg: warn if profile exts are disabled

 target/riscv/cpu.c         |  20 +++
 target/riscv/cpu.h         |  12 ++
 target/riscv/kvm/kvm-cpu.c |   7 +-
 target/riscv/tcg/tcg-cpu.c | 249 ++++++++++++++++++++++++++++++-------
 4 files changed, 245 insertions(+), 43 deletions(-)

-- 
2.41.0


