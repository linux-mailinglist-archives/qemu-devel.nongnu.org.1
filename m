Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D69745363
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 02:54:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG7oQ-0007dI-85; Sun, 02 Jul 2023 20:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qG7oL-0007cv-3a
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 20:53:01 -0400
Received: from mail-qk1-x72d.google.com ([2607:f8b0:4864:20::72d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qG7oJ-0007Nv-Lg
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 20:53:00 -0400
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-765a651a3b6so376079585a.2
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 17:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688345578; x=1690937578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOWVYeDdNz++OUIyBQbqFEt5N7OpgK/68o2a8rAJoh4=;
 b=Yh+3kz4kCiwibK+ah//au6v8MrVgWlzTWKLmG3VTPHIWirqIXqDkrX+e35N08Tmv7r
 Zn3KfZIYwtCDlB6EdpxSZT1g0lbz3ObjE4g+xkJBFrm4teJP6M3KS7Mx0jZGvMfOCi10
 xd+9zK//YL+aBUKlh4RUdhf2oU2Py+YToFvw7jA7waDDJ1LU21XrAdjJZaR/P7P0hyt4
 W4oRrPlXQfyb7M6Vb0aA2CneRQ7Nrj/JeHJhh5jbc3liN7ZWGPqj996fGrqMMkNgP5VQ
 dpH5XjqCmW4NqFS/OPfmYvPzLuTno6mPRiog6GvGEIz9Ge4jMrx71R7AwHABK64EIWAj
 uBFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688345578; x=1690937578;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOWVYeDdNz++OUIyBQbqFEt5N7OpgK/68o2a8rAJoh4=;
 b=OOerQ2VrDzfW9AWW7SLJkrQgo+zitiZloNZZUC5UXuMnQkErfIXYSUOA4rVWRhV0yj
 K2ew++pKkaPfdN6fLyztyCanKOe7mmEr0An1ScT/7wKoY2yPzKc/bU8o0EVvn1ALCwBG
 iWxuzBP/l2Wn8yx++HU/YlVCtdsT4ShNyxtPTBEzIgjf/URACqwx0Wh5BgX5vyIROiQW
 pTbTCRQIbvyIsuBHNiiKqrtlQCEiKUDwnKlcICrh9XbRscTZWn6RUSNjxU8ziei65pVG
 m2Jd96u+GGjyXmYKub9B4OAlN4u7PUboJgmkPSOkY2/Jl3DrK7KI6j4Q8IhVuZHJm1YV
 eJ+g==
X-Gm-Message-State: AC+VfDyn5hBUYrbF4cNkbhuOI/DVYqfxdnKDW2ZF1NkBAj0IRnS17CXp
 psirtfac8llaCbp3WQuwXaL+YoJrVHnRW7LRLNw=
X-Google-Smtp-Source: ACHHUZ4BCRx3faoVIlPYnssCbOPsMbkXEFWcYrupPE38vRKeyhfj4R2FGc82O5mBxuMLb69V2yar7EtlEgeIBjUusz0=
X-Received: by 2002:a37:f615:0:b0:767:1db2:c32f with SMTP id
 y21-20020a37f615000000b007671db2c32fmr8020490qkj.33.1688345578305; Sun, 02
 Jul 2023 17:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230630160717.843044-1-bmeng@tinylab.org>
 <20230630160717.843044-2-bmeng@tinylab.org>
In-Reply-To: <20230630160717.843044-2-bmeng@tinylab.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Jul 2023 10:52:32 +1000
Message-ID: <CAKmqyKPp8T8V83nwePRuC=SYTZNWtsin8A9_AOTEzoASKPoa0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/avocado: riscv: Enable 32-bit Spike OpenSBI
 boot testing
To: Bin Meng <bmeng@tinylab.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::72d;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x72d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sat, Jul 1, 2023 at 2:08=E2=80=AFAM Bin Meng <bmeng@tinylab.org> wrote:
>
> The 32-bit Spike boot issue has been fixed in the OpenSBI v1.3.
> Let's enable the 32-bit Spike OpenSBI boot testing.
>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>
>  tests/avocado/riscv_opensbi.py | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi=
.py
> index e02f0d404a..bfff9cc3c3 100644
> --- a/tests/avocado/riscv_opensbi.py
> +++ b/tests/avocado/riscv_opensbi.py
> @@ -6,7 +6,6 @@
>  # later.  See the COPYING file in the top-level directory.
>
>  from avocado_qemu import QemuSystemTest
> -from avocado import skip
>  from avocado_qemu import wait_for_console_pattern
>
>  class RiscvOpenSBI(QemuSystemTest):
> @@ -21,7 +20,6 @@ def boot_opensbi(self):
>          wait_for_console_pattern(self, 'Platform Name')
>          wait_for_console_pattern(self, 'Boot HART MEDELEG')
>
> -    @skip("requires OpenSBI fix to work")
>      def test_riscv32_spike(self):
>          """
>          :avocado: tags=3Darch:riscv32
> --
> 2.34.1
>
>

