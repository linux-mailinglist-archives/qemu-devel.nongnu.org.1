Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD4C744D9B
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 14:38:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFwJy-0000hy-MF; Sun, 02 Jul 2023 08:36:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qFwJv-0000hV-NW; Sun, 02 Jul 2023 08:36:51 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qFwJt-00040J-7B; Sun, 02 Jul 2023 08:36:51 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id D5B5874645F;
 Sun,  2 Jul 2023 14:36:28 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 9E4D274632B; Sun,  2 Jul 2023 14:36:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9AE10746369;
 Sun,  2 Jul 2023 14:36:28 +0200 (CEST)
Date: Sun, 2 Jul 2023 14:36:28 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v3 00/14] Misc clean ups to target/ppc exception handling
In-Reply-To: <a314ebf0-fede-2646-a255-59ee9ebf33d6@gmail.com>
Message-ID: <a7502abc-8186-134f-6019-771c1afc27fc@eik.bme.hu>
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <92e3591e-cce7-c3e7-7d73-a0bd24de8c2c@gmail.com>
 <1726bfcd-0e6e-0a72-bc97-be7a79f95340@eik.bme.hu>
 <03e0c0c0-d3e5-bc4c-6c07-db642d2e6f52@gmail.com>
 <275e9cc3-8cb5-052a-7683-7abf4ea78522@eik.bme.hu>
 <a314ebf0-fede-2646-a255-59ee9ebf33d6@gmail.com>
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

On Sat, 1 Jul 2023, Daniel Henrique Barboza wrote:
> On 7/1/23 06:39, BALATON Zoltan wrote:
>> On Sat, 1 Jul 2023, Daniel Henrique Barboza wrote:
>>> On 6/30/23 19:57, BALATON Zoltan wrote:
>>>> On Fri, 30 Jun 2023, Daniel Henrique Barboza wrote:
>>>>> Patches 1, 2, 3, 5, 7 and 11 are queued.
>>>>> 
>>>>> If you would be so kind to get the remaining patches, rebase them
>>>>> on top of my ppc-next and resend, I believe there's more stuff
>>>>> to be queued.
>>>> 
>>>> Thanks for taking care of these. I'll do the rebase of remaining patches 
>>>> once the current queue is merged, they aren't urgent so I can come back 
>>>> to those later. I'm working on some sam460ex patches but don't know yet 
>>>> when can I send it so don't wait for me now.
>>> 
>>> Got it. Just bear in mind the current release schedule. Code freeze is 
>>> July 11th:
>>> 
>>> https://wiki.qemu.org/Planning/8.1
>>> 
>>> I'll send one last PR before freeze (probably on July 10th) and then it'll 
>>> be only bug fixes until end of August.
>> 
>> Do you mean one more last PR after merging the current queue or the current 
>> queue will only be in that last PR? I hoped there would be a PR now on 
>> which I can rebase the outstanding patches for the last PR so I don't have 
>> to rebase on next but if the only PR you plan is the last on 10th then I 
>> may need to move to ppc-next now.
>
> Just use ppc-next right now.
>
> Even if I send a PR today with what we have, Peter/Richard has no 
> obligation of merging it quickly on Monday (there's an US holiday July 
> 4th, and some people will also skip July 3rd). If you wait for such PR 
> to merge upstream, then start rebasing your stuff, you'll have less time 
> to work with.

They may not be in the US though. Anyway, I've tried to rebase the 
remaining patches on your ppc-next branch and they applied without changes 
so not sure what you need from me now. I think Nick had alternative 
versions of the checkstop and sc patches that may cause a rebase when then 
go in first. Do you want me to merge them and submit that as a series with 
my patches? I don't have much time for now and these are just clean ups so 
I can live with these missing the next release and can come back to it 
later. I may try to do some sam460ex clean ups instead that should not 
clash with anything else.

Regards,
BALATON Zoltan

