Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5835C78FA51
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 10:57:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbzwb-00026l-LF; Fri, 01 Sep 2023 04:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qbzwY-00026c-Bg
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:55:54 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qbzwT-0000DK-M6
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 04:55:54 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8AxueoKp_Fk9r0dAA--.50932S3;
 Fri, 01 Sep 2023 16:55:38 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8AxzyMHp_Fkt8doAA--.15445S3; 
 Fri, 01 Sep 2023 16:55:35 +0800 (CST)
Subject: Re: [PATCH] roms: Support compile the efi bios for loongarch
From: lixianglai <lixianglai@loongson.cn>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>
References: <260307952ffe5382a55d66a4999034490e04f7df.1691653307.git.lixianglai@loongson.cn>
 <41a215d5-4ae6-dfa3-a61e-c21fd8ca311d@linaro.org>
 <0cc3d20d-e849-9e2d-7560-fd694a412032@loongson.cn>
Message-ID: <c9f1e257-0875-21cf-4bbb-f678aab6b60c@loongson.cn>
Date: Fri, 1 Sep 2023 16:55:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0cc3d20d-e849-9e2d-7560-fd694a412032@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8AxzyMHp_Fkt8doAA--.15445S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxZFWkWF43CF1xXF1rAr4rCrX_yoW5Kw13pa
 n7Ga1akrWkur4vyrZag3WxZrWjvwsYq398Xan3tFy8ArnxXr1qvr1jqr1Y9F9rXw4xGFWj
 vryYgw1093W5ZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
 xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
 6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67
 vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU25EfUUUU
 U
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.478,
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

ping!


Hi,Philippe Mathieu-Daudé:

Would like to know if there is any progress in the discussion on this issue?


In addition, is the compilation of our UEFI done on the fedora38 
operating system

or on a later version of fedora?


The loongarch cross-compilation tool on the fedora38 operating system is 
a bit old,

and there is a problem with the UEFI of the compiled loongarch,

so I want to ask about the UEFI compilation environment.


Thanks,

xianglai


On 8/10/23 8:54 PM, lixianglai wrote:
>
> On 8/10/23 7:34 PM, Philippe Mathieu-Daudé wrote:
>> Hi,
>>
>> On 10/8/23 09:42, xianglai li wrote:
>>> 1.Add edk2-platform submodule
>>> 2.Added loongarch UEFI BIOS support to compiled scripts.
>>> 3.The cross-compilation toolchain on x86 can be obtained from the 
>>> link below:
>>> https://github.com/loongson/build-tools/tree/2022.09.06
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
>>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>>> Cc: Thomas Huth <thuth@redhat.com>
>>> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>>> Cc: Song Gao <gaosong@loongson.cn>
>>> Cc: Bibo Mao <maobibo@loongson.cn>
>>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>>> ---
>>>   .gitmodules            |  3 +++
>>>   meson.build            |  2 +-
>>>   pc-bios/meson.build    |  2 ++
>>>   roms/edk2-build.config | 14 ++++++++++++++
>>>   roms/edk2-build.py     |  4 ++--
>>>   roms/edk2-platforms    |  1 +
>>>   6 files changed, 23 insertions(+), 3 deletions(-)
>>>   create mode 160000 roms/edk2-platforms
>>>
>>> diff --git a/.gitmodules b/.gitmodules
>>> index 73cae4cd4d..0cb57123fa 100644
>>> --- a/.gitmodules
>>> +++ b/.gitmodules
>>> @@ -43,3 +43,6 @@
>>>   [submodule "tests/lcitool/libvirt-ci"]
>>>       path = tests/lcitool/libvirt-ci
>>>       url = https://gitlab.com/libvirt/libvirt-ci.git
>>> +[submodule "roms/edk2-platforms"]
>>> +    path = roms/edk2-platforms
>>> +    url = https://github.com/tianocore/edk2-platforms.git
>>
>> See "Topic 4" in [*].
>>
>>  > We do need to be careful about GPL compliance (making sure users
>>  > have the source if we provide them the compiled firmware blob
>>  > for a GPL'd piece of firmware); but we don't need to necessarily
>>  > ship the sources in the exact same tarball as the blob.
>>
>>  > [...]
>>
>>  > Users of QEMU from git don't get a great firmware experience either,
>>  > since the firmware is in submodules, with all the usual git submodule
>>  > problems.
>>
>> edk2-platforms.git use the same license than edk2.git, 
>> BSD-2-Clause-Patent, which is compatible with GPLv2. At least this is 
>> not
>> edk2-non-osi.git.
>>
>> Still, we should discuss this generic issue before going forward with
>> this patch IMO.
>>
>
> Okay, I also think that there is no need to include EDK2 source code 
> in the tar ball,
>
> you can package the git repository of QEMU for distribution,
>
> and compile the BIOS binary package before release,
>
> so that there is no need to include BIOS code,
>
> QEMU users can also get the source code of BIOS through Git Submodule.
>
> This is only my opinion, and I look forward to the outcome of the 
> final discussion.
>
>
> Thanks,
>
> xianglai
>
>
>> Regards,
>>
>> Phil.
>>
>> [*] 
>> https://lore.kernel.org/qemu-devel/CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com/


