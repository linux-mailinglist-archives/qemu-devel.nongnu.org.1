Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EA87FE1F2
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 22:29:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8S7h-0006KE-Re; Wed, 29 Nov 2023 16:29:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KBMj=HK=kaod.org=clg@ozlabs.org>)
 id 1r8S7g-0006FN-38; Wed, 29 Nov 2023 16:29:32 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KBMj=HK=kaod.org=clg@ozlabs.org>)
 id 1r8S7d-0005Un-5h; Wed, 29 Nov 2023 16:29:30 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SgXWz5WDYz4xWh;
 Thu, 30 Nov 2023 08:29:19 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SgXWt4Lytz4xWV;
 Thu, 30 Nov 2023 08:29:14 +1100 (AEDT)
Message-ID: <1f2a6342-5d14-4549-bd44-1fe51f84f18d@kaod.org>
Date: Wed, 29 Nov 2023 22:29:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/10] Introduce model for IBM's FSI
Content-Language: en-US
To: Ninad Palsule <ninad@linux.ibm.com>, qemu-devel@nongnu.org,
 peter.maydell@linaro.org, andrew@codeconstruct.com.au, joel@jms.id.au,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, lvivier@redhat.com
Cc: qemu-arm@nongnu.org
References: <20231026164741.1184058-1-ninad@linux.ibm.com>
 <417e8a68-2f35-4315-b694-892f78c811b6@kaod.org>
 <a1fbfc7b-6f5a-44c4-9af4-65dac15763b6@linux.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <a1fbfc7b-6f5a-44c4-9af4-65dac15763b6@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=KBMj=HK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 11/29/23 15:56, Ninad Palsule wrote:
> Hello Cedric,
> 
> On 11/27/23 10:31, Cédric Le Goater wrote:
>> Hello Ninad,
>>
>> On 10/26/23 18:47, Ninad Palsule wrote:
>>> Hello,
>>>
>>> Please review the patch-set version 7.
>>> I have incorporated review comments from Cedric, Philippe and Thomas.
>>
>>
>> I reworked v7 with the suggestions I made in patches 1-6. Please check :
>>
>>   https://github.com/legoater/qemu/commits/aspeed-8.2
>>
>> I will have more questions on the mappings because some parts are really
>> unclear.
>>
> I forgot to mention in my last mail. If I build against your aspeed-8.2 branch then rainier machine is failing to boot.
> 
> The same images are working with qemu master branch.
> 
> fsi/qemu-system-arm -M rainier-bmc -nographic -kernel ./fitImage-linux.bin -dtb ./aspeed-bmc-ibm-rainier.dtb -initrd ./obmc-phosphor-initramfs.rootfs.cpio.xz -drive file=./obmc-phosphor-image.rootfs.wic.qcow2,if=sd,index=2 -append 'rootwait console=ttyS4,115200n8 root=PARTLABEL=rofs-a' -net nic -net user,hostfwd=:127.0.0.1:3222-:22,hostfwd=:127.0.0.1:2234-:1234 -trace 'fsi*'
>                          |
>                          |
> Starting systemd-udevd version 254^
> [   50.630407] /dev/disk/by-partlabel/rofs-a: Can't open blockdev
> mount: mounting /dev/disk/by-partlabel/rofs-a on /mnt/rofs failed: No such file or directory
> /bin/sh: can't access tty; job control turned off

Hello,

Please try with  '-M rainier-bmc,boot-emmc=false' to avoid using the
boot emmc mode which is the default for the rainier machine.

I just updated the aspeed-8.2 branch to take into account the -kernel
option when booting the rainier.


Thanks,

C.




