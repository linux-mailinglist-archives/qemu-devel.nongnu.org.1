Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24027AFF6A1
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Jul 2025 04:15:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZgnh-0000wb-IB; Wed, 09 Jul 2025 22:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uZgne-0000vy-EV
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 22:14:14 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uZgnb-0001Kl-GV
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 22:14:14 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxnOLtIW9oRvQlAQ--.45358S3;
 Thu, 10 Jul 2025 10:14:05 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowJAxE+TqIW9o7ukQAA--.30951S3;
 Thu, 10 Jul 2025 10:14:04 +0800 (CST)
Subject: Re: [PATCH v4 03/11] hw/loongarch: add misc register supoort avecintc
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, jiaxun.yang@flygoat.com
References: <20250703092650.2598059-1-gaosong@loongson.cn>
 <20250703092650.2598059-4-gaosong@loongson.cn>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <aa727712-dbba-99a0-2d76-5746b7b930c1@loongson.cn>
Date: Thu, 10 Jul 2025 10:12:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250703092650.2598059-4-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxE+TqIW9o7ukQAA--.30951S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Kr1rAr17urW5ZF1DCw15GFX_yoW8WFyrp3
 y8AFWrAFyjqr4IganrW3sxWrn8AF92grZFgr42k3yIgrZ8Ww15ur1vyasxJFyDA34DArsY
 9F4xGryDuF4qvrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.691,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



On 2025/7/3 下午5:26, Song Gao wrote:
> Add write misc  avecintc status bit and read avecintc feature and status bit.
Add feature register and misc register for avecintc feature checking and 
setting?
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/virt.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 112cf9a9db..26db1bbd68 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -560,6 +560,10 @@ static MemTxResult virt_iocsr_misc_write(void *opaque, hwaddr addr,
>               return MEMTX_OK;
>           }
>   
> +        if (val & BIT(IOCSRM_AVEC_EN)) {
> +            lvms->misc_status |= BIT(IOCSRM_AVEC_EN);
> +        }
> +
>           features = address_space_ldl(&lvms->as_iocsr,
>                                        EXTIOI_VIRT_BASE + EXTIOI_VIRT_CONFIG,
>                                        attrs, NULL);
> @@ -595,6 +599,9 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           break;
>       case FEATURE_REG:
>           ret = BIT(IOCSRF_MSI) | BIT(IOCSRF_EXTIOI) | BIT(IOCSRF_CSRIPI);
> +        if (virt_is_avecintc_enabled(lvms)) {
Can the name virt_is_avecintc_enabled() be renamed as virt_has_avecintc()?

Regards
Bibo Mao
> +            ret |= BIT(IOCSRF_AVEC);
> +        }
>           if (kvm_enabled()) {
>               ret |= BIT(IOCSRF_VM);
>           }
> @@ -624,6 +631,10 @@ static MemTxResult virt_iocsr_misc_read(void *opaque, hwaddr addr,
>           if (features & BIT(EXTIOI_ENABLE_INT_ENCODE)) {
>               ret |= BIT_ULL(IOCSRM_EXTIOI_INT_ENCODE);
>           }
> +        if (virt_is_avecintc_enabled(lvms) &&
> +            (lvms->misc_status & BIT(IOCSRM_AVEC_EN))) {
> +            ret |= BIT_ULL(IOCSRM_AVEC_EN);
> +        }
>           break;
>       default:
>           g_assert_not_reached();
> 


