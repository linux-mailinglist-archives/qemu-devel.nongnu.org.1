Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5A4965387
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Aug 2024 01:39:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjoey-0002mx-6K; Thu, 29 Aug 2024 19:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjoew-0002mP-BI
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:34 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sjoet-000380-Ig
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 19:34:34 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7cf6641765dso948153a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 16:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724974469; x=1725579269;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6ifwH3He+rBsTJOQn3YbtX3g/xeksCdxI9LHLl/EMaM=;
 b=HC1ZIsflS1Mu8C1WWU50w22LEgY90G3jT0PkHPEvteYSNzORxLLKqV5IdLo+8nd6oW
 BwpI4YZJTFo+4Yl5xcVhqMwSEf6UPj5+R0up9iH4qTnZWKy4uVmUHpbtkDiWReNIrM4H
 DK5VZmU7mM0SDtygkLbb2h5VBf8SFNRJybAW/2HkTgL9S57DeEi4IwK6p3CPCD1D/UMa
 QZ9A/gBsaIWBioz6RzDGZqUzKGktqztIoAr0/AuLp/VftkaF8vGeSUYm1np3ADxBKRTX
 OVZSw048jfDK2U6aiDm6weTp8noIPAQv03WLWthDzag2c/UWUXGPPitbY1CT2/yf/p6v
 8nsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724974469; x=1725579269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6ifwH3He+rBsTJOQn3YbtX3g/xeksCdxI9LHLl/EMaM=;
 b=wgFh80GL3y88zsSb4jBRO293OtvYVUtXMHDqfu5MK6plxJFtd+yzqZYhI1YV92nK1/
 xTtcWPFQiJO65i/NmtH92BNOGnJY/XcWG0OHTuzSTZbAg04I07SgHSBwVy7JJ2N3brv6
 vk4sq+EKvTpKdnoea3bMjiDkMr3Nb3N8ansopgVdQamsiAdYYTgPRAsshzrufkbMNdYe
 wEw+ALismkcS1ZSCnpcu8dV6TTPo1xP3/zep8iC5RJDfplp6ivaIdTkcm+XjNh9XeTbr
 FY3UMdTxbvadYRsBV2TMSIeUNJEXMqpM55MRrWu75A4A4FFX0ae47+oOS+tpmy0eeJq/
 0vyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8FWlv4W/e42PjDejafFYpVWAPH4fWjU+XvErxTFpGFo6ZVpn/Y6S6e5taCVXMKGOhXT9ICsYgyWL4@nongnu.org
X-Gm-Message-State: AOJu0YzABwQv00TVWXDRrxpYjBUm3Ck/aOpn45vLsB/uN7DqCbaln3dT
 w38dyJu/B2fHQeaKgI4DNByvmf2G47QarCcgrDgKqmxgxP6MTVhgJvaJW/kcXy3Oj57Do9Ill6g
 V
X-Google-Smtp-Source: AGHT+IEN7aTIKLDlmsBz993819L+vtqSJ4B2N9Egxgaov49zS/B4GolvQSIbPxQ18whcPYqPYkG5tA==
X-Received: by 2002:a17:90a:4dcc:b0:2d3:dca0:89b7 with SMTP id
 98e67ed59e1d1-2d85617bc40mr4821554a91.3.1724974469265; 
 Thu, 29 Aug 2024 16:34:29 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d85b13df55sm2331074a91.27.2024.08.29.16.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2024 16:34:28 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com, Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v12 00/20] riscv support for control flow integrity extensions
Date: Thu, 29 Aug 2024 16:34:04 -0700
Message-ID: <20240829233425.1005029-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v12 for riscv zicfilp and zicfiss extensions support in qemu.

zicfilp and zicfiss spec pdf
https://github.com/riscv/riscv-cfi/releases/download/v1.0/riscv-cfi.pdf

github sources to spec
https://github.com/riscv/riscv-cfi

Links for previous versions
[1] - v1 https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06017.html
[2] - v2 https://lore.kernel.org/all/ed23bcbc-fdc4-4492-803c-daa95880375a@linaro.org/T/
[3] - v3 https://lists.nongnu.org/archive/html/qemu-devel/2024-08/msg01005.html
[4] - v4 https://lore.kernel.org/all/20240816010711.3055425-6-debug@rivosinc.com/T/
[5] - v5
+https://lore.kernel.org/all/20240820000129.3522346-1-debug@rivosinc.com/T/#m7b9cc847e739ec86f9569a3ca9f3d9377b01e21
[6] - v6 https://mail.gnu.org/archive/html/qemu-riscv/2024-08/msg00418.html
[7] - v7 https://lore.kernel.org/all/20240822082504.3979610-1-debug@rivosinc.com/
[8] - v8 https://lore.kernel.org/all/20240823190140.4156920-1-debug@rivosinc.com/T/
[9] - v9 https://lore.kernel.org/all/20240826152949.294506-1-debug@rivosinc.com/
[10]- v10 https://lore.kernel.org/all/20240827231906.553327-1-debug@rivosinc.com/
[11]- v11 https://lore.kernel.org/all/20240828174739.714313-1-debug@rivosinc.com/

