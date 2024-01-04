Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 026D682460D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:24:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQW8-0002Us-2K; Thu, 04 Jan 2024 11:24:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLQVv-0002Ix-1S
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:24:12 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLQVs-0001ca-DA
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:24:10 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55590da560dso852358a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704385445; x=1704990245; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aFVg2KubPQQ5E3zK2GqXpSqKU8U4KT3jwPJW9p4EdZo=;
 b=FRTS68HweXsMNkHAxC3YWF35dxWfGsNVux6JlGw37DK8txyFQNjMyCcYXFwqri8U3W
 CAn2Sy31CpKOghAlEHHZ8qfyG1+Fn0nTD8tIwwwYZmLxMd5V/ZZTf0WxOEhxmhtqbUAJ
 eEKrvChI4KG8NuNilB/RHvdCT0RI69PZ3sfqEDw3AS5JyJsVsuf7JV+BDHM1hm+ZmCII
 Kut8Mg1vYyFgMd9uNElkPHExeaE/hJUzgJE/Vhw+0dRzS0TO7Be0eoADHpPPnUkzrD+s
 UUkXUMyL/cfajw+vhFOV2foCISTgCLHzPYU/p4xysuXv1KTs9AwBamruTDBEiUSTH503
 l0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704385445; x=1704990245;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aFVg2KubPQQ5E3zK2GqXpSqKU8U4KT3jwPJW9p4EdZo=;
 b=uLSNBswK+ALNtgQ0LevlFubZwXUoTNlKC/ysL7uT5uF0rBN/iU7Au9BoMJa8YO0F9l
 ybbcePKLQbfKTB/e0iV0bBO+GthGbv66xx4NWKtG0UYE+V31uiQcDR9mMJvuiUwtQdVE
 3MzYdJ97zkEWviHCBsVyt0tksZ6+tPvsN04kxlVa1Corro8XJNyPrmPtKIxLqqrXOVaC
 trjb5KwNUKbtbFCHT21b8l7EvemkfXYc4natQ42PHvdSgUvEXw6dJCOOYgN31MJ4mQfu
 ljA8UXoX2i4Kqr1/ZYPibowVulvt4kf9IMV7F230yD0lFBIbo3FAvFKftH7Mf+ht5tqb
 a6Ug==
X-Gm-Message-State: AOJu0YxcDnuVb128UpbsxlUfRVZsNYxALbQ8QPMCQwtp1XU46FMssLMv
 Eji5dpcXoBpKh3d5Us0SChWWBzG0jwYghRIru67Im0KiEQsJvy3bPTSgGQvP
X-Google-Smtp-Source: AGHT+IFJzVEHCEPGrBlpvZ4zAL2yeXjztinPp0CVpBsGwDDzqKtWsG3LQFcKtzjM22xTyFgOiLwJz6QbCwZM9T+n6oM=
X-Received: by 2002:a50:d64e:0:b0:557:1267:e380 with SMTP id
 c14-20020a50d64e000000b005571267e380mr301758edj.77.1704385445550; Thu, 04 Jan
 2024 08:24:05 -0800 (PST)
MIME-Version: 1.0
References: <20231218113305.2511480-1-peter.maydell@linaro.org>
 <20231218113305.2511480-27-peter.maydell@linaro.org>
 <88dcdb40-2fa3-449e-a3f7-41d75269a968@linaro.org>
In-Reply-To: <88dcdb40-2fa3-449e-a3f7-41d75269a968@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2024 16:23:54 +0000
Message-ID: <CAFEAcA88=EjttEfaVdthnn2vLgWRY1NqYd3cti1VE+4EqsboMg@mail.gmail.com>
Subject: Re: [PATCH 26/35] target/arm: Implement FEAT_NV2 redirection of
 sysregs to RAM
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Wed, 27 Dec 2023 at 23:55, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 12/18/23 22:32, Peter Maydell wrote:
> > +    if (s->nv && s->nv2 && ri->nv2_redirect_offset) {
>
> Again, s->nv test is redundant.

Fixed, thanks.

> > +        /*
> > +         * Some registers always redirect to memory; some only do so if
> > +         * HCR_EL2.NV1 is 0, and some only if NV1 is 1 (these come in
> > +         * pairs which share an offset; see the table in R_CSRPQ).
> > +         */
> > +        if (ri->nv2_redirect_offset & NV2_REDIR_NV1) {
> > +            nv2_mem_redirect = s->nv1;
> > +        } else if (ri->nv2_redirect_offset & NV2_REDIR_NO_NV1) {
> > +            nv2_mem_redirect = !s->nv1;
> > +        } else {
> > +            nv2_mem_redirect = true;
> > +        }
>
> I wondered if it would be clearer with the "both" case having both bits set.  While I see
> that the first defined offset is 0x20, offset 0x00 is still reserved and *could* be used.
> At which point ri->nv2_redirect_offset would need a non-zero value for a zero offset.
>
> Maybe clearer as
>
>      nv2_mem_redirect = (ri->nv2_redirect_offset &
>                          (s->nv1 ? NV2_REDIR_NV1_1 : NV2_REDIR_NV1_0));
>
> ?
>
> This is more verbose for the (common?) case of redirect regardless of nv1, so maybe not.

Yes, my motivation for the notation I used is that I wanted to
make the specification of the cpreg structs in the common case
simple and not too long-winded. If offset 0 does ever get
allocated, we'll have to come back and revisit this. But
new entries clearly seem to be being allocated at the other
end of the table, so I think our chances are good...

> > +        if (s->nv2_mem_be) {
> > +            mop |= MO_BE;
> > +        }
>
> MO_BSWAP is host dependent -- needs
>
>      mop |= (s->nv2_mem_be ? MO_BE : MO_LE);

Fixed.

With those two fixes, can I have a reviewed-by? This is the
only patch without one, and all the fixes seem to me like
very minor things not worth sending out a full v2 for.

thanks
-- PMM

