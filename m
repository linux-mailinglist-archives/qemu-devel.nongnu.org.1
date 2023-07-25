Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A183762212
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 21:12:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qONRl-0002GY-TS; Tue, 25 Jul 2023 15:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qONRS-0002FM-GA
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:11:30 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qONRQ-0008F1-Gx
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 15:11:30 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-4fbf09a9139so9295061e87.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 12:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690312286; x=1690917086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1XRq2nY/a6JPvJMJhVM1zHK/RJMx24ZwWk/hwrRY2Q=;
 b=PJMO5MdUsgUjGkmYYq/gioz0cEVxIzJ3Weuljjmhs3vMQRtqh3p0RgRflQ/v1IkW87
 Bx5RxCQ8eTmFKE/5UyFPsfdg1P3AmSL1YV0Q0xAGB0uPnYsg4rN5nOAMUwz2W0KJVkE5
 qiPYbW5OjHsyY4odVSVXHtEtVp4p4O6l58ZtpzCvwZ3C/hk1dCDCP1RQuRNXfRbTGE3Q
 fylbitEh1iNJQirLSlFHYUybLldHaTopfQm8I9K4VzFHyHZMWOXQ+Uteizzuw1sRb4CO
 W8chev2SOvHaPYzQhk7c3SmSXqFpgbMqt7RcBYNF5Vhrlyg9l2dICzOlkg+k9D8gvMWW
 w+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690312286; x=1690917086;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1XRq2nY/a6JPvJMJhVM1zHK/RJMx24ZwWk/hwrRY2Q=;
 b=b+lYhYLFuBE/sb1lQ++9kL4bPQrV3BPSl01OCn5ik74uWOltTRU+gsTcsw40a2IRWH
 HKdzkrfDFJ85eVGLBhIjaGbIhqefyv2RB9D7TkRlT/8yGSbMsOubYo45qOZl64j9mJ+z
 UhCWZcJDtersd9op/6PcEwL1iyqEQzgxJfNocoIpWvuw28bXRorydNhFHEL142w8gcaR
 B9ptIiZuM3Dy/20ylaYoB4SQP+6ncAeOMDKk6mgOhOLlE1orv3DY9XiAVvYVYx6jyZyb
 2PEXUNaVC2ww14iSqRbeFkOjWWHuVHWBzzQq7kFKe+9KAPMuB5bAAy08RULizlJABuVM
 x2FQ==
X-Gm-Message-State: ABy/qLYHnPsvgL3pIdc4onicKO73dgaR3X5kBpsarw+rgSqVwW+vMr/o
 tdHh1B7BOdOWzFOuotEYCYscUyhCDpT51vj5S1kgKA==
X-Google-Smtp-Source: APBJJlFTgzBeFvK9dhIl8hsf7g4SnZ76JKGTwoYop80vMuKAPz0cjSZgH2Z2vGXrC+IRMKCewoVhas1hxKaaeWb92kk=
X-Received: by 2002:a05:6512:118a:b0:4fd:f889:b9d2 with SMTP id
 g10-20020a056512118a00b004fdf889b9d2mr5657866lfr.38.1690312286317; Tue, 25
 Jul 2023 12:11:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230725162457.156429-1-berrange@redhat.com>
In-Reply-To: <20230725162457.156429-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2023 20:11:15 +0100
Message-ID: <CAFEAcA_wTsjGyMQj9wexRi7nESTUx4tE2JSyZS+w38cFpFmLgA@mail.gmail.com>
Subject: Re: [PULL 0/2] Misc next patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Canokeys.org" <contact@canokeys.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, "Hongren (Zenithal) Zheng" <i@zenithal.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Tue, 25 Jul 2023 at 17:26, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit a279ca4ea07383314b2d2b2f1d550be9482f14=
8e:
>
>   Merge tag 'pull-target-arm-20230725' of https://git.linaro.org/people/p=
maydell/qemu-arm into staging (2023-07-25 12:44:39 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/misc-next-pull-request
>
> for you to fetch changes up to 0e6b20b9656174e815751cf8b21f5e326148bb99:
>
>   hw/usb/canokey: change license to GPLv2+ (2023-07-25 17:24:12 +0100)
>
> ----------------------------------------------------------------
> Miscellaneous fixes
>
>  * Switch canokey license from Apache to GPLv2+
>  * Fix uninitialized variable in LUKS driver

FYI, this just missed rc1, but will go into rc2.

-- PMM

