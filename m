Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8ACAFBFEB
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Jul 2025 03:25:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYx4L-000292-FZ; Mon, 07 Jul 2025 21:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uYx4I-00028D-Fm; Mon, 07 Jul 2025 21:24:22 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uYx4G-0007ZX-RV; Mon, 07 Jul 2025 21:24:22 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-531a1fad7faso1363105e0c.2; 
 Mon, 07 Jul 2025 18:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751937859; x=1752542659; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkbnExsisBqaDO3OJcNhs2MIhoRg3ySlEryq4GDNj0s=;
 b=Rbb4wPHDvGj0Pk7dlFi9OuzRwwJyrKE+oCnJgVW3jzAsXrYmSE4zzYZln1Cbe7FV17
 h9fuFyUuZMKnhqO12dbJdVBbzquF+CkxmDDoO2/M5TtJdgdCGTESY76nOmyxajiBM/Nv
 YtAAvanBCBndMjhAJSzSjPFUoPt+VWueGeKly8vk1fK49QRLIClhEwU56JV/qjMNzyF1
 x9BwLgB1lWO0VnewjgAqg5qy1yfBg8kXmFQJOObb3yfS2wtATrgkkDJTXPQJwZFYaW+g
 5EzLL58NzPFCNufcbA2OOUU+l7e2Ozxy09lTvJ7jvj4oCci7EmQ7hMAaT2ZINtzHnfgI
 DvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751937859; x=1752542659;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkbnExsisBqaDO3OJcNhs2MIhoRg3ySlEryq4GDNj0s=;
 b=J0pqURYTdOiZ6jRRcQKgdICMH4T6FkX/IxoFuekHhNyo8AR0Ph6JmKxKyqH2JnC5A7
 xhiaxMCxRJHWXI07cez3fQoKzvgtF7IFBNz6E3LzJhSAXJyoV21zFwkZ6AU1WEoOtARs
 mQYq8TjDWLDgAqnCi7DBfdGT578unu/88XqFECr5NvpwU1YbXc5/31nb1Y6H2Ya7Lx7U
 Kt6CEcLEOdtah3LPVAGNgu1JHqjdQI0ubPTETJO8H0ni9iyWhZ7uQcRDOJi/HrEcdIf9
 iywNyJK3Qzi0eP2DuFbKGrs9DMU/zHegrwzToFToDp8+mF4ZJwBW5pmbf5Xl9TXeogOy
 AZPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm/7qJg9JJ+7xz4L0LUPIyQz5vTsr2gUQtoV+cHMBftQgHNRSR62bPmELH6hVZ3yJI6zNyrVItoiXZ@nongnu.org
X-Gm-Message-State: AOJu0YzXkQrLyQQ93Mp6WGdoG2BTATK9oiWuQM4EiiW4YNfvLTKNt9BT
 OFv1vhi3PWLb90VWsYoO3eoywmD+D8oi3uWbChfgdw8wYnstLW+3E9+VH5Sct4ZlFdNBXvvaC+j
 +yoo1wqSCfVwDtN3FC+GyPgk9lHXQpPg=
X-Gm-Gg: ASbGnctCbJ34Vjk1P26reXqSBewBGi1Bx6T1b7A5r6RpglPyzi903u6BcMfxgWRuRpj
 ztf91OoViruXG2Lxhr1lZr88nymnoRAwKRDqTvZOYyDSGDm7PLSp+kSKOYsc70y4Rko6dpAxKjY
 dLp5GGv9Lws3QxxQqcIgPiCe1MBw3rYSkgBU+m5xkrkQ3OWruZ86PinJ0QdD6FdB3qq8vd6GNjA
 Q==
X-Google-Smtp-Source: AGHT+IGkFO5r2DSdU336wSVcP5+WX3hpyN2A1ZYxa01bDbUR8NlRagb8Fg72yefZBTTV1Wy9fc3eJXyeRwLYcVS/dTM=
X-Received: by 2002:a05:6122:4893:b0:530:6bcb:c97f with SMTP id
 71dfb90a1353d-5347bff10b0mr9202015e0c.8.1751937858912; Mon, 07 Jul 2025
 18:24:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250706065554.42953-1-vacantron@gmail.com>
In-Reply-To: <20250706065554.42953-1-vacantron@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 8 Jul 2025 11:23:52 +1000
X-Gm-Features: Ac12FXyyJK86SrztxkJ9BoIj4_XAxQeUCtZZ1nBZeMNKtcE_pk-2K619B1O7CtQ
Message-ID: <CAKmqyKPZkUK8pJ8ypabdDvCN_PEr-7bJ2Ou=QHBO3PHd6koyhQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix pmp range wraparound on zero
To: Vac Chen <vacantron@gmail.com>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Sun, Jul 6, 2025 at 11:04=E2=80=AFPM Vac Chen <vacantron@gmail.com> wrot=
e:
>
> pmp_is_in_range() prefers to match addresses within the interval
> [start, end]. To archieve this, pmpaddrX is decremented during the end
> address update.
>
> In TOR mode, a rule is ignored if its start address is greater than or
> equal to its end address.
>
> However, if pmpaddrX is set to 0, this decrement operation causes the
> calulated end address to wrap around to UINT_MAX. In this scenario, the
> address guard for this PMP entry would become ineffective.
>
> This patch addresses the issue by moving the guard check earlier,
> preventing the problematic wraparound when pmpaddrX is zero.
>
> Signed-off-by: Vac Chen <vacantron@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 3540327c9a..72f1372a49 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -211,11 +211,12 @@ void pmp_update_rule_addr(CPURISCVState *env, uint3=
2_t pmp_index)
>          break;
>
>      case PMP_AMATCH_TOR:
> -        sa =3D prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> -        ea =3D (this_addr << 2) - 1u;
> -        if (sa > ea) {
> +        if (prev_addr >=3D this_addr) {
>              sa =3D ea =3D 0u;
> +            break;
>          }
> +        sa =3D prev_addr << 2; /* shift up from [xx:0] to [xx+2:2] */
> +        ea =3D (this_addr << 2) - 1u;
>          break;
>
>      case PMP_AMATCH_NA4:
> --
> 2.50.0
>
>

