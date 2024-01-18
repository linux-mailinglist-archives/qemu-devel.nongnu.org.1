Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D910831BE5
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 15:58:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQTpy-0000OG-QX; Thu, 18 Jan 2024 09:57:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KcIQ=I4=kaod.org=clg@ozlabs.org>)
 id 1rQTpw-0000JF-5d; Thu, 18 Jan 2024 09:57:44 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=KcIQ=I4=kaod.org=clg@ozlabs.org>)
 id 1rQTpu-0002Es-7d; Thu, 18 Jan 2024 09:57:43 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4TG5St0nlpz4xVM;
 Fri, 19 Jan 2024 01:57:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4TG5Sq6Fjmz4x2P;
 Fri, 19 Jan 2024 01:57:31 +1100 (AEDT)
Message-ID: <03ef8f5e-c1a9-4127-bbf7-3485619cb9e0@kaod.org>
Date: Thu, 18 Jan 2024 15:57:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] ppc: add machine check injection HMP command
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-devel@nongnu.org
References: <20240118143459.166994-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240118143459.166994-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=KcIQ=I4=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hello Nick,

On 1/18/24 15:34, Nicholas Piggin wrote:
> I'd like to resurrect this and get it merged, because it's quite
> useful for testing (has caught several Linux bugs in the past).
> 
> IIRC the main concern David had last time it came up was that it
> should have QMP commands too. Which is valid. But I ended up
> deciding it wouldn't be nice to expose this low level interface too
> much, it would be better to use maybe a higher level error injection
> interface that would be emulated in more detail (e.g., not just a
> MCE, but would set relevant FIR registers and go through error
> handling logic).
> 
> Since x86 has a low level 'mce' hmp command without qmp equivalent,
> and since better error injection might take some time, I'd like to
> just hold nose and take this for now.


I reworked this series some years ago :

   https://lore.kernel.org/qemu-devel/20211013214042.618918-1-clg@kaod.org/

Did you take into account the changes ?


Thanks,

C.



> Thanks,
> Nick
> 
> Nicholas Piggin (4):
>    nmi: add MCE class for implementing machine check injection commands
>    ppc/spapr: Implement mce injection
>    target/ppc: Add machine check interrupt injection helper
>    ppc/pnv: Implement mce injection
> 
>   include/hw/nmi.h             | 20 ++++++++++++
>   include/hw/ppc/spapr.h       |  3 ++
>   include/monitor/hmp-target.h |  1 -
>   include/monitor/hmp.h        |  1 +
>   target/ppc/cpu.h             |  1 +
>   hw/core/nmi.c                | 61 ++++++++++++++++++++++++++++++++++++
>   hw/ppc/pnv.c                 | 55 ++++++++++++++++++++++++++++++++
>   hw/ppc/spapr.c               | 54 +++++++++++++++++++++++++++++++
>   hw/ppc/spapr_events.c        |  3 +-
>   monitor/hmp-cmds.c           |  1 +
>   target/ppc/excp_helper.c     |  7 +++++
>   target/ppc/ppc-qmp-cmds.c    | 10 ++++++
>   hmp-commands.hx              | 20 +++++++++++-
>   13 files changed, 233 insertions(+), 4 deletions(-)
> 


