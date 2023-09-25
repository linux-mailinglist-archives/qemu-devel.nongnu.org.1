Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 867C47AD284
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 09:59:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkgUR-0005Lf-UK; Mon, 25 Sep 2023 03:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=n5Cv=FJ=kaod.org=clg@ozlabs.org>)
 id 1qkgUP-0005KS-E5; Mon, 25 Sep 2023 03:58:45 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=n5Cv=FJ=kaod.org=clg@ozlabs.org>)
 id 1qkgUN-0007ya-IT; Mon, 25 Sep 2023 03:58:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4RvFcV5LjNz4xNh;
 Mon, 25 Sep 2023 17:58:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4RvFcS6PFVz4xM6;
 Mon, 25 Sep 2023 17:58:32 +1000 (AEST)
Message-ID: <a79f00cd-795d-9f5d-5461-2ae532b2f82b@kaod.org>
Date: Mon, 25 Sep 2023 09:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] MAINTAINERS: aspeed: Update Andrew's email address
Content-Language: en-US
To: Andrew Jeffery <andrew@codeconstruct.com.au>, andrew@aj.id.au
Cc: joel@jms.id.au, peter.maydell@linaro.org, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20230925062212.66112-1-andrew@codeconstruct.com.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230925062212.66112-1-andrew@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=n5Cv=FJ=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

On 9/25/23 08:22, Andrew Jeffery wrote:
> I've changed employers, have company email that deals with patch-based
> workflows without too much of a headache, and am trying to steer some
> content out of my personal mail.
> 
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> 
> Hi Cédric, do you mind including this in your Aspeed queue?

Sure. It's on aspeed-8.2 for now. I will send a PR when I have more
material for QEMU 8.2

Thanks,

C.


> 
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 355b1960ce46..b142c09628b9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1108,7 +1108,7 @@ F: docs/system/arm/emcraft-sf2.rst
>   ASPEED BMCs
>   M: Cédric Le Goater <clg@kaod.org>
>   M: Peter Maydell <peter.maydell@linaro.org>
> -R: Andrew Jeffery <andrew@aj.id.au>
> +R: Andrew Jeffery <andrew@codeconstruct.com.au>
>   R: Joel Stanley <joel@jms.id.au>
>   L: qemu-arm@nongnu.org
>   S: Maintained


