Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52985995B0C
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Oct 2024 00:52:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syJ24-00008Z-RY; Tue, 08 Oct 2024 18:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ22-000086-Ph
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:18 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1syJ20-0003t0-BM
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 18:50:18 -0400
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so4010488a12.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 15:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728427814; x=1729032614;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SYWocMPERHAMMWl5VDTtG3ivULINtPFu0jSGtVJu8V4=;
 b=sHj/4bL9bzU7NR0uze/lT99Sd+ajxQpAjyESLzb7AKB8bbPaxfmarp6hcmnZ117sFb
 OgMKw10pVGEGGxoJhM+xHYwbvq6JGZwZGaAxXj9CHlRLc5WQhHjlfpSSuoPCIRbRjl9F
 oJ/rZIFI2m1pGuA0svuyLYr8SC238X/mlAPwnCeT9ZYQYM09W8OVp80FnatAbu+FENRu
 hIxKU2kJZSYNJUqtbsj3oyc47BzuLFtRik3vjr3RlxFfe+pL0Jjm1E6+1tF6S2U9duCm
 z8QsCP8aUyw17rxgaWzLW+VpOvJyxwnRMmUo8W8ujCuI+MD3aMdnq66et8NhupXS6WLX
 bS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728427814; x=1729032614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SYWocMPERHAMMWl5VDTtG3ivULINtPFu0jSGtVJu8V4=;
 b=lKDqpswTO0p0RQhd9n5Tpmdd6a8JAvy6bOlcBIXDW8vT9SI5yUp6CsKWmIeBbLAOwX
 VjdQ8h27lb8784e5txF+XAv7gObLgMJ2/Kml9uSBTDLukSpH6ggX0mMyJ5m+Jz39pHhD
 nEIk1lKjWLV9Fbi5dFo66INrIKmFATpUB15ovb3FR5gEjRRap0wdkmH4uz0Q0b56FOkJ
 tR8RzLGzU8FyRU+PXoXD6rB2lsDRfsGlOKIEw4izRULkE1/c7pD/2nWcOIbJKTDuK7te
 Eab/ygDEZVidFpqQ1YarE9AOdhgO/D/CHWZ1vFiHLLcmdrez/sUaC0jdXfupVx9Wu+ES
 3/BA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4s52v8YEcJ6SRJvVOEyt35Erxu8uleUfSjZ+y3dCfAiYw1i/LZZd8bbObX807JCCRfyZ1w32c4ABH@nongnu.org
X-Gm-Message-State: AOJu0YwFWM6DMIpaEjjQ4n8KnaTzUb+EhXsmHS6md08YUx3DPgzERsCw
 ch654T0fKb5MFi+n/81JVat4/OfVlDPkzN8qdtJTVG0V4cDCUSPpimTGd7N8mac=
X-Google-Smtp-Source: AGHT+IHhYUAEBUNVJIl81rSJKuNWDxV68nWLXfFyC0j9yXoSIq6f4PwyD0Hyt995GPkTN3Ppvs1vew==
X-Received: by 2002:a17:902:fb4e:b0:20b:a41f:6e48 with SMTP id
 d9443c01a7336-20c63736907mr6977115ad.27.1728427814267; 
 Tue, 08 Oct 2024 15:50:14 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138af962sm60006105ad.26.2024.10.08.15.50.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 15:50:13 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, kito.cheng@sifive.com,
 Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH v16 00/20] riscv support for control flow integrity extensions
Date: Tue,  8 Oct 2024 15:49:50 -0700
Message-ID: <20241008225010.1861630-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.45.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=debug@rivosinc.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

v16 for riscv zicfilp and zicfiss extensions support in qemu.

Following change in this version:
cache block operations of clean, flush and inval have store semantics.
These operations on shadow stack must look like regular stores and must
always raise store/AMO access fault. However with current logic,
`probe_access_flags` will succeed because it will be seen as a load.
In order to prevent that `get_physical_address` must receive `probe`
parameter. Depending on that parameter, `get_physical_address` can return
TRANSLATE_PMP_FAIL.

In v15, this was created as a new commit so that we could review and discuss
it out. In this version, I've squashed it with "mmu changes for zicfiss shadow
stack protection".

zicfilp and zicfiss spec pdf
----------------------------
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
[12]- v12 https://lore.kernel.org/all/20240829233425.1005029-1-debug@rivosinc.com/
[13]- v14 https://lore.kernel.org/all/20240912235320.3768582-1-debug@rivosinc.com/
[14]- v15 https://lore.kernel.org/all/20241003183342.679249-1-debug@rivosinc.com/

---
v16:
   - Squashed changes with respect to "disallow probe access" to shadow stack
     from cbo.clean/flush/inval flows with "shadow stack mmu" changes 
v15:
   - Extended `get_physical_address` to take `probe` parameter. This is to ensure
     that cbo.clean/flush/inval accesses to shadow stack always lead to store/AMO
     access fault

v14:
   - Rebased on https://github.com/alistair23/qemu/blob/riscv-to-apply.next
v13:
   - Fixed bug(s) reported by richard that
         - shadow stack doesn't exist in M-mode
         - shadow stack is not available in M + U only config
   - updated commit messages with removal of `ufcfien` and `ubcfien` mentions
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
 target/riscv/cpu.h                            |  31 ++-
 target/riscv/cpu_bits.h                       |  17 ++
 target/riscv/cpu_cfg.h                        |   2 +
 target/riscv/cpu_helper.c                     | 184 ++++++++++++++++--
 target/riscv/cpu_user.h                       |   1 +
 target/riscv/csr.c                            |  84 ++++++++
 target/riscv/insn16.decode                    |   4 +
 target/riscv/insn32.decode                    |  26 ++-
 .../riscv/insn_trans/trans_privileged.c.inc   |   8 +-
 target/riscv/insn_trans/trans_rva.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvd.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvf.c.inc       |   4 +-
 target/riscv/insn_trans/trans_rvh.c.inc       |   8 +-
 target/riscv/insn_trans/trans_rvi.c.inc       |  61 +++++-
 target/riscv/insn_trans/trans_rvvk.c.inc      |  10 +-
 target/riscv/insn_trans/trans_rvzacas.c.inc   |   4 +-
 target/riscv/insn_trans/trans_rvzfh.c.inc     |   4 +-
 target/riscv/insn_trans/trans_rvzicfiss.c.inc | 114 +++++++++++
 target/riscv/insn_trans/trans_svinval.c.inc   |   6 +-
 target/riscv/internals.h                      |   3 +
 target/riscv/machine.c                        |  38 ++++
 target/riscv/op_helper.c                      |  17 ++
 target/riscv/pmp.c                            |   5 +
 target/riscv/pmp.h                            |   3 +-
 target/riscv/tcg/tcg-cpu.c                    |  29 +++
 target/riscv/translate.c                      |  44 ++++-
 29 files changed, 749 insertions(+), 61 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvzicfiss.c.inc

-- 
2.45.0


