Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77DB72FA1E
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 12:08:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9NQD-0007TI-6u; Wed, 14 Jun 2023 06:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9NQ8-0007Sk-L1; Wed, 14 Jun 2023 06:08:08 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9NQ5-0006s5-Sd; Wed, 14 Jun 2023 06:08:07 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6132374633D;
 Wed, 14 Jun 2023 12:07:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 30A6C746335; Wed, 14 Jun 2023 12:07:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2F062745720;
 Wed, 14 Jun 2023 12:07:57 +0200 (CEST)
Date: Wed, 14 Jun 2023 12:07:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH 06/10] target/ppc: Readability improvements in exception
 handlers
In-Reply-To: <CTC29HK3ZXQL.2GCE26RLVYS75@wheely>
Message-ID: <38943a8a-5e25-8336-586a-615716ac1369@eik.bme.hu>
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <edbb93cb67b72bb948155932767ef989cddc8aa0.1686522199.git.balaton@eik.bme.hu>
 <CTC29HK3ZXQL.2GCE26RLVYS75@wheely>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spam-Probability: 9%
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

On Wed, 14 Jun 2023, Nicholas Piggin wrote:
> On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
>> Improve readability by shortening some long comments, removing
>> comments that state the obvious and dropping some empty lines so they
>> don't distract when reading the code.
>
> Some changes are a matter of taste, but in the interest of having
> somebody do some spring cleaning of this code I don't want to nitpick
> it, so I won't :)

Thanks. I prefer functions to be less streched out vertically so more 
lines fit in a single screen. Ideally the whole function should be visible 
so it's easier to comprehend than having to scroll around but if there's 
something really bothering you I can consider changing that. But if you 
can accept this as it is then that's less work for me.

Regards,
BALATON Zoltan

> Acked-by: Nicholas Piggin <npiggin@gmail.com>
>
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  target/ppc/cpu.h         |   1 +
>>  target/ppc/excp_helper.c | 180 +++++++--------------------------------
>>  2 files changed, 33 insertions(+), 148 deletions(-)
>>
>
>

