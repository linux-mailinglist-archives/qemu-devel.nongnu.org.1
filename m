Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729D57B56C9
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 17:39:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKzU-0001uX-Q4; Mon, 02 Oct 2023 11:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnKzR-0001uJ-Bn; Mon, 02 Oct 2023 11:37:45 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qnKzL-0002u2-IQ; Mon, 02 Oct 2023 11:37:44 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1c434c33ec0so124728395ad.3; 
 Mon, 02 Oct 2023 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696261058; x=1696865858; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TXfzbWru7W09CMX3f9N7Tl3U+i9E/Ze2aP9PKWDV9zs=;
 b=gonrdu09ZuuOuJZlbTlGOnIwJqoz3/bIZLUNGwDdAupsumnW1Ke3Som2eA0097GzE3
 CftUHR8f3loRZtcfCpeBPgV0DGWpgfC861skFQuSzwmhqW/0FZPEIXkpbgH7VfoVKsMz
 5U1YkoOaJvQ31Zz5t14+6l/Pjs1tQdFr7wgQYRgf6IIbnXkbWymijm2z3aJ/qA14hNxu
 93Xd8gosgtxkPrUU7XLO3S4UlKP7S8HOQrzmFzmGKnLX2Kg1F+KDnrkhb5ehB9HC7a3o
 knmipealQcz6VEJl0Id//eGb6KQwmJlElGNWvnRNn3n43OvElEPNDqwxrlABiI06uCRt
 TQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696261058; x=1696865858;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TXfzbWru7W09CMX3f9N7Tl3U+i9E/Ze2aP9PKWDV9zs=;
 b=wC/vcwtXOha1/MN8j0x/4HsHqL1MbX9DSH/89BRkCuKoAV8cHGYMXBP0lPGN3Icz6L
 WrS8LlQ8ZAkKsdJpshE1TNmTZlxLeHoGLR3jRjTfc6Ut6Dxq36MdA35kDlhztIxW2hK0
 LKvVZ4cM2Q8ynwbFOmCR+T8ohcLnyWvBXeFicD2Qbe3hemFkNBWNpRMT8zqD/1qOaVhB
 FR3pqmlRLOpoQoRM2+lfZTT1pNsM2iI6z8qzdZAh+mwwJLZpsPmSRzhGDH2JVp4PxMqQ
 wP1xsOfdv04R/nMIIz+nDDzaAzEL4BLoBwuGnNPNBI354KQ1AotTo7xqMS4wVrgzvdKE
 U9yg==
X-Gm-Message-State: AOJu0Yzl4Jkr5KPOzCJJ4rjmFmRqQJt/QA5AwpPBy0+ky9KSYhujnF31
 j4x471SD8Bwx7dE0SLvB2+w=
X-Google-Smtp-Source: AGHT+IFK7YPKrpAYxXdhjcObqJxxZky5sFFKLTMmOQqQmbY8Gn5XdGq7Q64Xw5taTgqnbavoW1riOw==
X-Received: by 2002:a17:902:cec3:b0:1bd:a22a:d409 with SMTP id
 d3-20020a170902cec300b001bda22ad409mr11867699plg.40.1696261057709; 
 Mon, 02 Oct 2023 08:37:37 -0700 (PDT)
Received: from [192.168.68.107] ([177.94.15.124])
 by smtp.gmail.com with ESMTPSA id
 q16-20020a170902dad000b001c0cb2aa2easm21937176plx.121.2023.10.02.08.37.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 08:37:37 -0700 (PDT)
Message-ID: <e1fe24d3-19a8-1c07-6910-0d621de3602c@gmail.com>
Date: Mon, 2 Oct 2023 12:37:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/8] ppc/{bamboo, virtex_ml507}: Remove useless dependency
 on ppc405.h header
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20231002122326.365368-1-clg@kaod.org>
 <20231002122326.365368-2-clg@kaod.org>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <20231002122326.365368-2-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=danielhb413@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-2.321,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



On 10/2/23 09:23, Cédric Le Goater wrote:
> Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com> (odd fixer:virtex_ml507)
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Daniel Henrique Barboza <danielhb413@gmail.com>

>   hw/ppc/ppc440_bamboo.c | 1 -
>   hw/ppc/virtex_ml507.c  | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 45f409c83862..a189942de4cf 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -24,7 +24,6 @@
>   #include "elf.h"
>   #include "hw/char/serial.h"
>   #include "hw/ppc/ppc.h"
> -#include "ppc405.h"
>   #include "sysemu/sysemu.h"
>   #include "sysemu/reset.h"
>   #include "hw/sysbus.h"
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index f2f81bd4259c..d02f330650fc 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -43,7 +43,6 @@
>   #include "hw/ppc/ppc.h"
>   #include "hw/ppc/ppc4xx.h"
>   #include "hw/qdev-properties.h"
> -#include "ppc405.h"
>   
>   #include <libfdt.h>
>   

