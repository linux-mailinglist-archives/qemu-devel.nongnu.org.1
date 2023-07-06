Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFB1749B05
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 13:43:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNOr-0005nj-Ts; Thu, 06 Jul 2023 07:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHNOZ-0005jB-Ps; Thu, 06 Jul 2023 07:43:35 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1qHNOW-0007L8-HY; Thu, 06 Jul 2023 07:43:35 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0B664746335;
 Thu,  6 Jul 2023 13:43:11 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 953CE74632B; Thu,  6 Jul 2023 13:43:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9392B745720;
 Thu,  6 Jul 2023 13:43:10 +0200 (CEST)
Date: Thu, 6 Jul 2023 13:43:10 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: Re: [PATCH v3] target/ppc: Machine check on invalid real address
 access on POWER9/10
In-Reply-To: <53ae3355-e7a9-13cb-92d7-b300f44951f1@kaod.org>
Message-ID: <26d30881-8d33-2c4f-1998-834991cf8538@eik.bme.hu>
References: <20230703120301.45313-1-npiggin@gmail.com>
 <CTUWXISZHAI1.3A3FS0U9SD90B@wheely>
 <53ae3355-e7a9-13cb-92d7-b300f44951f1@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-104072064-1688643790=:49441"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-104072064-1688643790=:49441
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 6 Jul 2023, Cédric Le Goater wrote:
> On 7/6/23 09:32, Nicholas Piggin wrote:
>> On Mon Jul 3, 2023 at 10:03 PM AEST, Nicholas Piggin wrote:
>>> ppc currently silently accepts invalid real address access. Catch
>>> these and turn them into machine checks on POWER9/10 machines.
>> 
>> Would there be any objections to merging this and the checkstop patch?
>> We could disable this one before release if it turns out to cause
>> breakage.
>> 
>> I don't think it needs to rebase, and passes clang build and make check
>> here. Just messed up the separator on the changelog of the checkstop
>> patch.
>
> I have been using the v2 series for a while :
>
>  https://patchwork.ozlabs.org/project/qemu-ppc/list/?series=361456
>
> without patch 4 and it looked good. Let's take v3 since this patch is
> unchanged.

I think there was a newer version that dropped the test for the MSR bit 
from the checkstop function and left that at the call site to avoid adding 
a one line wrapper later. This version does not seem to be that so 
probably the next iteration is better but I was lost following these 
series..

Regards,
BALATON Zoltan
--3866299591-104072064-1688643790=:49441--

