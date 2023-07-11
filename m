Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69ACF74EF36
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 14:43:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJChg-0004C1-Gc; Tue, 11 Jul 2023 08:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qJCha-00049s-Lk
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:42:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qJChX-00043B-K7
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 08:42:46 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8BxpPA0Tq1kkoMDAA--.10088S3;
 Tue, 11 Jul 2023 20:42:29 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxB80oTq1kILYoAA--.42331S3; 
 Tue, 11 Jul 2023 20:42:27 +0800 (CST)
Subject: Re: [PATCH] hw/intc/loongarch_pch: fix edge triggered irq handling
To: Bibo Mao <maobibo@loongson.cn>
Cc: qemu-devel@nongnu.org, Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20230707091557.1474790-1-maobibo@loongson.cn>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <d06ad8e3-84ac-c129-8b6b-115720cd9633@loongson.cn>
Date: Tue, 11 Jul 2023 20:42:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230707091557.1474790-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxB80oTq1kILYoAA--.42331S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF17XFWUtryxAryxWry5Jrc_yoW8WF47pF
 WDC3Z0yFZ5Jr17XF1ku345WryxZwsrWrWa9Fs5Ary7Xas8JFyFgrn5Jr47ZFy8C395GFW2
 vr4rGrW5Za4UGabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UE-erU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.089, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



ÔÚ 2023/7/7 ÏÂÎç5:15, Bibo Mao Ð´µÀ:
> For edge triggered irq, qemu_irq_pulse is used to inject irq. It will
> set irq with high level and low level soon to simluate pulse irq.
>
> For edge triggered irq, irq is injected and set as pending at rising
> level, do not clear irq at lowering level. LoongArch pch interrupt will
> clear irq for lowering level irq, there will be problem. ACPI ged deivce
> is edge-triggered irq, it is used for cpu/memory hotplug.
>
> This patch fixes memory hotplug issue on LoongArch virt machine.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_pic.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/intc/loongarch_pch_pic.c b/hw/intc/loongarch_pch_pic.c
> index 9208fc4460..6aa4cadfa4 100644
> --- a/hw/intc/loongarch_pch_pic.c
> +++ b/hw/intc/loongarch_pch_pic.c
> @@ -30,7 +30,11 @@ static void pch_pic_update_irq(LoongArchPCHPIC *s, uint64_t mask, int level)
>               qemu_set_irq(s->parent_irq[s->htmsi_vector[irq]], 1);
>           }
>       } else {
> -        val = mask & s->intisr;
> +        /*
> +         * intirr means requested pending irq
> +         * do not clear pending irq for edge-triggered on lowering edge
> +         */
> +        val = mask & s->intisr & ~s->intirr;
>           if (val) {
>               irq = ctz64(val);
>               s->intisr &= ~MAKE_64BIT_MASK(irq, 1);
> @@ -51,6 +55,7 @@ static void pch_pic_irq_handler(void *opaque, int irq, int level)
>           /* Edge triggered */
>           if (level) {
>               if ((s->last_intirr & mask) == 0) {
> +                /* marked pending on a rising edge */
>                   s->intirr |= mask;
>               }
>               s->last_intirr |= mask;


