Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF647EEC5B
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 07:46:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3sbi-00008m-H4; Fri, 17 Nov 2023 01:45:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1r3sbe-00008J-2j
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 01:45:35 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1r3sbb-0005Aa-7p
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 01:45:33 -0500
Received: from loongson.cn (unknown [10.20.42.173])
 by gateway (Coremail) with SMTP id _____8AxV_EFDFdl9L46AA--.51077S3;
 Fri, 17 Nov 2023 14:45:26 +0800 (CST)
Received: from [10.20.42.173] (unknown [10.20.42.173])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxH90BDFdl4g1FAA--.22750S3; 
 Fri, 17 Nov 2023 14:45:23 +0800 (CST)
Subject: Re: [PATCH] linux-headers: Synchronize linux headers from linux
 v6.7.0-rc1
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>, gaosong <gaosong@loongson.cn>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, qemu-devel@nongnu.org,
 mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 lixianglai@loongson.cn
References: <20231114015412.53135-1-zhaotianrui@loongson.cn>
 <be0da6a9-6f1e-11d9-f088-328ea33aee36@loongson.cn>
 <771dd5ff-45d0-40bd-87dd-40f666d3355d@redhat.com>
 <257d6562-51fb-867a-e65c-13418c6ce888@loongson.cn>
 <800a75b9-8c0c-459b-8cad-ab36e9a08d69@redhat.com>
From: maobibo <maobibo@loongson.cn>
Message-ID: <7de1a120-22d4-0eb0-905b-44ec7894f045@loongson.cn>
Date: Fri, 17 Nov 2023 14:45:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <800a75b9-8c0c-459b-8cad-ab36e9a08d69@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxH90BDFdl4g1FAA--.22750S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrtw47Gr4UtFyDCF17XrW3CFX_yoWftFgE93
 yUAwnrKw4UK3yUJan8tr4fursxJF4UA3s5t348JF40g345ArWxGrWDKryxAF9xtayxAFn8
 uryYvFy5Aw4jgosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbhxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
 6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
 c4AY6r1j6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
 Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
 6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
 AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
 1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1RBT5UUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.193,
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



On 2023/11/17 下午2:35, Cédric Le Goater wrote:
> Hello,
> 
> On 11/17/23 02:14, maobibo wrote:
>> Thomas,
>>
>> Linux 6.7-rc1 has already released, LoongArch KVM is supported in this 
>> version. LoongArch qemu KVM function depends on linux-headers and I do 
>> not know whether LoongArch qemu KVM can be merged in 8.2 cycle.
> 
> It's too late for 8.2. See https://wiki.qemu.org/Planning/8.2.

Got it, and thanks for the clarification.

Regards
Bibo Mao

> 
> Thanks,
> 
> C.
> 
> 
> 
>> Regards
>> Bibo Mao
>>
>>
>> On 2023/11/16 下午9:19, Thomas Huth wrote:
>>> On 15/11/2023 11.07, gaosong wrote:
>>>> Hi,
>>>>
>>>> Can this patch be merged in during the 8.2 cycle?
>>>
>>>   Hi!
>>>
>>> We normally do linux-headers updates along with the patches that need 
>>> the new definitions ... so is there an urgent reason to push this 
>>> stand-alone
>>> patch into 8.2 without any patches that require these new definitions?
>>>
>>>   Thomas
>>
>>


