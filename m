Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82248791700
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 14:19:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd8XA-0005oX-Vh; Mon, 04 Sep 2023 08:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lixianglai@loongson.cn>)
 id 1qd8Ww-0005nI-LR
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:18:10 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lixianglai@loongson.cn>) id 1qd8Ws-0006mf-UL
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 08:18:10 -0400
Received: from loongson.cn (unknown [10.20.42.32])
 by gateway (Coremail) with SMTP id _____8CxruvzyvVkLeIeAA--.59824S3;
 Mon, 04 Sep 2023 20:17:56 +0800 (CST)
Received: from [10.20.42.32] (unknown [10.20.42.32])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxLCPxyvVkRzFrAA--.42919S3; 
 Mon, 04 Sep 2023 20:17:54 +0800 (CST)
Subject: Re: [PATCH] roms: Support compile the efi bios for loongarch
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Xiaojuan Yang <yangxiaojuan@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Bibo Mao <maobibo@loongson.cn>, Chao Li <lichao@loongson.cn>
References: <260307952ffe5382a55d66a4999034490e04f7df.1691653307.git.lixianglai@loongson.cn>
 <41a215d5-4ae6-dfa3-a61e-c21fd8ca311d@linaro.org>
 <0cc3d20d-e849-9e2d-7560-fd694a412032@loongson.cn>
 <c9f1e257-0875-21cf-4bbb-f678aab6b60c@loongson.cn>
 <lx3zo3f2ox5d4cgi2rhce2mikiiqetdngvzhfaxx5tnsz65vtr@al2euj2s7m6j>
From: lixianglai <lixianglai@loongson.cn>
Message-ID: <e086fca3-39c1-cf8d-afed-65dba64d2dcc@loongson.cn>
Date: Mon, 4 Sep 2023 20:17:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <lx3zo3f2ox5d4cgi2rhce2mikiiqetdngvzhfaxx5tnsz65vtr@al2euj2s7m6j>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxLCPxyvVkRzFrAA--.42919S3
X-CM-SenderInfo: 5ol0xt5qjotxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tFWkJw48Kr4UCr1DXF1DJwc_yoW8Ww4kpF
 9aywsrJF48KryvqrWkGa48Xa1DZ34fGrn2vF4UXr18C3s8XrWru3srtFZYgF9rJw1vvFyU
 ury093yqg3WDZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
 z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
 8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE
 2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
 xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
 7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07URKZXUUUUU=
Received-SPF: pass client-ip=114.242.206.163;
 envelope-from=lixianglai@loongson.cn; helo=mail.loongson.cn
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
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


On 9/4/23 7:42 PM, Gerd Hoffmann wrote:
>    Hi,
>
>> The loongarch cross-compilation tool on the fedora38 operating system is a
>> bit old,
> The gcc 12 -> 13 update for the cross compilers landed meanwhile,
> right now we have:
>
>      binutils-loongarch64-linux-gnu.x86_64 2.39-4.fc38    @updates
>      gcc-loongarch64-linux-gnu.x86_64      13.2.1-1.fc38  @updates

Compile with the compiler of the above version to compile UEFI normally,

but there are some problems running on qemu,

which require a later version of binutils to solve.

It means that we need UEFI compiled by the following version

of the compiler to run properly on qemu:

binutils-loongarch64-linux-gnu-2.40-3.fc39.x86_64
gcc-loongarch64-linux-gnu-13.2.1-1.fc39.x86_64

>
> Trying to build the loongarch firmware throws errors
> (edk2/edk2-platforms repos, master branch, checkout
> being a few days old):
>
> build.py...
> /home/kraxel/projects/edk2-platforms/Platform/Loongson/LoongArchQemuPkg/Loongson.dsc(...): error 4000: Instance of library class [AcpiPlatformLib] is not found
> 	in [/home/kraxel/projects/edk2/OvmfPkg/AcpiPlatformDxe/AcpiPlatformDxe.inf] [LOONGARCH64]
> 	consumed by module [/home/kraxel/projects/edk2/OvmfPkg/AcpiPlatformDxe/AcpiPlatformDxe.inf]

This compilation error is caused by a change in the AcpiPlatformLib 
position in edk2, which is referenced by loongarch's UEFI.

We have already submitted the patch to the edk2 community and may need a 
day or two to merge.

You can get the corresponding submission from the link below:

https://github.com/tianocore/edk2-platforms/pull/94/files


Thanks,

xianglai


> take care,
>    Gerd


