Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0BF7A732C
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 08:53:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qir42-0007hA-S5; Wed, 20 Sep 2023 02:51:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qir40-0007gZ-De
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:51:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qir3x-0003zV-Ep
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 02:51:56 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8Bx5fB+lgplcS8qAA--.15908S3;
 Wed, 20 Sep 2023 14:51:43 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxzdx7lgplhVYMAA--.24315S2; 
 Wed, 20 Sep 2023 14:51:39 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Subject: [PULL 00/57] loongarch-to-apply queue
Date: Wed, 20 Sep 2023 14:50:42 +0800
Message-Id: <20230920065139.1403868-1-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxzdx7lgplhVYMAA--.24315S2
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

The following changes since commit 4907644841e3200aea6475c0f72d3d987e9f3d93:

  Merge tag 'mem-2023-09-19' of https://github.com/davidhildenbrand/qemu into staging (2023-09-19 13:22:19 -0400)

are available in the Git repository at:

  https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20230920

for you to fetch changes up to 2cd81e37512648a03d7dd37c39fa7fd50e2e4478:

  target/loongarch: CPUCFG support LASX (2023-09-20 14:33:43 +0800)

----------------------------------------------------------------
Add LASX instructions support.

----------------------------------------------------------------
Song Gao (57):
      target/loongarch: Renamed lsx*.c to vec* .c
      target/loongarch: Implement gvec_*_vl functions
      target/loongarch: Use gen_helper_gvec_4_ptr for 4OP + env vector instructions
      target/loongarch: Use gen_helper_gvec_4 for 4OP vector instructions
      target/loongarch: Use gen_helper_gvec_3_ptr for 3OP + env vector instructions
      target/loongarch: Use gen_helper_gvec_3 for 3OP vector instructions
      target/loongarch: Use gen_helper_gvec_2_ptr for 2OP + env vector instructions
      target/loongarch: Use gen_helper_gvec_2 for 2OP vector instructions
      target/loongarch: Use gen_helper_gvec_2i for 2OP + imm vector instructions
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
      target/loongarch: Implement xvldi
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

 target/loongarch/cpu.h                             |   26 +-
 target/loongarch/helper.h                          |  689 ++--
 target/loongarch/internals.h                       |   22 -
 target/loongarch/translate.h                       |    1 +
 target/loongarch/vec.h                             |   75 +
 target/loongarch/insns.decode                      |  782 +++++
 linux-user/loongarch64/signal.c                    |    1 +
 target/loongarch/cpu.c                             |    4 +
 target/loongarch/disas.c                           |  924 ++++++
 target/loongarch/gdbstub.c                         |    1 +
 target/loongarch/lsx_helper.c                      | 3004 -----------------
 target/loongarch/machine.c                         |   36 +-
 target/loongarch/translate.c                       |   19 +-
 target/loongarch/vec_helper.c                      | 3494 ++++++++++++++++++++
 .../{trans_lsx.c.inc => trans_vec.c.inc}           | 2393 ++++++++++----
 target/loongarch/meson.build                       |    2 +-
 16 files changed, 7386 insertions(+), 4087 deletions(-)
 create mode 100644 target/loongarch/vec.h
 delete mode 100644 target/loongarch/lsx_helper.c
 create mode 100644 target/loongarch/vec_helper.c
 rename target/loongarch/insn_trans/{trans_lsx.c.inc => trans_vec.c.inc} (61%)


