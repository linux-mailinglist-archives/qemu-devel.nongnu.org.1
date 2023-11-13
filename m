Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3586F7E9BE3
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 13:09:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2VjQ-0005Di-RM; Mon, 13 Nov 2023 07:07:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r2VjO-0005DF-DV; Mon, 13 Nov 2023 07:07:54 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r2VjM-000567-SW; Mon, 13 Nov 2023 07:07:54 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4525375A4BE;
 Mon, 13 Nov 2023 13:08:16 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 38B4B75A4BA; Mon, 13 Nov 2023 13:08:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3734075A4B7;
 Mon, 13 Nov 2023 13:08:16 +0100 (CET)
Date: Mon, 13 Nov 2023 13:08:16 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v4 0/8] Misc clean ups to target/ppc exception handling
In-Reply-To: <CWXM7PTSELOP.3T6EQY4GSFR59@wheely>
Message-ID: <35e0ca4c-2572-149d-e3b6-6ff65ca574a6@eik.bme.hu>
References: <cover.1698158152.git.balaton@eik.bme.hu>
 <c5d4e1dd-5da9-8efe-20f4-4bcdc24357fe@eik.bme.hu>
 <CWXM7PTSELOP.3T6EQY4GSFR59@wheely>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
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

On Mon, 13 Nov 2023, Nicholas Piggin wrote:
> On Wed Nov 1, 2023 at 8:44 PM AEST, BALATON Zoltan wrote:
>> On Tue, 24 Oct 2023, BALATON Zoltan wrote:
>>> These are some small clean ups for target/ppc/excp_helper.c trying to
>>> make this code a bit simpler. No functional change is intended. This
>>> series was submitted before but only partially merged due to freeze
>>> and conflicting series os thia was postponed then to avoid conflicts.
>>
>> Ping?
>
> May just leave this for next release, sorry.

No problem, these aren't that important. I've tried to optimise exception 
handling a bit as these seem to happen very often with some guests. 
Especially sc is common so that's why I tried to avoid moving nip around 
unnecessarily. But these did not have a great impact (unlike the ppc440 
tlbwe patches) so they are just clean ups now to alow further profiling 
and optimisation later. It can wait until the next devel window.

Regards,
BALATON Zoltan

> I still didn't like the change to logging -- that's not intended to
> print some machine implementation detail, but the address of the
> instruction that caused the syscall/hcall. That could be changed
> easily enough.
>
> But I am also now in two minds about the change to nip too.
> Synchronous interrupt is today handled here with nip at the address
> of the instruction that caused it. That's *also* a nice invaraint to
> have.
>
> Other patches seem okay.
>
> Thanks,
> Nick
>
>

