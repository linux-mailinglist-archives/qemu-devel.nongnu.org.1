Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A867EF5D2
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 17:05:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r41Kp-0000AO-0u; Fri, 17 Nov 2023 11:04:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=r3Gg=G6=kaod.org=clg@ozlabs.org>)
 id 1r41Km-0000A3-GD; Fri, 17 Nov 2023 11:04:44 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=r3Gg=G6=kaod.org=clg@ozlabs.org>)
 id 1r41Kk-0006UG-Ji; Fri, 17 Nov 2023 11:04:44 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SX1tm6mk2z4wdC;
 Sat, 18 Nov 2023 03:04:32 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SX1tl1J9Rz4wd7;
 Sat, 18 Nov 2023 03:04:30 +1100 (AEDT)
Message-ID: <401c3b41-8344-4043-9f7d-26844fcb03cd@kaod.org>
Date: Fri, 17 Nov 2023 17:04:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] ppc/pnv: Add pca9552 to powernv10 for PCIe hotplug
 power control
Content-Language: en-US
To: Miles Glenn <milesg@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>
References: <20231114195659.1219821-1-milesg@linux.vnet.ibm.com>
 <20231114195659.1219821-2-milesg@linux.vnet.ibm.com>
 <54fad54f-a52e-41c6-90ba-7bc0b637cd59@kaod.org>
 <d5c90e92aa4cf313925de81872e95d0b62c36cce.camel@linux.vnet.ibm.com>
 <bd0875a1-4258-457d-8a9b-cfa12f0d84ef@kaod.org>
 <07f8b838e5a6696f81b6fc056105cf8dddbcaab4.camel@linux.vnet.ibm.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <07f8b838e5a6696f81b6fc056105cf8dddbcaab4.camel@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=r3Gg=G6=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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


> Well, I was hoping to sweep the pca9554 model under the PowerNV
> maintainership (like pca9552 is under the BMC aspeed maintainership).
> I did update the PowerNV list to include it, but perhaps that was
> presumptuous of me. :-)

Well, you are the person who has the most knowledge on both and
you have access to HW to check changes !

> I would be ok with being added as a reviewer under the PowerNV list,
> but I wonder if I shouldn't have more opensource experience before
> becoming a maintainer? TBH, I have no idea what that would entail.

For these devices, mostly acking the changes. I don't think anyone
will ask you to send PRs. This can be handled through some other
tree, PPC or Aspeed.
  
> As for patches 3 and 4, it sounds like I should split those changes out
> from the current patch series so that they can make it into QEMU 8.2.
> Correct?

I don't think this is needed. They can be picked in the series and
merged in the ppc tree independently.

Thanks,

C.


