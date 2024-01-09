Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE5827CA3
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 02:52:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN1Gi-0006mQ-3D; Mon, 08 Jan 2024 20:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rN1Gf-0006mI-PT
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 20:51:01 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rN1Gd-0002J9-8J
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 20:51:01 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxOuh0ppxl6U8DAA--.2272S3;
 Tue, 09 Jan 2024 09:50:44 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxO9xxppxl4DMIAA--.21531S3; 
 Tue, 09 Jan 2024 09:50:43 +0800 (CST)
Subject: Re: [PATCH v3 11/46] hw/loongarch: use pci_init_nic_devices()
To: David Woodhouse <dwmw2@infradead.org>
References: <20240108204909.564514-1-dwmw2@infradead.org>
 <20240108204909.564514-12-dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org
From: gaosong <gaosong@loongson.cn>
Message-ID: <e8d0289d-f8e9-1b28-4b51-1dc0589a95b8@loongson.cn>
Date: Tue, 9 Jan 2024 09:50:41 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240108204909.564514-12-dwmw2@infradead.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxO9xxppxl4DMIAA--.21531S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZrW7XF4Uuw1fJFy7Kr45Arc_yoWfGwc_Wa
 4I9ws29r45Xw10vanIqr45JFyxJa1FqF93CFZxJrs5X3W0qwn3XFW7J3W7ZrsFgr4UZrZx
 JayvvFn8Cr4I9osvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
 JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUXVWUAwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7XTmDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.383, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

ÔÚ 2024/1/9 ÉÏÎç4:26, David Woodhouse Ð´µÀ:
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/loongarch/virt.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 4b7dc67a2d..c48804ac38 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -504,9 +504,7 @@ static void loongarch_devices_init(DeviceState *pch_pic, LoongArchMachineState *
>       fdt_add_uart_node(lams);
>   
>       /* Network init */
> -    for (i = 0; i < nb_nics; i++) {
> -        pci_nic_init_nofail(&nd_table[i], pci_bus, mc->default_nic, NULL);
> -    }
> +    pci_init_nic_devices(pci_bus, mc->default_nic);
>   
>       /*
>        * There are some invalid guest memory access.


