Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4260874775B
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 19:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGjMN-0001hj-Ht; Tue, 04 Jul 2023 12:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGjMI-0001h7-5o; Tue, 04 Jul 2023 12:58:35 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=18er=CW=kaod.org=clg@ozlabs.org>)
 id 1qGjLv-0006ST-D8; Tue, 04 Jul 2023 12:58:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QwTWK0nt3z4wxW;
 Wed,  5 Jul 2023 02:58:05 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QwTWH4v2Qz4wb8;
 Wed,  5 Jul 2023 02:58:03 +1000 (AEST)
Message-ID: <6d4334e9-4a90-169b-0a90-a260aaaf2bb2@kaod.org>
Date: Tue, 4 Jul 2023 18:57:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 0/4] ppc: Improve multisocket support
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>
References: <20230704134921.2626692-1-clg@kaod.org>
 <25be9d1c-08bb-94ff-50e2-8e5e317ef997@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <25be9d1c-08bb-94ff-50e2-8e5e317ef997@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=18er=CW=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 7/4/23 18:20, Frederic Barrat wrote:
> 
> 
> On 04/07/2023 15:49, Cédric Le Goater wrote:
>> Hello,
>>
>> Here are changes improving multisocket support of the XIVE models
>> (POWER9 only). When a source has an END target on another chip, the
>> XIVE IC will use an MMIO store to forward the notification to the
>> remote chip. The long term plan is to get rid of pnv_xive_get_remote()
>> whic is a modeling shortcut. I have had them for while, they compile,
>> they seem to still work but this is not for merge yet. If someone
>> could take over, that would be nice.
>>
>> The best way to test is to start a 2 sockets * 1 cpu system with devices
>> attached to the PCI buses of chip 0 and to offline CPU 0. All sources
>> should be configured to be served by CPU 1 on socket 1 and trigger
>> notifications on chip 0 should be forwarded to chip 1.
>>
>> Last patch adds support for degenerative interrupts. This is used by
>> the lowest level FW of POWER systems. Difficult to test.
>>
> 
> 
> Thanks for the series! My crystal ball tells me the PC MMIO patch will come handy soon (to be adapted for P10 and groups). And the remote routing looks pretty interesting too.

I am glad !

I think the first 2 patches are a good addition. They remove a
qdev_get_machine() call which is ugly. P10 has the same kind of
shortcut.

C.



