Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6168B749A7C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:20:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHN1d-0008HY-Qf; Thu, 06 Jul 2023 07:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHN1c-0008HL-4m; Thu, 06 Jul 2023 07:19:52 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHN1a-0002D6-GU; Thu, 06 Jul 2023 07:19:51 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 22C7B746369;
 Thu,  6 Jul 2023 13:19:32 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E61AF746335; Thu,  6 Jul 2023 13:19:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E4A2C745720;
 Thu,  6 Jul 2023 13:19:31 +0200 (CEST)
Date: Thu, 6 Jul 2023 13:19:31 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, 
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 00/14] PPC440 devices misc clean up
In-Reply-To: <c00e7c46-6928-ed4d-f2c6-2754a590802f@gmail.com>
Message-ID: <2155c455-6ac0-638f-e9a8-735233451e19@eik.bme.hu>
References: <cover.1688586835.git.balaton@eik.bme.hu>
 <d192a786-6019-f1d3-6491-c245527da417@gmail.com>
 <ec526143-9f3f-3d8d-9977-2ee76a31ef23@eik.bme.hu>
 <c00e7c46-6928-ed4d-f2c6-2754a590802f@gmail.com>
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

On Thu, 6 Jul 2023, Daniel Henrique Barboza wrote:
> On 7/5/23 22:09, BALATON Zoltan wrote:
>> On Wed, 5 Jul 2023, Daniel Henrique Barboza wrote:
>>> Zoltan,
>>> 
>>> Patches 1-9 are queued. Don't need to re-send those.
>> 
>> Thanks, the last two patches are also reviewed and they don't depend on the 
>> ones before so you could queue those too.
>
> Just queued patch 13.
>
> Patch 14 doesn't apply in ppc-next even after applying patch 13:
>
> $ git am -s -m \[PATCH\ v2\ 14_14\]\ ppc440_pcix\:\ Stop\ using\ system\ io\ 
> region\ for\ PCI\ bus\ -\ BALATON\ Zoltan\ \<balaton@eik.bme.hu\>\ -\ 
> 2023-07-05\ 1712.eml
> Applying: ppc440_pcix: Stop using system io region for PCI bus
> error: patch failed: hw/ppc/ppc440_pcix.c:490
> error: hw/ppc/ppc440_pcix.c: patch does not apply
> error: patch failed: hw/ppc/sam460ex.c:441
> error: hw/ppc/sam460ex.c: patch does not apply
> Patch failed at 0001 ppc440_pcix: Stop using system io region for PCI bus
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> I suspect we need  some of the previous (10, 11, 12) to apply it cleanly.

There was only one place in context that differs. All I did was an 
interactive rebase with moving it to the front and it did not have any 
conflict. I've resent a v3 series with that so you can take the first 
patch from that (or the rest of that if we can reach a decision on 
naming). The first attempt had wrong dates so I've resent the series. 
Sorry about that.

Regards,
BALATON Zoltan

