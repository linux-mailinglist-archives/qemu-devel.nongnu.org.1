Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AB47C6358
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 05:40:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqmWo-0005lj-4I; Wed, 11 Oct 2023 23:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qqmWm-0005lS-31
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 23:38:24 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qqmWi-0000Uc-Uq
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 23:38:23 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8AxTeshaidlhT8xAA--.23892S3;
 Thu, 12 Oct 2023 11:38:10 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8Bxvt4daidlAlQhAA--.3303S2; 
 Thu, 12 Oct 2023 11:38:08 +0800 (CST)
Subject: Re: [PATCH RFC v4 0/9] Add loongarch kvm accel support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Song Gao <gaosong@loongson.cn>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <cover.1696841645.git.lixianglai@loongson.cn>
 <e9f0c004-cb23-0985-30ca-394197d6bf94@linaro.org>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <3cbee563-23c2-ed96-8faa-c9b288e0add3@loongson.cn>
Date: Thu, 12 Oct 2023 11:38:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e9f0c004-cb23-0985-30ca-394197d6bf94@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8Bxvt4daidlAlQhAA--.3303S2
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7CF4UWw45ArW3Kw18uw18CrX_yoW5JF15pF
 WY9Fy3Krs5Grn7Jw4vg3s8XayUXrs5CF9rJ3Z3KFy8CFWDZF1vqr48urZ0gFsrA395XF1j
 qryxXw17u3WUXFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 XVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
 JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUU
 UUU
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
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

Hi Philippe Mathieu-Daudé :
> Hi,
>
> On 9/10/23 11:01, xianglai li wrote:
>> This series add loongarch kvm support, mainly implement
>> some interfaces used by kvm such as kvm_arch_get/set_regs,
>> kvm_arch_handle_exit, kvm_loongarch_set_interrupt, etc.
>>
>> Currently, we are able to boot LoongArch KVM Linux Guests.
>> In loongarch VM, mmio devices and iocsr devices are emulated
>> in user space such as APIC, IPI, pci devices, etc, other
>> hardwares such as MMU, timer and csr are emulated in kernel.
>>
>> It is based on temporarily unaccepted linux kvm:
>> https://github.com/loongson/linux-loongarch-kvm
>> And We will remove the RFC flag until the linux kvm patches
>> are merged.
>>
>> The running environment of LoongArch virt machine:
>> 1. Get the linux source by the above mentioned link.
>>     git checkout kvm-loongarch
>>     make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu- 
>> loongson3_defconfig
>>     make ARCH=loongarch CROSS_COMPILE=loongarch64-unknown-linux-gnu-
>> 2. Get the qemu source: https://github.com/loongson/qemu
>>     git checkout kvm-loongarch
>>     ./configure --target-list="loongarch64-softmmu" --enable-kvm
>>     make
>> 3. Get uefi bios of LoongArch virt machine:
>>     Link: 
>> https://github.com/tianocore/edk2-platforms/tree/master/Platform/Loongson/LoongArchQemuPkg#readme
>> 4. Also you can access the binary files we have already build:
>>     https://github.com/yangxiaojuan-loongson/qemu-binary
>>
>> The command to boot loongarch virt machine:
>>     $ qemu-system-loongarch64 -machine virt -m 4G -cpu la464 \
>>     -smp 1 -bios QEMU_EFI.fd -kernel vmlinuz.efi -initrd ramdisk \
>>     -serial stdio   -monitor telnet:localhost:4495,server,nowait \
>>     -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" \
>>     --nographic
>
> 2 years ago Song helped with an access to a LoongArch 3a5000 machine but
> it stopped working (IP was x.242.206.180).
>
> Would it be possible to add a Loongarch64 runner to our CI
> (ideally with KVM support, but that can come later)? See:
> https://www.qemu.org/docs/master/devel/ci.html#jobs-on-custom-runners
>

Ok, Song Gao will rebuild the Loongarch64 runner environment in the next 
few days,

and we will publish it to the community as soon as it is completed.

Thanks,

Xianglai.



> Regards,
>
> Phil.


