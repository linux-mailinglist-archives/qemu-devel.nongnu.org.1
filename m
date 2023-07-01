Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F927448C4
	for <lists+qemu-devel@lfdr.de>; Sat,  1 Jul 2023 14:00:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFZG0-0004hc-5Y; Sat, 01 Jul 2023 07:59:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFZFv-0004hP-Q0
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 07:59:11 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFZFu-0000Ij-88
 for qemu-devel@nongnu.org; Sat, 01 Jul 2023 07:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 In-Reply-To:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HUvWWzeC6i10u0AquICUezzYl2yLIB0LMiRxiVfqyBk=; b=IOmQ7yGgID/KuDQlwtrlcQjPDM
 eWMWXQyTr62fuLjJqJQ9UN++wx1Ds4IlurVCjW4mSI6bLcOIb5ZxF7eBJi3Z04pRAlF5Q1cru7UMK
 jxe8qdkDMU1ydCeTJmFOiDWhZLnZcgdjYIZaUsIP0ucHwF4AHqnN+Ll3I86IEcYxjF1gkRjmCYjCC
 5oE9M7qcTlfXwZKdiFLd3gC8WfgwKFtffJ3RaquYsvf6aLETE7RLiWsWbKbCJZ4z2Z+MvR4qz3hy6
 z12ik1OC5MxQorqKWQwc3WselrMPoMM8NCphrUYqXd4HxhpanLriXtBWsbXCqSsFEelDirg5a85BS
 ZTnZZYSJ19/ghWtSTlNIYSe+BXFcFjesy1ob12n1N52j874sk42lkgXq9h+sM8ddANTtCBnqOWZzQ
 3vKjmnU2dj1mB29rCR0MaVqPWdm3eVcgcbXyPSn+oiO+v6BlS9nj1fnXfFkX5QgHuFlWWmO3xBTG3
 XOlclsW1vaXd6LMWbdfj2VER3mqf9cbIjmfOlsU3NfuBPgf+nrJlHgb4mwMO1jPyev8d0KMixbNP9
 u7D80zH1olqYW9AB+04tXhCPDH8jeenM4l7uEh2nweyGdyZTehPMTOG+ZY+VzhOV5Fp/0DJMvbBZg
 dk0YCPgLCNoghK9WLBBck+lRnI8S5T++MrJ7Ngs4M=;
Received: from [2a00:23c4:8bad:df00:f732:dd76:7417:d15b]
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qFZFc-0005I2-Q0; Sat, 01 Jul 2023 12:58:56 +0100
Message-ID: <b562eb6f-c7ad-dec9-d92f-266ca8561170@ilande.co.uk>
Date: Sat, 1 Jul 2023 12:58:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Bernhard Beschow <shentey@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>, qemu-devel <qemu-devel@nongnu.org>,
 John Snow <jsnow@redhat.com>, "open list:X86"
 <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>
References: <20210317070046.17860-1-olaf@aepfle.de>
 <4441d32f-bd52-9408-cabc-146b59f0e4dc@redhat.com>
 <20210325121219.7b5daf76.olaf@aepfle.de>
 <dae251e1-f808-708e-902c-05cfcbbea9cf@redhat.com>
 <20230509225818.GA16290@aepfle.de> <20230626231901.5b5d11c1.olaf@aepfle.de>
 <c939b695-2b68-085a-0f19-108ecdcc1a05@redhat.com>
 <5DB37FA5-41DF-4ED6-8C8A-CDDD6F276F42@gmail.com>
 <20230627140740.2736f6e8.olaf@aepfle.de>
 <4F5609FD-4A89-4450-89E2-3311CC5A9317@gmail.com>
 <CABgObfamZEHv0W3B6kPXGTiT1f2G__S=Bi1-_PYeSomsiVFaFg@mail.gmail.com>
 <3987B0DB-46F2-49F1-AEA5-B88BC61A633F@gmail.com>
Content-Language: en-US
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <3987B0DB-46F2-49F1-AEA5-B88BC61A633F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bad:df00:f732:dd76:7417:d15b
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v2] piix: fix regression during unplug in Xen HVM domUs
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.093,
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

On 01/07/2023 10:53, Bernhard Beschow wrote:

> Am 30. Juni 2023 08:48:02 UTC schrieb Paolo Bonzini <pbonzini@redhat.com>:
>> Il mer 28 giu 2023, 13:28 Bernhard Beschow <shentey@gmail.com> ha scritto:
>>
>>>
>>>
>>> Am 27. Juni 2023 12:07:40 UTC schrieb Olaf Hering <olaf@aepfle.de>:
>>>> Tue, 27 Jun 2023 10:12:50 +0000 Bernhard Beschow <shentey@gmail.com>:
>>>>
>>>>> The BAR is a 32 bit register whose default value is 0x00000001. I think
>>> what's supposed to happen here is a pci_set_long() rather than a
>>> pci_set_byte().
>>>>
>>>> Indeed, the u32 at that address changes from c121 to c101 with the
>>> current code.
>>>
>>> Neat! Would you mind sending a patch fixing the BMIBA register to be reset
>>> as 32 bit?
>>>
>>
>> I think we should also check why writing the command register is not
>> disabling the BAR as well.
> 
> So IIUC the BMIBA register is managed internally by QEMU's PCI code and we shouldn't have to mess with the register at all. We should actually remove the explicit reset of BMIBA, correct?
> 
> I've tried debugging the PCI code when working on the VIA IDE controller to understand it better. But despite QEMU being compiled with --enable-debug it seemd to be compiled with -O2 still, making debugging quite hard. I'm not sure if any compile flags leak into my build environment though.

Certainly --enable-debug normally does the right thing when building QEMU. If you 
want to double-check the compiler flags in use to see if anything from CFLAGS/LDFLAGS 
is getting picked up, use "make V=1" after configure which outputs the full command 
being used during the build rather than just the summary.


ATB,

Mark.


