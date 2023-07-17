Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB107568D0
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 18:15:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLQrX-00072r-7V; Mon, 17 Jul 2023 12:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLQr5-0006yn-Ck
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:13:48 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLQr3-0006Dn-Jp
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 12:13:47 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fba86f069bso7461136e87.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 09:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689610423; x=1692202423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UtoSklhlObPJcwA6KPS2ELA2alA8g5cyLCA0SBsKcbY=;
 b=N8WtfAo7IGgufxPeNSXjEGoflUB0t70B+ak5qV9Qek7fcYz1J3QxNmbMNLj+aYXMKc
 4bwZYnaZXoUoyxIo3SDH05vrCVJ7mjpMce3x3nkpLKP7A24S6SQ2/Jxoc/dF2bAMWMum
 Z88+0vjcOLm6gqtFyqcd66ROCATw1etJgdHU8qzAsU4uK3k/Bj1j1YLwBOeoP/ENPbEw
 I03siagQQzQLB+Iv62tP5nq5Z/fO6UOdiSNQ2r/SaQu8UR813wQVdnul35pvwPCU0bFr
 qV8xoHSafCYoR1MHU1CY3nLfP5GFYn+UhNfYKDJiAB1nnf0SJe4n9Fiz9X1HcoHYhnal
 sGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689610423; x=1692202423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UtoSklhlObPJcwA6KPS2ELA2alA8g5cyLCA0SBsKcbY=;
 b=SLUYFjyN4DjCjFXW0GwbPch/tCMy22mzj53n2Fer9IXe/pXNJLxdR+20pX/mYSVFO9
 mCqSZP3UOcmQqzALsIRcCcHtkmg5UuK6DbdcES2J/lBpPsbggDtW1X/f596V4UDXNd/Z
 a9mIZa/QT+CHweCYqrML4wE4CV+xpuAjj87YaHONMEzaHZLpcEu2gCys9VzyAtAs9URV
 jf9WkZcA71QzGqbarFJuuysOJOsba1DEUoFT2aacuMWvDSW5hTmLwoJKod8IOj1Vo3To
 DRIYXYvH+3tGtzG5DURU3ac19KjYeEG+F1hPOw+fxVMRXXsgphMK+vNY2wsTpAUE8VBT
 vRZg==
X-Gm-Message-State: ABy/qLYPqIvCGln/7M6SgWvjGY5exIglrTCBSuKm0kHM40FU1wF7wTri
 DkMQxZ5NibKNb4o/TXU/kbtUCoJUyELKCx2GgIF77g==
X-Google-Smtp-Source: APBJJlEL+22JNfjruwSaZFNCYfOvHD+/I+ROW/UgKlJWmZyOMfaHRugH2gjGl2/RkvILbDNEBUSIecKbJeFw+1EvOQY=
X-Received: by 2002:a05:6512:4002:b0:4f9:69e9:4fa6 with SMTP id
 br2-20020a056512400200b004f969e94fa6mr9428051lfb.23.1689610423242; Mon, 17
 Jul 2023 09:13:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230717155316.17714-1-philmd@linaro.org>
In-Reply-To: <20230717155316.17714-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2023 17:13:32 +0100
Message-ID: <CAFEAcA_a66wBE2PYfLLqjR-nXV0fujVws6eNZTpWtuzgBPe55g@mail.gmail.com>
Subject: Re: [PATCH-for-8.1] hw/sd/sdcard: Allow users to bypass the
 power-of-2 size check
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bin Meng <bin.meng@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, 17 Jul 2023 at 16:53, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Since we committed a9bcedd15a ("hw/sd/sdcard: Do not allow invalid
> SD card sizes") to preclude some guests to access beyond the size
> of the card (leading to security issues such CVE-2020-13253), various
> users complained this prevent them to run guests potencially well
> behaving with non-power-of-2 card sizes. In order to allow them to
> experiment with such guests, add a property to disable the pow2
> check.
>
> Resolves: https://bugs.launchpad.net/qemu/+bug/1910586
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/297
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1754
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

I agree with Daniel that this should be an x- property.
We still need to figure out what's actually going on here.

> @@ -2151,7 +2155,13 @@ static void sd_realize(DeviceState *dev, Error **e=
rrp)
>          }
>
>          blk_size =3D blk_getlength(sd->blk);
> -        if (blk_size > 0 && !is_power_of_2(blk_size)) {
> +        if (sd->bypass_pow2_size_check) {
> +            warn_report_once("Unsupported property '%s' enabled: some gu=
ests"
> +                             " might trigger data corruption and/or cras=
h"
> +                             " (thus this process is vulnerable to"
> +                             " CVE-2020-13253).",
> +                             PROP_NAME_BYPASS_POW2_SIZE_CHECK);

If the guest really can trigger an overrun of a QEMU buffer,
then we shouldn't be letting users opt in to this behaviour.
("Buggy guest might do something odd that causes it to get confused
or crash or just not get data out of the SD card" is fine.)
Again, we need to figure out what's actually happening here...

> +        } else if (blk_size > 0 && !is_power_of_2(blk_size)) {
>              int64_t blk_size_aligned =3D pow2ceil(blk_size);
>              char *blk_size_str;
>
> @@ -2161,11 +2171,15 @@ static void sd_realize(DeviceState *dev, Error **=
errp)
>
>              blk_size_str =3D size_to_str(blk_size_aligned);
>              error_append_hint(errp,
> -                              "SD card size has to be a power of 2, e.g.=
 %s.\n"
> +                              "SD card size should be a power of 2, e.g.=
 %s.\n"
>                                "You can resize disk images with"
>                                " 'qemu-img resize <imagefile> <new-size>'=
\n"
>                                "(note that this will lose data if you mak=
e the"
> -                              " image smaller than it currently is).\n",
> +                              " image smaller than it currently is).\n"
> +                              "Note: you can disable this check by setti=
ng"
> +                              " the '" PROP_NAME_BYPASS_POW2_SIZE_CHECK =
"'"
> +                              " global property but this is DANGEROUS"
> +                              " and unsupported.\n",

This is overly vague. In particular, we shouldn't
save the specifics of what the user is opting into
for when the user has actually enabled the x- option...

thanks
-- PMM

