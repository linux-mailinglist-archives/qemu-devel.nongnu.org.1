Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B91A99E11
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Apr 2025 03:24:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7l9K-0005Hi-6y; Wed, 23 Apr 2025 21:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u7l8q-0004zi-Af
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:12:40 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u7l8n-0006Zp-2l
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 21:12:40 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Bx12n+jwloxvrEAA--.64279S3;
 Thu, 24 Apr 2025 09:12:31 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowMCx7xv7jwlosbaSAA--.36356S3;
 Thu, 24 Apr 2025 09:12:29 +0800 (CST)
Subject: Re: [PATCH] hw/intc/loongarch_pch_msi: Remove gpio input handler
To: Bibo Mao <maobibo@loongson.cn>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
References: <20250410085004.3577627-1-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <60ee8c05-d07b-9c14-790a-7af628820204@loongson.cn>
Date: Thu, 24 Apr 2025 09:15:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250410085004.3577627-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowMCx7xv7jwlosbaSAA--.36356S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar18Jr4fGFyDGrWUuFyDArc_yoW8WrWxpr
 Zxua4rKr4rJw4DuFs2q3429F93XFnrGF4xZFnxKry7Crn8Awn8WF18Jry2gFy2k3yruFyq
 v3ykKrWUX3WUCabCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtx
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-0.765, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

�� 2025/4/10 ����4:50, Bibo Mao д��:
> MSI interrupt is triggered by writing message on specified memory address.
> In generic it is used by PCI devices, and no device is connected pch MSI
> irqchip with GPIO pin line method, here remove gpio input setting for MSI
> controller.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/intc/loongarch_pch_msi.c | 9 ---------
>   1 file changed, 9 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>
Tested-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao.
> diff --git a/hw/intc/loongarch_pch_msi.c b/hw/intc/loongarch_pch_msi.c
> index 66b5c1e660..bc93504ff7 100644
> --- a/hw/intc/loongarch_pch_msi.c
> +++ b/hw/intc/loongarch_pch_msi.c
> @@ -42,13 +42,6 @@ static const MemoryRegionOps loongarch_pch_msi_ops = {
>       .endianness = DEVICE_LITTLE_ENDIAN,
>   };
>   
> -static void pch_msi_irq_handler(void *opaque, int irq, int level)
> -{
> -    LoongArchPCHMSI *s = LOONGARCH_PCH_MSI(opaque);
> -
> -    qemu_set_irq(s->pch_msi_irq[irq], level);
> -}
> -
>   static void loongarch_pch_msi_realize(DeviceState *dev, Error **errp)
>   {
>       LoongArchPCHMSI *s = LOONGARCH_PCH_MSI(dev);
> @@ -59,9 +52,7 @@ static void loongarch_pch_msi_realize(DeviceState *dev, Error **errp)
>       }
>   
>       s->pch_msi_irq = g_new(qemu_irq, s->irq_num);
> -
>       qdev_init_gpio_out(dev, s->pch_msi_irq, s->irq_num);
> -    qdev_init_gpio_in(dev, pch_msi_irq_handler, s->irq_num);
>   }
>   
>   static void loongarch_pch_msi_unrealize(DeviceState *dev)
>
> base-commit: 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365


