Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2262AACBEFB
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Jun 2025 05:54:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMIj9-0003Ly-JM; Mon, 02 Jun 2025 23:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1uMIj7-0003Lp-MV
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:54:13 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1uMIj5-00049g-6r
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:54:13 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8AxquDecT5oZKIJAQ--.56741S3;
 Tue, 03 Jun 2025 11:54:06 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by front1 (Coremail) with SMTP id qMiowMCxLcXbcT5o1SIGAQ--.19796S3;
 Tue, 03 Jun 2025 11:54:05 +0800 (CST)
Subject: Re: [PATCH] hw/loongarch/virt: inform guest of kvm
To: Qiang Ma <maqianga@uniontech.com>, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com
Cc: qemu-devel@nongnu.org
References: <20250603031813.31794-1-maqianga@uniontech.com>
From: Bibo Mao <maobibo@loongson.cn>
Message-ID: <59ac7f55-cfb7-e500-296b-eff39763c086@loongson.cn>
Date: Tue, 3 Jun 2025 11:52:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250603031813.31794-1-maqianga@uniontech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCxLcXbcT5o1SIGAQ--.19796S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7GFWDurW7Wr4rKw1xGF1xWFX_yoWfAFXEgr
 12ywn2kr45XF1kW3Zaqa45Aw45Ga48J3Z5ZFn7Grn3Ga45JrnxCF4IgwnxCwsrtr40vw43
 A39Yyr1YyryagosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.054,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Bibo Mao <maobibo@loongson.cn>

On 2025/6/3 上午11:18, Qiang Ma wrote:
> Commit bab27ea2e3 ("hw/arm/virt: smbios:
> inform guest of kvm") fixes the same issue
> on arm.
> 
> without this patch:
> [root@localhost ~]# virt-what
> qemu
> 
> with this patch:
> [root@localhost ~]# virt-what
> kvm
> 
> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> ---
>   hw/loongarch/virt.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 1b504047db..a3d449ca8b 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -136,6 +136,10 @@ static void virt_build_smbios(LoongArchVirtMachineState *lvms)
>           return;
>       }
>   
> +    if (kvm_enabled()) {
> +        product = "KVM Virtual Machine";
> +    }
> +
>       smbios_set_defaults("QEMU", product, mc->name);
>   
>       smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,
> 


