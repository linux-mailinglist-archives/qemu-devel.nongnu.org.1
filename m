Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 105C2738D03
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 19:25:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC1Yc-0006fo-TI; Wed, 21 Jun 2023 13:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5utS=CJ=kaod.org=clg@ozlabs.org>)
 id 1qC1Yb-0006fc-Cs; Wed, 21 Jun 2023 13:23:49 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=5utS=CJ=kaod.org=clg@ozlabs.org>)
 id 1qC1YZ-0006uL-F7; Wed, 21 Jun 2023 13:23:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QmVht1Cq5z4x04;
 Thu, 22 Jun 2023 03:23:42 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QmVhr5gnGz4wjF;
 Thu, 22 Jun 2023 03:23:40 +1000 (AEST)
Message-ID: <e8a0ebed-0210-9084-407a-4737648663b3@kaod.org>
Date: Wed, 21 Jun 2023 19:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 0/2] pnv/xive2: Fix TIMA special ops detection
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230621160306.896045-1-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230621160306.896045-1-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=5utS=CJ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.093, SPF_HELO_PASS=-0.001,
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

On 6/21/23 18:03, Frederic Barrat wrote:
> Fix the TIMA special ops detection regression, as spotted by Coverity.
> 
> Tested by running a pseries guest on top of a powernv9 and powernv10 host.

FYI,

It is possible to force Gen1 on XIVE2 also. It you set the "capabilities"
property on the command line :

   -global driver=pnv-xive2,property=capabilities,value=0x1000120076f000FC

OPAL should self adapt and QEMU will probably crash ...

C.

> 
> Frederic Barrat (2):
>    pnv/xive2: Add a get_config() method on the presenter class
>    pnv/xive2: Check TIMA special ops against a dedicated array for P10
> 
>   hw/intc/pnv_xive.c    | 11 +++++++++
>   hw/intc/pnv_xive2.c   | 44 +++++++++------------------------
>   hw/intc/xive.c        | 57 +++++++++++++++++++++++++++++++++++++------
>   include/hw/ppc/xive.h |  3 +++
>   4 files changed, 75 insertions(+), 40 deletions(-)
> 