---
v12
   - Moved ssamoswap to trans_rvzicfiss.
   - Fixed bcfi_enabled in disascontext to rely only on tb flag
   - added comment on why PMP_TRANSLATE_FAIL for stores on shadow stack page

v11:
   - default *envcfg and priv for qemu-user are handled in `riscv_cpu_reset_hold`
v10:
   - Exposed *envcfg CSR and priv to qemu-user as well and removed special
     state management for *envcfg related feature enabling for qemu-user
   - Exposing zicfilp and zicfiss as different patch
v9:
   - fix switch case fallthrough for sw_check excp in patch 4
v8:
   - fixed up `gen_cmpxchg` to store extra word2 during compile to raise storeAMO always
v7:
   - Updated decode_save_opc to take extra argument of excp_uw2 and
     updated callsites
   - added a helper for promoting load faults to store faults
   - Removed stale comments and edited existed comments
v6:
   - Added support extra store word 2 for tcg compile and extraction during unwind
   - Using extra word, AMO instructions and shadow stack instructions can raise store fault
   - some alignment and cosmetic changes
   - added vmstate migration support for elp and ssp cpu state
v5:
   - Simplified elp tracking and lpad implementation as per suggestion by richard
   - Simplified shadow stack mmu checks as per suggestion by richard
   - Converged zicfiss compressed and non-comressed instructions to same translation
   - Removed trace hooks. Don't need for upstream.

v4:
   - elp state in cpu is true/false instead of enum and elp cleared
     unconditionally on trap entry. elp in *status cleared unconditionally on
     trap return.
   - Moved logic for branch tracking in instruction translation from tb_start.
   - fixed zicfiss dependency on 'A'
   - `cpu_get_fcfien/bcfien` helpers checks fixed to check for extension first.
   - removed trace hook enums. Instead added dedicated trace helpers wherever needed.
   - fixed/simplified instruction format in decoder for lpad, sspush, sspopchk
   - simplified tlb index logic for shadow stack instructions. Removed SUM TB_FLAG
   - access to ssp CSR is gated on `cpu_get_bcfien` instead of duplicated logic
   - removed vDSO related changes for now.
v3:
   - Removed prctl specific patches because they need to be upstream
     in kernel first.
   - As suggested by Richard, added TB flag if fcfi enabled
   - Re-worked translation for landing pad and shadow stack instructions
     to not require helper.
   - tcg helpers only for cfi violation cases so that trace hooks can be
     placed.
   - Style changes.
   - fixes assert condition in accel/tcg

v2:
   - added missed file (in v1) for shadow stack instructions implementation.

Deepak Gupta (20):
  target/riscv: expose *envcfg csr and priv to qemu-user as well
  target/riscv: Add zicfilp extension
  target/riscv: Introduce elp state and enabling controls for zicfilp
  target/riscv: save and restore elp state on priv transitions
  target/riscv: additional code information for sw check
  target/riscv: tracking indirect branches (fcfi) for zicfilp
  target/riscv: zicfilp `lpad` impl and branch tracking
  disas/riscv: enable `lpad` disassembly
  target/riscv: Expose zicfilp extension as a cpu property
  target/riscv: Add zicfiss extension
  target/riscv: introduce ssp and enabling controls for zicfiss
  target/riscv: tb flag for shadow stack  instructions
  target/riscv: mmu changes for zicfiss shadow stack protection
  target/riscv: AMO operations always raise store/AMO fault
  target/riscv: update `decode_save_opc` to store extra word2
  target/riscv: implement zicfiss instructions
  target/riscv: compressed encodings for sspush and sspopchk
  disas/riscv: enable disassembly for zicfiss instructions
  disas/riscv: enable disassembly for compressed sspush/sspopchk
  target/riscv: Expose zicfiss extension as a cpu property

 disas/riscv.c                                 |  77 +++++++-
 disas/riscv.h                                 |   4 +
 target/riscv/cpu.c                            |  14 ++
 target/riscv/cpu.h                            |  31 +++-
 target/riscv/cpu_bits.h                       |  17 ++
 target/riscv/cpu_cfg.h                        |   2 +
 target/riscv/cpu_helper.c                     | 164 +++++++++++++++++-
 target/riscv/cpu_user.h                       |   1 +
 target/riscv/csr.c                            |  84 +++++++++
 target/riscv/insn16.decode                    |   4 +
 target/riscv/insn32.decode                    |  26 ++-
 .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
 target/riscv/insn_trans/trans_rva.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  61 ++++++-
 target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 114 ++++++++++++
 target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
 target/riscv/internals.h                      |   3 +
 target/riscv/machine.c                        |  38 ++++
 target/riscv/op_helper.c                      |  18 ++
 target/riscv/pmp.c                            |   5 +
 target/riscv/pmp.h                            |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |  25 +++
 target/riscv/translate.c                      |  44 ++++-
 29 files changed, 733 insertions(+), 54 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

-- 
2.44.0


