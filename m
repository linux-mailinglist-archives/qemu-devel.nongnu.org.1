Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC6783BA8
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 10:22:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYMe1-0006QO-NB; Tue, 22 Aug 2023 04:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qYMdz-0006QG-0H
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:21:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qYMdu-0003G8-Cf
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 04:21:42 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8BxJvEMcORku9kaAA--.55379S3;
 Tue, 22 Aug 2023 16:21:32 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxXSMJcORkVClgAA--.19240S3; 
 Tue, 22 Aug 2023 16:21:29 +0800 (CST)
Subject: Re: [PATCH RESEND v5 00/19] Add some checks before translating
 instructions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Huacai Chen <chenhuacai@loongson.cn>, Jiajie Chen <c@jia.je>
References: <20230822071405.35386-1-philmd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <822e33b0-6c53-a493-f990-2c6b8f7e7851@loongson.cn>
Date: Tue, 22 Aug 2023 16:21:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230822071405.35386-1-philmd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXSMJcORkVClgAA--.19240S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw13Kw18CrWfGw4xtFW8uFX_yoW5KF13pr
 47ur15KFW8GrZ7Arn2qay5Xw4qqF45Gw42q3Wft3s3Cr4Yqry7ZF48t392gF1UJ34UWry2
 qF10kw1UZF45ZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8r9
 N3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.374,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

在 2023/8/22 下午3:13, Philippe Mathieu-Daudé 写道:
> Based-on: https://patchew.org/QEMU/20230821125959.28666-1-philmd@linaro.org/
> 
> (all series reviewed, for Song Gao to pick whichever v4/v5 is preferred)
> 
> Hi,
> 
> This series adds some checks before translating instructions
> 
> This includes:
> 
> CPUCFG[1].IOCSR
> 
> CPUCFG[2].FP
> CPUCFG[2].FP_SP
> CPUCFG[2].FP_DP
> CPUCFG[2].LSPW
> CPUCFG[2].LAM
> CPUCFG[2].LSX
> 
> V5:
> - Split 2 patches, extracting helpers
> - R-b
> Thanks!

Applied to loongarch-to-apply queue

Thanks.
Song Gao

> V4:
> - Rebase;
> - Split patch 'Add LoongArch32 cpu la132' in two patch; (PMD)
> - Remove unrelated cpucfgX;(PMD)
> - R-b.
> 
> V3:
> - Rebase;
> - The la32 instructions following Table 2 at [2].
> 
> V2:
> - Add a check parameter to the TRANS macro.
> - remove TRANS_64.
> - Add avail_ALL/64/FP/FP_SP/FP_DP/LSPW/LAM/LSX/IOCSR
>    to check instructions.
> 
> [1]: https://patchew.org/QEMU/20230809083258.1787464-1-c@jia.je/
> [2]: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#overview-of-basic-integer-instructions
> 
> Jiajie Chen (11):
>    target/loongarch: Support LoongArch32 TLB entry
>    target/loongarch: Support LoongArch32 DMW
>    target/loongarch: Support LoongArch32 VPPN
>    target/loongarch: Add LA64 & VA32 to DisasContext
>    target/loongarch: Extract make_address_x() helper
>    target/loongarch: Extract make_address_i() helper
>    target/loongarch: Extract make_address_pc() helper
>    target/loongarch: Extract set_pc() helper
>    target/loongarch: Truncate high 32 bits of address in VA32 mode
>    target/loongarch: Sign extend results in VA32 mode
>    target/loongarch: Add LoongArch32 cpu la132
> 
> Song Gao (8):
>    target/loongarch: Add a check parameter to the TRANS macro
>    target/loongarch: Add avail_64 to check la64-only instructions
>    hw/loongarch: Remove restriction of la464 cores in the virt machine
>    target/loongarch: Add avail_FP/FP_SP/FP_DP to check fpu instructions
>    target/loongarch: Add avail_LSPW to check LSPW instructions
>    target/loongarch: Add avail_LAM to check atomic instructions
>    target/loongarch: Add avail_LSX to check LSX instructions
>    target/loongarch: Add avail_IOCSR to check iocsr instructions
> 
>   target/loongarch/cpu-csr.h                    |   22 +-
>   target/loongarch/cpu.h                        |   22 +
>   target/loongarch/translate.h                  |   19 +-
>   hw/loongarch/virt.c                           |    5 -
>   target/loongarch/cpu.c                        |   46 +-
>   target/loongarch/gdbstub.c                    |    2 +-
>   target/loongarch/op_helper.c                  |    4 +-
>   target/loongarch/tlb_helper.c                 |   66 +-
>   target/loongarch/translate.c                  |   46 +
>   target/loongarch/insn_trans/trans_arith.c.inc |   98 +-
>   .../loongarch/insn_trans/trans_atomic.c.inc   |   85 +-
>   target/loongarch/insn_trans/trans_bit.c.inc   |   56 +-
>   .../loongarch/insn_trans/trans_branch.c.inc   |   27 +-
>   target/loongarch/insn_trans/trans_extra.c.inc |   24 +-
>   .../loongarch/insn_trans/trans_farith.c.inc   |   96 +-
>   target/loongarch/insn_trans/trans_fcmp.c.inc  |    8 +
>   target/loongarch/insn_trans/trans_fcnv.c.inc  |   56 +-
>   .../loongarch/insn_trans/trans_fmemory.c.inc  |   62 +-
>   target/loongarch/insn_trans/trans_fmov.c.inc  |   52 +-
>   target/loongarch/insn_trans/trans_lsx.c.inc   | 1434 +++++++++--------
>   .../loongarch/insn_trans/trans_memory.c.inc   |  118 +-
>   .../insn_trans/trans_privileged.c.inc         |   24 +-
>   target/loongarch/insn_trans/trans_shift.c.inc |   34 +-
>   23 files changed, 1386 insertions(+), 1020 deletions(-)
> 


