Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B108724559
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:10:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XNi-0002AP-Dg; Tue, 06 Jun 2023 10:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=R+T2=B2=kaod.org=clg@ozlabs.org>)
 id 1q6XNg-00029V-Dn; Tue, 06 Jun 2023 10:09:52 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=R+T2=B2=kaod.org=clg@ozlabs.org>)
 id 1q6XNe-0004mD-9f; Tue, 06 Jun 2023 10:09:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QbC604Sjbz4x3k;
 Wed,  7 Jun 2023 00:09:44 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QbC5y4bSFz4x42;
 Wed,  7 Jun 2023 00:09:42 +1000 (AEST)
Message-ID: <43ca9ac8-d383-42fd-ca29-f7cdd18d701d@kaod.org>
Date: Tue, 6 Jun 2023 16:09:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/4] target/ppc: TCG SMT support for spapr
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Richard Henderson
 <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <20230605112323.179259-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230605112323.179259-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=R+T2=B2=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.094,
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

On 6/5/23 13:23, Nicholas Piggin wrote:
> Previous RFC here
> 
> https://lists.gnu.org/archive/html/qemu-ppc/2023-05/msg00453.html
> 
> This series drops patch 1 from the previous, which is more of
> a standalone bugfix.
> 
> Also accounted for Cedric's comments, except a nicer way to
> set cpu_index vs PIR/TIR SPRs, which is not quite trivial.
> 
> This limits support for SMT to POWER8 and newer. It is also
> incompatible with nested-HV so that is checked for too.
> 
> Iterating CPUs to find siblings for now I kept because similar
> loops exist in a few places, and it is not conceptually
> difficult for SMT, just fiddly code to improve. For now it
> should not be much performane concern.
> 
> I removed hypervisor msgsnd support from patch 3, which is not
> required for spapr and added significantly to the patch.
> 
> For now nobody has objected to the way shared SPR access is
> handled (serialised with TCG atomics support) so we'll keep
> going with it.

Cc:ing more people for possible feedback.

Thanks,

C.


