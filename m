Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD136706A4A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 15:58:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzHep-0000x6-MQ; Wed, 17 May 2023 09:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1pzHek-0000wX-1l
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:57:30 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1pzHeh-0000Tv-D8
 for qemu-devel@nongnu.org; Wed, 17 May 2023 09:57:28 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-54fd1a3b821so317687eaf.2
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1684331844; x=1686923844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fh+dZlMqIDxD4os3T8AmNXRxu0WF5B0Z0kLs6+9OaCA=;
 b=cIv9+bdtOomexHwwG+FnH3VVltSJtsPzGhlPvf6femDS7N68+2obGFMiib9k4MbheX
 VRDm7uUkQ7UagkjShKSxLvisTW+6YOAhE5iOifLrA2Dv4hcyZup9R0mHM5vWYYsKQk4Z
 0d8MpKnSkLRdTlXgsN9iVwHn6C0/SfSEzDp+dNdzfBplqpcy6K4fhpr2kxJIflqYPRRZ
 mGpAM1xlmEZqgGtjfALfILcpR5V4uoDoNe5m2maL1TvfVhpJRm4ZrtW8yG+Avu3sxQhT
 svkGGe85tfANrCdxPKVPttcj+uq2qFoK8DrcY+sLFTRJKyfannG0zmLgFsJSzB/JFOrD
 Rr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684331844; x=1686923844;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fh+dZlMqIDxD4os3T8AmNXRxu0WF5B0Z0kLs6+9OaCA=;
 b=ZW6/X59x4LIv2qUu2DC1atrFM6NVIID1w3N/WZ5D7HBcc5ephheGjsDGZ3IVCjo/K0
 JL34MfKpdXxEPr6e1+jLmAByjyKO1uu2xz0pvPujLtbqluKj/IkiRtwc1S3lK1+EX6iW
 1MWR3AOpNC223CMO2ySOfSNsvvLbMp9l08OrT8NZRBc9xtwM7cdLJY7IS6CCWu59ONmC
 NfMt0LGqW+lBabRZM3qD+fLndEtEl8WFkTB7pV84up+lgUQ03FoHWL5RkRyB6qp7QFom
 vCsqc1xj+rmQvI8jdpyo0OVPb/hV+W/r3lGVEN/dBFoxZJZLbczdZH0Ezza8d9vrSCT/
 DzHw==
X-Gm-Message-State: AC+VfDww0gJZ+zkIxu+iK0L83MW7N3E4Y8JXfr5KiYotyxbSXPaRoxaw
 L4xUBaf7I3iUogW2a78wDb7IqxxXj9svhQ0jZGA=
X-Google-Smtp-Source: ACHHUZ5FCLSDrJo2mDiB1n5xqcjXwVrQQymZDbEZ/1GgfMT2L0NO+MTULrKWx0gf48/gsKh9SSOZeg==
X-Received: by 2002:a4a:7606:0:b0:54f:7f89:55e1 with SMTP id
 t6-20020a4a7606000000b0054f7f8955e1mr13676949ooc.2.1684331844498; 
 Wed, 17 May 2023 06:57:24 -0700 (PDT)
Received: from grind.. (189-46-207-53.dsl.telesp.net.br. [189.46.207.53])
 by smtp.gmail.com with ESMTPSA id
 j21-20020a544815000000b00383d9700294sm9409562oij.40.2023.05.17.06.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 06:57:24 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v9 00/11] target/riscv: rework CPU extension validation
Date: Wed, 17 May 2023 10:57:03 -0300
Message-Id: <20230517135714.211809-1-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi,

In this version we have a change in patch 11. We're now firing a
GUEST_ERROR if write_misa() fails and we need to rollback (i.e. not
change MISA ext).

No other changes made. 

Changes from v8:
- patch 11:
  - log a GUEST_ERROR if we decided to keep the current env->misa_ext
    value because the user value failed our validation
- v8 link: https://lists.gnu.org/archive/html/qemu-devel/2023-04/msg03584.html


Daniel Henrique Barboza (9):
  target/riscv/cpu.c: add riscv_cpu_validate_v()
  target/riscv/cpu.c: remove set_vext_version()
  target/riscv/cpu.c: remove set_priv_version()
  target/riscv: add PRIV_VERSION_LATEST
  target/riscv/cpu.c: add priv_spec validate/disable_exts helpers
  target/riscv/cpu.c: add riscv_cpu_validate_misa_mxl()
  target/riscv/cpu.c: validate extensions before riscv_timer_init()
  target/riscv/cpu.c: remove cfg setup from riscv_cpu_init()
  target/riscv: rework write_misa()

Weiwei Li (2):
  target/riscv: Mask the implicitly enabled extensions in isa_string
    based on priv version
  target/riscv: Update check for Zca/Zcf/Zcd

 target/riscv/cpu.c                      | 333 ++++++++++++++----------
 target/riscv/cpu.h                      |   3 +
 target/riscv/csr.c                      |  51 ++--
 target/riscv/insn_trans/trans_rvd.c.inc |  12 +-
 target/riscv/insn_trans/trans_rvf.c.inc |  14 +-
 target/riscv/insn_trans/trans_rvi.c.inc |   5 +-
 target/riscv/translate.c                |   5 +-
 7 files changed, 248 insertions(+), 175 deletions(-)

-- 
2.40.1


