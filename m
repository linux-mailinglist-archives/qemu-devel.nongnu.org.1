Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 830AF7EF461
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 15:24:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zkS-0007Tc-QA; Fri, 17 Nov 2023 09:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r3zkO-0007T0-EF; Fri, 17 Nov 2023 09:23:04 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r3zkM-0006OF-47; Fri, 17 Nov 2023 09:23:04 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4D31675607B;
 Fri, 17 Nov 2023 15:23:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4215A756078; Fri, 17 Nov 2023 15:23:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 40399756066;
 Fri, 17 Nov 2023 15:23:28 +0100 (CET)
Date: Fri, 17 Nov 2023 15:23:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Kevin Wolf <kwolf@redhat.com>
cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com, 
 qemu-block@nongnu.org, qemu-devel@nongnu.org, philmd@linaro.org, 
 shentey@gmail.com
Subject: Re: [PATCH v3 0/4] ide: implement simple legacy/native mode switching
 for PCI IDE controllers
In-Reply-To: <c29fa245-fbb6-ff76-7836-7447c845cf9f@eik.bme.hu>
Message-ID: <48c8863d-6534-eae2-4cba-089cc4fb6a6d@eik.bme.hu>
References: <20231116103355.588580-1-mark.cave-ayland@ilande.co.uk>
 <ZVYdkaQ5DcTHxhnJ@redhat.com>
 <c29fa245-fbb6-ff76-7836-7447c845cf9f@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 16 Nov 2023, BALATON Zoltan wrote:
> On Thu, 16 Nov 2023, Kevin Wolf wrote:
>> Am 16.11.2023 um 11:33 hat Mark Cave-Ayland geschrieben:
>>> This series adds a simple implementation of legacy/native mode switching 
>>> for PCI
>>> IDE controllers and updates the via-ide device to use it.
>>> 
>>> The approach I take here is to add a new pci_ide_update_mode() function 
>>> which handles
>>> management of the PCI BARs and legacy IDE ioports for each mode to avoid 
>>> exposing
>>> details of the internal logic to individual PCI IDE controllers.
>>> 
>>> As noted in [1] this is extracted from a local WIP branch I have which 
>>> contains
>>> further work in this area. However for the moment I've kept it simple (and
>>> restricted it to the via-ide device) which is good enough for Zoltan's PPC
>>> images whilst paving the way for future improvements after 8.2.
>>> 
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> 
>>> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg05403.html
>>> 
>>> v3:
>>> - Rebase onto master
>>> - Move ide_portio_list[] and ide_portio_list2[] to IDE core to prevent 
>>> duplication in
>>>   hw/ide/pci.c
>>> - Don't zero BARs when switching from native mode to legacy mode, instead 
>>> always force
>>>   them to read zero as suggested in the PCI IDE specification (note: this 
>>> also appears
>>>   to fix the fuloong2e machine booting from IDE)
>>> - Add comments in pci_ide_update_mode() suggested by Kevin
>>> - Drop the existing R-B and T-B tags: whilst this passes my local tests, 
>>> the behaviour
>>>   around zero BARs feels different enough here
>> 
>> Thanks, applied to the block branch.
>
> I feel a bit left out of this conversation... Did Google or some other spam 
> filter decide again to filter my messages so you did not see them at all? 
> Could you confitm that you've got my previous two replies in this thread so I 
> know I'm not sending comments to /dev/null please?

Looks like there's some issue with these mails. They appear in the list 
archive but maybe not in people's mailboxes? Did any of you got this 
message and previous ones I've sent?
https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03180.html 
https://lists.nongnu.org/archive/html/qemu-devel/2023-11/msg03983.html

Regards,
BALATON Zoltan


