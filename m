Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8016B8296E5
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 11:07:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNVTE-0000k8-85; Wed, 10 Jan 2024 05:06:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNVTA-0000jV-Sz
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 05:05:56 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNVT6-0000bT-DZ
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 05:05:55 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Dxfbv0a55lG88DAA--.3400S3;
 Wed, 10 Jan 2024 18:05:41 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cx74fxa55lxr4KAA--.28453S3; 
 Wed, 10 Jan 2024 18:05:39 +0800 (CST)
Subject: Re: [PATCH v4 0/9] Add loongarch kvm accel support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org
Cc: maobibo@loongson.cn, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, richard.henderson@linaro.org, peter.maydell@linaro.org,
 yangxiaojuan@loongson.cn
References: <20240105075804.1228596-1-zhaotianrui@loongson.cn>
 <a51860ec-26f7-6567-bee5-86b03afb9dad@loongson.cn>
 <84dc483e-08fc-4a47-a192-3db2003b38cd@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <9693d07a-45a4-fc56-7ee7-44bf8cd494cc@loongson.cn>
Date: Wed, 10 Jan 2024 18:05:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <84dc483e-08fc-4a47-a192-3db2003b38cd@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cx74fxa55lxr4KAA--.28453S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7urW7uw17trW8KFyrWw4rJFc_yoW8Xryfpr
 ZIyFs0qr45C3ykJa1kK3ZxZr1jqr4rG39Fv3Wft3yxCFsxZrykXrs2q390gFyav34kWF1j
 qF1Sk3W5XFy5A3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
 c4AY6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
 Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
 6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
 AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
 1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8rcTPUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.045,
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

在 2024/1/10 下午5:42, Philippe Mathieu-Daudé 写道:
> Hi Song,
>
> On 10/1/24 03:46, gaosong wrote:
>> 在 2024/1/5 下午3:57, Tianrui Zhao 写道:
>
>>> This series add loongarch kvm support, mainly implement
>>> some interfaces used by kvm, such as kvm_arch_get/set_regs,
>>> kvm_arch_handle_exit, kvm_loongarch_set_interrupt, etc.
>
>
>>> Tianrui Zhao (9):
>>>    linux-headers: Synchronize linux headers from linux v6.7.0-rc8
>>>    target/loongarch: Define some kvm_arch interfaces
>>>    target/loongarch: Supplement vcpu env initial when vcpu reset
>>>    target/loongarch: Implement kvm get/set registers
>>>    target/loongarch: Implement kvm_arch_init function
>>>    target/loongarch: Implement kvm_arch_init_vcpu
>>>    target/loongarch: Implement kvm_arch_handle_exit
>>>    target/loongarch: Implement set vcpu intr for kvm
>>>    target/loongarch: Add loongarch kvm into meson build
>
>
>> Applied to loongarch-next.
>
> Sorry it took me some time to test this on a loongarch64
> host. I made minor changes to patch #8, please consider
> the alternative:
> https://lore.kernel.org/qemu-devel/20240110094152.52138-1-philmd@linaro.org/ 
> and
> https://lore.kernel.org/qemu-devel/20240110094152.52138-2-philmd@linaro.org/ 
>

Thank you ,  I wll  apply them to loongarch-next.
if no new problem with this series,  I think we can merge it on this week.

Thanks.
Song Gao


