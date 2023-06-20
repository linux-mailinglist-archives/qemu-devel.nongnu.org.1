Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C6B7369ED
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 12:52:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBYy5-00042H-93; Tue, 20 Jun 2023 06:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBYy3-000422-PT; Tue, 20 Jun 2023 06:52:11 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qBYy2-0007bm-9r; Tue, 20 Jun 2023 06:52:11 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6564F74645F;
 Tue, 20 Jun 2023 12:52:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 394CC746335; Tue, 20 Jun 2023 12:52:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 37E7B746377;
 Tue, 20 Jun 2023 12:52:00 +0200 (CEST)
Date: Tue, 20 Jun 2023 12:52:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 12/14] target/ppc: Clean up ifdefs in excp_helper.c,
 part 1
In-Reply-To: <CTH7TRQ8I0SP.30Z12X2RSO5JI@wheely>
Message-ID: <69cde6a8-ce94-dde2-bd32-f62ebe8f5325@eik.bme.hu>
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <178a7e99a1d930b8f988280741147513a726a68b.1686868895.git.balaton@eik.bme.hu>
 <CTH7TRQ8I0SP.30Z12X2RSO5JI@wheely>
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

On Tue, 20 Jun 2023, Nicholas Piggin wrote:
> On Fri Jun 16, 2023 at 9:03 AM AEST, BALATON Zoltan wrote:
>> Use #ifdef, #ifndef for brevity and add comments to #endif that are
>> more than a few lines apart for clarity.
>
> These will collide with the SOFTMMU ifdef changes that Philippe is
> working on I think? They seem okay but maybe wait until after those
> are merged?

Those were just merged and I did not get rebase conflicts. I 
think Phillippe replaced SOFTMMU with USER_ONLY or so not touching 
exsiring USER_ONLY stuff.

Regards,
BALATON Zoltan

