Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C869747B1
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Sep 2024 03:18:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soByR-00062Z-KU; Tue, 10 Sep 2024 21:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1soByM-00061z-RK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:16:43 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1soByJ-0005YB-HN
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 21:16:42 -0400
Received: from loongson.cn (unknown [10.20.42.184])
 by gateway (Coremail) with SMTP id _____8CxPutw7+Bmg0EEAA--.10627S3;
 Wed, 11 Sep 2024 09:16:32 +0800 (CST)
Received: from [10.20.42.184] (unknown [10.20.42.184])
 by front1 (Coremail) with SMTP id qMiowMBxn+Rv7+BmNGgDAA--.19724S3;
 Wed, 11 Sep 2024 09:16:32 +0800 (CST)
Subject: Re: [RFC PATCH V2 1/5] include: Add macro definitions needed for
 interrupt controller kvm emulation
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 Bibo Mao <maobibo@loongson.cn>
References: <cover.1725969898.git.lixianglai@loongson.cn>
 <2182eb694629ee3f2859e441b8076d62d3606ee2.1725969898.git.lixianglai@loongson.cn>
 <87cylbvcts.fsf@redhat.com>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <ba11190f-9001-552a-68bb-2c8ab0c8b826@loongson.cn>
Date: Wed, 11 Sep 2024 09:16:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87cylbvcts.fsf@redhat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: qMiowMBxn+Rv7+BmNGgDAA--.19724S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr1xGw18uFy7Xry3GF13WrX_yoW8XF1xpa
 9rC3Z09r4kJryxA3ZxXa47ZFy3Ja95GF92qFy3G34FywnxX3W8Xw1xKw1kXFyUKr1rKFWU
 Xr43K3WYg3WUZrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
 8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
 xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
 AYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
 14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
 kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAF
 wI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r
 4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8czVUUU
 UUU==
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.597,
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

Hi Cornelia Huck:
> On Tue, Sep 10 2024, Xianglai Li <lixianglai@loongson.cn> wrote:
>
>> Add macro definitions needed for interrupt controller kvm emulation.
>>
>> Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
>> ---
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> Cc: Huacai Chen <chenhuacai@kernel.org>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Cornelia Huck <cohuck@redhat.com>
>> Cc: kvm@vger.kernel.org
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Cc: Xianglai Li <lixianglai@loongson.cn>
>>
>>   include/hw/intc/loongarch_extioi.h    | 38 ++++++++++++++++--
>>   include/hw/intc/loongarch_ipi.h       | 15 +++++++
>>   include/hw/intc/loongarch_pch_pic.h   | 58 +++++++++++++++++++++++++--
>>   include/hw/intc/loongson_ipi.h        |  1 -
>>   include/hw/intc/loongson_ipi_common.h |  2 +
>>   include/hw/loongarch/virt.h           | 15 +++++++
>>   linux-headers/asm-loongarch/kvm.h     | 18 +++++++++
>>   linux-headers/linux/kvm.h             |  6 +++
>>   8 files changed, 146 insertions(+), 7 deletions(-)
> The parts you need to split out into a separate patch are the changes
> under linux-headers/ (because they get updated via a script); the
> changes under include/hw/ are internal to QEMU and should go where it
> makes sense (probably with the actual changes in .c files, but I didn't
> check what the patch actually does.)
Ok, I'll correct it in the next version.
Thanks!
Xianglai.


