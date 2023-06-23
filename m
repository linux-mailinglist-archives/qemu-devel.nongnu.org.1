Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A86273B398
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:30:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCd7d-0004du-NL; Fri, 23 Jun 2023 05:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCd7a-0004al-9V; Fri, 23 Jun 2023 05:30:26 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCd7Y-0006UA-K7; Fri, 23 Jun 2023 05:30:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QnX5l16XBz4x3k;
 Fri, 23 Jun 2023 19:30:19 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnX5j2vTdz4x3j;
 Fri, 23 Jun 2023 19:30:17 +1000 (AEST)
Message-ID: <bdf2f9bd-fe85-9d3b-e061-160a3a0b28d6@kaod.org>
Date: Fri, 23 Jun 2023 11:30:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/4] ppc/spapr: Nested HV fix and tidying
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>
References: <20230620105737.160451-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230620105737.160451-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=Kxto=CL=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
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

On 6/20/23 12:57, Nicholas Piggin wrote:
> To prepare for some later changes to nested-HV I would like to get
> these cleanups done and move nested to its own file. This is
> rebased and patch 4 has some nested function definitions and
> structs in spapr_nested.h that Harsh suggested.
> 
> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>    ppc/spapr: H_ENTER_NESTED should restore host XER ca field
>    ppc/spapr: Add a nested state struct
>    ppc/spapr: load and store l2 state with helper functions
>    ppc/spapr: Move spapr nested HV to a new file
> 
>   hw/ppc/meson.build              |   1 +
>   hw/ppc/spapr.c                  |   1 +
>   hw/ppc/spapr_hcall.c            | 335 +--------------------------
>   hw/ppc/spapr_nested.c           | 395 ++++++++++++++++++++++++++++++++
>   include/hw/ppc/spapr.h          |  62 -----
>   include/hw/ppc/spapr_cpu_core.h |   5 +-
>   include/hw/ppc/spapr_nested.h   | 102 +++++++++
>   7 files changed, 504 insertions(+), 397 deletions(-)
>   create mode 100644 hw/ppc/spapr_nested.c
>   create mode 100644 include/hw/ppc/spapr_nested.h
> 

Applied to ppc-next.

Thanks,

C.



