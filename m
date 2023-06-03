Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE0F720E79
	for <lists+qemu-devel@lfdr.de>; Sat,  3 Jun 2023 09:22:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5LaJ-0007LB-Cy; Sat, 03 Jun 2023 03:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q5LaG-0007L1-0R
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 03:21:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1q5LaC-0001uS-Au
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 03:21:55 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8Dx_+sC6npky+EDAA--.8291S3;
 Sat, 03 Jun 2023 15:21:38 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxFLEB6npkAgeHAA--.21375S3; 
 Sat, 03 Jun 2023 15:21:38 +0800 (CST)
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, QEMU devel
 <qemu-devel@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Huacai Chen <chenhuacai@kernel.org>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
 <CAFEAcA9F4OOwg9LQn-y7ScixG9mZ58bsvcE6qGqxw1WXENYaZw@mail.gmail.com>
 <203A9E36-9EAC-41B5-9EE1-94936957FA89@flygoat.com>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <5ac0d330-7f05-3395-6b9c-61d07f41b699@loongson.cn>
Date: Sat, 3 Jun 2023 15:21:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <203A9E36-9EAC-41B5-9EE1-94936957FA89@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8BxFLEB6npkAgeHAA--.21375S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxWr1xKF18Cw47Gr1UJFWxCrg_yoW5Ww4Dpr
 yUZF45CF4kWr17AFyvqas0gF45C3Z3ur129F45Kry8uF1Yvrnava4ktrn3ua4rA3WrJrn0
 vr43Wa43XF17X37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
 bxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
 1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
 wVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwA2z4
 x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS
 0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0V
 AKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1l
 Ox8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42
 xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
 GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
 8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4U
 MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
 8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URa0PUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.095,
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



在 2023/6/3 下午3:06, Jiaxun Yang 写道:
>
>> 2023年6月3日 01:28，Peter Maydell <peter.maydell@linaro.org> 写道：
>>
>> On Sun, 21 May 2023 at 11:24, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>>> As per "Loongson 3A5000/3B5000 Processor Reference Manual",
>>> Loongson 3A5000's IPI implementation have 4 mailboxes per
>>> core.
>>>
>>> However, in 78464f023b54 ("hw/loongarch/virt: Modify ipi as
>>> percpu device"), the number of IPI mailboxes was reduced to
>>> one, which mismatches actual hardware.
>>>
>>> It won't affect LoongArch based system as LoongArch boot code
>>> only uses the first mailbox, however MIPS based Loongson boot
>>> code uses all 4 mailboxes.
>>>
>>> Fixes: 78464f023b54 ("hw/loongarch/virt: Modify ipi as percpu device")
>>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>>> ---
>>> hw/intc/loongarch_ipi.c         | 6 +++---
>>> include/hw/intc/loongarch_ipi.h | 4 +++-
>>> 2 files changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/intc/loongarch_ipi.c b/hw/intc/loongarch_ipi.c
>>> index d6ab91721ea1..3e453816524e 100644
>>> --- a/hw/intc/loongarch_ipi.c
>>> +++ b/hw/intc/loongarch_ipi.c
>>> @@ -238,14 +238,14 @@ static void loongarch_ipi_init(Object *obj)
>>>
>>> static const VMStateDescription vmstate_ipi_core = {
>>>      .name = "ipi-single",
>>> -    .version_id = 1,
>>> -    .minimum_version_id = 1,
>>> +    .version_id = 2,
>>> +    .minimum_version_id = 2,
>>>      .fields = (VMStateField[]) {
>>>          VMSTATE_UINT32(status, IPICore),
>>>          VMSTATE_UINT32(en, IPICore),
>>>          VMSTATE_UINT32(set, IPICore),
>>>          VMSTATE_UINT32(clear, IPICore),
>>> -        VMSTATE_UINT32_ARRAY(buf, IPICore, 2),
>>> +        VMSTATE_UINT32_ARRAY(buf, IPICore, IPI_MBX_NUM * 2),
>>>          VMSTATE_END_OF_LIST()
>>>      }
>>> };
>>> diff --git a/include/hw/intc/loongarch_ipi.h b/include/hw/intc/loongarch_ipi.h
>>> index 664e050b926e..6c6194786e80 100644
>>> --- a/include/hw/intc/loongarch_ipi.h
>>> +++ b/include/hw/intc/loongarch_ipi.h
>>> @@ -28,6 +28,8 @@
>>> #define MAIL_SEND_OFFSET      0
>>> #define ANY_SEND_OFFSET       (IOCSR_ANY_SEND - IOCSR_MAIL_SEND)
>>>
>>> +#define IPI_MBX_NUM           4
>>> +
>>> #define TYPE_LOONGARCH_IPI "loongarch_ipi"
>>> OBJECT_DECLARE_SIMPLE_TYPE(LoongArchIPI, LOONGARCH_IPI)
>>>
>>> @@ -37,7 +39,7 @@ typedef struct IPICore {
>>>      uint32_t set;
>>>      uint32_t clear;
>>>      /* 64bit buf divide into 2 32bit buf */
>>> -    uint32_t buf[2];
>>> +    uint32_t buf[IPI_MBX_NUM * 2];
>>>      qemu_irq irq;
>>> } IPICore;
>> In particular, this fixes Coverity issues CID 1512452 and 1512453,
>> where Coverity notices that the code in loongarch_ipi_writel() and
>> loongarch_ipi_readl() reads off the end of the too-short buf[].
> LoongArch maintainers, do you mind to take this patch while I’m refactoring
> rest of the series?
I don't mind.

Thanks.
Song Gao


