Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF027643E6
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 04:40:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOqWE-0000O3-Fa; Wed, 26 Jul 2023 22:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qOqWB-0000Nt-QX
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 22:14:19 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qOqW8-00061C-TJ
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 22:14:19 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8BxXevw0sFkensKAA--.20739S3;
 Thu, 27 Jul 2023 10:14:08 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxX8_u0sFkkWU8AA--.30074S3; 
 Thu, 27 Jul 2023 10:14:06 +0800 (CST)
Subject: Re: [PATCH 0/8] Adds CPU hot-plug support to Loongarch
To: Gavin Shan <gshan@redhat.com>, qemu-devel@nongnu.org,
 Salil Mehta <salil.mehta@huawei.com>, zhukeqian1@huawei.com,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1689837093.git.lixianglai@loongson.cn>
 <83d5c2b6-20a2-0637-8373-c1935d97dc68@redhat.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <e1c36ce7-6799-b003-9a47-b8094f869168@loongson.cn>
Date: Thu, 27 Jul 2023 10:14:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <83d5c2b6-20a2-0637-8373-c1935d97dc68@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxX8_u0sFkkWU8AA--.30074S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZry3AF47XrWUAF1kZFWftFc_yoW5XrW7pF
 Waka1avw4DKFWkC397uwn2vF4xKay8Ga45tF1Yq34fZrs8Arnayr4fKan8WFy5Wr18Wr12
 vr4jvw18Zas8AacCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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

Hi Gavin and Salil,

On 7/27/23 8:57 AM, Gavin Shan wrote:
> Hi Xianglai,
>
> On 7/20/23 17:15, xianglai li wrote:
>> Hello everyone, We refer to the implementation of ARM CPU
>> Hot-Plug to add GED-based CPU Hot-Plug support to Loongarch.
>>
>> The first 4 patches are changes to the QEMU common code,
>> including adding GED support for CPU Hot-Plug, updating
>> the ACPI table creation process, and adding 
>> qdev_disconnect_gpio_out_named
>> and cpu_address_space_destroy interfaces to release resources
>> when CPU un-plug.
>>
>> The last four patches are Loongarch architecture-related,
>> and the modifications include the definition of the hook
>> function related to the CPU Hot-(UN)Plug, the allocation
>> and release of CPU resources when CPU Hot-(UN)Plug,
>> the creation process of updating the ACPI table,
>> and finally the custom switch for the CPU Hot-Plug.
>>
>
> [...]
>
> It seems the design for ARM64 hotplug has been greatly referred, but 
> the authors
> are missed to be copied if you were referring to the following 
> repository. There
> will be conflicts between those two patchsets as I can see and I'm not 
> sure how
> it can be resolved. In theory, one patchset needs to be rebased on 
> another one
> since they're sharing large amount of codes.
>
>   https://github.com/salil-mehta/qemu.git
>   (branch: virt-cpuhp-armv8/rfc-v1-port11052023.dev-1)
>
> I took a quick scan on this series. Loongarch doesn't have ARM64's 
> constraint due
> to vGIC3 where all vCPUs's file descriptor needs to be in place. It 
> means the possible
> and not yet present vCPU needs to be visible to KVM. Without this 
> constraint, the
> implementation is simplified a lot.

We have great respect and gratitude to Salil and his team for their work 
and contributions to CPU HotPlug,

which greatly reduced the difficulty of developing CPU HotPlug in Loongarch.

So, We plan to rebase the next version of patch based on their code.


Hi Salil,

I estimate that it will take quite some time for your patch series to 
merge in,

if allowed, can you merge your patch series changes to the common code 
section into the community first,

so that our code can be rebase and merged.


>
> Besides, we found the vCPU hotplug isn't working for TCG when Salil's 
> series was
> tested. I'm not sure if we have same issue with this series, or TCG 
> isn't a concern
> to us at all?

At present, QEMU only supports TCG under Loongarch,

and we test CPU HotPlug is also carried out under QEMU TCG,

and CPU HotPlug can work normally when testing.

Of course, we are also very happy to see you testing CPU hotplug under 
Loongarch,

which can find more problems and help us improve our patch.

>
> Thanks,
> Gavin

Thanks,

xianglai li


