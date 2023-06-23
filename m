Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4039F73B3A6
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:34:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCdB9-0000SG-94; Fri, 23 Jun 2023 05:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCdB8-0000Rj-4z; Fri, 23 Jun 2023 05:34:06 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCdB6-0000l2-5g; Fri, 23 Jun 2023 05:34:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QnXB13D5xz4x0L;
 Fri, 23 Jun 2023 19:34:01 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnX9y6Q65z4x3k;
 Fri, 23 Jun 2023 19:33:58 +1000 (AEST)
Message-ID: <ad19b2ba-5c71-f93c-9a93-fb6a8641f77a@kaod.org>
Date: Fri, 23 Jun 2023 11:33:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/7] target/ppc: TCG SMT support for spapr machine
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230622093357.255649-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230622093357.255649-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=Kxto=CL=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/22/23 11:33, Nicholas Piggin wrote:
> This series is based on some previously posted TCG fixes, in particular
> the CTRL register fix is required.
> 
> Also added the Philippe's patch in the series to prevent conflict.
> 
> Since v1, main changes are just some tidying of comments and changelogs,
> and addition of avocado tests to boot Linux on SMT machine and make sure
> the CPUs come up, as suggested by Cedric.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (6):
>    target/ppc: Add initial flags and helpers for SMT support
>    target/ppc: Add support for SMT CTRL register
>    target/ppc: Add msgsnd/p and DPDES SMT support
>    spapr: TCG allow up to 8-thread SMT on POWER8 and newer CPUs
>    tests/avocado: boot ppc64 pseries to Linux VFS mount
>    tests/avocado: Add ppc64 pseries multiprocessor boot tests
> 
> Philippe Mathieu-Daudé (1):
>    hw/ppc/spapr: Test whether TCG is enabled with tcg_enabled()
> 
>   hw/ppc/ppc.c                 |  6 ++++
>   hw/ppc/spapr.c               | 16 ++++++---
>   hw/ppc/spapr_caps.c          | 14 ++++++++
>   hw/ppc/spapr_cpu_core.c      |  7 ++--
>   include/hw/ppc/ppc.h         |  1 +
>   target/ppc/cpu.h             |  9 +++++
>   target/ppc/cpu_init.c        |  5 +++
>   target/ppc/excp_helper.c     | 30 +++++++++++++---
>   target/ppc/helper.h          |  2 ++
>   target/ppc/misc_helper.c     | 69 ++++++++++++++++++++++++++++++++----
>   target/ppc/translate.c       | 46 +++++++++++++++++++++++-
>   tests/avocado/ppc_pseries.py | 62 ++++++++++++++++++++++++++++----
>   12 files changed, 243 insertions(+), 24 deletions(-)
> 

Applied to ppc-next.

Thanks,

C.



