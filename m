Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6244A7BFAC7
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 14:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBV6-0007ZV-GC; Tue, 10 Oct 2023 08:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qqBUv-0007Xb-3Y; Tue, 10 Oct 2023 08:06:01 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qqBUl-0002nu-JN; Tue, 10 Oct 2023 08:06:00 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-9a58dbd5daeso994992766b.2; 
 Tue, 10 Oct 2023 05:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1696939549; x=1697544349; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LHtuht1eLKLim21FQpJTz2Yn8QXl+Dy9gJychZ8OvK0=;
 b=QRUfYfXJafV5AgRtn5v0dSmJ/hnnZNYwu4O+ApJsBVrO+g0RWjjt5q4JG4/StPRPXF
 5mz/7NwNaShS+i2vCj0W4ezknDQw0jbAPJlZ5R9C+jvu85EScF9idJ7Uv27uD46P4riK
 aTAXEht+nmdKqDoXaA3LNLh6bv90hU+kWkJV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696939549; x=1697544349;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LHtuht1eLKLim21FQpJTz2Yn8QXl+Dy9gJychZ8OvK0=;
 b=EoDwsQoqQknC/4foklCEmMQm75SSkU8yBSXTg954hoRYPuiqCi0icmKS32DWtRC8OV
 A+8VodVifScAFKot6cExZ66op0DViQl3c0ACqVvqyHWSlhrs+FsusYFwIGeckUie6uR2
 U5X0sZtqPaymK39Zyb7XoG8DUWIsliXbBJJTkQaTzZa7ftvTLnPiYZLRI1TggwIIxyMM
 9bzH5Qqb2u5h9g6P90eEmFKpz47uA4GXPvWrM8PKESUfIoywiyOFZWfswot/HYjFiAsh
 /5+sBg8hG12XN3FVVEN7fZTXxQx6AGkTxgXISCbQJfygihDacElUeCXu/8JKbL6UsX3K
 e12A==
X-Gm-Message-State: AOJu0YwA8fzIAZXZ5XclDDIv4h9kHkhT7fDaAzdbrJF1FJeAugMTGSzU
 PbnMmKUKal3h3G9pOcvaVBOLD5+ZIsXE9miPIqo=
X-Google-Smtp-Source: AGHT+IGi1Fkc8blAyykpT683JHjhyWaDzTqmzbQY16dOldf85M6mrMXCGef4k3BsyrJNpL4z3sjSRTbYiXsPTrSP63s=
X-Received: by 2002:a17:906:7382:b0:9ae:284:c93d with SMTP id
 f2-20020a170906738200b009ae0284c93dmr13479064ejl.5.1696939549251; Tue, 10 Oct
 2023 05:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231010075238.95646-1-npiggin@gmail.com>
 <20231010075238.95646-12-npiggin@gmail.com>
In-Reply-To: <20231010075238.95646-12-npiggin@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 10 Oct 2023 22:35:37 +1030
Message-ID: <CACPK8XeLPd3yw=+jBtc1mj94cxF3e1HAaSZ-4mubh5XV4tvgXg@mail.gmail.com>
Subject: Re: [RFC PATCH 11/11] ppc/pnv: Change powernv default to powernv10
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 10 Oct 2023 at 18:24, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> POWER10 is the latest IBM Power machine. Although it is not offered in
> "OPAL mode" (i.e., powernv configuration), so there is a case that it
> should remain at powernv9, most of the development work is going into
> powernv10 at the moment.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

Do we need to update the docs?

We should consider updating the skiboot to the latest release too.


> ---
>  hw/ppc/pnv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index eb54f93986..f3dad5ae05 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2195,8 +2195,6 @@ static void pnv_machine_power9_class_init(ObjectClass *oc, void *data)
>
>      xfc->match_nvt = pnv_match_nvt;
>
> -    mc->alias = "powernv";
> -
>      pmc->compat = compat;
>      pmc->compat_size = sizeof(compat);
>      pmc->dt_power_mgt = pnv_dt_power_mgt;
> @@ -2220,6 +2218,8 @@ static void pnv_machine_power10_class_init(ObjectClass *oc, void *data)
>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
>      compat_props_add(mc->compat_props, phb_compat, G_N_ELEMENTS(phb_compat));
>
> +    mc->alias = "powernv";
> +
>      pmc->compat = compat;
>      pmc->compat_size = sizeof(compat);
>      pmc->dt_power_mgt = pnv_dt_power_mgt;
> --
> 2.42.0
>
>

