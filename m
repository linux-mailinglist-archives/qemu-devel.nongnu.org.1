Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E070D07D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 03:26:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1GmN-0006Rj-0k; Mon, 22 May 2023 21:25:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1q1GmI-0006RV-GK
 for qemu-devel@nongnu.org; Mon, 22 May 2023 21:25:30 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1q1GmF-0004qC-N9
 for qemu-devel@nongnu.org; Mon, 22 May 2023 21:25:30 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8CxE_ACFmxkgCALAA--.19016S3;
 Tue, 23 May 2023 09:25:22 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dx87AAFmxk28BvAA--.56533S3; 
 Tue, 23 May 2023 09:25:20 +0800 (CST)
Subject: Re: [PATCH 1/4] hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>
Cc: QEMU devel <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, maobibo <maobibo@loongson.cn>
References: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
 <20230521102307.87081-2-jiaxun.yang@flygoat.com>
 <CAAhV-H4kx5cDcswkHpCYH9UZhh7PDEndP+NvwNgdZaZji6BFLA@mail.gmail.com>
 <CA74488A-DB92-4D13-8BAC-5E853F187419@flygoat.com>
 <e184fa06-9ce4-1ab9-4680-58aa6c4200b9@linaro.org>
From: Song Gao <gaosong@loongson.cn>
Message-ID: <c965d4ef-3993-cfca-7d22-3ecef5cfc256@loongson.cn>
Date: Tue, 23 May 2023 09:25:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e184fa06-9ce4-1ab9-4680-58aa6c4200b9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dx87AAFmxk28BvAA--.56533S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjvdXoWrur17CFy7KF48WrWxXFWDJwb_yoWDJrc_uF
 1ay3WDCw1UJ3ZI9392v34fAr9rJFZ3Cr45C3y0qrsavwn3tr4Fgr4UGr9ayF1SqFyfJF90
 yFWDtw4vyr15XjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrn0
 xqx4xG64xvF2IEw4CE5I8CrVC2j2Jv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY
 J7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3w
 AFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK
 6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7
 xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAaw2AF
 wI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
 Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
 14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1c
 AE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E
 14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
 CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
 MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnI
 WIevJa73UjIFyTuYvjxU74lkDUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
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



在 2023/5/22 下午9:44, Philippe Mathieu-Daudé 写道:
> On 22/5/23 13:47, Jiaxun Yang wrote:
>>
>>
>>> 2023年5月22日 04:52，Huacai Chen <chenhuacai@kernel.org> 写道：
>>>
>>> Hi, Jiaxun,
>>>
>>> Rename loongarch_ipi to loongson_ipi? It will be shared by both MIPS
>>> and LoongArch in your series.
>>
>> Hi Huacai,
>>
>> Thanks for the point, what’s the opinion from LoongArch mainatiners?
>>
>> Or perhaps rename it as loong_ipi to reflect the nature that it’s shared
>> by MIPS based Loongson and LoongArch based Loongson?
>
> I'm not a LoongArch maintainer, but a model named "loong_ipi" makes
> sense to me.
>
> Please add it to the two Virt machine sections in MAINTAINERS.
>
'loonggson_ipi' is better, qemu doesn't have naming with 'loong' as prefix.

And  patch2 should not use macros. Some attributes should be added to 
distinguish between MIPS and LongArch.

All references to loongarch_ipi should also be changed.

Thanks.
Song Gao


