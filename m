Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CFD7778DE
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 14:55:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qU5BJ-0004Fe-9Z; Thu, 10 Aug 2023 08:54:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qU5BF-0004F6-QI
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:54:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qU5BB-0007xq-Og
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 08:54:21 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8Dxg_Dy3dRkrqwUAA--.44874S3;
 Thu, 10 Aug 2023 20:54:10 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax98zv3dRkeClTAA--.56422S3; 
 Thu, 10 Aug 2023 20:54:07 +0800 (CST)
Subject: Re: [PATCH] roms: Support compile the efi bios for loongarch
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>
References: <260307952ffe5382a55d66a4999034490e04f7df.1691653307.git.lixianglai@loongson.cn>
 <41a215d5-4ae6-dfa3-a61e-c21fd8ca311d@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <0cc3d20d-e849-9e2d-7560-fd694a412032@loongson.cn>
Date: Thu, 10 Aug 2023 20:54:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <41a215d5-4ae6-dfa3-a61e-c21fd8ca311d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Ax98zv3dRkeClTAA--.56422S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF48AFyftr4rur45Gw4DGFX_yoW5Aw4Upa
 n7GrW5CrZ7WrWktFs3W3WxZFy7ZrsYq398Xan3tFyUAas8Xw1qvr1jvF1j9FnrXw48KF4j
 qry0g3W09a45XFXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
 7xkEbVWUJVW8JwCFI7km07C267AKxVWUtVW8ZwC20s026c02F40E14v26r1j6r18MI8I3I
 0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
 cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcV
 CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
 c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jbsqXUUUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.156,
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


On 8/10/23 7:34 PM, Philippe Mathieu-Daudé wrote:
> Hi,
>
> On 10/8/23 09:42, xianglai li wrote:
>> 1.Add edk2-platform submodule
>> 2.Added loongarch UEFI BIOS support to compiled scripts.
>> 3.The cross-compilation toolchain on x86 can be obtained from the 
>> link below:
>> https://github.com/loongson/build-tools/tree/2022.09.06
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
>> Cc: "Daniel P. Berrangé" <berrange@redhat.com>
>> Cc: Thomas Huth <thuth@redhat.com>
>> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Xiaojuan Yang <yangxiaojuan@loongson.cn>
>> Cc: Song Gao <gaosong@loongson.cn>
>> Cc: Bibo Mao <maobibo@loongson.cn>
>> Signed-off-by: xianglai li <lixianglai@loongson.cn>
>> ---
>>   .gitmodules            |  3 +++
>>   meson.build            |  2 +-
>>   pc-bios/meson.build    |  2 ++
>>   roms/edk2-build.config | 14 ++++++++++++++
>>   roms/edk2-build.py     |  4 ++--
>>   roms/edk2-platforms    |  1 +
>>   6 files changed, 23 insertions(+), 3 deletions(-)
>>   create mode 160000 roms/edk2-platforms
>>
>> diff --git a/.gitmodules b/.gitmodules
>> index 73cae4cd4d..0cb57123fa 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -43,3 +43,6 @@
>>   [submodule "tests/lcitool/libvirt-ci"]
>>       path = tests/lcitool/libvirt-ci
>>       url = https://gitlab.com/libvirt/libvirt-ci.git
>> +[submodule "roms/edk2-platforms"]
>> +    path = roms/edk2-platforms
>> +    url = https://github.com/tianocore/edk2-platforms.git
>
> See "Topic 4" in [*].
>
>  > We do need to be careful about GPL compliance (making sure users
>  > have the source if we provide them the compiled firmware blob
>  > for a GPL'd piece of firmware); but we don't need to necessarily
>  > ship the sources in the exact same tarball as the blob.
>
>  > [...]
>
>  > Users of QEMU from git don't get a great firmware experience either,
>  > since the firmware is in submodules, with all the usual git submodule
>  > problems.
>
> edk2-platforms.git use the same license than edk2.git, 
> BSD-2-Clause-Patent, which is compatible with GPLv2. At least this is not
> edk2-non-osi.git.
>
> Still, we should discuss this generic issue before going forward with
> this patch IMO.
>

Okay, I also think that there is no need to include EDK2 source code in 
the tar ball,

you can package the git repository of QEMU for distribution,

and compile the BIOS binary package before release,

so that there is no need to include BIOS code,

QEMU users can also get the source code of BIOS through Git Submodule.

This is only my opinion, and I look forward to the outcome of the final 
discussion.


Thanks,

xianglai


> Regards,
>
> Phil.
>
> [*] 
> https://lore.kernel.org/qemu-devel/CAFEAcA_rziBuSwgJ9cg9m1PS5pNG58eyim+_P9hMu5nF7G70XA@mail.gmail.com/


