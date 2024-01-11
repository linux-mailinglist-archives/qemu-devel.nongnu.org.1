Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0185482AE56
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 13:06:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNtpC-0000R6-Vv; Thu, 11 Jan 2024 07:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1rNtp2-0000Kj-Mv
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:06:09 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1rNtov-0000gZ-2I
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 07:06:04 -0500
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8Cxbbui2Z9l60EEAA--.4395S3;
 Thu, 11 Jan 2024 20:05:54 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Ax692d2Z9l5A8QAA--.42440S3; 
 Thu, 11 Jan 2024 20:05:51 +0800 (CST)
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
 <6134cdb3-1884-5d7f-fc2d-4a6a2fa2126a@loongson.cn>
 <9fcd71ae-8a65-4f60-ab98-5a3e5807070d@redhat.com>
From: gaosong <gaosong@loongson.cn>
Message-ID: <93861775-6cc5-fb52-8926-9c85fe42b932@loongson.cn>
Date: Thu, 11 Jan 2024 20:05:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <9fcd71ae-8a65-4f60-ab98-5a3e5807070d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Ax692d2Z9l5A8QAA--.42440S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxKr1fXw1xXFy5ZrWrCrW7Awc_yoW3Zw4fpF
 ySkF12gryUJr1xJw18tw1UJFyYyr47tw1UJFy8t3W0yr4Uur12qr1jqr1qgF1DXr48Gr1Y
 vw15Gws8uw1rGrcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07
 AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
 F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
 ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
 xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
 4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jO
 F4_UUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.982,
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

在 2024/1/11 下午4:26, Thomas Huth 写道:
> On 11/01/2024 08.25, gaosong wrote:
>> Hi,
>>
>> 在 2024/1/11 下午3:08, Thomas Huth 写道:
>>> On 02/01/2024 18.22, Philippe Mathieu-Daudé wrote:
>>>> Full build config to run CI tests on a Loongarch64 host.
>>>>
>>>> Forks might enable this by setting LOONGARCH64_RUNNER_AVAILABLE
>>>> in their CI namespace settings, see:
>>>> https://www.qemu.org/docs/master/devel/ci.html#maintainer-controlled-job-variables 
>>>>
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>> ---
>>>>   docs/devel/ci-jobs.rst.inc                    |  6 ++++++
>>>>   .gitlab-ci.d/custom-runners.yml               |  1 +
>>>>   .../openeuler-22.03-loongarch64.yml           | 21 
>>>> +++++++++++++++++++
>>>>   3 files changed, 28 insertions(+)
>>>>   create mode 100644 
>>>> .gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>>>
>>> ...
>>>> diff --git a/.gitlab-ci.d/custom-runners.yml 
>>>> b/.gitlab-ci.d/custom-runners.yml
>>>> index 8e5b9500f4..152ace4492 100644
>>>> --- a/.gitlab-ci.d/custom-runners.yml
>>>> +++ b/.gitlab-ci.d/custom-runners.yml
>>>> @@ -32,3 +32,4 @@ include:
>>>>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
>>>>     - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
>>>>     - local: '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
>>>> +  - local: 
>>>> '/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml'
>>>> diff --git 
>>>> a/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml 
>>>> b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>>> new file mode 100644
>>>> index 0000000000..86d18f820e
>>>> --- /dev/null
>>>> +++ b/.gitlab-ci.d/custom-runners/openeuler-22.03-loongarch64.yml
>>>> @@ -0,0 +1,21 @@
>>>> +openeuler-22.03-loongarch64-all:
>>>> + extends: .custom_runner_template :-)
>>>> + needs: []
>>>> + stage: build
>>>> + tags:
>>>> + - oe2203
>>>> + - loongarch64
>>>> + rules:
>>>> + - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && 
>>>> $CI_COMMIT_BRANCH =~ /^staging/'
>>>> +   when: manual
>>>> +   allow_failure: true
>>>> + - if: "$LOONGARCH64_RUNNER_AVAILABLE"
>>>> +   when: manual
>>>> +   allow_failure: true
>>>> + script:
>>>> + - mkdir build
>>>> + - cd build
>>>> + - ../configure
>>>> +   || { cat config.log meson-logs/meson-log.txt; exit 1; }
>>>> + - make --output-sync -j`nproc --ignore=40`
>>>> + - make --output-sync -j`nproc --ignore=40` check
>>>
>>> Does this system really have more than 40 CPU threads? Or is this a 
>>> copy-n-past from one of the other scripts? In the latter case, I'd 
>>> suggest to adjust the --ignore=40 to a more reasonable value.
>>>
>>>  Thomas
>> No,  only 32.   I think it should be --ignore=32 or 16.
>
> --ignore=32 then also does not make much sense, that would still be 
> the same as simply omitting the -j parameter. I guess --ignore=16 
> should be fine.
>
>> I create a same runner on this machine, and I  find  some check error.
>> but I am not sure how to fix it. :-)
>>
>> See:
>>
>> https://gitlab.com/gaosong/qemu/-/jobs/5906269934
>
> Seems to be related to RAM backing... for example, the erst-test is 
> failing, which is doing something like:
>
>     setup_vm_cmd(&state,
>         "-object memory-backend-file,"
>             "mem-path=acpi-erst.XXXXXX,"
>             "size=64K,"
>             "share=on,"
>             "id=nvram "
>         "-device acpi-erst,"
>             "memdev=nvram");
>
> So it seems like -object memory-backend-file" is not correctly working 
> in your gitlab runner? Is there some setup missing?
>
>  Thomas
>
>
This is my runner config.

     concurrent = 32
     check_interval = 0
     shutdown_timeout = 0

     [session_server]
       session_timeout = 1800

     ...

     [[runners]]
       name = "loongarch64"
       request_concurrency = 24
       url = "https://gitlab.com"
       id = 31426483
       token = "glrt-bGugocYrR2yqcu3ma7ka"
       token_obtained_at = 2024-01-10T08:31:29Z
       token_expires_at = 0001-01-01T00:00:00Z
       executor = "shell"
       builds_dir = "/data/gitlab-runner/builds"
       cache_dir = "/data/gitlab-runner/cache"
       [runners.cache]
         MaxUploadedArchiveSize = 0

