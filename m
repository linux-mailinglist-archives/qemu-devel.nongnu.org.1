Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A047B4376
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Sep 2023 22:18:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmgOG-0004YS-IQ; Sat, 30 Sep 2023 16:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.qemu@xen0n.name>) id 1qmgOE-0004YG-8U
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 16:16:38 -0400
Received: from mail.xen0n.name ([115.28.160.31] helo=mailbox.box.xen0n.name)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.qemu@xen0n.name>) id 1qmgO9-0000cu-Tw
 for qemu-devel@nongnu.org; Sat, 30 Sep 2023 16:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
 t=1696104984; bh=mIo9QnkARm8UhlZ6SQOOJsxA7VgWdzKJKkKEHtcTpOA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=SPYV9l6ZEqHf9Wg6XmkB7KpHQi4g92boAIZZsvXvxhi9cm7k5+wFMCU8uTl3YHx0p
 nlCA/VZy+FYBikCT3Z+4NlEaXoNN66DY10v5MhFytFosCwSEV1ZGAeHi5aQE8NxT9X
 ZB6rnlUjJp2oP2eFVjB7t3DTETbubpNukie+hIds=
Received: from [IPV6:240e:388:8d29:7200:ab91:7c43:136f:4b7b] (unknown
 [IPv6:240e:388:8d29:7200:ab91:7c43:136f:4b7b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 1D4EF60103;
 Sun,  1 Oct 2023 04:16:24 +0800 (CST)
Message-ID: <89c67ba0-5152-4b03-b0be-19ba97bfac4c@xen0n.name>
Date: Sun, 1 Oct 2023 04:16:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On integrating LoongArch EDK2 firmware into QEMU build process
Content-Language: en-US
To: maobibo <maobibo@loongson.cn>, qemu-devel <qemu-devel@nongnu.org>
Cc: Song Gao <gaosong@loongson.cn>, =?UTF-8?B?5p2o5bCP5aif?=
 <yangxiaojuan@loongson.cn>, Chao Li <lichao@loongson.cn>
References: <1f1d3d9f-c3df-4f29-df66-886410994cc3@xen0n.name>
 <67517424-0f32-09f8-6446-53f71ebd59b5@loongson.cn>
From: WANG Xuerui <i.qemu@xen0n.name>
In-Reply-To: <67517424-0f32-09f8-6446-53f71ebd59b5@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.28.160.31; envelope-from=i.qemu@xen0n.name;
 helo=mailbox.box.xen0n.name
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 3/31/23 08:54, maobibo wrote:
> Xuerui,
> 
> Thanks for your mail, it is a good suggestion. Now we are planing to move LoongArch uefi bios from edk2-platform to edk2 repo, so that uefi bios supporting LoongArch can be auto compiled and uploaded to qemu repo. Only that process is somwhat slow since lacking of hands, however we are doing this.

Pinging: a few months have passed, and it seems this work is stalled? 
Given the LoongArch Linux KVM support is about to land in v6.7, it may 
be time to prepare the firmware and QEMU side of things, so users would 
no longer have to manually acquire the firmware blobs whenever they fire 
up their VMs.

> 
> Regards
> Bibo, Mao
> 
> 在 2023/3/30 22:06, WANG Xuerui 写道:
>> Hi,
>>
>> Recently there are reportedly increased general interest in trying out LoongArch on top of QEMU, among both end users and organizations; and the EDK2 firmware port is fully upstreamed since the stable202211 version, and a build suitable for QEMU is already possible with Platform/Loongson/LoongArchQemuPkg in edk2-platforms. I think providing pre-built LoongArch firmware would make it much easier to dabble in system emulation, helping those users. (They currently have to pull a blob from yangxiaojuan/qemu-binary, and remember to pair certain version of QEMU with certain revision of the firmware blob. I'm also one of the users who can't remember which version to use, but I can always build my own; imagine the difficulty an end user would face!)
>>
>> So I tried to add a LoongArch build to the list stored in roms/, but discovered that edk2-platforms seems not included, because all other platforms' EDK2 packages are directly under the main edk2 repo.
>>
>> The question is: is integrating a platform package from edk2-platforms okay under the current build system, so we can arrange to provide edk2-platforms also as a submodule and go ahead? Or do we (the LoongArch firmware community) have to change the code organization to make necessary parts available in the main edk2 repo?
>>
>> CC-ing target/loongarch maintainers from Loongson too as you may have more information.
> 


