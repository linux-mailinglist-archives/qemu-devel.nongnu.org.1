Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EBCA6836F
	for <lists+qemu-devel@lfdr.de>; Wed, 19 Mar 2025 04:08:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tujmd-00008A-HQ; Tue, 18 Mar 2025 23:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1tujmb-00007O-Lg
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 23:07:53 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1tujmZ-0003qq-OX
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 23:07:53 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxquADNdpnII+cAA--.26059S3;
 Wed, 19 Mar 2025 11:07:47 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMAxzMQDNdpnm+1SAA--.41516S3;
 Wed, 19 Mar 2025 11:07:47 +0800 (CST)
Subject: Re: [PATCH 3/5] hw/intc/loongarch_extioi: Replace legacy reset
 callback with new api
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250307071346.2260062-1-maobibo@loongson.cn>
 <20250307071346.2260062-4-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <695e88ca-ad86-0e70-9942-4421910b8347@loongson.cn>
Date: Wed, 19 Mar 2025 11:10:12 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250307071346.2260062-4-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMAxzMQDNdpnm+1SAA--.41516S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr48tr4ftFW5uw4fZF1xtFc_yoW5Gry3pr
 yUZF15GrWUZw4DJrsrKa4DWryUXrsagF12qF1rKa4rCan8Jry0g34vqr9xXF1UG395A34j
 q3s3tw15ZFnFy3gCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7MmhUUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.526, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

�� 2025/3/7 ����3:13, Bibo Mao д��:
> Replace legacy reset callback register device_class_set_legacy_reset()
> with new function resettable_class_set_parent_phases(). With new API,
> it will call reset callback of parent object and then itself.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_extioi.c         | 12 ++++++++----
>   include/hw/intc/loongarch_extioi.h |  1 +
>   2 files changed, 9 insertions(+), 4 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

thanks.
Song Gao
> diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
> index a51a215e6e..0fecc62a09 100644
> --- a/hw/intc/loongarch_extioi.c
> +++ b/hw/intc/loongarch_extioi.c
> @@ -377,11 +377,13 @@ static void loongarch_extioi_unrealize(DeviceState *dev)
>       g_free(s->cpu);
>   }
>   
> -static void loongarch_extioi_reset(DeviceState *d)
> +static void loongarch_extioi_reset_hold(Object *obj, ResetType type)
>   {
> -    LoongArchExtIOICommonState *s = LOONGARCH_EXTIOI_COMMON(d);
> +    LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_GET_CLASS(obj);
>   
> -    s->status = 0;
> +    if (lec->parent_phases.hold) {
> +        lec->parent_phases.hold(obj, type);
> +    }
>   }
>   
>   static int vmstate_extioi_post_load(void *opaque, int version_id)
> @@ -406,12 +408,14 @@ static void loongarch_extioi_class_init(ObjectClass *klass, void *data)
>       DeviceClass *dc = DEVICE_CLASS(klass);
>       LoongArchExtIOIClass *lec = LOONGARCH_EXTIOI_CLASS(klass);
>       LoongArchExtIOICommonClass *lecc = LOONGARCH_EXTIOI_COMMON_CLASS(klass);
> +    ResettableClass *rc = RESETTABLE_CLASS(klass);
>   
>       device_class_set_parent_realize(dc, loongarch_extioi_realize,
>                                       &lec->parent_realize);
>       device_class_set_parent_unrealize(dc, loongarch_extioi_unrealize,
>                                         &lec->parent_unrealize);
> -    device_class_set_legacy_reset(dc, loongarch_extioi_reset);
> +    resettable_class_set_parent_phases(rc, NULL, loongarch_extioi_reset_hold,
> +                                       NULL, &lec->parent_phases);
>       lecc->post_load = vmstate_extioi_post_load;
>   }
>   
> diff --git a/include/hw/intc/loongarch_extioi.h b/include/hw/intc/loongarch_extioi.h
> index 351f18afcf..4a6ae903e9 100644
> --- a/include/hw/intc/loongarch_extioi.h
> +++ b/include/hw/intc/loongarch_extioi.h
> @@ -22,6 +22,7 @@ struct LoongArchExtIOIClass {
>   
>       DeviceRealize parent_realize;
>       DeviceUnrealize parent_unrealize;
> +    ResettablePhases parent_phases;
>   };
>   
>   #endif /* LOONGARCH_EXTIOI_H */


