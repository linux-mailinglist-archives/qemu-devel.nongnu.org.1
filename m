Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A387BCB65
	for <lists+qemu-devel@lfdr.de>; Sun,  8 Oct 2023 03:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpIJ4-0000W8-V9; Sat, 07 Oct 2023 21:10:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lichao@loongson.cn>)
 id 1qpIIz-0000VN-Gm
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 21:10:03 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lichao@loongson.cn>) id 1qpIIo-0005tH-EX
 for qemu-devel@nongnu.org; Sat, 07 Oct 2023 21:09:53 -0400
Received: from loongson.cn (unknown [10.40.24.149])
 by gateway (Coremail) with SMTP id _____8BxpPBTASJlwOkvAA--.26592S3;
 Sun, 08 Oct 2023 09:09:40 +0800 (CST)
Received: from [10.40.24.149] (unknown [10.40.24.149])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8BxbNxTASJlNnoaAA--.56007S3; 
 Sun, 08 Oct 2023 09:09:39 +0800 (CST)
Content-Type: multipart/alternative;
 boundary="------------U9oR1eCOnFDyad0eYOeTNO91"
Message-ID: <56be5657-8c37-126d-2626-a24fce49be50@loongson.cn>
Date: Sun, 8 Oct 2023 09:09:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: On integrating LoongArch EDK2 firmware into QEMU build process
To: WANG Xuerui <i.qemu@xen0n.name>, maobibo <maobibo@loongson.cn>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Song Gao <gaosong@loongson.cn>, =?UTF-8?B?5p2o5bCP5aif?=
 <yangxiaojuan@loongson.cn>
References: <1f1d3d9f-c3df-4f29-df66-886410994cc3@xen0n.name>
 <67517424-0f32-09f8-6446-53f71ebd59b5@loongson.cn>
 <89c67ba0-5152-4b03-b0be-19ba97bfac4c@xen0n.name>
From: Chao Li <lichao@loongson.cn>
In-Reply-To: <89c67ba0-5152-4b03-b0be-19ba97bfac4c@xen0n.name>
X-CM-TRANSID: AQAAf8BxbNxTASJlNnoaAA--.56007S3
X-CM-SenderInfo: xolfxt3r6o00pqjv00gofq/1tbiAQASCGUgwCUKLQABsd
X-Coremail-Antispam: 1Uk129KBj93XoW7uF43AF1ruw4rZryxXF1fuFX_yoW5JFy7pr
 4fua13tr4kGFW8Kw1kCw47uFZavrn5GrW5Jw15GryDCwnIgFn2vry0qFs8CFy7Grn3t3yj
 gFWjvw4kAa1DZFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAF
 F20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r
 1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAF
 wI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67
 AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x2
 0xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1lYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
 0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCjr7xv
 wVCIw2I0I7xG6c02F41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2
 IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r106r1rMI8I3I0E7480Y4vE14v2
 6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
 AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
 s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
 0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1njjDUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=lichao@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, HTML_MESSAGE=0.001,
 NICE_REPLY_A=-0.644, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------U9oR1eCOnFDyad0eYOeTNO91
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Xuerui,

     Sorry for late reply. In fact the EDK2 repo is ready for submit, in 
a few days I will commit the patch set in kilaterlee/edk2 repo and 
execute the EDK2 CI testing. I will notify some people to review them, 
you are also welcome to review the patch set. And then, I'll submit the 
formal version patch to the EDK2 devel community.


