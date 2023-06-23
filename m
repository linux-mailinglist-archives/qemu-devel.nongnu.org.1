Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A48F873BC6E
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 18:18:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCjTH-0006lO-Ab; Fri, 23 Jun 2023 12:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qCjTC-0006kx-B3; Fri, 23 Jun 2023 12:17:10 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qCjTA-0001D4-0Z; Fri, 23 Jun 2023 12:17:10 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E6B27748A69;
 Fri, 23 Jun 2023 18:16:53 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 66A5F74632B; Fri, 23 Jun 2023 18:16:53 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 64644745720;
 Fri, 23 Jun 2023 18:16:53 +0200 (CEST)
Date: Fri, 23 Jun 2023 18:16:53 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Fabiano Rosas <farosas@suse.de>
cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 qemu-devel@nongnu.org, Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 3/4] target/ppc: Move common check in machne check handlers
 to a function
In-Reply-To: <87edm2s4bh.fsf@suse.de>
Message-ID: <1bacd3d0-ac36-b5fe-f392-f209836f3c61@eik.bme.hu>
References: <20230623081953.290875-1-npiggin@gmail.com>
 <20230623081953.290875-4-npiggin@gmail.com> <87edm2s4bh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
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

On Fri, 23 Jun 2023, Fabiano Rosas wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
>> From: BALATON Zoltan <balaton@eik.bme.hu>
>>
>> All powerpc exception handlers share some code when handling machine
>> check exceptions. Move this to a common function.
>>
>
> Maybe Machine Check is simple enough, but this kind of sharing of code
> has historically caused pain when people want to change something for
> the modern cpus and end up affecting the old cpus by mistake.
>
> There is also the inverse scenario where someone has access to the old
> HW and just want to make an one-off contribution, but the community gets
> insecure about it because it could also affect the new cpus.

It's a trade off between making these independent and avoiding code 
duplication. I think if we have common things that are the same between 
different CPU models then we should not duplicate those, otherwise they 
can diverge when a problem is fixed in one copy but not in the others. We 
just have to remember that if in the future a new CPU defines these 
differently then we mayy need to add another function implementing that 
for the new CPU but the old CPUs can still share the same code without 
duplicating it. So the question is if this machine check is something that 
is the same across different CPU models or do we ever need to model this 
differently for different CPU models? At least the current implementation 
had the same code duplicated everywhere which this patch resolves.

Regards,
BALATON Zoltan

> Then comes the obvious "solution" which is to bring in an artificial
> identifier (excp. model) to be able to have conditional code inside the
> common function. And that causes problems because no one really knows
> how it maps to actual hardware/ISA.
>
> No objection, just a little cautionary tale. =)

