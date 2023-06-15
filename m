Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 707CA73145F
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 11:47:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9jYX-0001w6-32; Thu, 15 Jun 2023 05:46:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xCJj=CD=kaod.org=clg@ozlabs.org>)
 id 1q9jYU-0001vM-Cy; Thu, 15 Jun 2023 05:46:14 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=xCJj=CD=kaod.org=clg@ozlabs.org>)
 id 1q9jYS-0006ls-LN; Thu, 15 Jun 2023 05:46:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QhcqY18Xpz4wfg;
 Thu, 15 Jun 2023 19:46:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QhcqW0GqPz4wjD;
 Thu, 15 Jun 2023 19:45:58 +1000 (AEST)
Message-ID: <34de2184-3743-45f8-77c6-ab688b143e64@kaod.org>
Date: Thu, 15 Jun 2023 11:45:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/4] ppc/pnv: Add chiptod and core timebase state machine
 models
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Frederic Barrat <frederic.barrat@fr.ibm.com>,
 Michael Neuling <mikey@neuling.org>
References: <20230603233612.125879-1-npiggin@gmail.com>
 <e3f591df-6569-b396-0cf7-0ea62aee9f0c@kaod.org>
 <CTC47NS1KELC.35U22YEEW26UP@wheely>
 <e2e88fc1-8099-7eab-b51b-8212063fa6a5@kaod.org>
 <CTCV3K9JWBVQ.3R7AH302X3VHQ@wheely>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CTCV3K9JWBVQ.3R7AH302X3VHQ@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=xCJj=CD=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.098, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

[ ... ]
> Yes it worked with 2 chips.

I will give the next series a try.

[ ... ]

>> It's difficult to review PATCH 4 without some good knowledge of HW. I know
>> you do but you can not review your own patches ! That said, the impact is
>> limited to PowerNV machines, I guess we are fine.
> 
> Yeah. I appreciate all the review so far. It's pretty complicated even
> with the workbook. I might be able to add a simpler and higher-level
> description of the basic init sequence and states. You would still have
> to trust me, but it might make it easier to see what's going on.

Sure. Patches 2-4 are acked. I am only looking at patch 1 now.

Thanks,

C.


