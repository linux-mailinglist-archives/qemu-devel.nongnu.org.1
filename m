Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA74191D8E0
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jul 2024 09:24:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOBNG-0000mz-I3; Mon, 01 Jul 2024 03:22:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1sOBN4-0000jU-E3
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:22:42 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1sOBN2-0002DU-6H
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 03:22:42 -0400
Received: from loongson.cn (unknown [10.20.42.62])
 by gateway (Coremail) with SMTP id _____8Ax3eo6WYJmBNILAA--.45252S3;
 Mon, 01 Jul 2024 15:22:34 +0800 (CST)
Received: from [10.20.42.62] (unknown [10.20.42.62])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxmsY3WYJmbjg3AA--.63342S3; 
 Mon, 01 Jul 2024 15:22:33 +0800 (CST)
Subject: Re: [PATCH v3 1/4] hw/intc: Remove loongarch_ipi.c
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 gaosong <gaosong@loongson.cn>, QEMU devel <qemu-devel@nongnu.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240605-loongson3-ipi-v3-0-ddd2c0e03fa3@flygoat.com>
 <20240605-loongson3-ipi-v3-1-ddd2c0e03fa3@flygoat.com>
 <e1b8bbd8-2a9d-2417-1123-4aabfdedb684@loongson.cn>
 <002f4e7e-682b-479b-9c6c-8971a0e6640a@linaro.org>
 <8d975e9c-c2fd-09c8-7a37-5aebc63656d4@loongson.cn>
 <9a0f73c6-33e9-4576-9056-6a5fd0718630@linaro.org>
 <ceebb4ea-a417-0985-d45e-3988d76e2086@loongson.cn>
 <3544da40-d680-20f2-d7af-cf304d07bc8d@loongson.cn>
 <74a9606c-3b3b-4af3-8242-944619f898c9@app.fastmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <c817c31b-3f22-da1a-c110-4873e1a36eab@loongson.cn>
Date: Mon, 1 Jul 2024 15:22:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <74a9606c-3b3b-4af3-8242-944619f898c9@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxmsY3WYJmbjg3AA--.63342S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CFWDZryfXw47Xw17Xr45XFc_yoW8Gr18pF
 WfCa1SkF1UtrWjkws2qryIqF1j9r48Ww1DX345KFyDur98tr1xAFWkKryYkr9Fvan3K3W2
 vr43K3WxXF4jyFcCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9Sb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
 daVFxhVjvjDU0xZFpf9x07j5WrAUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.587,
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



On 2024/7/1 下午3:01, Jiaxun Yang wrote:
> 
> 
> 在2024年7月1日七月 上午7:44，maobibo写道：
>> Also this patch is problematic on LoongArch.
>>
>> The original patch is to search physical cpuid rather than logic cpuid.
>>
>> We want to make ipi module better and better, however now it comes back
>> to initial state at the beginning :(
> 
> Isn't arch_id the "physical id" you want? "cs->cpu_index" is the logical ID
> for QEMU.
> 
> arch_id is setup by arch code, like APIC ID for x86.
> 
> I had come across the old ipi_getcpu  implementation, and I'm sure we were
> looking at arch_id as well.
So, where is implementation code for function get_arch_id() looking for 
vcpu with physical index?

Regards
Bibo Mao

> 
> Thanks
> - Jiaxun
>>
>> commit 03ca348b6b9038ce284916b36c19f700ac0ce7a6
>> Author: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Date:   Wed Jun 5 10:04:27 2024
>>
>>       hw/intc/loongson_ipi: Replace ipi_getcpu with cpu_by_arch_id
>>
>>       cpu_by_arch_id is doing the same thing as our ipi_getcpu logic.
>>
>>       Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>       Reviewed-by: Song Gao <gaosong@loongson.cn>
>>       Message-ID: <20240605-loongson3-ipi-v3-4-ddd2c0e03fa3@flygoat.com>
>>       Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>>
>> Regards
>> Bibo Mao
>>


