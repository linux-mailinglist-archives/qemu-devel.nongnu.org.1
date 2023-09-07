Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E13CB7970BC
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 10:29:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeAMo-0000CY-DL; Thu, 07 Sep 2023 04:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qeAMl-0000C4-Sc
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:27:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qeAMh-00006P-JI
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 04:27:55 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cx2eqCiflkfzghAA--.61242S3;
 Thu, 07 Sep 2023 16:27:46 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXSOBiflkT1RwAA--.53961S3; 
 Thu, 07 Sep 2023 16:27:45 +0800 (CST)
Subject: Re: [PATCH v5 00/57] Add LoongArch LASX instructions
From: gaosong <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, maobibo@loongson.cn
References: <20230907080916.3974502-1-gaosong@loongson.cn>
Message-ID: <41b8a294-6837-d92e-7e84-6a25956e4121@loongson.cn>
Date: Thu, 7 Sep 2023 16:27:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230907080916.3974502-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXSOBiflkT1RwAA--.53961S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3GrWxuw4DWF4rWw18Ww4fCrX_yoW7WFyxpr
 W3ZrsFkFWUJFZ7XF1kXa9xX3sIqr18GrW2v3Wft3y8Cw4ayr97ZF1kt3s2gFyUJayUury2
 q3W0kw1UZF43X3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.473, SPF_HELO_NONE=0.001,
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

Please ignore this series. I will resend.

Thanks.
Song Gao

