Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 195AD732887
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 09:12:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA3cH-0001W1-2p; Fri, 16 Jun 2023 03:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qA3cF-0001Vo-0y
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:11:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qA3cD-0006pP-4D
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 03:11:26 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8AxV+kaC4xkq+AFAA--.10531S3;
 Fri, 16 Jun 2023 15:11:22 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxZuQaC4xkBv4cAA--.16735S3; 
 Fri, 16 Jun 2023 15:11:22 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Fix CSR.DMW0-3.VSEG check
To: Jiajie Chen <c@jia.je>, qemu-devel@nongnu.org
Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
References: <20230614065556.2397513-1-c@jia.je>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <7d1e54b9-76ee-4583-b5b4-a871ae81f70b@loongson.cn>
Date: Fri, 16 Jun 2023 15:11:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230614065556.2397513-1-c@jia.je>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxZuQaC4xkBv4cAA--.16735S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJrWxtr4fKFW5uw1xKryrZrc_yoW8JFyUpF
 n3CF42yayUGrWDCan29wn0q3W5XFs7K3W2v3Z7JryFkrn0g34I9F48Gwn8KF4xJF4xua10
 vr4jy34FvF1kX3XCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
 0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
 aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2
 xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
 x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r
 17MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
 7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
 W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
 cHUqUUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.098, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



ÔÚ 2023/6/14 ÏÂÎç2:55, Jiajie Chen Ð´µÀ:
> The previous code checks whether the highest 16 bits of virtual address
> equal to that of CSR.DMW0-3. This is incorrect according to the spec,
> and is corrected to compare only the highest four bits instead.
>
> Signed-off-by: Jiajie Chen <c@jia.je>
> ---
>   target/loongarch/tlb_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/target/loongarch/tlb_helper.c b/target/loongarch/tlb_helper.c
> index cce1db1e0a..6e00190547 100644
> --- a/target/loongarch/tlb_helper.c
> +++ b/target/loongarch/tlb_helper.c
> @@ -185,10 +185,10 @@ static int get_physical_address(CPULoongArchState *env, hwaddr *physical,
>       }
>   
>       plv = kernel_mode | (user_mode << R_CSR_DMW_PLV3_SHIFT);
> -    base_v = address >> TARGET_VIRT_ADDR_SPACE_BITS;
> +    base_v = address >> R_CSR_DMW_VSEG_SHIFT;
>       /* Check direct map window */
>       for (int i = 0; i < 4; i++) {
> -        base_c = env->CSR_DMW[i] >> TARGET_VIRT_ADDR_SPACE_BITS;
> +        base_c = FIELD_EX64(env->CSR_DMW[i], CSR_DMW, VSEG);
>           if ((plv & env->CSR_DMW[i]) && (base_c == base_v)) {
>               *physical = dmw_va2pa(address);
>               *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;


