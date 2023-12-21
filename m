Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 740EC81AEDF
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 07:44:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGCmV-0007Do-9g; Thu, 21 Dec 2023 01:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rGCmL-0007DJ-Ny
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:43:33 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rGCmI-0005er-EK
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 01:43:33 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxVPCL3oNllFIDAA--.16936S3;
 Thu, 21 Dec 2023 14:43:23 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Axnr6J3oNlGkwDAA--.10553S3; 
 Thu, 21 Dec 2023 14:43:21 +0800 (CST)
Subject: Re: [PATCH v2 09/71] target/loongarch: Constify VMState in machine.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20231221031652.119827-1-richard.henderson@linaro.org>
 <20231221031652.119827-10-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <6dfca7e7-77f5-2550-f49d-55b488a51682@loongson.cn>
Date: Thu, 21 Dec 2023 14:43:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231221031652.119827-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Axnr6J3oNlGkwDAA--.10553S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxurW3GF18Kw15KFykKw4ftFc_yoW5ur15pw
 nxAF1DKFW09rZ3Zw4xGrWrWFs8Wr17Ga12kr4UCwn3KF1xWrsagrZ7trWxArZ3Ca40gr12
 vF1xZryDJF4kZ3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
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
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.41, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2023/12/21 ÉÏÎç11:15, Richard Henderson Ð´µÀ:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/loongarch/machine.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/machine.c b/target/loongarch/machine.c
> index 1c4e01d076..c7029fb9b4 100644
> --- a/target/loongarch/machine.c
> +++ b/target/loongarch/machine.c
> @@ -14,7 +14,7 @@ static const VMStateDescription vmstate_fpu_reg = {
>       .name = "fpu_reg",
>       .version_id = 1,
>       .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_UINT64(UD(0), VReg),
>           VMSTATE_END_OF_LIST()
>       }
> @@ -36,7 +36,7 @@ static const VMStateDescription vmstate_fpu = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .needed = fpu_needed,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_FPU_REGS(env.fpr, LoongArchCPU, 0),
>           VMSTATE_UINT32(env.fcsr0, LoongArchCPU),
>           VMSTATE_BOOL_ARRAY(env.cf, LoongArchCPU, 8),
> @@ -48,7 +48,7 @@ static const VMStateDescription vmstate_lsxh_reg = {
>       .name = "lsxh_reg",
>       .version_id = 1,
>       .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_UINT64(UD(1), VReg),
>           VMSTATE_END_OF_LIST()
>       }
> @@ -70,7 +70,7 @@ static const VMStateDescription vmstate_lsx = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .needed = lsx_needed,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_LSXH_REGS(env.fpr, LoongArchCPU, 0),
>           VMSTATE_END_OF_LIST()
>       },
> @@ -80,7 +80,7 @@ static const VMStateDescription vmstate_lasxh_reg = {
>       .name = "lasxh_reg",
>       .version_id = 1,
>       .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_UINT64(UD(2), VReg),
>           VMSTATE_UINT64(UD(3), VReg),
>           VMSTATE_END_OF_LIST()
> @@ -103,7 +103,7 @@ static const VMStateDescription vmstate_lasx = {
>       .version_id = 1,
>       .minimum_version_id = 1,
>       .needed = lasx_needed,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_LASXH_REGS(env.fpr, LoongArchCPU, 0),
>           VMSTATE_END_OF_LIST()
>       },
> @@ -114,7 +114,7 @@ const VMStateDescription vmstate_tlb = {
>       .name = "cpu/tlb",
>       .version_id = 0,
>       .minimum_version_id = 0,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_UINT64(tlb_misc, LoongArchTLB),
>           VMSTATE_UINT64(tlb_entry0, LoongArchTLB),
>           VMSTATE_UINT64(tlb_entry1, LoongArchTLB),
> @@ -127,7 +127,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
>       .name = "cpu",
>       .version_id = 1,
>       .minimum_version_id = 1,
> -    .fields = (VMStateField[]) {
> +    .fields = (const VMStateField[]) {
>           VMSTATE_UINTTL_ARRAY(env.gpr, LoongArchCPU, 32),
>           VMSTATE_UINTTL(env.pc, LoongArchCPU),
>   
> @@ -193,7 +193,7 @@ const VMStateDescription vmstate_loongarch_cpu = {
>   
>           VMSTATE_END_OF_LIST()
>       },
> -    .subsections = (const VMStateDescription*[]) {
> +    .subsections = (const VMStateDescription * const []) {
>           &vmstate_fpu,
>           &vmstate_lsx,
>           &vmstate_lasx,


