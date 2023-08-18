Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 739C8780658
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 09:29:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWtul-0003YC-5R; Fri, 18 Aug 2023 03:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qWtuh-0003Y4-3W
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 03:28:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qWtub-0002Uz-Cc
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 03:28:53 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxNvGpHd9kLdAZAA--.52948S3;
 Fri, 18 Aug 2023 15:28:41 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxniOlHd9k1XNdAA--.57138S3; 
 Fri, 18 Aug 2023 15:28:37 +0800 (CST)
Subject: Re: [PATCH v4 07/18] linux-user: Load vdso image if available
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230816180338.572576-1-richard.henderson@linaro.org>
 <20230816180338.572576-8-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <41dee294-d74c-1e58-b7c0-6325e4aea83a@loongson.cn>
Date: Fri, 18 Aug 2023 15:28:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230816180338.572576-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxniOlHd9k1XNdAA--.57138S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ArW7Ww13Aw13Kw1rXr17twc_yoW8GFy7pa
 95Ww1DArWrAw4rAFs2yw48Z3WkXF1DuF4UGw45G3ykA34vyr4j934DK3W29ws8Xr1vvF4U
 t398ZrZ8GFWDurgCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF
 1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8cz
 VUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-4.01, SPF_HELO_NONE=0.001,
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

Hi, Richard

ÔÚ 2023/8/17 ÉÏÎç2:03, Richard Henderson Ð´µÀ:
> @@ -3629,10 +3694,13 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>       }
>   
>       /*
> -     * TODO: load a vdso, which would also contain the signal trampolines.
> -     * Otherwise, allocate a private page to hold them.
> +     * Load a vdso if available, which will amongst other things contain the
> +     * signal trampolines.  Otherwise, allocate a separate page for them.
>        */
> -    if (TARGET_ARCH_HAS_SIGTRAMP_PAGE) {
> +    const VdsoImageInfo *vdso = vdso_image_info();
> +    if (vdso) {
> +        load_elf_vdso(&vdso_info, vdso);
> +    } else if (TARGET_ARCH_HAS_SIGTRAMP_PAGE) {
I see some targets already support vdso.

./linux-user/aarch64/vdso-be.so
./linux-user/aarch64/vdso-le.so
./linux-user/arm/vdso-arm-be.so
./linux-user/arm/vdso-arm-le.so
./linux-user/arm/vdso-thm-be.so
./linux-user/arm/vdso-thm-le.so
./linux-user/hppa/vdso.so
./linux-user/i386/vdso.so
./linux-user/loongarch64/vdso.so
./linux-user/ppc/vdso-32.so
./linux-user/ppc/vdso-64.so
./linux-user/ppc/vdso-64le.so
./linux-user/riscv/vdso-32.so
./linux-user/riscv/vdso-64.so
./linux-user/s390x/vdso.so
./linux-user/x86_64/vdso.so

This branch will never reach.

what about remove TARGET_ARCH_HAS_SIGTRAMP_PAGE and setup_sigtramp() for 
these targets?

Thanks.
Song Gao


