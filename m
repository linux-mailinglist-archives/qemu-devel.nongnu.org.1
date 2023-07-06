Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C687474A55F
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHW18-0005d3-7r; Thu, 06 Jul 2023 16:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=00IJ=CY=kaod.org=clg@ozlabs.org>)
 id 1qHW10-0005cE-Ns; Thu, 06 Jul 2023 16:55:51 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=00IJ=CY=kaod.org=clg@ozlabs.org>)
 id 1qHW0t-0002GZ-9v; Thu, 06 Jul 2023 16:55:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QxphT3TPnz4wb5;
 Fri,  7 Jul 2023 06:55:37 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QxphR1X0Sz4wZv;
 Fri,  7 Jul 2023 06:55:34 +1000 (AEST)
Message-ID: <82163867-c39f-db16-7c6a-f77bcc5d475e@kaod.org>
Date: Thu, 6 Jul 2023 22:55:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] target/ppc: Machine check on invalid real address
 access on POWER9/10
Content-Language: en-US
To: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 Greg Kurz <groug@kaod.org>, Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230703120301.45313-1-npiggin@gmail.com>
 <CTUWXISZHAI1.3A3FS0U9SD90B@wheely>
 <ba50f55b-1c48-df50-a16c-95f0f51f48f8@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <ba50f55b-1c48-df50-a16c-95f0f51f48f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=00IJ=CY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091,
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

On 7/6/23 22:50, Daniel Henrique Barboza wrote:
> 
> 
> On 7/6/23 04:32, Nicholas Piggin wrote:
>> On Mon Jul 3, 2023 at 10:03 PM AEST, Nicholas Piggin wrote:
>>> ppc currently silently accepts invalid real address access. Catch
>>> these and turn them into machine checks on POWER9/10 machines.
>>
>> Would there be any objections to merging this and the checkstop patch?
>> We could disable this one before release if it turns out to cause
>> breakage.
> 
> I don't have objections but his bad boy has no acks.
> 
> Cedric, if you vouch for this change send a R-b and I'll queue this up.


Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks,

C.


> 
> 
> Thanks,
> 
> 
> Daniel
> 
>>
>> I don't think it needs to rebase, and passes clang build and make check
>> here. Just messed up the separator on the changelog of the checkstop
>> patch.
>>
>> Thanks,
>> Nick
>>
>>
>>>
>>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>>> ---
>>> Since v1:
>>> - Only implement this for POWER9/10. Seems like previous IBM processors
>>>    may not catch this, trying to get info.
>>>
>>> Since v2:
>>> - Split out from larger series since it is independent.


