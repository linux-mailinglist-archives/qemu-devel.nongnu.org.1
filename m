Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F737716BB
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 22:11:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSk4h-0003gE-MN; Sun, 06 Aug 2023 16:10:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=i+VO=DX=kaod.org=clg@ozlabs.org>)
 id 1qSk4e-0003fa-TS; Sun, 06 Aug 2023 16:10:00 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=i+VO=DX=kaod.org=clg@ozlabs.org>)
 id 1qSk4c-0000KB-Rg; Sun, 06 Aug 2023 16:10:00 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RJrCK493gz4wyB;
 Mon,  7 Aug 2023 06:09:49 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RJrCH1wzyz4wy9;
 Mon,  7 Aug 2023 06:09:45 +1000 (AEST)
Message-ID: <7fc442b3-c1ce-00db-2682-dc091bc836b2@kaod.org>
Date: Sun, 6 Aug 2023 22:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/7] ppc queue
To: Michael Tokarev <mjt@tls.msk.ru>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, peter.maydell@linaro.org, richard.henderson@linaro.org
References: <20230804152955.22316-1-danielhb413@gmail.com>
 <64324789-0c4e-d88f-d79f-74c727e5668a@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <64324789-0c4e-d88f-d79f-74c727e5668a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=i+VO=DX=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-4.139, SPF_HELO_PASS=-0.001,
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

On 8/5/23 08:56, Michael Tokarev wrote:
> 04.08.2023 18:29, Daniel Henrique Barboza wrote:
> ..
>> Nicholas Piggin (3):
>>        target/ppc: Implement ASDR register for ISA v3.0 for HPT
>>        target/ppc: Fix pending HDEC when entering PM state
>>        target/ppc: Fix VRMA page size for ISA v3.0
> 
> Should these 3 be picked up for -stable?

Yes. They are good candidates.

Thanks,

C.


