Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAAF7DCAAD
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:23:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxltn-00021B-0z; Tue, 31 Oct 2023 06:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0CP7=GN=kaod.org=clg@ozlabs.org>)
 id 1qxltl-00020N-5U; Tue, 31 Oct 2023 06:23:01 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=0CP7=GN=kaod.org=clg@ozlabs.org>)
 id 1qxlth-0004f8-V3; Tue, 31 Oct 2023 06:23:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4SKR6M1zgmz4xSX;
 Tue, 31 Oct 2023 21:22:51 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4SKR6J1bVdz4xS7;
 Tue, 31 Oct 2023 21:22:47 +1100 (AEDT)
Message-ID: <6a2950a9-53b4-4306-a8ea-21250ca00e9d@kaod.org>
Date: Tue, 31 Oct 2023 11:22:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ppc: qtest already exports qtest_rtas_call()
Content-Language: en-US
To: quintela@redhat.com, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>
References: <20231030163834.4638-1-quintela@redhat.com>
 <6257f025-a000-4f89-88ae-704f51afdb73@kaod.org> <ZUBUqpn26N/hc34x@zatzit>
 <878r7j9jyl.fsf@secure.mitica>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <878r7j9jyl.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=0CP7=GN=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/31/23 11:15, Juan Quintela wrote:
> David Gibson <david@gibson.dropbear.id.au> wrote:
>> On Mon, Oct 30, 2023 at 05:41:36PM +0100, Cédric le Goater wrote:
>>> On 10/30/23 17:38, Juan Quintela wrote:
>>>> Having two functions with the same name is a bad idea.  As spapr only
>>>> uses the function locally, made it static.
>>>>
>>>> When you compile with clang, you get this compilation error:
>>>>
>>>> /usr/bin/ld: tests/qtest/libqos/libqos.fa.p/.._libqtest.c.o: in function `qtest_rtas_call':
>>>> /scratch/qemu/clang/full/all/../../../../../mnt/code/qemu/full/tests/qtest/libqtest.c:1195:
>>>> multiple definition of `qtest_rtas_call';
>>>> libqemu-ppc64-softmmu.fa.p/hw_ppc_spapr_rtas.c.o:/scratch/qemu/clang/full/all/../../../../../mnt/code/qemu/full/hw/ppc/spapr_rtas.c:536:
>>>> first defined here
>>>> clang-16: error: linker command failed with exit code 1 (use -v to see invocation)
>>>> ninja: build stopped: subcommand failed.
>>>> make: *** [Makefile:162: run-ninja] Error 1
>>>>
>>>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>>>
>>>
>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>
>> I think changing the name of one of the functions would be even
>> better.  Making it static means it won't confuse the compiler, but it
>> can still confuse people.

Since it is a spapr file, something like :

   static uint64_t spapr_qtest_rtas_call(...)

?

Thanks,

C.


> I think that made it static when it is not used anywhere else is a good
> idea.
> 
> After that, I don't understand it enough to make a rename that makes
> sense.
> 
> This patch is the typical fix for "make all" with clang fails here.
> I let ppc maintainers to do anything more sensible.
> 
> Later, Juan.
> 


