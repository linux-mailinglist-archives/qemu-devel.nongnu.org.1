Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF027ADD14
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 18:29:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkoSR-0002XA-Jl; Mon, 25 Sep 2023 12:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=n5Cv=FJ=kaod.org=clg@ozlabs.org>)
 id 1qkoSM-0002UJ-9O; Mon, 25 Sep 2023 12:29:10 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=n5Cv=FJ=kaod.org=clg@ozlabs.org>)
 id 1qkoSK-0003Ft-2f; Mon, 25 Sep 2023 12:29:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RvSxS2KFYz4xPM;
 Tue, 26 Sep 2023 02:29:00 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RvSxQ09JJz4xQ1;
 Tue, 26 Sep 2023 02:28:57 +1000 (AEST)
Message-ID: <6e17b750-8e07-874d-05ae-fae05b2cd804@kaod.org>
Date: Mon, 25 Sep 2023 18:28:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/4] aspeed: Clean up local variable shadowing
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>
References: <20230922155924.1172019-1-clg@kaod.org>
 <f7cdbd47-1833-af1a-ae09-363c86c2e74e@linaro.org>
 <838837dc-0d95-1d6c-3cfc-e321c9c01a7d@kaod.org> <87msxdmkeq.fsf@pond.sub.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <87msxdmkeq.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=n5Cv=FJ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/23/23 09:13, Markus Armbruster wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> On 9/22/23 20:20, Philippe Mathieu-Daudé wrote:
>>> On 22/9/23 17:59, Cédric Le Goater wrote:
>>>> Hello,
>>>>
>>>> Here are cleanups for local variable shadowing warnings in aspeed models.
>>>>
>>>> Joel, Andrew,
>>>>
>>>> Could you please double check patch 4 ?
>>> Could Markus' MAKE_IDENTFIER() help there?
>>
>> ah ! you typed too fast and I also read too fast, as :
>>
>>    MARKUS_IDENTIFIER()
>>
>> and I liked it :)
> 
> LOL
> 
>>                    but what is MAKE_IDENTIFIER  ? really, please explain.
> 
> Philippe is referring to
> 
>      [PATCH v3 7/7] qobject atomics osdep: Make a few macros more hygienic
>      Message-ID: <20230921121312.1301864-8-armbru@redhat.com>
> 
> which tweaks MAX() to permit nesting without shadowing.  Your PATCH 4
> may not be needed if you base on it.

We don't need the nested MAX(). PATCH 4 is a cleanup which happens
to remove the shadowing. Let's keep it the way it is.

> MAKE_IDENTIFIER() is a helper macro introduced in that patch.
> 
> You can fetch the patch from https://repo.or.cz/qemu/armbru.git branch
> shadow-next, along with collected other shadowing patches.

OK.

Would you prefer maintainers to include the shadowing changes in a
potential PR they would send or would you rather take care of it in
a PR of your own ?

Thanks,

C.



