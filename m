Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA69A7F9700
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 02:02:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Q03-0008S6-KN; Sun, 26 Nov 2023 20:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1r7Q01-0008RH-7I; Sun, 26 Nov 2023 20:01:21 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1r7Pzy-0006Oz-1S; Sun, 26 Nov 2023 20:01:20 -0500
Received: from [192.168.68.112] (203-57-215-234.dyn.iinet.net.au
 [203.57.215.234])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id C1FC42012A;
 Mon, 27 Nov 2023 09:01:05 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1701046868;
 bh=gyXYbD+jBNyHAa8R6BFK0wYQc5cwzpYcgzXJaYq4x98=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=TE3nyeyssTkHYsI6HNVJmk3ZHWKqVWfMfFKPrCWw/TMGuYvoFnKK+ntONe1XTDFD8
 BRPZn3W/lWFVNy3csGtPLbRE2ax2FDdSLKtvbQwva3M4NBiFCSF3CWsgaRweF9WSJP
 vEoghqraiq6/UTU7BdJt+R4O0O1HUlRTrbqZl54N7GcbwPqQirQrOTcCkRqxq/HnMh
 v+8RB6ZO5TesXJIoB6SuWyiHhE8F1gzZr1oaWRNhERIPriRyqwZ1wIMrpOCtBcpmPO
 GlmwsDw839BNZkbIM25X2/AK4tXc1smOVgJrrFo+zMwD1A1V4n2TaUYhHmr/RdwdD8
 uUmBxeaV7Z8dw==
Message-ID: <5aa705e249de5b14797ba0facbe813fa4ca1c07a.camel@codeconstruct.com.au>
Subject: Re: [PATCH-for-9.0 20/25] hw: Simplify memory_region_init_ram() calls
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  qemu-ppc@nongnu.org,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,  Peter Xu
 <peterx@redhat.com>, Joel Stanley <joel@jms.id.au>, Jean-Christophe Dubois
 <jcd@tribudubois.net>, =?ISO-8859-1?Q?Herv=E9?= Poussineau
 <hpoussin@reactos.org>
Date: Mon, 27 Nov 2023 11:31:05 +1030
In-Reply-To: <20231120213301.24349-21-philmd@linaro.org>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-21-philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
Received-SPF: pass client-ip=203.29.241.158;
 envelope-from=andrew@codeconstruct.com.au; helo=codeconstruct.com.au
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 2023-11-20 at 22:32 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Mechanical change using the following coccinelle script:
>=20
> @@
> expression mr, owner, arg3, arg4, errp;
> @@
> -   memory_region_init_ram(mr, owner, arg3, arg4, &errp);
>     if (
> -       errp
> +       !memory_region_init_ram(mr, owner, arg3, arg4, &errp)
>     ) {
>         ...
>         return;
>     }
>=20
> and removing the local Error variable.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/aspeed_ast2400.c | 6 ++----
>  hw/arm/aspeed_ast2600.c | 6 ++----

For my own benefit it looks like the motivating thread for this series
is:=C2=A0

https://lore.kernel.org/qemu-devel/936e1ac4-cef8-08b4-c688-e5b1e057208b@lin=
aro.org/

Anyway,

Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au> # aspeed

