Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D7181AF29
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 08:10:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGDBg-00070d-CU; Thu, 21 Dec 2023 02:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1rGDBd-0006xz-F6
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:09:41 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1rGDBa-00061L-De
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 02:09:41 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8DxVPCr5INlUVUDAA--.16995S3;
 Thu, 21 Dec 2023 15:09:31 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxbb6o5INl9FQDAA--.10604S3; 
 Thu, 21 Dec 2023 15:09:30 +0800 (CST)
Subject: Re: [PATCH v2 02/17] hw/loongarch: Add load initrd
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, philmd@linaro.org, peter.maydell@linaro.org
References: <20231218090059.2678224-1-gaosong@loongson.cn>
 <20231218090059.2678224-3-gaosong@loongson.cn>
From: maobibo <maobibo@loongson.cn>
Message-ID: <c4cc87e1-5403-b75b-4e7c-3cb76748af17@loongson.cn>
Date: Thu, 21 Dec 2023 15:09:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20231218090059.2678224-3-gaosong@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Bxbb6o5INl9FQDAA--.10604S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw43Gw4fJrW3GFW3GF4fXrc_yoW8ZF43pF
 sxAF98GryfAFWxAwsrAa4UuF95Aw1rKr15WFnxKryFvrZIgr1DZFy8Zr97WrWvyws3KFn0
 qrn8Cw1j9a4UtrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1QV
 y3UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.41,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On 2023/12/18 下午5:00, Song Gao wrote:
> we load initrd ramdisk after kernel_high address
> 
> Signed-off-by: Song Gao <gaosong@loongson.cn>
> ---
>   hw/loongarch/boot.c | 29 ++++++++++++++++++++++++++++-
>   1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 9f25ea5847..2be6dfb037 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -21,7 +21,8 @@ static uint64_t cpu_loongarch_virt_to_phys(void *opaque, uint64_t addr)
>   
>   static int64_t load_kernel_info(struct loongarch_boot_info *info)
>   {
> -    uint64_t kernel_entry, kernel_low, kernel_high;
> +    uint64_t kernel_entry, kernel_low, kernel_high, initrd_size;
> +    ram_addr_t initrd_offset;
>       ssize_t kernel_size;
>   
>       kernel_size = load_elf(info->kernel_filename, NULL,
> @@ -36,6 +37,32 @@ static int64_t load_kernel_info(struct loongarch_boot_info *info)
>                        load_elf_strerror(kernel_size));
>           exit(1);
>       }
> +
> +    if (info->initrd_filename) {
> +        initrd_size = get_image_size(info->initrd_filename);
> +        if (initrd_size > 0) {
> +            initrd_offset = ROUND_UP(kernel_high, 64 * KiB);
Do you test self-compressed vmlinuz elf load?

I think that offset of initrd had better be 4 * kernel_size from 
kernel_high, else uncompressed kernel may overwrite INITRD image.
such as:
  initrd_offset = ROUND_UP(kernel_high + 4 * kernel_size, 64 * KiB);

Regards
Bibo Mao
> +
> +            if (initrd_offset + initrd_size > info->ram_size) {
> +                error_report("memory too small for initial ram disk '%s'",
> +                             info->initrd_filename);
> +                exit(1);
> +            }
> +
> +            initrd_size = load_image_targphys(info->initrd_filename, initrd_offset,
> +                                              info->ram_size - initrd_offset);
> +        }
> +
> +        if (initrd_size == (target_ulong)-1) {
> +            error_report("could not load initial ram disk '%s'",
> +                         info->initrd_filename);
> +            exit(1);
> +        }
> +    } else {
> +        error_report("Need initrd!");
> +        exit(1);
> +    }
> +
>       return kernel_entry;
>   }
>   
> 


