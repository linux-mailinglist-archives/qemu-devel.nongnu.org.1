Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 777168251F6
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 11:29:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLhSD-00063J-Dh; Fri, 05 Jan 2024 05:29:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhS9-000639-Tf
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:29:25 -0500
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1rLhS8-0000RF-7u
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 05:29:25 -0500
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-5ced19f15c3so681171a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 02:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1704450562; x=1705055362; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KLfo45tFwgxvNBE8rGRkJUx7pI021kRK8Y91h9Q4828=;
 b=ivUGBQl32stIkZCzZre54A6OKpfsmYT1CVgHf46oo8Ya/fOmiIEydav3T6GLLL43vh
 aj8JjyYefzdZz3ZltPpyy/nBkjSxeraQYVXg7Km/zDs4p5pzDhPDH0j8OKqAdKL1jWYT
 4McXQn/z0Wo4Tl7ESb2CNEYBsukLiVH/UEEvtYQ1brm92q5xzmKhSnWceTojAL8iB6Eg
 pyceYe2mRvvirknFAO16p0pXz7xBYf34/yiW+QBA19E+Vk8Gd4Og5QLrBxdqBCDUlm2q
 My+lWLd+1Gvs2Tr79kF39HrRnojmc6rS1QY765FaZ6XYrrkqjuu5Yx1hqfhX9BRitwGC
 08HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704450562; x=1705055362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KLfo45tFwgxvNBE8rGRkJUx7pI021kRK8Y91h9Q4828=;
 b=h2duw65ManqiinGkDB2S+sUViCQIeR8WboAmIm3SJQWDsYG+HtLtzABZQgEX7w5YKM
 uTdH4LlmQA54aQbQUjSo7JrpLlMSgY98J5m4ng9QgrIV1COI8jeqexu+v6DKNQcC/RPa
 53liB2FOr2W+5e34z4Nio/mmhmEfGktlOPlVvwljV0ptxpPYBM7ntTymqL5tNCmiOM70
 4kgcRlPIikZ9mHxEfv7PFAIaTfhjPn2volFiLgvFyFOSZuWnxfp3lQRBCfetjDLkZbz5
 Qa8HhfUUl5LWuj1H6PqGTc5GDZQN5ejAK2Kqbw/N+nFTA9/0IBsOCUXaRKN5Paz4qXzb
 QcSw==
X-Gm-Message-State: AOJu0Ywocblg1psV2E1L59QLHFBBReg9snsy9ET1vgmY4kAidb1E2C5/
 FCZysY5iDamx83bknFK7by6W17Rj7eiP8NYQRlzFq4PQgk5P18GmA6qS/8I=
X-Google-Smtp-Source: AGHT+IFQNhFhH9v1ZLMtzjSdxFImDDGLiL0n/FmTc599RAecoc+1Ce77gAI5XKgwj1HAOReBTKn0ED1/ataOan/+lRw=
X-Received: by 2002:a05:6a21:a588:b0:199:2178:ae48 with SMTP id
 gd8-20020a056a21a58800b001992178ae48mr1759892pzc.99.1704450561718; Fri, 05
 Jan 2024 02:29:21 -0800 (PST)
MIME-Version: 1.0
References: <20240105102421.163554-1-chigot@adacore.com>
 <20240105102421.163554-10-chigot@adacore.com>
In-Reply-To: <20240105102421.163554-10-chigot@adacore.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 5 Jan 2024 11:29:10 +0100
Message-ID: <CAJ307EjcP7_-qaC9CkmsU_tbWg9c+nV1JuocdYR4J-yJfLPhNw@mail.gmail.com>
Subject: Re: [PATCH 9/9] MAINTAINERS: replace Fabien by myself as Leon3
 maintainer
To: qemu-devel@nongnu.org
Cc: Fabien Chouteau <chouteau@adacore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x52c.google.com
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

On Fri, Jan 5, 2024 at 11:24=E2=80=AFAM Cl=C3=A9ment Chigot <chigot@adacore=
.com> wrote:
>
> CC: Fabien Chouteau <chouteau@adaocore.com>

Typo here... Should have been chouteau@adacore.com...
I'll update it in v2 if one is needed. Otherwise, could the one
pushing these patches make the change for me ? Thanks and sorry for
that.

> Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 395f26ba86..a065e0b21f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1694,7 +1694,7 @@ F: hw/rtc/sun4v-rtc.c
>  F: include/hw/rtc/sun4v-rtc.h
>
>  Leon3
> -M: Fabien Chouteau <chouteau@adacore.com>
> +M: Cl=C3=A9ment Chigot <chigot@adacore.com>
>  M: Frederic Konrad <konrad.frederic@yahoo.fr>
>  S: Maintained
>  F: hw/sparc/leon3.c
> --
> 2.25.1
>