Thanks,
Chao
在 2023/10/1 04:16, WANG Xuerui 写道:
> On 3/31/23 08:54, maobibo wrote:
>> Xuerui,
>>
>> Thanks for your mail, it is a good suggestion. Now we are planing to 
>> move LoongArch uefi bios from edk2-platform to edk2 repo, so that 
>> uefi bios supporting LoongArch can be auto compiled and uploaded to 
>> qemu repo. Only that process is somwhat slow since lacking of hands, 
>> however we are doing this.
>
> Pinging: a few months have passed, and it seems this work is stalled? 
> Given the LoongArch Linux KVM support is about to land in v6.7, it may 
> be time to prepare the firmware and QEMU side of things, so users 
> would no longer have to manually acquire the firmware blobs whenever 
> they fire up their VMs.
>
>>
>> Regards
>> Bibo, Mao
>>
>> 在 2023/3/30 22:06, WANG Xuerui 写道:
>>> Hi,
>>>
>>> Recently there are reportedly increased general interest in trying 
>>> out LoongArch on top of QEMU, among both end users and 
>>> organizations; and the EDK2 firmware port is fully upstreamed since 
>>> the stable202211 version, and a build suitable for QEMU is already 
>>> possible with Platform/Loongson/LoongArchQemuPkg in edk2-platforms. 
>>> I think providing pre-built LoongArch firmware would make it much 
>>> easier to dabble in system emulation, helping those users. (They 
>>> currently have to pull a blob from yangxiaojuan/qemu-binary, and 
>>> remember to pair certain version of QEMU with certain revision of 
>>> the firmware blob. I'm also one of the users who can't remember 
>>> which version to use, but I can always build my own; imagine the 
>>> difficulty an end user would face!)
>>>
>>> So I tried to add a LoongArch build to the list stored in roms/, but 
>>> discovered that edk2-platforms seems not included, because all other 
>>> platforms' EDK2 packages are directly under the main edk2 repo.
>>>
>>> The question is: is integrating a platform package from 
>>> edk2-platforms okay under the current build system, so we can 
>>> arrange to provide edk2-platforms also as a submodule and go ahead? 
>>> Or do we (the LoongArch firmware community) have to change the code 
>>> organization to make necessary parts available in the main edk2 repo?
>>>
>>> CC-ing target/loongarch maintainers from Loongson too as you may 
>>> have more information.
>>
--------------U9oR1eCOnFDyad0eYOeTNO91
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><font size="2">Hi Xuerui,</font></p>
    <p><font size="2">    Sorry for late reply. In fact the EDK2 repo is
        ready for submit, in a few days I will commit the patch set in
        kilaterlee/edk2 repo and execute the EDK2 CI testing. I will
        notify some people to review them, you are also welcome to
        review the patch set. And then, I'll submit the formal version
        patch to the EDK2 devel community.</font></p>
    <div class="moz-signature"
      signature-switch-id="18b8a24a-8ce6-4aca-a108-921eeebcd5e9"><br>
      <div
        style="width:15%;height:1px;background-color:grey;transform:scaleY(0.3)"></div>
      <div style="color:grey;font-size:11px">Thanks,<br>
        Chao<br>
      </div>
    </div>
    <div class="moz-cite-prefix">在 2023/10/1 04:16, WANG Xuerui 写道:<br>
    </div>
    <blockquote type="cite"
      cite="mid:89c67ba0-5152-4b03-b0be-19ba97bfac4c@xen0n.name">On
      3/31/23 08:54, maobibo wrote:
      <br>
      <blockquote type="cite">Xuerui,
        <br>
        <br>
        Thanks for your mail, it is a good suggestion. Now we are
        planing to move LoongArch uefi bios from edk2-platform to edk2
        repo, so that uefi bios supporting LoongArch can be auto
        compiled and uploaded to qemu repo. Only that process is somwhat
        slow since lacking of hands, however we are doing this.
        <br>
      </blockquote>
      <br>
      Pinging: a few months have passed, and it seems this work is
      stalled? Given the LoongArch Linux KVM support is about to land in
      v6.7, it may be time to prepare the firmware and QEMU side of
      things, so users would no longer have to manually acquire the
      firmware blobs whenever they fire up their VMs.
      <br>
      <br>
      <blockquote type="cite">
        <br>
        Regards
        <br>
        Bibo, Mao
        <br>
        <br>
        在 2023/3/30 22:06, WANG Xuerui 写道:
        <br>
        <blockquote type="cite">Hi,
          <br>
          <br>
          Recently there are reportedly increased general interest in
          trying out LoongArch on top of QEMU, among both end users and
          organizations; and the EDK2 firmware port is fully upstreamed
          since the stable202211 version, and a build suitable for QEMU
          is already possible with Platform/Loongson/LoongArchQemuPkg in
          edk2-platforms. I think providing pre-built LoongArch firmware
          would make it much easier to dabble in system emulation,
          helping those users. (They currently have to pull a blob from
          yangxiaojuan/qemu-binary, and remember to pair certain version
          of QEMU with certain revision of the firmware blob. I'm also
          one of the users who can't remember which version to use, but
          I can always build my own; imagine the difficulty an end user
          would face!)
          <br>
          <br>
          So I tried to add a LoongArch build to the list stored in
          roms/, but discovered that edk2-platforms seems not included,
          because all other platforms' EDK2 packages are directly under
          the main edk2 repo.
          <br>
          <br>
          The question is: is integrating a platform package from
          edk2-platforms okay under the current build system, so we can
          arrange to provide edk2-platforms also as a submodule and go
          ahead? Or do we (the LoongArch firmware community) have to
          change the code organization to make necessary parts available
          in the main edk2 repo?
          <br>
          <br>
          CC-ing target/loongarch maintainers from Loongson too as you
          may have more information.
          <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------U9oR1eCOnFDyad0eYOeTNO91--


