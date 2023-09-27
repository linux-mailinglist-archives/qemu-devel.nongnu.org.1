Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7A97AF839
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 04:40:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlKRg-0004wL-24; Tue, 26 Sep 2023 22:38:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qlKRd-0004w3-IY; Tue, 26 Sep 2023 22:38:33 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qlKRX-00020m-PL; Tue, 26 Sep 2023 22:38:33 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2b9338e4695so168429511fa.2; 
 Tue, 26 Sep 2023 19:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1695782305; x=1696387105; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7WR6vHIEEVdIjBC3pWufmBrSu+xygCKsI+r8KdJjQaA=;
 b=GZkc2+6gb2I3aa97m42ii5wtL1rjory7z+gcQ2h2s3uqnmCERHIB40wEb+FeX42VdS
 FdDT7GcjS/xfJZZ4z4I/Ba2C5Py1GtxL+QRkAZ/UTa2f5zflJ66F+vfZJCiJdTXxPUlC
 h2A0fZu3BbOVwhDK7vl96I0gSTaKeQcWC/SOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695782305; x=1696387105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7WR6vHIEEVdIjBC3pWufmBrSu+xygCKsI+r8KdJjQaA=;
 b=nxGWqtKANXuGRlP36N6Vp+Z+QeZL9mS4XazAn1eR1tG5IXsgqx949hpi/31sasrmQ5
 IbFZa6QAfeRlcZVGVpPWApQB+JzMaEK/Bl1kYZpV5GlTr+mGgEQaJn0tK7O5w/7gAG1Q
 vuMMSTIAsoT7VizxsNyuJFoZFQ+1iFQJelXWMPc0MxbHfir3cz+GbKAe55Q8G7Ude5lb
 4RPF7mpLDp9XCGNDEVqoD/aG6WCwE2n9+vZRAmRpmXMy1IpzPzfOIbl1d6KWZVPpmNRA
 mFgeugsZxdZHbDMDsSEpt5fzsXdxPL4a2p3denQLclm/DlLNBBIFFte1ExE/q2akmTkm
 /D1w==
X-Gm-Message-State: AOJu0Yx13IchNfVAqx734sqhJINS8a+LHPF4ysHcjhDOtey4WrTV75M0
 EoQIppBy4qZ+jxOD6bUZ0UvlQIRpYFoZmyM7E/s=
X-Google-Smtp-Source: AGHT+IFCpu7tPZ/XjI9JzG9I2g0qySHlEntCIod5ri0+8cpwjPgw/55dVVX4/pnHW8GHEHLR199rlaxiXwtAoKyV7Sc=
X-Received: by 2002:a2e:b606:0:b0:2bc:c3ad:f418 with SMTP id
 r6-20020a2eb606000000b002bcc3adf418mr720730ljn.20.1695782305252; Tue, 26 Sep
 2023 19:38:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230922155924.1172019-1-clg@kaod.org>
 <20230922155924.1172019-2-clg@kaod.org>
In-Reply-To: <20230922155924.1172019-2-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 27 Sep 2023 02:38:14 +0000
Message-ID: <CACPK8XdzL9EJ+v6KKsfRvX6x5bVnevVtTmdjM_w22p6gH8oXKQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] aspeed/i2c: Clean up local variable shadowing
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Andrew Jeffery <andrew@aj.id.au>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=joel.stan@gmail.com; helo=mail-lj1-x231.google.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 22 Sept 2023 at 15:59, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Remove superfluous local 'data' variable and use the one define at the
> top of the routine. This fixes :
>
>   ../hw/i2c/aspeed_i2c.c: In function =E2=80=98aspeed_i2c_bus_recv=E2=80=
=99:
>   ../hw/i2c/aspeed_i2c.c:315:17: warning: declaration of =E2=80=98data=E2=
=80=99 shadows a previous local [-Wshadow=3Dcompatible-local]
>     315 |         uint8_t data;
>         |                 ^~~~
>   ../hw/i2c/aspeed_i2c.c:288:13: note: shadowed declaration is here
>     288 |     uint8_t data;
>         |             ^~~~
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

messy.

> ---
>  hw/i2c/aspeed_i2c.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 7275d40749a9..1037c22b2f79 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -312,7 +312,6 @@ static void aspeed_i2c_bus_recv(AspeedI2CBus *bus)
>          SHARED_ARRAY_FIELD_DP32(bus->regs, reg_pool_ctrl, RX_COUNT, i & =
0xff);
>          SHARED_ARRAY_FIELD_DP32(bus->regs, reg_cmd, RX_BUFF_EN, 0);
>      } else if (SHARED_ARRAY_FIELD_EX32(bus->regs, reg_cmd, RX_DMA_EN)) {
> -        uint8_t data;
>          /* In new mode, clear how many bytes we RXed */
>          if (aspeed_i2c_is_new_mode(bus->controller)) {
>              ARRAY_FIELD_DP32(bus->regs, I2CM_DMA_LEN_STS, RX_LEN, 0);
> --
> 2.41.0
>

