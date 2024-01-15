Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C718582D6DD
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 11:10:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJte-00066c-PC; Mon, 15 Jan 2024 05:08:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rPJtc-00066T-Cs
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:08:44 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rPJtZ-00060G-Cb
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 05:08:44 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxdfEcBKVl51EAAA--.1694S3;
 Mon, 15 Jan 2024 18:08:28 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Cxf88YBKVlnPYBAA--.10237S3; 
 Mon, 15 Jan 2024 18:08:26 +0800 (CST)
Subject: Re: [PATCH 1/2] gitlab: Introduce Loongarch64 runner
From: gaosong <gaosong@loongson.cn>
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Tianrui Zhao
 <zhaotianrui@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-2-philmd@linaro.org>
 <3d30c1b6-1de1-418e-80f6-3d693375142a@redhat.com>
 <6134cdb3-1884-5d7f-fc2d-4a6a2fa2126a@loongson.cn>
 <9fcd71ae-8a65-4f60-ab98-5a3e5807070d@redhat.com>
 <70a13656-39ed-1be8-44fe-fbed87dffa08@loongson.cn>
Message-ID: <9afd6640-c797-7a61-5992-d12d7890087b@loongson.cn>
Date: Mon, 15 Jan 2024 18:08:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <70a13656-39ed-1be8-44fe-fbed87dffa08@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Cxf88YBKVlnPYBAA--.10237S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAF4kJry7Cw4rKF1fWF45Jwc_yoWrKrWkpF
 ySka13KrWUXr1kt3W3K34UXFy8Kr18t3WUXF98J3W0yr4qgr92qr4jqr1qgF1kZr48Gr1Y
 qw15t3429Fs5JrXCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xu
 ctUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.821,
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

在 2024/1/12 下午5:52, gaosong 写道:
> 在 2024/1/11 下午4:26, Thomas Huth 写道:
>> On 11/01/2024 08.25, gaosong wrote:
>>> Hi,
>>>
>>> 在 2024/1/11 下午3:08, Thomas Huth 写道:
>>>> On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
>>>>> Full build config to run CI tests on a Loongarch64 host.
>>>>>
>>>>> Forks might enable this by setting LOONGARCH64_RUNNER_AVAILABLE
>>>>> in their CI namespace settings, see:
>>>>> https://www.qemu.org/docs/master/devel/ci.html#maintainer-controlled-job-variables 
>>>>>
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>>> ---
>>>>>   docs/devel/ci-jobs.rst.inc                    |  6 ++++++
>>>>>   .gitlab-ci.d/custom-runners.yml               |  1 +
>>>>>   .../openeuler-22.03-loongarch64.yml           | 21 
>>>>> +++++++++++++++++++
>>>>>   3 files changed, 28 insertions(+)
>>>>>   create mode 100644 
>>>>> .gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>>>>
>>>> ...
>>>>> diff --git a/.gitlab-ci.d/custom-runners.yml 
>>>>> b/.gitlab-ci.d/custom-runners.yml
>>>>> index 8e5b9500f4..152ace4492 100644
>>>>> --- a/.gitlab-ci.d/custom-runners.yml
>>>>> +++ b/.gitlab-ci.d/custom-runners.yml
>>>>> @@ -32,3 +32,4 @@ include:
>>>>>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
>>>>>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
>>>>>     - local: 
>>>>> '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
>>>>> +  - local: 
>>>>> '/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml'
>>>>> diff --git 
>>>>> a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml 
>>>>> b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>>>> new file mode 100644
>>>>> index 0000000000..86d18f820e
>>>>> --- /dev/null
>>>>> +++ b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>>>> @@ -0,0 +1,21 @@
>>>>> +openeuler-22.03-loongarch64-all:
>>>>> + extends: .custom_runner_template :-)
>>>>> + needs: []
>>>>> + stage: build
>>>>> + tags:
>>>>> + - oe2203
>>>>> + - loongarch64
>>>>> + rules:
>>>>> + - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && 
>>>>> $CI_COMMIT_BRANCH =~ /^staging/'
>>>>> +   when: manual
>>>>> +   allow_failure: true
>>>>> + - if: "$LOONGARCH64_RUNNER_AVAILABLE"
>>>>> +   when: manual
>>>>> +   allow_failure: true
>>>>> + script:
>>>>> + - mkdir build
>>>>> + - cd build
>>>>> + - ../configure
>>>>> +   || { cat config.log meson-logs/meson-log.txt; exit 1; }
>>>>> + - make --output-sync -j`nproc --ignore=40`
>>>>> + - make --output-sync -j`nproc --ignore=40` check
>>>>
>>>> Does this system really have more than 40 CPU threads? Or is this a 
>>>> copy-n-past from one of the other scripts? In the latter case, I'd 
>>>> suggest to adjust the --ignore=40 to a more reasonable value.
>>>>
>>>>  Thomas
>>> No,  only 32.   I think it should be --ignore=32 or 16.
>>
>> --ignore=32 then also does not make much sense, that would still be 
>> the same as simply omitting the -j parameter. I guess --ignore=16 
>> should be fine.
>>
>>> I create a same runner on this machine, and I  find  some check error.
>>> but I am not sure how to fix it. :-)
>>>
>>> See:
>>>
>>> https://gitlab.com/gaosong/qemu/-/jobs/5906269934
>>
>> Seems to be related to RAM backing... for example, the erst-test is 
>> failing, which is doing something like:
>>
>>     setup_vm_cmd(&state,
>>         "-object memory-backend-file,"
>>             "mem-path=acpi-erst.XXXXXX,"
>>             "size=64K,"
> Hi,
>
> We tested this  on
> LoongArch host with the 5.10 kernel,  (openEuler 22.03),
> x86_64 host with 5.10 kernel, (openEuler 22.03)
> x86_64 host with 5.15kernel , (Ubuntu 20.04.3 LTS)
>
> and didn't get any error.
>
> but the CI machine use the  6.7_rc4 kernel.
> we didn't update the x86_64 host kernel to tested this.
>
> Is it possible that the new kernel is causing the problem?
>
Hi,

The kernel adds the patch[1] can fix this problem.

[1] 
https://patchew.org/linux/20240106145501.3370364-1-chenhuacai@loongson.cn/

So
Tested-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Song Gao <gaosong@loongson.cn>

Thanks.
Song Gao

>> "share=on,"
>>             "id=nvram "
>>         "-device acpi-erst,"
>>             "memdev=nvram");
>>
>> So it seems like -object memory-backend-file" is not correctly 
>> working in your gitlab runner? Is there some setup missing?
>>
>>  Thomas
>>
>>
>