I create a project runner 'loongarch64' for my branch ci-master.
Do we need some special configuration?

and  I just './configure  --target-list="x86_64-softmmu" 
--enable-debug'  on LoongArch host.   make , make check.
I got the same error.

[7/361] 🌗 qemu:qtest+qtest-x86_64 / 
qtest-x86_64/qos-test                                    2928s   60 
subtests passed

^CWARNING: Received SIGTERM, exiting
   7/361 qemu:qtest+qtest-x86_64 / 
qtest-x86_64/qos-test                        INTERRUPT 4671.32s   killed 
by signal 11 SIGSEGV
 >>> PYTHON=/home/gs/gitlab/qemu/build/pyvenv/bin/python3 
G_TEST_DBUS_DAEMON=/home/gs/gitlab/qemu/tests/dbus-vmstate-daemon.sh 
MALLOC_PERTURB_=198 QTEST_QEMU_IMG=./qemu-img 
QTEST_QEMU_BINARY=./qemu-system-x86_64 
QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon 
/home/gs/gitlab/qemu/build/tests/qtest/qos-test --tap -k
――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― ✀ 
―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
stderr:
qemu-system-x86_64: unable to map backing store for guest RAM: Invalid 
argument
Broken pipe
../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU 
process but encountered exit status 1 (expected 0)

TAP parsing error: Too few tests run (expected 119, got 60)


I also use V=2  to check.


  PYTHON=/home/gs/gitlab/qemu/build/pyvenv/bin/python3 
G_TEST_DBUS_DAEMON=/home/gs/gitlab/qemu/tests/dbus-vmstate-daemon.sh 
QTEST_QEMU_IMG=./qemu-img V=2 QTEST_QEMU_BINARY=./qemu-system-x86_64 
QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon 
MALLOC_PERTURB_=220 
/home/gs/gitlab/qemu/build/tests/qtest/bios-tables-test --tap -k

I got the error:

...
Looking for expected file 'tests/data/acpi/pc/FACS'
Using expected file 'tests/data/acpi/pc/FACS'
Looking for expected file 'tests/data/acpi/pc/DSDT.acpihmat'
Using expected file 'tests/data/acpi/pc/DSDT.acpihmat'
ok 15 /x86_64/acpi/piix4/acpihmat
# starting QEMU: exec ./qemu-system-x86_64 -qtest 
unix:/tmp/qtest-923048.sock -qtest-log /dev/null -chardev 
socket,path=/tmp/qtest-923048.qmp,id=char0 -mon 
chardev=char0,mode=control -display none -audio none -machine pc -accel 
kvm -accel tcg -net none  -object 
memory-backend-file,id=erstnvram,mem-path=/tmp/qemu-test-erst.N41SG2,size=0x10000,share=on 
-device acpi-erst,memdev=erstnvram -drive 
id=hd0,if=none,file=tests/acpi-test-disk-KIDwOM,format=raw -device 
ide-hd,drive=hd0  -accel qtest
qemu-system-x86_64: unable to map backing store for guest RAM: Invalid 
argument
Broken pipe
../tests/qtest/libqtest.c:195: kill_qemu() tried to terminate QEMU 
process but encountered exit status 1 (expected 0)
Aborted (core dumped)

is there need some  special  package for '-object memory-backend-file' ?

Thanks.
Song Gao


