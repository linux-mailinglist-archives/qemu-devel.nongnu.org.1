Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55853740262
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 19:41:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qECgU-0007YT-Qd; Tue, 27 Jun 2023 13:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qECgT-0007XX-34; Tue, 27 Jun 2023 13:40:57 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qECgO-0003fK-C6; Tue, 27 Jun 2023 13:40:55 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0A829746335;
 Tue, 27 Jun 2023 19:40:23 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C7D0374632B; Tue, 27 Jun 2023 19:40:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C612D745720;
 Tue, 27 Jun 2023 19:40:22 +0200 (CEST)
Date: Tue, 27 Jun 2023 19:40:22 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Nicholas Piggin <npiggin@gmail.com>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, 
 Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v3 09/14] target/ppc: Move patching nip from exception
 handler to helper_scv
In-Reply-To: <CTMJMWCPZQX7.LVCEBEI5KXOE@wheely>
Message-ID: <434967dc-b631-f1d2-0267-93695c1e806b@eik.bme.hu>
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <b7317331ebccb0209fd0b12687945af6f626b0eb.1686868895.git.balaton@eik.bme.hu>
 <CTH6LN434MCH.2IK0QCFPCBW6F@wheely>
 <cd15856c-a664-66e6-cd27-65247784b3fe@eik.bme.hu>
 <CTMJMWCPZQX7.LVCEBEI5KXOE@wheely>
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

On Mon, 26 Jun 2023, Nicholas Piggin wrote:
> On Tue Jun 20, 2023 at 8:47 PM AEST, BALATON Zoltan wrote:
>> On Tue, 20 Jun 2023, Nicholas Piggin wrote:
>>> On Fri Jun 16, 2023 at 9:03 AM AEST, BALATON Zoltan wrote:
>>>> From: Nicholas Piggin <npiggin@gmail.com>
>>>>
>>>> Unlike sc, for scv a facility unavailable interrupt must be generated
>>>> if FSCR[SCV]=0 so we can't raise the exception with nip set to next
>>>> instruction but we can move advancing nip if the FSCR check passes to
>>>> helper_scv so the exception handler does not need to change it.
>>>>
>>>> [balaton: added commit message]
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>
>>> Ah you sent it, fine, thank you. But actually now I look again,
>>> now we're off by one in the other direction for the dumps.
>>
>> This is mentioned in the commit message for the patch changing sc. I think
>> we should not patch nip in the dump so we actually dump what the CPU
>> should have and match the ISA docs.
>>
>>> So... probably your way is still better because it matches the
>>> interrupt semantics of the ISA when executing the instruction,
>>> but it needs this patch:
>>
>> OK so then I'm confused why we need nip - 4 in dumps?
>
> Sorry I missed your reply here. We want nip - 4 in dumps so the
> address of the syscall is the sc instruction itself, not the
> random one after it.

Although that's how it was in QEMU before that's not how it is on real 
hardware so I don't think we should keep this and just log what a real CPU 
would have and people should know how to interpret that after consulting 
the ISA docs.

Regards,
BALATON Zoltan

