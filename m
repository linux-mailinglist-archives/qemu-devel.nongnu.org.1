Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E961D73FBDF
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 14:19:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE7eL-0007Af-MS; Tue, 27 Jun 2023 08:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE7eK-0007A1-3I
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:18:24 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qE7eF-0002yG-C4
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 08:18:21 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2b699284ff4so43304611fa.2
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 05:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687868297; x=1690460297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q9CKyDDLdNVAY7Na0lCbm2OKOo0ud7z20ESMUW/hXkE=;
 b=LG6yVvPG35mwWTjBN75rVfssYZpW32GBCT1sORIsp5g1BG5yBidtdcNpEwr/T4fscA
 X6Kq/5ic2hEzyT8aNS8+Cksemx9J0RutXCADhug5hKzhS5d/xGwMrHKMNtt7xuQfDOGL
 rm3K6vnFoyJlaCRrWdViCu4yx2WyNJFjoPJmDKL6N3jd4jPf4OGK8MPIz90yHupqSSUM
 y66tmFgmiGbsRl2aUwoRbXTPdnxjMVjUL2fJYgua1qXhJR+NQeD/4nGPgZBMbvKVINg8
 LNbP9n4zeszO7rE1SctkSk8QLJ+Nryj8L1fquGMyMVI2uBiqjy/CbZdzHsXy+r7pve+x
 exow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687868297; x=1690460297;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q9CKyDDLdNVAY7Na0lCbm2OKOo0ud7z20ESMUW/hXkE=;
 b=h3S5GZphsv0jE/G6v3rNEC9YDXNDrzAoT3bWVUqSGL7Vuwcupl4qDnq715hvHz/R0D
 AHwWWUqx4+0XCYkOZMicow5sykdGJ96Ou8a4+SQDw4lhXlx7yp8+nMseOtbh+e3NRHue
 OL8Fzxlgyy4+lk3FR/3pO40oQ/VBfPt2a6vDlminRIh61TaOv7v8rBdmqDXW0LJ7iTrR
 qryb5rHYntBDtPLA72bBYYx8FPrdS/geY96D0+1GGvTXMPNTLXBPNnM7oMsaC+q6XJuR
 rTzOmvrDeDIukyxUbIrRUPADrnbk207HoKWTYNIwMULW20wusJ4bQ6B2f2Pp1OBLqt0H
 4Wyg==
X-Gm-Message-State: AC+VfDzLW5PAiKw5foR/+Um63t+NSpGfWrKQiY8NeU71ltBTrNdsQ6aX
 DTMmaJL6NwdqKsSvsbQev/WzJ6A7Xtxg58nL98FQ/g==
X-Google-Smtp-Source: ACHHUZ7n5E/WGjITRiBPkG7pLBazPOvI3t3ai0EuuALk7Rk2W5G3EGIDYZyJNoXa9A2DOtF+aJon7BgwiE+JX8nonPQ=
X-Received: by 2002:a05:6512:1319:b0:4f8:6625:f2ca with SMTP id
 x25-20020a056512131900b004f86625f2camr10168587lfu.61.1687868297382; Tue, 27
 Jun 2023 05:18:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAC583hE_ZXqA4ZkA2OfYYULzPAD+mJOHqvZuJxevyae8eT74rg@mail.gmail.com>
In-Reply-To: <CAC583hE_ZXqA4ZkA2OfYYULzPAD+mJOHqvZuJxevyae8eT74rg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2023 13:18:06 +0100
Message-ID: <CAFEAcA-iXJRiKs5ZRC=_1fP63difCrQZEFjt75FxuiokS41LXA@mail.gmail.com>
Subject: Re: Request for Assistance: Adding I2C Support in QEMU for Raspberry
 Pi (BCM2835 Peripherals)
To: Shivam <shivamvijay543@gmail.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

On Wed, 21 Jun 2023 at 06:01, Shivam <shivamvijay543@gmail.com> wrote:
> I hope this email finds you well. I am reaching out to seek guidance and =
assistance regarding a project I am working on involving the addition of I2=
C support in QEMU for the Raspberry Pi, specifically targeting the BCM2835 =
peripherals.

Hi! Thanks for having a look at implementing this.

> I have been studying the BCM2835 datasheet to familiarize myself with the=
 I2C device registers and their functionalities. Currently, I have started =
implementing the i2c controller for bcm2835, but now couldn't able to get t=
he feel that how should I integrate it with the BCM2835 Soc.(bcm2835_periph=
eral.c)

You should be able to follow the same pattern as with
other devices that are in that SoC, like the 'aux'
or 'rng' devices:
 * your source file is integrated into the build/kconfig
   system, and implements the new device
 * you have a header file that defines things like the
   type macros and struct
 * you modify the bcm2835_peripherals.c file to
   initialize, realize and wire up the new device,
   similarly to how it handles the other devices it has

You'll want to do this all on a git branch, so you can
split it up into different patches (eg "create new
device"; "add new device to the SoC"). When you get
to a state where you'd like us to take a look at it,
that will be more convenient for us if you send it as a
series of patches, rather than attaching individual source
files to an email.

(We have some notes about patch submission here
https://www.qemu.org/docs/master/devel/submitting-a-patch.html
if you haven't found that page already).

thanks
-- PMM

