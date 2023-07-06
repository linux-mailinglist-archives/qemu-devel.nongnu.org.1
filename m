Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F40C4749582
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 08:22:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHINQ-00038l-6W; Thu, 06 Jul 2023 02:22:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=00IJ=CY=kaod.org=clg@ozlabs.org>)
 id 1qHINJ-00036z-6n; Thu, 06 Jul 2023 02:21:58 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=00IJ=CY=kaod.org=clg@ozlabs.org>)
 id 1qHINH-0004da-Hc; Thu, 06 Jul 2023 02:21:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QxRJF5wptz4wxT;
 Thu,  6 Jul 2023 16:21:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QxRJC65zjz4wZt;
 Thu,  6 Jul 2023 16:21:47 +1000 (AEST)
Message-ID: <ba5c63b1-0edb-4cde-d699-602e896a6e34@kaod.org>
Date: Thu, 6 Jul 2023 08:21:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 0/2] ppc/pnv: Set P10 core xscom region size to match
 hardware
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Joel Stanley <joel@jms.id.au>, =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?=
 <fbarrat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
References: <20230706053923.115003-1-npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230706053923.115003-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=00IJ=CY=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089, SPF_HELO_PASS=-0.001,
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

On 7/6/23 07:39, Nicholas Piggin wrote:
> Sorry about the paper bag bug in the first version of the patch -
> I broke powernv8 and 9.
> 
> This adds a xsom_size core class field to change the P10 size without
> changing the others.
> 
> Also added a P10 xscom test, and passes make check.

Now, you know there is check-qtest-ppc64 :) XSCOM is important for
the machine to boot and I wish there were a few more low level tests.
XIVE for instance, to test IPIs.

Thanks,

C.


> Thanks,
> Nick
> 
> Nicholas Piggin (2):
>    ppc/pnv: Set P10 core xscom region size to match hardware
>    tests/qtest: Add xscom tests for powernv10 machine
> 
>   hw/ppc/pnv_core.c            |  6 +++--
>   include/hw/ppc/pnv_core.h    |  1 +
>   include/hw/ppc/pnv_xscom.h   |  2 +-
>   tests/qtest/pnv-xscom-test.c | 44 ++++++++++++++++++++++++++++--------
>   4 files changed, 41 insertions(+), 12 deletions(-)
> 


