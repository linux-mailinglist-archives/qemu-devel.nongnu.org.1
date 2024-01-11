Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93482A84C
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:27:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNpSC-0005t4-9z; Thu, 11 Jan 2024 02:26:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNpS9-0005ss-78
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:26:13 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNpS6-0000KS-4H
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:26:12 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8AxTesGmJ9lECsEAA--.12358S3;
 Thu, 11 Jan 2024 15:25:59 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Dxmd0CmJ9lQhUPAA--.39537S3; 
 Thu, 11 Jan 2024 15:25:56 +0800 (CST)
Subject: Re: [PATCH 1/2] gitlab: Introduce Loongarch64 runner
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-2-philmd@linaro.org>
 <3d30c1b6-1de1-418e-80f6-3d693375142a@redhat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <6134cdb3-1884-5d7f-fc2d-4a6a2fa2126a@loongson.cn>
Date: Thu, 11 Jan 2024 15:25:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <3d30c1b6-1de1-418e-80f6-3d693375142a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Dxmd0CmJ9lQhUPAA--.39537S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxWF4fCFWDAw4fXFWrCr4kGrX_yoW5ArWrpa
 ySka1akFy7Zws5K3WfC345XFyrGr18t3W7JF9Yq3W0vrsIgrZ2qr4jgr1vgF1DZr48Cr4Y
 gwnYv34a9FsYqagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jYpB-UUU
 UU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.07,
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

Hi,

在 2024/1/11 下午3:08, Thomas Huth 写道:
> On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
>> Full build config to run CI tests on a Loongarch64 host.
>>
>> Forks might enable this by setting LOONGARCH64_RUNNER_AVAILABLE
>> in their CI namespace settings, see:
>> https://www.qemu.org/docs/master/devel/ci.html#maintainer-controlled-job-variables 
>>
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   docs/devel/ci-jobs.rst.inc                    |  6 ++++++
>>   .gitlab-ci.d/custom-runners.yml               |  1 +
>>   .../openeuler-22.03-loongarch64.yml           | 21 +++++++++++++++++++
>>   3 files changed, 28 insertions(+)
>>   create mode 100644 
>> .gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>
> ...
>> diff --git a/.gitlab-ci.d/custom-runners.yml 
>> b/.gitlab-ci.d/custom-runners.yml
>> index 8e5b9500f4..152ace4492 100644
>> --- a/.gitlab-ci.d/custom-runners.yml
>> +++ b/.gitlab-ci.d/custom-runners.yml
>> @@ -32,3 +32,4 @@ include:
>>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
>>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
>>     - local: '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
>> +  - local: 
>> '/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml'
>> diff --git 
>> a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml 
>> b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>> new file mode 100644
>> index 0000000000..86d18f820e
>> --- /dev/null
>> +++ b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>> @@ -0,0 +1,21 @@
>> +openeuler-22.03-loongarch64-all:
>> + extends: .custom_runner_template :-)
>> + needs: []
>> + stage: build
>> + tags:
>> + - oe2203
>> + - loongarch64
>> + rules:
>> + - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH 
>> =~ /^staging/'
>> +   when: manual
>> +   allow_failure: true
>> + - if: "$LOONGARCH64_RUNNER_AVAILABLE"
>> +   when: manual
>> +   allow_failure: true
>> + script:
>> + - mkdir build
>> + - cd build
>> + - ../configure
>> +   || { cat config.log meson-logs/meson-log.txt; exit 1; }
>> + - make --output-sync -j`nproc --ignore=40`
>> + - make --output-sync -j`nproc --ignore=40` check
>
> Does this system really have more than 40 CPU threads? Or is this a 
> copy-n-past from one of the other scripts? In the latter case, I'd 
> suggest to adjust the --ignore=40 to a more reasonable value.
>
>  Thomas
No,  only 32.   I think it should be --ignore=32 or 16.

I create a same runner on this machine,  and I  find  some check error.
but I am not sure how to fix it. :-)

See:

https://gitlab.com/gaosong/qemu/-/jobs/5906269934

Thanks.
Song Gao


