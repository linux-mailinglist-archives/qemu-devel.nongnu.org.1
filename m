Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4057970A7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:12:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeA5C-0003z2-Sl; Thu, 07 Sep 2023 04:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeA4t-0003uc-6z
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:09:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeA4p-0003Kx-12
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:09:26 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Dx_7suhflkQjQhAA--.7206S3;
 Thu, 07 Sep 2023 16:09:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8DxviMthflkXE1wAA--.31585S2; 
 Thu, 07 Sep 2023 16:09:17 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	maobibo@loongson.cn
Subject: [PATCH v5 00/57] Add LoongArch LASX instructions
Date: Thu,  7 Sep 2023 16:08:19 +0800
Message-Id: <20230907080916.3974502-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxviMthflkXE1wAA--.31585S2
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hi,

This series adds LoongArch LASX instructions.

About test:
We use RISU test the LoongArch LASX instructions.

QEMU:
    https://github.com/loongson/qemu/tree/tcg-old-abi-support-lasx
RISU:
    https://github.com/loongson/risu/tree/loongarch-suport-lasx

Please review, Thanks.

Changes for v5:
- Rebase;
- Split V4'patch 10 to 7 patches(patch3-9);
- LSX use gen/gvec_vv..
- LASX use gen/gvec_xx...
- Don't use an array of shift_res. (patch40,41);
- Move simply DO_XX marcos together (patch56);
- Renamed lsx*.c to vec*.c,(patch 1);
- Change marcos CHECK_VEC to check_vec(ctx, oprsz);
- R-b.

Changes for v4:
- Rebase;
- Add avail_LASX to check.

Changes for v3:
- Add a new patch 9, rename lsx_helper.c to vec_helper.c,
  and use gen_helper_gvec_* series functions;
- Use i < oprsz / (BIT / 8) in loop;
- Some helper functions use loop;
- patch 46: use tcg_gen_qemu_ld/st_i64 for xvld/xvst{x};
- R-b.

Changes for v2:
- Expand the definition of VReg to be 256 bits.
- Use more LSX functions.
- R-b.

Song Gao (57):
  target/loongarch: Renamed lsx*.c to vec* .c
  target/loongarch: Implement gvec_*_vl functions
  target/loongarch: Use gen_helper_gvec_4_ptr for 4OP + env vector
    instructions
  target/loongarch: Use gen_helper_gvec_4 for 4OP vector instructions
  target/loongarch: Use gen_helper_gvec_3_ptr for 3OP + env vector
    instructions
  target/loongarch: Use gen_helper_gvec_3 for 3OP vector instructions
  target/loongarch: Use gen_helper_gvec_2_ptr for 2OP + env vector
    instructions
  target/loongarch: Use gen_helper_gvec_2 for 2OP vector instructions
  target/loongarch: Use gen_helper_gvec_2i for 2OP + imm vector
    instructions
  target/loongarch: Replace CHECK_SXE to check_vec(ctx, 16)
  target/loongarch: Add LASX data support
  target/loongarch: check_vec support check LASX instructions
  target/loongarch: Add avail_LASX to check LASX instructions
  target/loongarch: Implement xvadd/xvsub
  target/loongarch: Implement xvreplgr2vr
  target/loongarch: Implement xvaddi/xvsubi
  target/loongarch: Implement xvneg
  target/loongarch: Implement xvsadd/xvssub
  target/loongarch: Implement xvhaddw/xvhsubw
  target/loongarch: Implement xvaddw/xvsubw
  target/loongarch: Implement xavg/xvagr
  target/loongarch: Implement xvabsd
  target/loongarch: Implement xvadda
  target/loongarch: Implement xvmax/xvmin
  target/loongarch: Implement xvmul/xvmuh/xvmulw{ev/od}
  target/loongarch: Implement xvmadd/xvmsub/xvmaddw{ev/od}
  target/loongarch; Implement xvdiv/xvmod
  target/loongarch: Implement xvsat
  target/loongarch: Implement xvexth
  target/loongarch: Implement vext2xv
  target/loongarch: Implement xvsigncov
  target/loongarch: Implement xvmskltz/xvmskgez/xvmsknz
  target/loognarch: Implement xvldi
  target/loongarch: Implement LASX logic instructions
  target/loongarch: Implement xvsll xvsrl xvsra xvrotr
  target/loongarch: Implement xvsllwil xvextl
  target/loongarch: Implement xvsrlr xvsrar
  target/loongarch: Implement xvsrln xvsran
  target/loongarch: Implement xvsrlrn xvsrarn
  target/loongarch: Implement xvssrln xvssran
  target/loongarch: Implement xvssrlrn xvssrarn
  target/loongarch: Implement xvclo xvclz
  target/loongarch: Implement xvpcnt
  target/loongarch: Implement xvbitclr xvbitset xvbitrev
  target/loongarch: Implement xvfrstp
  target/loongarch: Implement LASX fpu arith instructions
  target/loongarch: Implement LASX fpu fcvt instructions
  target/loongarch: Implement xvseq xvsle xvslt
  target/loongarch: Implement xvfcmp
  target/loongarch: Implement xvbitsel xvset
  target/loongarch: Implement xvinsgr2vr xvpickve2gr
  target/loongarch: Implement xvreplve xvinsve0 xvpickve
  target/loongarch: Implement xvpack xvpick xvilv{l/h}
  target/loongarch: Implement xvshuf xvperm{i} xvshuf4i
  target/loongarch: Implement xvld xvst
  target/loongarch: Move simply DO_XX marcos togther
  target/loongarch: CPUCFG support LASX

 target/loongarch/cpu.h                        |   26 +-
 target/loongarch/helper.h                     |  689 ++--
 target/loongarch/internals.h                  |   22 -
 target/loongarch/translate.h                  |    1 +
 target/loongarch/vec.h                        |   75 +
 target/loongarch/insns.decode                 |  782 ++++
 linux-user/loongarch64/signal.c               |    1 +
 target/loongarch/cpu.c                        |    4 +
 target/loongarch/disas.c                      |  924 +++++
 target/loongarch/gdbstub.c                    |    1 +
 target/loongarch/lsx_helper.c                 | 3004 --------------
 target/loongarch/machine.c                    |   36 +-
 target/loongarch/translate.c                  |    7 +-
 target/loongarch/vec_helper.c                 | 3508 +++++++++++++++++
 .../{trans_lsx.c.inc => trans_vec.c.inc}      | 2413 +++++++++---
 target/loongarch/meson.build                  |    2 +-
 16 files changed, 7669 insertions(+), 3826 deletions(-)
 create mode 100644 target/loongarch/vec.h
 delete mode 100644 target/loongarch/lsx_helper.c
 create mode 100644 target/loongarch/vec_helper.c
 rename target/loongarch/insn_trans/{trans_lsx.c.inc => trans_vec.c.inc} (62%)

-- 
2.39.1


