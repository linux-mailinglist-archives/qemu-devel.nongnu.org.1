Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 212D5B50AE2
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Sep 2025 04:12:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwAI2-0007Ct-UT; Tue, 09 Sep 2025 22:10:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1uwAHz-0007Ch-ES
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:10:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1uwAHu-0001W3-BD
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 22:10:27 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dx_tL93cBoCKIIAA--.18389S3;
 Wed, 10 Sep 2025 10:10:06 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by front1 (Coremail) with SMTP id qMiowJCxM+T63cBoo02LAA--.49378S3;
 Wed, 10 Sep 2025 10:10:05 +0800 (CST)
Subject: Re: [PATCH v4 1/3] hw/loongarch/virt: Add BSP support with aux boot
 code
To: Bibo Mao <maobibo@loongson.cn>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org
References: <20250906070200.3749326-1-maobibo@loongson.cn>
 <20250906070200.3749326-2-maobibo@loongson.cn>
From: gaosong <gaosong@loongson.cn>
Message-ID: <4bd52e3f-7e80-0c07-257f-317b2ffe3ed6@loongson.cn>
Date: Wed, 10 Sep 2025 10:13:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20250906070200.3749326-2-maobibo@loongson.cn>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: qMiowJCxM+T63cBoo02LAA--.49378S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxCF4Utw13Xr4ruF13Xw4kKrX_yoW5ZFW3pr
 y5W34rW395Jr1avrs3Ary5XrW5ArWIyF45t343Kr1IyFnxtr17W34Uur9FqFWDJr4ktF1v
 vFnxu3ya9F48tabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUU
 U
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, MIME_CHARSET_FARAWAY=2.45,
 NICE_REPLY_A=-1.932, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

�� 2025/9/6 ����3:01, Bibo Mao д��:
> If system boots directly from Linux kernel, BSP core jumps to kernel
> entry of Linux kernel image and other APs jump to aux boot code. Instead
> BSP and APs can all jump to aux boot code like UEFI bios.
>
> With aux boot code, BSP core is judged from physical cpu id, whose
> cpu id is 0. With BSP core, load data to register A0-A2 and PC.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>   hw/loongarch/boot.c | 36 ++++++++++++++++++++++++++++++++++--
>   1 file changed, 34 insertions(+), 2 deletions(-)
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao
> diff --git a/hw/loongarch/boot.c b/hw/loongarch/boot.c
> index 14d6c52d4e..4962668e5a 100644
> --- a/hw/loongarch/boot.c
> +++ b/hw/loongarch/boot.c
> @@ -35,13 +35,19 @@ struct loongarch_linux_hdr {
>       uint32_t pe_header_offset;
>   } QEMU_PACKED;
>   
> -static const unsigned int slave_boot_code[] = {
> +static const unsigned int aux_boot_code[] = {
>                     /* Configure reset ebase.                    */
>       0x0400302c,   /* csrwr      $t0, LOONGARCH_CSR_EENTRY      */
>   
>                     /* Disable interrupt.                        */
>       0x0380100c,   /* ori        $t0, $zero,0x4                 */
>       0x04000180,   /* csrxchg    $zero, $t0, LOONGARCH_CSR_CRMD */
> +    0x03400000,   /* nop                                       */
> +
> +    0x0400800c,   /* csrrd      $t0, LOONGARCH_CSR_CPUNUM      */
> +    0x034ffd8c,   /* andi       $t0, $t0, 0x3ff                */
> +    0x0015000d,   /* move       $t1, $zero                     */
> +    0x5800718d,   /* beq        $t0, $t1, 112                  */
>   
>                     /* Clear mailbox.                            */
>       0x1400002d,   /* lu12i.w    $t1, 1(0x1)                    */
> @@ -81,6 +87,26 @@ static const unsigned int slave_boot_code[] = {
>       0x06480dac,   /* iocsrrd.d  $t0, $t1                       */
>       0x00150181,   /* move       $ra, $t0                       */
>       0x4c000020,   /* jirl       $zero, $ra,0                   */
> +                  /* BSP Core                                  */
> +    0x03400000,   /* nop                                       */
> +    0x1800000d,   /* pcaddi     $t1, 0                         */
> +    0x28c0a1a4,   /* ld.d       $a0, $t1, 40                   */
> +    0x1800000d,   /* pcaddi     $t1, 0                         */
> +    0x28c0a1a5,   /* ld.d       $a1, $t1, 40                   */
> +    0x1800000d,   /* pcaddi     $t1, 0                         */
> +    0x28c0a1a6,   /* ld.d       $a2, $t1, 40                   */
> +    0x1800000d,   /* pcaddi     $t1, 0                         */
> +    0x28c0a1ac,   /* ld.d       $t0, $t1, 40                   */
> +    0x00150181,   /* move       $ra, $t0                       */
> +    0x4c000020,   /* jirl       $zero, $ra,0                   */
> +    0x00000000,   /* .dword 0   A0                             */
> +    0x00000000,
> +    0x00000000,   /* .dword 0   A1                             */
> +    0x00000000,
> +    0x00000000,   /* .dword 0   A2                             */
> +    0x00000000,
> +    0x00000000,   /* .dword 0   PC                             */
> +    0x00000000,
>   };
>   
>   static inline void *guidcpy(void *dst, const void *src)
> @@ -391,6 +417,7 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
>       int64_t kernel_addr = VIRT_FLASH0_BASE;
>       LoongArchCPU *lacpu;
>       CPUState *cs;
> +    uint64_t *data;
>   
>       if (info->kernel_filename) {
>           kernel_addr = load_kernel_info(info);
> @@ -408,7 +435,12 @@ static void loongarch_direct_kernel_boot(MachineState *ms,
>   
>       /* Load slave boot code at pflash0 . */
>       void *boot_code = g_malloc0(VIRT_FLASH0_SIZE);
> -    memcpy(boot_code, &slave_boot_code, sizeof(slave_boot_code));
> +    memcpy(boot_code, &aux_boot_code, sizeof(aux_boot_code));
> +    data = (uint64_t *)(boot_code + sizeof(aux_boot_code));
> +    *(data - 4) = cpu_to_le64(info->a0);
> +    *(data - 3) = cpu_to_le64(info->a1);
> +    *(data - 2) = cpu_to_le64(info->a2);
> +    *(data - 1) = cpu_to_le64(kernel_addr);
>       rom_add_blob_fixed("boot_code", boot_code, VIRT_FLASH0_SIZE, VIRT_FLASH0_BASE);
>   
>       CPU_FOREACH(cs) {


