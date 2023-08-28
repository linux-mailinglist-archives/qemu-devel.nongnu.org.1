Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7CE78B252
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 15:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qachb-0005de-43; Mon, 28 Aug 2023 09:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qachX-0005dL-7E; Mon, 28 Aug 2023 09:54:43 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qachT-00048x-Ej; Mon, 28 Aug 2023 09:54:42 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99357737980so415077966b.2; 
 Mon, 28 Aug 2023 06:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1693230877; x=1693835677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZkuNOEu8z3nGdSdxiZcGzrZgMXnvKJUHQ+2W1hwOFhs=;
 b=SOEVcoHxGttpzoWg7Z3DRCCGwDFRchzw4M2wGnTyXuO8Kd1Pz5VL1Tz7eWwT2iq2vY
 /tgUFDedcJ+18T9XhNMHbd1ekAyuN/sJqCZbQkVJG2c3oXIzLLtXp7z8EKS77f0YouuS
 j7zalJdHiINKEuz9fRufzFWQCTDPIDziagVlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693230877; x=1693835677;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZkuNOEu8z3nGdSdxiZcGzrZgMXnvKJUHQ+2W1hwOFhs=;
 b=ZPFsmjB7fq5RW8TbDVwSbzD/HZDBzBq9kzDz6GMrlGnQTjf5mraaC49FI90AfsZcgI
 oXyoAA1eD3v3WCHkZKiZaBNMSqw3GzpAHoJ9UZRZU/5xom94+pVwDyZYir38alAV/SZg
 lFRFK/WvJZ24ARS60+SVA3YUtBx5Cm2eBC2kDDlyGh0jDs8fyqVJxc3OkDfDLspaAVNt
 tUvXHEel/lYmcoq9Q9LValXFbmIp8dovQaIjvCCxu10ZmGhcXmrVFFmeRHJ4vzQuT76I
 0AfpwaVVnBGb1VLTLZylRXiPaANKOol1XXAmu8W+fYTcVTjzkbG2/0o22Jr5CMX57sVw
 YsUg==
X-Gm-Message-State: AOJu0YzTMqSi0DijOgye4XH3qlldZSiy7nmT+YSXn8Xc684smvhydiSv
 eSaKahf42yyKlBeF6KoRQ8JFfS+5dDUdlXbKwo8=
X-Google-Smtp-Source: AGHT+IEXnok7pOZE/8loV9jk4oPjOeGYPmznMbIFhHAw5/rb/hpD2QNVA8Kj7coItdkqswH/0aCsCKQNhFoKg1rdhUY=
X-Received: by 2002:a17:906:5199:b0:9a1:b6e1:c2e with SMTP id
 y25-20020a170906519900b009a1b6e10c2emr15260954ejk.33.1693230877062; Mon, 28
 Aug 2023 06:54:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230828090101.74357-1-clg@kaod.org>
In-Reply-To: <20230828090101.74357-1-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Mon, 28 Aug 2023 13:54:24 +0000
Message-ID: <CACPK8XfMn5PJaM9dBkck=jxhLuusJmGnAv_RE3Dp-kdezYM+-A@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado/machine_aspeed.py: Update SDK images
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>, 
 Hang Yu <francis_yuu@stu.pku.edu.cn>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, 28 Aug 2023 at 09:01, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Switch to the latest v8.06 release which introduces interesting
> changes for the AST2600 I2C and I3C models. Also take the AST2600 A2
> images instead of the default since QEMU tries to model The AST2600 A3
> SoC.

Is there any value in testing both the old and the new images?

Reviewed-by: Joel Stanley <joel@jms.id.au>

>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>
>   Requires patches from Hang Yu [1]
>
>   [1] https://lore.kernel.org/qemu-devel/20230812065230.8839-1-francis_yu=
u@stu.pku.edu.cn/
>
>
>  tests/avocado/machine_aspeed.py | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tests/avocado/machine_aspeed.py b/tests/avocado/machine_aspe=
ed.py
> index 724ee72c0208..90f1b7cb77a1 100644
> --- a/tests/avocado/machine_aspeed.py
> +++ b/tests/avocado/machine_aspeed.py
> @@ -316,8 +316,8 @@ def test_arm_ast2500_evb_sdk(self):
>          """
>
>          image_url =3D ('https://github.com/AspeedTech-BMC/openbmc/releas=
es/'
> -                     'download/v08.01/ast2500-default-obmc.tar.gz')
> -        image_hash =3D ('5375f82b4c43a79427909342a1e18b4e48bd663e3846686=
2145d27bb358796fd')
> +                     'download/v08.06/ast2500-default-obmc.tar.gz')
> +        image_hash =3D ('e1755f3cadff69190438c688d52dd0f0d399b70a1e14b1d=
3d5540fc4851d38ca')
>          image_path =3D self.fetch_asset(image_url, asset_hash=3Dimage_ha=
sh,
>                                        algorithm=3D'sha256')
>          archive.extract(image_path, self.workdir)
> @@ -334,8 +334,8 @@ def test_arm_ast2600_evb_sdk(self):
>          """
>
>          image_url =3D ('https://github.com/AspeedTech-BMC/openbmc/releas=
es/'
> -                     'download/v08.01/ast2600-default-obmc.tar.gz')
> -        image_hash =3D ('f12ef15e8c1f03a214df3b91c814515c5e2b2f561190213=
98c1dbdd626817d15')
> +                     'download/v08.06/ast2600-a2-obmc.tar.gz')
> +        image_hash =3D ('9083506135f622d5e7351fcf7d4e1c7125cee5ba1614122=
0c0ba88931f3681a4')
>          image_path =3D self.fetch_asset(image_url, asset_hash=3Dimage_ha=
sh,
>                                        algorithm=3D'sha256')
>          archive.extract(image_path, self.workdir)
> @@ -345,8 +345,8 @@ def test_arm_ast2600_evb_sdk(self):
>          self.vm.add_args('-device',
>                           'ds1338,bus=3Daspeed.i2c.bus.5,address=3D0x32')=
;
>          self.do_test_arm_aspeed_sdk_start(
> -            self.workdir + '/ast2600-default/image-bmc')
> -        self.wait_for_console_pattern('nodistro.0 ast2600-default ttyS4'=
)
> +            self.workdir + '/ast2600-a2/image-bmc')
> +        self.wait_for_console_pattern('nodistro.0 ast2600-a2 ttyS4')
>
>          self.ssh_connect('root', '0penBmc', False)
>          self.ssh_command('dmesg -c > /dev/null')
> --
> 2.41.0
>