ÔÚ 2023/9/7 ÏÂÎç4:08, Song Gao Ð´µÀ:
> Hi,
> 
> This series adds LoongArch LASX instructions.
> 
> About test:
> We use RISU test the LoongArch LASX instructions.
> 
> QEMU:
>      https://github.com/loongson/qemu/tree/tcg-old-abi-support-lasx
> RISU:
>      https://github.com/loongson/risu/tree/loongarch-suport-lasx
> 
> Please review, Thanks.
> 
> Changes for v5:
> - Rebase;
> - Split V4'patch 10 to 7 patches(patch3-9);
> - LSX use gen/gvec_vv..
> - LASX use gen/gvec_xx...
> - Don't use an array of shift_res. (patch40,41);
> - Move simply DO_XX marcos together (patch56);
> - Renamed lsx*.c to vec*.c,(patch 1);
> - Change marcos CHECK_VEC to check_vec(ctx, oprsz);
> - R-b.
> 
> Changes for v4:
> - Rebase;
> - Add avail_LASX to check.
> 
> Changes for v3:
> - Add a new patch 9, rename lsx_helper.c to vec_helper.c,
>    and use gen_helper_gvec_* series functions;
> - Use i < oprsz / (BIT / 8) in loop;
> - Some helper functions use loop;
> - patch 46: use tcg_gen_qemu_ld/st_i64 for xvld/xvst{x};
> - R-b.
> 
> Changes for v2:
> - Expand the definition of VReg to be 256 bits.
> - Use more LSX functions.
> - R-b.
> 
> Song Gao (57):
>    target/loongarch: Renamed lsx*.c to vec* .c
>    target/loongarch: Implement gvec_*_vl functions
>    target/loongarch: Use gen_helper_gvec_4_ptr for 4OP + env vector
>      instructions
>    target/loongarch: Use gen_helper_gvec_4 for 4OP vector instructions
>    target/loongarch: Use gen_helper_gvec_3_ptr for 3OP + env vector
>      instructions
>    target/loongarch: Use gen_helper_gvec_3 for 3OP vector instructions
>    target/loongarch: Use gen_helper_gvec_2_ptr for 2OP + env vector
>      instructions
>    target/loongarch: Use gen_helper_gvec_2 for 2OP vector instructions
>    target/loongarch: Use gen_helper_gvec_2i for 2OP + imm vector
>      instructions
>    target/loongarch: Replace CHECK_SXE to check_vec(ctx, 16)
>    target/loongarch: Add LASX data support
>    target/loongarch: check_vec support check LASX instructions
>    target/loongarch: Add avail_LASX to check LASX instructions
>    target/loongarch: Implement xvadd/xvsub
>    target/loongarch: Implement xvreplgr2vr
>    target/loongarch: Implement xvaddi/xvsubi
>    target/loongarch: Implement xvneg
>    target/loongarch: Implement xvsadd/xvssub
>    target/loongarch: Implement xvhaddw/xvhsubw
>    target/loongarch: Implement xvaddw/xvsubw
>    target/loongarch: Implement xavg/xvagr
>    target/loongarch: Implement xvabsd
>    target/loongarch: Implement xvadda
>    target/loongarch: Implement xvmax/xvmin
>    target/loongarch: Implement xvmul/xvmuh/xvmulw{ev/od}
>    target/loongarch: Implement xvmadd/xvmsub/xvmaddw{ev/od}
>    target/loongarch; Implement xvdiv/xvmod
>    target/loongarch: Implement xvsat
>    target/loongarch: Implement xvexth
>    target/loongarch: Implement vext2xv
>    target/loongarch: Implement xvsigncov
>    target/loongarch: Implement xvmskltz/xvmskgez/xvmsknz
>    target/loognarch: Implement xvldi
>    target/loongarch: Implement LASX logic instructions
>    target/loongarch: Implement xvsll xvsrl xvsra xvrotr
>    target/loongarch: Implement xvsllwil xvextl
>    target/loongarch: Implement xvsrlr xvsrar
>    target/loongarch: Implement xvsrln xvsran
>    target/loongarch: Implement xvsrlrn xvsrarn
>    target/loongarch: Implement xvssrln xvssran
>    target/loongarch: Implement xvssrlrn xvssrarn
>    target/loongarch: Implement xvclo xvclz
>    target/loongarch: Implement xvpcnt
>    target/loongarch: Implement xvbitclr xvbitset xvbitrev
>    target/loongarch: Implement xvfrstp
>    target/loongarch: Implement LASX fpu arith instructions
>    target/loongarch: Implement LASX fpu fcvt instructions
>    target/loongarch: Implement xvseq xvsle xvslt
>    target/loongarch: Implement xvfcmp
>    target/loongarch: Implement xvbitsel xvset
>    target/loongarch: Implement xvinsgr2vr xvpickve2gr
>    target/loongarch: Implement xvreplve xvinsve0 xvpickve
>    target/loongarch: Implement xvpack xvpick xvilv{l/h}
>    target/loongarch: Implement xvshuf xvperm{i} xvshuf4i
>    target/loongarch: Implement xvld xvst
>    target/loongarch: Move simply DO_XX marcos togther
>    target/loongarch: CPUCFG support LASX
> 
>   target/loongarch/cpu.h                        |   26 +-
>   target/loongarch/helper.h                     |  689 ++--
>   target/loongarch/internals.h                  |   22 -
>   target/loongarch/translate.h                  |    1 +
>   target/loongarch/vec.h                        |   75 +
>   target/loongarch/insns.decode                 |  782 ++++
>   linux-user/loongarch64/signal.c               |    1 +
>   target/loongarch/cpu.c                        |    4 +
>   target/loongarch/disas.c                      |  924 +++++
>   target/loongarch/gdbstub.c                    |    1 +
>   target/loongarch/lsx_helper.c                 | 3004 --------------
>   target/loongarch/machine.c                    |   36 +-
>   target/loongarch/translate.c                  |    7 +-
>   target/loongarch/vec_helper.c                 | 3508 +++++++++++++++++
>   .../{trans_lsx.c.inc => trans_vec.c.inc}      | 2413 +++++++++---
>   target/loongarch/meson.build                  |    2 +-
>   16 files changed, 7669 insertions(+), 3826 deletions(-)
>   create mode 100644 target/loongarch/vec.h
>   delete mode 100644 target/loongarch/lsx_helper.c
>   create mode 100644 target/loongarch/vec_helper.c
>   rename target/loongarch/insn_trans/{trans_lsx.c.inc => trans_vec.c.inc} (62%)
> 


