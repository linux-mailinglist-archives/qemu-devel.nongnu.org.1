Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 558C2731383
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 11:21:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9j8k-0001QO-7I; Thu, 15 Jun 2023 05:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9j8d-0001Or-Q9; Thu, 15 Jun 2023 05:19:31 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9j8b-0001wE-D6; Thu, 15 Jun 2023 05:19:31 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 56F8D748A5C;
 Thu, 15 Jun 2023 11:19:21 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 286CA748A59; Thu, 15 Jun 2023 11:19:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 26AC7748A5A;
 Thu, 15 Jun 2023 11:19:21 +0200 (CEST)
Date: Thu, 15 Jun 2023 11:19:21 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v2 05/10] target/ppc: Change parameter of
 cpu_interrupt_exittb() to an env pointer
In-Reply-To: <CTCWOA3I3X48.2RZG2THERVO2@wheely>
Message-ID: <33d841e7-38ab-07d3-4914-a055b029605c@eik.bme.hu>
References: <cover.1686776990.git.balaton@eik.bme.hu>
 <78ecd505a8b523e236cbeab335aa0621f7834cc5.1686776990.git.balaton@eik.bme.hu>
 <CTCWOA3I3X48.2RZG2THERVO2@wheely>
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

On Thu, 15 Jun 2023, Nicholas Piggin wrote:
> On Thu Jun 15, 2023 at 7:34 AM AEST, BALATON Zoltan wrote:
>> Changing the parameter of cpu_interrupt_exittb() from CPUState to env
>> allows removing some more local CPUState variables in callers.
>
> I think it's more consistent to keep cs, which is same as
> cpu_interrupt().

But with this patch it's more consistent with the other functions devlared 
in helper_regs.h and gets rid of the #ifdef in hreg_store_msr() so I'd 
still like to keep this patch. Callers already have env so it should not 
matter.

Regards,
BALATON Zoltan

