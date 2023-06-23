Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1045573B396
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 11:30:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCd6p-0003yO-Ae; Fri, 23 Jun 2023 05:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCd6i-0003xS-SY; Fri, 23 Jun 2023 05:29:32 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=Kxto=CL=kaod.org=clg@ozlabs.org>)
 id 1qCd6f-0005NM-QV; Fri, 23 Jun 2023 05:29:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QnX4k0mntz4x3k;
 Fri, 23 Jun 2023 19:29:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QnX4h6XRtz4x3j;
 Fri, 23 Jun 2023 19:29:24 +1000 (AEST)
Message-ID: <fce7933c-4a42-7602-0c8a-80516b95f5e6@kaod.org>
Date: Fri, 23 Jun 2023 11:29:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/9] ppc: New reviewers and KVM cleanups
Content-Language: en-US
To: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org
References: <20230620055911.187065-1-clg@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230620055911.187065-1-clg@kaod.org>
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

On 6/20/23 07:59, Cédric Le Goater wrote:
> Hello,
> 
> Please welcome new reviewers on baremetal POWER systems !
> 
> Follow cleanups to report an error when KVM is used on non-KVM
> machines.
> 
> Thanks,
> 
> C.
> 
> Cédric Le Goater (9):
>    MAINTAINERS: Add reviewers for PowerNV baremetal emulation
>    MAINTAINERS: Add reviewer for PowerPC TCG CPUs
>    MAINTAINERS: Add reviewer for XIVE
>    ppc/prep: Report an error when run with KVM
>    ppc/pegasos2: Report an error when run with KVM
>    ppc/sam460ex: Report an error when run with KVM
>    ppc/bamboo: Report an error when run with KVM
>    ppc/pnv: Rephrase error when run with KVM
>    target/ppc: Fix timer register accessors when !KVM
> 
>   MAINTAINERS            |  4 ++++
>   hw/ppc/pegasos2.c      |  7 ++++++-
>   hw/ppc/pnv.c           |  3 ++-
>   hw/ppc/ppc440_bamboo.c | 17 ++++++-----------
>   hw/ppc/prep.c          | 20 +++++++-------------
>   hw/ppc/sam460ex.c      | 15 ++++++---------
>   target/ppc/kvm.c       | 12 ++++++++++++
>   7 files changed, 43 insertions(+), 35 deletions(-)
> 

Applied to ppc-next, without the sam460ex and pegasos2 changes as requested
by Zoltan.

Thanks,

C.



