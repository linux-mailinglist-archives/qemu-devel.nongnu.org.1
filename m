Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A29D171956B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 10:22:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4dYy-0003DC-HA; Thu, 01 Jun 2023 04:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dYw-0003Cw-Fz; Thu, 01 Jun 2023 04:21:38 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=vOrz=BV=kaod.org=clg@ozlabs.org>)
 id 1q4dYt-0000js-CY; Thu, 01 Jun 2023 04:21:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QWzcQ24ptz4x4L;
 Thu,  1 Jun 2023 18:21:26 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QWzcN0mynz4x4H;
 Thu,  1 Jun 2023 18:21:23 +1000 (AEST)
Message-ID: <170a2356-39a2-2367-e77a-171561215c6f@kaod.org>
Date: Thu, 1 Jun 2023 10:21:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/2] Added 32 bits property for ASPEED GPIO with updated
 qtests. This change gives ASPEED GPIO similar behavior as Nuvoton.
Content-Language: en-US
To: Jingbo Wu <flwu@google.com>, peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Andrew Jeffery <andrew@aj.id.au>
References: <20230531165537.3721999-1-flwu@google.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230531165537.3721999-1-flwu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=vOrz=BV=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.091, SPF_HELO_PASS=-0.001,
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

On 5/31/23 18:55, Jingbo Wu wrote:
> From: Felix Wu <flwu@google.com>

Hello Felix,

Thanks for the extension. It could be useful in some situations but
it seems also dangerous to set all lines controlled by a register
at once. The same comment applies to Nuvoton [1].

C.

[1] https://lore.kernel.org/qemu-devel/CAFEAcA-2_gwOUgapmgSSFGVNiOk9Grse_E3TVo=pQTf-OgW2vg@mail.gmail.com/


> 
> Felix Wu (2):
>    hw/gpio: Add property for ASPEED GPIO in 32 bits basis
>    tests/qtest: Add qtest for for ASPEED GPIO gpio-set property
> 
>   hw/gpio/aspeed_gpio.c          |  56 ++++++++++++++++++
>   include/qapi/qmp/qdict.h       |   1 +
>   qobject/qdict.c                |  13 ++++
>   tests/qtest/aspeed_gpio-test.c | 105 ++++++++++++++++++++++++++++++---
>   4 files changed, 166 insertions(+), 9 deletions(-)
> 


