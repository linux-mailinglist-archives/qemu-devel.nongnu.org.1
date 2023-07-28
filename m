Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE32766581
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 09:40:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPHUt-0000hk-Td; Fri, 28 Jul 2023 03:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qPHUg-0000ha-B3
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 03:02:34 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qPHUc-0007Nj-6i
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 03:02:34 -0400
Received: from loongson.cn (unknown [10.20.42.244])
 by gateway (Coremail) with SMTP id _____8AxEvDwZ8NkZjYLAA--.26795S3;
 Fri, 28 Jul 2023 15:02:08 +0800 (CST)
Received: from [10.20.42.244] (unknown [10.20.42.244])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx4eTtZ8NkjvU9AA--.33916S3; 
 Fri, 28 Jul 2023 15:02:05 +0800 (CST)
Subject: Re: [PATCH v3 00/47] Add LoongArch LASX instructions
From: gaosong <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
References: <20230714084615.2448038-1-gaosong@loongson.cn>
Message-ID: <08c1a321-4927-539a-fefa-85efe2b80108@loongson.cn>
Date: Fri, 28 Jul 2023 15:02:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230714084615.2448038-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dx4eTtZ8NkjvU9AA--.33916S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFy8JF15Wr4xKr4fWFy8Zwc_yoWrArykpr
 W3ZrnrKFWUJFZ7XF1kXa9xX3sxXr18GrW2v3Z3t348Cw4ayr97ZF1kt3s2gFyUJayUWry2
 q3WIkw1UZF43X3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1wL
 05UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.091, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ping !

ÔÚ 2023/7/14 ÏÂÎç4:45, Song Gao Ð´µÀ:
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
> Song Gao (47):
>    target/loongarch: Add LASX data support
>    target/loongarch: meson.build support build LASX
>    target/loongarch: Add CHECK_ASXE maccro for check LASX enable
>    target/loongarch: Implement xvadd/xvsub
>    target/loongarch: Implement xvreplgr2vr
>    target/loongarch: Implement xvaddi/xvsubi
>    target/loongarch: Implement xvneg
>    target/loongarch: Implement xvsadd/xvssub
>    target/loongarch: rename lsx_helper.c to vec_helper.c
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
>    target/loongarch: Implement xvreplve xvinsve0 xvpickve xvb{sll/srl}v
>    target/loongarch: Implement xvpack xvpick xvilv{l/h}
>    target/loongarch: Implement xvshuf xvperm{i} xvshuf4i xvextrins
>    target/loongarch: Implement xvld xvst
>    target/loongarch: CPUCFG support LASX
>
>   linux-user/loongarch64/signal.c              |    1 +
>   target/loongarch/cpu.c                       |    4 +
>   target/loongarch/cpu.h                       |   26 +-
>   target/loongarch/disas.c                     |  925 +++++
>   target/loongarch/gdbstub.c                   |    1 +
>   target/loongarch/helper.h                    |  689 ++--
>   target/loongarch/insn_trans/trans_lasx.c.inc | 1008 +++++
>   target/loongarch/insn_trans/trans_lsx.c.inc  | 2047 ++++++-----
>   target/loongarch/insns.decode                |  782 ++++
>   target/loongarch/internals.h                 |   22 -
>   target/loongarch/lsx_helper.c                | 3004 ---------------
>   target/loongarch/machine.c                   |   36 +-
>   target/loongarch/meson.build                 |    2 +-
>   target/loongarch/translate.c                 |    6 +
>   target/loongarch/vec.h                       |   98 +
>   target/loongarch/vec_helper.c                | 3431 ++++++++++++++++++
>   16 files changed, 7723 insertions(+), 4359 deletions(-)
>   create mode 100644 target/loongarch/insn_trans/trans_lasx.c.inc
>   delete mode 100644 target/loongarch/lsx_helper.c
>   create mode 100644 target/loongarch/vec.h
>   create mode 100644 target/loongarch/vec_helper.c
>


