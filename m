Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EAB7D3753
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 14:58:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quuUR-0002mV-9k; Mon, 23 Oct 2023 08:57:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1quuUH-0002kD-Hv
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:56:56 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1quuUB-0005wv-OF
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 08:56:52 -0400
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8Cxc_CGbTZlqPQzAA--.35578S3;
 Mon, 23 Oct 2023 20:56:39 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxnd6DbTZlNF0vAA--.36473S3; 
 Mon, 23 Oct 2023 20:56:37 +0800 (CST)
Subject: Re: [PATCH] target/loongarch: Support 4K page size
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, philmd@linaro.org
References: <20231023024059.3858349-1-gaosong@loongson.cn>
 <b0e7be32-ab05-a39c-f722-44b2eaac8318@loongson.cn>
 <CAFEAcA8UEC1XSsjuSbwDmiUs03VVK=wTY0PHSte-4f1=hk3EgA@mail.gmail.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <6b6bf8c6-c4de-450e-0b50-27d3324df68a@loongson.cn>
Date: Mon, 23 Oct 2023 20:56:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8UEC1XSsjuSbwDmiUs03VVK=wTY0PHSte-4f1=hk3EgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxnd6DbTZlNF0vAA--.36473S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ar18uF45Kw18ZFy7KrWUWrX_yoW8tw1Dpa
 yfA3Wvkr4DWrZxKa1FqwnxCFnIyanrKF12qFnrKrW8twn8t34IyF1vkrZ3Ca4fZFW8CFWI
 vr4Dtry3uF1DZacCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVWxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
 rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtw
 CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
 67AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
 0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtx
 DUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.339,
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



在 2023/10/23 下午6:22, Peter Maydell 写道:
> On Mon, 23 Oct 2023 at 05:06, maobibo <maobibo@loongson.cn> wrote:
>>
>>
>>
>> 在 2023/10/23 上午10:40, Song Gao 写道:
>>> The LoongArch kernel supports 4K page size.
>>> Change TARGET_PAGE_BITS to 12.
>>>
>>> Signed-off-by: Song Gao <gaosong@loongson.cn>
>>> ---
>>>    target/loongarch/cpu-param.h  | 2 +-
>>>    target/loongarch/tlb_helper.c | 9 ++++-----
>>>    2 files changed, 5 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/target/loongarch/cpu-param.h b/target/loongarch/cpu-param.h
>>> index 1265dc7cb5..cfe195db4e 100644
>>> --- a/target/loongarch/cpu-param.h
>>> +++ b/target/loongarch/cpu-param.h
>>> @@ -12,6 +12,6 @@
>>>    #define TARGET_PHYS_ADDR_SPACE_BITS 48
>>>    #define TARGET_VIRT_ADDR_SPACE_BITS 48
>>>
>>> -#define TARGET_PAGE_BITS 14
>>> +#define TARGET_PAGE_BITS 12
>> Hi Gaosong,
>>
>> The popular OS about LoongArch still uses 16K page size, qemu should
>> follow the rule of OS rather than defining 4K page size alone.
> 
> The TARGET_PAGE_BITS value in QEMU is a property of the hardware,
> not the guest OS. It should specify the smallest page size the
> guest can configure the CPU to use. If the guest asks for a
> larger page size than the minimum then that works fine. See
> for example PPC64 -- on this architecture both 4K and 64K
> pages are possible, so we define TARGET_PAGE_BITS to 12,
> even though a lot of Linux guests use 64K pages.
> 
> It is slightly less efficient when the guest uses a page size
> larger than the TARGET_PAGE_BITS value indicates, so if you
> have an architecture where some CPUs support small pages
> but most do not, you can do what Arm does, and use the
> TARGET_PAGE_BITS_VARY support. This makes the TARGET_PAGE_BITS
> macro be a runtime-configurable value, where a machine model can
> set the mc->minimum_page_bits value to indicate that that
> machine doesn't need the small-pages handling.
Peter,

Thanks for your guidance, the TARGET_PAGE_BITS setting issue puzzle
us for a long time. I have a simple test for kernel with 4K/16K 
different page size, it boots well if TARGET_PAGE_BITS
is set as 12. And we will do more test, we will switch to 
TARGET_PAGE_BITS to 12 if all the test pass.

Regards
Bibo Mao

> 
> thanks
> -- PMM
> 


