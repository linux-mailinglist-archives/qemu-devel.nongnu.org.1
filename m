Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E8D7C7B23
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 03:22:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qr6rB-0000Rp-Du; Thu, 12 Oct 2023 21:20:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qr6r8-0000Rc-M0
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 21:20:46 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qr6r5-00050Y-SC
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 21:20:46 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxLOtkmyhl5YkxAA--.24475S3;
 Fri, 13 Oct 2023 09:20:37 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxfNximyhlQmUiAA--.7158S3; 
 Fri, 13 Oct 2023 09:20:36 +0800 (CST)
Subject: Re: [PATCH 1/1] LoongArch: step down as general arch maintainer
To: Xiaojuan Yang <yangxiaojuan@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 philmd@linaro.org, alex.bennee@linaro.org, maobibo@loongson.cn
References: <20231012095135.1423071-1-yangxiaojuan@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <ff083b35-6d42-b969-e6ed-27b111d94278@loongson.cn>
Date: Fri, 13 Oct 2023 09:20:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231012095135.1423071-1-yangxiaojuan@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxfNximyhlQmUiAA--.7158S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKw4xCryftw1DWF18Gw1fZrc_yoWftrX_JF
 Wayaykur4DGw1kAr4vgr95Aa45Jw4xAa1fCanrAws7X3sFqay8JryYyanrXF1avFWxursx
 tay2qr9Ikw1UXosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-3.339, SPF_HELO_NONE=0.001,
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

ÔÚ 2023/10/12 ÏÂÎç5:51, Xiaojuan Yang Ð´µÀ:
> I haven't really been working on LoongArch for some time now,
> so let's remove myself from this entry.
> 
> Signed-off-by: Xiaojuan Yang <yangxiaojuan@loongson.cn>
> ---
>   MAINTAINERS | 2 --
>   1 file changed, 2 deletions(-)
> 

Acked-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao

> diff --git a/MAINTAINERS b/MAINTAINERS
> index c3cc12dc29..5c386f1f37 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -248,7 +248,6 @@ F: disas/hppa.c
>   
>   LoongArch TCG CPUs
>   M: Song Gao <gaosong@loongson.cn>
> -M: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>   S: Maintained
>   F: target/loongarch/
>   F: tests/tcg/loongarch64/
> @@ -1182,7 +1181,6 @@ F: pc-bios/hppa-firmware.img
>   LoongArch Machines
>   ------------------
>   Virt
> -M: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>   M: Song Gao <gaosong@loongson.cn>
>   S: Maintained
>   F: docs/system/loongarch/virt.rst
> 


