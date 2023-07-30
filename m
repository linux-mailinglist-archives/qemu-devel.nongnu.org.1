Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA79768698
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 19:09:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ98L-0006ld-1Q; Sun, 30 Jul 2023 12:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=LlZL=DQ=kaod.org=clg@ozlabs.org>)
 id 1qQ98J-0006kz-39; Sun, 30 Jul 2023 12:19:03 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=LlZL=DQ=kaod.org=clg@ozlabs.org>)
 id 1qQ98H-000605-2s; Sun, 30 Jul 2023 12:19:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RDRQ20tBDz4wyJ;
 Mon, 31 Jul 2023 02:18:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RDRPz1Q9mz4wy6;
 Mon, 31 Jul 2023 02:18:46 +1000 (AEST)
Message-ID: <18d18c7b-7877-ab9d-1fac-b2d356df4326@kaod.org>
Date: Sun, 30 Jul 2023 18:18:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 5/6] hw/ppc: Always store the decrementer value
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
References: <20230726182230.433945-1-npiggin@gmail.com>
 <20230726182230.433945-6-npiggin@gmail.com>
 <8d485d17-2f96-8517-6607-7344d0aa178c@kaod.org>
 <CUFEOWJA6156.NJED7GB1RF8Q@wheely>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <CUFEOWJA6156.NJED7GB1RF8Q@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=LlZL=DQ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.101,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 7/30/23 11:40, Nicholas Piggin wrote:
> On Thu Jul 27, 2023 at 10:26 PM AEST, Cédric Le Goater wrote:
>> Hello Nick,
>>
>> On 7/26/23 20:22, Nicholas Piggin wrote:
>>> When writing a value to the decrementer that raises an exception, the
>>> irq is raised, but the value is not stored so the store doesn't appear
>>> to have changed the register when it is read again.
>>>
>>> Always store the write value to the register.
>>
>> This change has a serious performance impact when a guest is run under
>> PowerNV. Could you please take a look ?
> 
> Yeah, the decrementer load doesn't sign-extend the value correctly as
> it should for the large-decrementer option. It makes skiboot detect
> the decrementer size as 64 bits instead of 56, and things go bad from
> there. KVM seems more affected because it's saving and restoring DEC
> frequently.
> 
> The fix seems simple but considering the compounding series of bugs
> and issues coming up with this, I think it will be better to defer
> the decrementer work until 8.2 unfortunately.

Yes. QEMU 8.1 has already a lot, fixes, tests and models [1].

>> PS: We should really introduce avocado tests for nested.
> 
> Yeah agreed. Both for pseries and powernv, ideally.

The same disk image could be used for the 3 HV implementations. This would
be a nice addition to Harsh's series [2]

Thanks,

C.

[1] https://wiki.qemu.org/ChangeLog/8.1#PowerPC
[2] https://patchwork.ozlabs.org/project/qemu-ppc/list/?series=364386


