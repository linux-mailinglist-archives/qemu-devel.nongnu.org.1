Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6592D72F9F0
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 12:02:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9NIt-0008MF-UK; Wed, 14 Jun 2023 06:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9NIq-0008Kh-JM; Wed, 14 Jun 2023 06:00:36 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1q9NIo-00052L-59; Wed, 14 Jun 2023 06:00:36 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 60CD1748A5A;
 Wed, 14 Jun 2023 12:00:24 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 2BBD5748A59; Wed, 14 Jun 2023 12:00:24 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 29A4F748A56;
 Wed, 14 Jun 2023 12:00:24 +0200 (CEST)
Date: Wed, 14 Jun 2023 12:00:24 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH] target/ppc: Implement gathering irq statistics
In-Reply-To: <b9285487-fd9a-6955-6857-711f2258b706@kaod.org>
Message-ID: <f2e43ecf-d015-951c-8f8e-6e0b09dc79df@eik.bme.hu>
References: <20230606220200.7EBCC74635C@zero.eik.bme.hu>
 <a274071c-b2c0-8371-b10d-82a883edef1f@kaod.org>
 <074e4215-2f3d-2292-4f93-2048233fa33a@eik.bme.hu>
 <b9285487-fd9a-6955-6857-711f2258b706@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-265803155-1686736824=:19284"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-265803155-1686736824=:19284
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 14 Jun 2023, Cédric Le Goater wrote:
> On 6/8/23 11:34, BALATON Zoltan wrote:
>> On Thu, 8 Jun 2023, Cédric Le Goater wrote:
>>> On 6/7/23 00:02, BALATON Zoltan wrote:
>>>> Count exceptions which can be queried with info irq monitor command.
>>> 
>>> I don't think the TYPE_INTERRUPT_STATS_PROVIDER interface was designed
>>> for CPUs. It is more suitable for interrupt controllers.
>> 
>> True but:
>> - It works and provides useful statistics
>> - At least older PPC CPUs have embedded interrupt controller as the comment 
>> in cpu.h shows
>> 
>> so is this just a comment, question or you want something changed in this 
>> patch?
>
> It was more a general comment. It is also adding a very large array
> in an even larger structure. I wonder this has some impact on cache
> misses.

I could not measure a performance decrease at least with the tests I did 
so it likely has no major impact but that could also be host arch 
specific. I've found exceptions may be one source of slowness because I 
see a lot of external interrupts raised with MorphOS on pegasos2 while 
much less with AmigaOS on the same machine and the latter seems to run 
faster while same MoprhOS on mac99 does not have these interrupts and runs 
faster than AmigaOS on pegasos2. I've added these irq counts to be able to 
get some info on this. This series started as an attempt to optimise this 
part a bit but could not make it much faster so only the clean ups 
remained at the end. I have more changes that in theory could help but 
tests showed it made things slower so I've dropped those. These were 
changing cs parameter to env in other functions such as 
powerpc_reset_excp_state(), powerpc_set_excp_state(), 
ppc_interrupts_little_endian(), powerpc_excp() and all its model specific 
variants to get rid of local cs variables but this made it slower. Or 
marking error checks with unlikely that also made it slower despite I 
heven't seen any of those errors firing so it's hard to tell which change 
would have a performance impact. I've tested that these in this series 
don't change things much, I still get about the same speed as before.

Regards,
BALATON Zoltan
--3866299591-265803155-1686736824=:19284--

