Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B973C76806D
	for <lists+qemu-devel@lfdr.de>; Sat, 29 Jul 2023 17:57:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPlqa-0002tU-AJ; Sat, 29 Jul 2023 11:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPlqY-0002t3-1O
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 11:27:10 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qPlqU-0005vM-Qs
 for qemu-devel@nongnu.org; Sat, 29 Jul 2023 11:27:09 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5221e2e69bdso3950303a12.2
 for <qemu-devel@nongnu.org>; Sat, 29 Jul 2023 08:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690644424; x=1691249224;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e3xliaUbV8HgFjq433LYBKj5J0JmxGcmuARLnJ7CKP8=;
 b=XyK5dvRAkTz16Ao6+Y4XYubCCZsD1GYtkNslTKz0xi/L9zWe/O8puoriAKLmDPGHbZ
 Gs1gbG34PDrJyvLNDdZ0B1k8725NwdLZNQAHxtFDWm4V8pRw9jajjCYq8OJYWkE5FfF9
 H1BEUdSj8Wqf7Afx/Tjahia11jDR+eoeqRqpTtSm3oEBGMh9KZNxAS66D7CwDlg6OIQb
 6kGaRtXix0PoCIbUOgwg97MU4zG0yFby4GJLA6MgSyYFu5KSrtUOzsZMDU1AHiUEeOtK
 QtzFAxvU3wBERwnZoev7Po5qqh/DSkXZH411/6tVoUqOGAOMCDX8ao1zpR/XZUNVVf/3
 os/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690644425; x=1691249225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e3xliaUbV8HgFjq433LYBKj5J0JmxGcmuARLnJ7CKP8=;
 b=gySP8oaXXlqF8Iayw+76xXcmm2cy173wqrwdq2R4qUNKrmQuqdqqjjhxXxpAUj4wOW
 mghnh9bkfeNoDDgv/M/y8NIgImGi4rMEwII4QMeMx63oZVpztlA9J2uJN6JXXrD04VQj
 ccizQFyabI73X2H9YET0RDHlOgsGtV2I6b+/U7K+cCHQcWAtimtxakKgbd7UweTwcCE0
 tGhhp4bINj25VyCzdOGm3X5HtYVCVlhwalavUm9G9g4LaD+q4Zx6h8fCi8626IMNG7xU
 OHNVFyg2Fv737R+40S7RRRi2azu0bI8AR7CiZF5UHazUkYV8QGz0rj1kquPseJdLszj5
 XrTg==
X-Gm-Message-State: ABy/qLZkuRlKbQfKW9eEW0GZSLRzw762IXgebnpQSHhN3hDjUGj/GqGG
 dx3tiLQPzmlVdyGVZ2VbvEu0h9LspHMYKFx9l++xug==
X-Google-Smtp-Source: APBJJlHqI/khkTXCyh74n3Fc87CGK7ZbQWtGSxITaK6rCjewqXm1U7wPb/GP9jFziJumfLLvEtkMGcFsXvU45Ck075g=
X-Received: by 2002:a05:6402:1055:b0:522:4d1b:3acf with SMTP id
 e21-20020a056402105500b005224d1b3acfmr4397060edu.37.1690644424587; Sat, 29
 Jul 2023 08:27:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230728195646.168997-1-danielhb413@gmail.com>
 <20230728195646.168997-2-danielhb413@gmail.com>
In-Reply-To: <20230728195646.168997-2-danielhb413@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 29 Jul 2023 16:26:53 +0100
Message-ID: <CAFEAcA8MJ8pPwgQMLJZbwVkBLv4BBzLYTGmFw8cOErUo_Z=TOA@mail.gmail.com>
Subject: Re: [PATCH for-8.2 1/2] hw/ppc: use g_free() in
 spapr_tce_table_post_load()
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 28 Jul 2023 at 21:15, Daniel Henrique Barboza
<danielhb413@gmail.com> wrote:
>
> tcet->mig_table is memcpy'ed from tcet->table,

The pointer is just copied, not memcpy'd.

> which in turn is created
> via spapr_tce_alloc_table().

You could mention that this uses g_new0() for the allocation.

> Use g_free() instead of free() to deallocate it.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  hw/ppc/spapr_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
> index 63e34d457a..5e3973fc5f 100644
> --- a/hw/ppc/spapr_iommu.c
> +++ b/hw/ppc/spapr_iommu.c
> @@ -248,7 +248,7 @@ static int spapr_tce_table_post_load(void *opaque, int version_id)
>          memcpy(tcet->table, tcet->mig_table,
>                 tcet->nb_table * sizeof(tcet->table[0]));
>
> -        free(tcet->mig_table);
> +        g_free(tcet->mig_table);
>          tcet->mig_table = NULL;
>      }

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

