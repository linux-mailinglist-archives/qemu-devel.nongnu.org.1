Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDECE82A87A
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 08:38:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNpdi-0003kb-Q3; Thu, 11 Jan 2024 02:38:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNpde-0003dg-4Z
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:38:06 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNpda-0006bE-CL
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 02:38:05 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8CxqurUmp9lvCsEAA--.11618S3;
 Thu, 11 Jan 2024 15:37:56 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax693Rmp9lrx8PAA--.39979S3; 
 Thu, 11 Jan 2024 15:37:55 +0800 (CST)
Subject: Re: [NOTFORMERGE PATCH 2/2] gitlab: Add Loongarch64 KVM-only build
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Cc: Zhiguo Wu <wuzhiguo@loongson.cn>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>, Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Beraldo Leal <bleal@redhat.com>, WANG Xuerui <git@xen0n.name>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Xianglai Li <lixianglai@loongson.cn>, Tianrui Zhao <zhaotianrui@loongson.cn>
References: <20240102172239.69452-1-philmd@linaro.org>
 <20240102172239.69452-3-philmd@linaro.org>
 <dbc7f2c6-15c0-4d5a-abf7-8946ff2d03cb@redhat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <4cc9ab90-c1bc-03d3-d82e-a763199fa029@loongson.cn>
Date: Thu, 11 Jan 2024 15:37:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <dbc7f2c6-15c0-4d5a-abf7-8946ff2d03cb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Ax693Rmp9lrx8PAA--.39979S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZF4rXrWfJr4fKFy8uF13KFX_yoW8uF4kp3
 s2kFWSkFWj9r1kKF4fC34rXF1rJw1kK3W7JFnaq3W0vrZFgr9rWr10qr4vgF15Zw48Gr1F
 vwnYqas8WFnxXrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUU9ab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C2
 67AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
 8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
 CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
 1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
 vfC2KfnxnUUI43ZEXa7IU8wNVDUUUUU==
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

在 2024/1/11 下午3:10, Thomas Huth 写道:
> On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> Used to test 
>> https://lore.kernel.org/qemu-devel/20231228084051.3235354-1-zhaotianrui@loongson.cn/
>
> So why is it NOTFORMERGE ? Don't we want to test KVM-only builds for 
> loongarch in the long run?
>
>  Thomas
>
I think we can drop this title.

I tested this job by the latest loongarch kvm patches.  buf I find a 
test-hmp check error.

See:
https://gitlab.com/gaosong/qemu/-/jobs/5906385234

If you want to log in to this machine, we can create an account for you.

Thanks.
Song Gao
>
>> ---
>>   .../openeuler-22.03-loongarch64.yml           | 22 +++++++++++++++++++
>>   1 file changed, 22 insertions(+)
>>
>> diff --git 
>> a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml 
>> b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>> index 86d18f820e..60674b8d0f 100644
>> --- a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>> +++ b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>> @@ -19,3 +19,25 @@ openeuler-22.03-loongarch64-all:
>>      || { cat config.log meson-logs/meson-log.txt; exit 1; }
>>    - make --output-sync -j`nproc --ignore=40`
>>    - make --output-sync -j`nproc --ignore=40` check
>> +
>> +openeuler-22.03-loongarch64-kvm:
>> + extends: .custom_runner_template
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
>> + - ../configure --enable-kvm --disable-tcg
>> +   || { cat config.log meson-logs/meson-log.txt; exit 1; }
>> + - make --output-sync -j`nproc --ignore=40`
>> + - make --output-sync -j`nproc --ignore=40` check


