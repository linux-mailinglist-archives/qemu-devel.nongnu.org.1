Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A6D8215FA
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 01:13:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKSNl-0002SI-TT; Mon, 01 Jan 2024 19:11:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1rKSNj-0002Rb-1Q; Mon, 01 Jan 2024 19:11:43 -0500
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1rKSNh-0001Mz-0i; Mon, 01 Jan 2024 19:11:42 -0500
Received: from [192.168.68.112]
 (ppp14-2-68-9.adl-apt-pir-bras31.tpg.internode.on.net [14.2.68.9])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F11B720075;
 Tue,  2 Jan 2024 08:11:23 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1704154289;
 bh=weh08tZKSKDDmoMpcPHoWfnvsNdSNM6cDkIsSxqlShY=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=OmSHmBwdmeFiUzpRkGAg8FQzxPW22/rSq/wYrrUA2hOgo4Sgf87OOQxZYnMpo/xiy
 86s0kkSHYOfE7q9jOvMqJ0b9t6aJhoaGWmemHxfB3oGQojaUAL+7Qbag6LQdwwcejM
 N18GHo2QGbSs5EDlUair6u2cspIDl6AVbJ+KffGEt5fftxuvbDXNocJRU+QarWf7+V
 eV5fNDHMkAmIplFDaF53dmcA2wcKT/WyGxa8u7nSQjjhrEU8M7Y2U8rS2rK1MhRpVr
 vPNaF6USvsHc6b2UvGZ36kLYsdzwwoOHhxx5lipLbzTqkp+3Yxe0RexHBIScFq2x8m
 BI43JcfIl6oDQ==
Message-ID: <92d9cfc4f56ecda0b0d451e44bb9eef81e70211a.camel@codeconstruct.com.au>
Subject: Re: [PATCH 22/33] hw/arm/aspeed_ast2600: Let the A7MPcore
 create/wire the CPU cores
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Manos
 Pitsidianakis <manos.pitsidianakis@linaro.org>,  Eduardo Habkost
 <eduardo@habkost.net>, Joel Stanley <joel@jms.id.au>, Alistair Francis
 <alistair@alistair23.me>,  Anton Johansson <anjo@rev.ng>, Andrey Smirnov
 <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Hao
 Wu <wuhaotsh@google.com>,  =?ISO-8859-1?Q?C=E9dric?= Le Goater
 <clg@kaod.org>, Jean-Christophe Dubois <jcd@tribudubois.net>, Igor
 Mitsyanko <i.mitsyanko@gmail.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 02 Jan 2024 10:41:22 +1030
In-Reply-To: <20231212162935.42910-23-philmd@linaro.org>
References: <20231212162935.42910-1-philmd@linaro.org>
 <20231212162935.42910-23-philmd@linaro.org>
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

On Tue, 2023-12-12 at 17:29 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Set the properties on the a7mpcore object to let it create and
> wire the CPU cores. Remove the redundant code.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Andrew Jeffery <andrew@codeconstruct.com.au>

