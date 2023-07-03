Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9195B74536A
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 02:57:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG7rs-0000bI-Mz; Sun, 02 Jul 2023 20:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qG7rr-0000b8-4C
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 20:56:39 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qG7rp-00089t-LQ
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 20:56:38 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-47e43b71bb7so550781e0c.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 17:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688345796; x=1690937796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ebfJdY7KWqoWsxSmNlu13tQRC+C22T9HbH7/LUIy4RY=;
 b=myZLE6cd9xWkhYl2ZMfM5gwrm1wbasAFoY7aAeKkBxw8EeiF1GC54Mo8cXdrOeQ/nM
 81BcYbdwXFo/Kzljy6jbHdJtsl3in3IjG1HV1D3laAHyjEo7E9L0DpwLndtRtocBpx+s
 x67YV9+DeYgNcyXeZ3YJeapYfhcMky8Y/Xw4wF2tDdEqtpMu94q161UXx06ehiAtk6M0
 0hdMLNkGaTQpFqnUYVVVe38pGyUKcFqaLmUIGA+iH8OaS8ng0VT3RK6WsEGgtH88sRF1
 1lZPkw2oEAzVSDqxktFW4EcptevDmNqBr7WjSb5AMVkEBJQhnLcOcHiErdh/JtyS+zUz
 hNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688345796; x=1690937796;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ebfJdY7KWqoWsxSmNlu13tQRC+C22T9HbH7/LUIy4RY=;
 b=KQ+H3OyjVKzkvnjuuQWVpeK3vwv5xBYlfRs9SW0YSBPndt5n9BzQVHKiiJFnop00qb
 8Xv/K/iaVkOGu1bsjlRAJt9xLxF9U7o8TggWlFkDeS4njRlEAQ3wNLtWd49i1bVxc9h4
 Db35MDH7MnK/IeRNtWZz+ZGCd63hN9tP4M1QIesX4/AKv/sy6icvepubDYWj69UpoUfO
 JaKBCVefJkQL2iLN9V9vpWyODyVcAbs7mWNnB2BMsoVV6IoHvaVchO8VRh6Yqhb8VTnr
 9/Rrgg8MLxlFWfNHgQHixO2sCthRFsWmKBkjT9M0NPa+1HyiZ9xgfs6I2AlKNjon7bxk
 DG5Q==
X-Gm-Message-State: ABy/qLa34NiFL8kBYMvr99ire++4xKi+C6xqIvaUDNg2vE0aKzx+VbCU
 TFb1ih6s23RlQYrrgsU9qPYL6f7jJUFmU4ExMFM=
X-Google-Smtp-Source: APBJJlGI+TdiraCwbuBfmyWFuLgFo4L31+5sy7ec4gj/85RBe1OBRhqErB6cOiqdfSzojpqHW3eQF2yY41yZXuQ0igc=
X-Received: by 2002:a1f:5c56:0:b0:471:4f65:4f7f with SMTP id
 q83-20020a1f5c56000000b004714f654f7fmr3763667vkb.3.1688345796661; Sun, 02 Jul
 2023 17:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230630160717.843044-1-bmeng@tinylab.org>
 <20230630160717.843044-2-bmeng@tinylab.org>
In-Reply-To: <20230630160717.843044-2-bmeng@tinylab.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Jul 2023 10:56:10 +1000
Message-ID: <CAKmqyKNMz5Trg7znqJwbwEsdvkcD=MFs0L3o46kKZ5L-UHSOcA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tests/avocado: riscv: Enable 32-bit Spike OpenSBI
 boot testing
To: Bin Meng <bmeng@tinylab.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

