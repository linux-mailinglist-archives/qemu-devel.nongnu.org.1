Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67864747B62
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 04:07:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGru5-0001HM-Ne; Tue, 04 Jul 2023 22:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGrtr-0001Es-QP; Tue, 04 Jul 2023 22:05:50 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qGrtp-0005pn-6F; Tue, 04 Jul 2023 22:05:47 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-991c786369cso727103866b.1; 
 Tue, 04 Jul 2023 19:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=jms.id.au; s=google; t=1688522743; x=1691114743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sV7iyPLTHpB6T8Z/z7UWIfMfvfhOmoiUKepqpLlDEdI=;
 b=MTilERlIbpWB2iGNpzfIkjSkpN1JhfhZnr3dyAqTSVqY8U/1x7YGK8S6KyYIN0KfLo
 8S0giWlZLHv3mEiamYuYbGX5CQXJ90dr3xAP5wEiOFLdUR42JXlOTR7ONRCicCQBJ/4C
 EgtDearLi1O5QAP9PppgOTFJ6f8gnS46JpmOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688522743; x=1691114743;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sV7iyPLTHpB6T8Z/z7UWIfMfvfhOmoiUKepqpLlDEdI=;
 b=PBtqDz9MAU1eT4iKfe9ZNbRYvGz1wEIELempwIujZw6GWnsWPQy+NnFFzdGVig0Ys3
 woSZOSB91ZrT9WfV4rPpqNjxfnmfUIcLQ70Nj6sBSP7kZYlcUkYTYv+bmTF8UId+iGY+
 MSCZRioB7c1VbI6cnPapAkdDbvx1CUVfPGHB/PJ69R6BvoMxDJF7gJmbm1F5IiaErCaU
 zqFGjKiD6of0SisGCnOEbJEmPEHhkdngb6P/Bi4pPFZKpcc2/xdL4XOoayMTx+GCi5D1
 UlySAc14hAax73wrHmRATeAzQxiuCMxIJwx83C8zbJcQW1uwIS9CkshA482JYvDmIznZ
 cNQA==
X-Gm-Message-State: AC+VfDwyRgG40ev+hEYuRwm1sBHVAA9Hn3eXfbgFpl7mgPMTn0DS329R
 tx+6rRU3AiwE3kSC9rMb9RpinPH9YvLwrlSu4sM=
X-Google-Smtp-Source: APBJJlHyYKYQBvjTPfYDHJvWPjazp89fk+oVU8BOUgGzJF+M1iGr6IT8RQD8grZYLtoNK7Ns+lwaFnfFe9mw0feNgK0=
X-Received: by 2002:a17:906:b7c8:b0:984:bd75:6a3 with SMTP id
 fy8-20020a170906b7c800b00984bd7506a3mr10970799ejb.58.1688522742956; Tue, 04
 Jul 2023 19:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230705012736.20020-1-npiggin@gmail.com>
In-Reply-To: <20230705012736.20020-1-npiggin@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 5 Jul 2023 02:05:31 +0000
Message-ID: <CACPK8XcsBt5ZQ=SRFd2+6OjRx4zM1gmcr12djiMugS9QTa6SGw@mail.gmail.com>
Subject: Re: [PATCH] ppc/pnv: Set P10 core xscom region size to match hardware
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x633.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, URIBL_CSS=0.1 autolearn=no autolearn_force=no
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

On Wed, 5 Jul 2023 at 01:27, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The P10 core xscom memory regions overlap because the size is wrong.
> The P10 core+L2 xscom region size is allocated as 0x1000 (with some
> unused ranges). "EC" is used as a closer match, as "EX" includes L3
> which has a disjoint xscom range that would require a different
> region if it were implemented.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Nice, that looks better:

0000000100000000-00000001000fffff (prio 0, i/o): xscom-quad.0: 0x100000
0000000100108000-000000010010ffff (prio 0, i/o): xscom-core.3: 0x8000
0000000100110000-0000000100117fff (prio 0, i/o): xscom-core.2: 0x8000
0000000100120000-0000000100127fff (prio 0, i/o): xscom-core.1: 0x8000
0000000100140000-0000000100147fff (prio 0, i/o): xscom-core.0: 0x8000
0000000108000000-00000001080fffff (prio 0, i/o): xscom-quad.4: 0x100000
0000000108108000-000000010810ffff (prio 0, i/o): xscom-core.7: 0x8000
0000000108110000-0000000108117fff (prio 0, i/o): xscom-core.6: 0x8000
0000000108120000-0000000108127fff (prio 0, i/o): xscom-core.5: 0x8000
0000000108140000-0000000108147fff (prio 0, i/o): xscom-core.4: 0x8000

Reviewed-by: Joel Stanley <joel@jms.id.au>


> ---
>  hw/ppc/pnv_core.c          | 3 +--
>  include/hw/ppc/pnv_xscom.h | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index b7223bb445..ffbc29cbf4 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -299,9 +299,8 @@ static void pnv_core_realize(DeviceState *dev, Error **errp)
>      }
>
>      snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
> -    /* TODO: check PNV_XSCOM_EX_SIZE for p10 */
>      pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), pcc->xscom_ops,
> -                          pc, name, PNV_XSCOM_EX_SIZE);
> +                          pc, name, PNV10_XSCOM_EC_SIZE);
>
>      qemu_register_reset(pnv_core_reset, pc);
>      return;
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index f7da9a1dc6..a4c9d95dc5 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -133,7 +133,7 @@ struct PnvXScomInterfaceClass {
>
>  #define PNV10_XSCOM_EC_BASE(core) \
>      ((uint64_t) PNV10_XSCOM_EQ_BASE(core) | PNV10_XSCOM_EC(core & 0x3))
> -#define PNV10_XSCOM_EC_SIZE        0x100000
> +#define PNV10_XSCOM_EC_SIZE        0x1000
>
>  #define PNV10_XSCOM_PSIHB_BASE     0x3011D00
>  #define PNV10_XSCOM_PSIHB_SIZE     0x100
> --
> 2.40.1
>

