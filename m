Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 597217D7C22
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 07:19:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvslA-0001zZ-8Y; Thu, 26 Oct 2023 01:18:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qvsl3-0001vE-C5; Thu, 26 Oct 2023 01:18:13 -0400
Received: from pi.codeconstruct.com.au ([203.29.241.158]
 helo=codeconstruct.com.au)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@codeconstruct.com.au>)
 id 1qvsl1-0004Rg-N5; Thu, 26 Oct 2023 01:18:13 -0400
Received: from [192.168.13.88]
 (ppp118-210-136-142.adl-adc-lon-bras33.tpg.internode.on.net
 [118.210.136.142])
 by mail.codeconstruct.com.au (Postfix) with ESMTPSA id EDDAA20174;
 Thu, 26 Oct 2023 13:18:05 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codeconstruct.com.au; s=2022a; t=1698297488;
 bh=dAHfECnoFvXcqfIQIqID4USTey8MMaNynUgTIYo+GaI=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References;
 b=EPKrh0djUxCHCZi8sBE7mhllzGodTnw+dPQ0ZL3kII7ETzL6Ix4WmXkp9cdBh5DcZ
 X/mpw4hojMWKtc4PDby3sOlz8gELdkmEpMsalWE940N4sYxf5Shy7JKzU1IYJkGVd3
 hgnSdJBvYI9gfxFmXg20ah9tKmCax3knJx0Knhw/A6/ZlKZLddrO3ZCHaqG7WaJTXo
 ytlqARk2G0BBVMI9jFjbDPTp+KWmchjjO1VIFH0zp/tO9Ct36jLJyUGaJKYMgGPBRE
 de0TAANYs6KPL6PMjhaFMidNQUrygYGzSYsJKoq1OL+D1n2vBvAECtd0ZyEtamWRSj
 RDLFAKLP7g4tQ==
Message-ID: <6a3d71264cc7e771cf1988ac4a73ef23d142a895.camel@codeconstruct.com.au>
Subject: Re: [PATCH] MAINTAINERS: aspeed: Update Andrew's email address
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, andrew@aj.id.au
Cc: joel@jms.id.au, peter.maydell@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org, qemu-trivial@nongnu.org, Laurent Vivier
 <lvivier@redhat.com>
Date: Thu, 26 Oct 2023 15:48:05 +1030
In-Reply-To: <255f59a0-6666-44c5-9b21-2435c82e17e2@kaod.org>
References: <20230925062212.66112-1-andrew@codeconstruct.com.au>
 <aaa71ccc-e7d4-46f4-b902-22a422ff895a@kaod.org>
 <255f59a0-6666-44c5-9b21-2435c82e17e2@kaod.org>
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

On Wed, 2023-10-25 at 10:57 +0200, C=C3=A9dric Le Goater wrote:
> On 10/24/23 11:36, C=C3=A9dric Le Goater wrote:
> > On 9/25/23 08:22, Andrew Jeffery wrote:
> > > I've changed employers, have company email that deals with patch-base=
d
> > > workflows without too much of a headache, and am trying to steer some
> > > content out of my personal mail.
> > >=20
> > > Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> > > ---
> > >=20
> > > Hi C=C3=A9dric, do you mind including this in your Aspeed queue?
> >=20
> >=20
> > I am not sure to send an Aspeed PR. May be this change could go
> > through qemu-trivial ?
>=20
> After all, I will send an Aspeed PR. Don't bother.

Thanks!

