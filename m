Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0215B7E6C89
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:40:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16C8-0006ac-Vo; Thu, 09 Nov 2023 09:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16C6-0006Zm-H2
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:39:42 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r16C4-0007a4-HE
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 09:39:42 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-54394328f65so1467271a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 06:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699540779; x=1700145579; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msdVLAIhlH+1RsLafz3R2lsBbz1GRyTbWGmT21yH9cY=;
 b=ucT02uUt4dnQjyHnqQjPuKqbL6dvqZF+F/FbocSA8JQJv33J5++GwezHqr5W++Vebc
 oycp4u6R6EJFIyO9dY0EEanIGTzwG0tdodPPY5q8M4AxgELkwATcO8JQwY1MjEURKEqn
 6X+aJno/16FnH1A0LD/Q1UJeCJgpuN7B27Qhm+Nu5vyGbX6kw53Xeg3Ze0hqR+cprCEy
 lfBe1+WNhvWWSK97lZ3Yq4r+QtbdIcCZLhDf/2Dh8d3OyToWhoEqd9vbetbiLHFuKSMB
 /Vs+cPcK5zB53D6oXfML5eO4dBcoLb0qWxpKvu4xoe3H6yaZcmEzLpYANngo8GXHqqv7
 wsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699540779; x=1700145579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=msdVLAIhlH+1RsLafz3R2lsBbz1GRyTbWGmT21yH9cY=;
 b=j1AY+3mP3T37KjoD1cRxJZFLCdgaRal2aQPXJYgzDLy2YFth8cc1tOs+c8gH5s5ovU
 Co3eklHw3cZoKtvH8zPk5QWL5l8n63efDHPb8B7fdml2+PE6axOt6uP9nDazOldP4kZR
 OA3HEJBrAus3OErFsgmG0Eoe6R9eZsyqPiJ9R1ByySM9g+9fmsvuE6LdfBsAuPrg+wYx
 83WjZaa5qHn8UfvDhWJY3+pJSNSrJ68EGs43QmuU7QG6BD5zvjAgDkDv3pxJ7cdWfJJG
 pNaOweIV4JjCmagVtoK4ahUGwVRWXGIba8U4Ac1VgX8hVA2TwOTQ7xF39RdeYfeBdxE+
 IiRg==
X-Gm-Message-State: AOJu0Yzd/040A52B/cV8gk1bVkwQX1BcgneygYxn3kjCZcH4LtGXfB3S
 Sn4sNBQOtWP7+XNwylu0AsvtXvK4MSIPGCXREOmzI3FOuXiibpaH
X-Google-Smtp-Source: AGHT+IHNgK5uZaT6C8Tj2i1pHSkFzZc2mU1qKRfmio5nRVOJvEsqPSLFD8uOdH1nX8mNtfp17Y1mFnjgIlVhvOhkzHY=
X-Received: by 2002:a50:9310:0:b0:53f:8493:5b0b with SMTP id
 m16-20020a509310000000b0053f84935b0bmr3829015eda.35.1699540778936; Thu, 09
 Nov 2023 06:39:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699351720.git.mst@redhat.com>
 <25a52959f99d6860a186175bda898e3bdb605f91.1699351720.git.mst@redhat.com>
In-Reply-To: <25a52959f99d6860a186175bda898e3bdb605f91.1699351720.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 14:39:28 +0000
Message-ID: <CAFEAcA8Hed0Av2PCZBmwkO8mj+qzSsZqt10funKOyXTmo7gu4g@mail.gmail.com>
Subject: Re: [PULL 57/63] hw/cxl: Add support for device sanitation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 7 Nov 2023 at 10:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Davidlohr Bueso <dave@stgolabs.net>
>
> Make use of the background operations through the sanitize command, per C=
XL
> 3.0 specs. Traditionally run times can be rather long, depending on the
> size of the media.
>
> Estimate times based on:
>          https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
>

Hi; Coverity points out dead code in this function (CID 1523905):

> +/*
> + * CXL 3.0 spec section 8.2.9.8.5.1 - Sanitize.
> + *
> + * Once the Sanitize command has started successfully, the device shall =
be
> + * placed in the media disabled state. If the command fails or is interr=
upted
> + * by a reset or power failure, it shall remain in the media disabled st=
ate
> + * until a successful Sanitize command has been completed. During this s=
tate:
> + *
> + * 1. Memory writes to the device will have no effect, and all memory re=
ads
> + * will return random values (no user data returned, even for locations =
that
> + * the failed Sanitize operation didn=E2=80=99t sanitize yet).
> + *
> + * 2. Mailbox commands shall still be processed in the disabled state, e=
xcept
> + * that commands that access Sanitized areas shall fail with the Media D=
isabled
> + * error code.
> + */
> +static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLCCI *cci)
> +{
> +    CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> +    uint64_t total_mem; /* in Mb */
> +    int secs;
> +
> +    total_mem =3D (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_si=
ze) >> 20;
> +    if (total_mem <=3D 512) {
> +        secs =3D 4;
> +    } else if (total_mem <=3D 1024) {
> +        secs =3D 8;
> +    } else if (total_mem <=3D 2 * 1024) {
> +        secs =3D 15;
> +    } else if (total_mem <=3D 4 * 1024) {
> +        secs =3D 30;
> +    } else if (total_mem <=3D 8 * 1024) {
> +        secs =3D 60;
> +    } else if (total_mem <=3D 16 * 1024) {
> +        secs =3D 2 * 60;
> +    } else if (total_mem <=3D 32 * 1024) {
> +        secs =3D 4 * 60;
> +    } else if (total_mem <=3D 64 * 1024) {
> +        secs =3D 8 * 60;
> +    } else if (total_mem <=3D 128 * 1024) {
> +        secs =3D 15 * 60;
> +    } else if (total_mem <=3D 256 * 1024) {
> +        secs =3D 30 * 60;
> +    } else if (total_mem <=3D 512 * 1024) {
> +        secs =3D 60 * 60;
> +    } else if (total_mem <=3D 1024 * 1024) {
> +        secs =3D 120 * 60;
> +    } else {
> +        secs =3D 240 * 60; /* max 4 hrs */
> +    }

Here we have an exhaustive if ladder that sets 'secs'. None
of the values we might end up with are less than 4.

> +
> +    /* EBUSY other bg cmds as of now */
> +    cci->bg.runtime =3D secs * 1000UL;
> +    *len_out =3D 0;
> +
> +    cxl_dev_disable_media(&ct3d->cxl_dstate);
> +
> +    if (secs > 2) {
> +        /* sanitize when done */
> +        return CXL_MBOX_BG_STARTED;
> +    } else {

...but here we have an else clause for when secs <=3D 2,
which can never happen.

> +        __do_sanitization(ct3d);
> +        cxl_dev_enable_media(&ct3d->cxl_dstate);
> +
> +        return CXL_MBOX_SUCCESS;
> +    }

What was the intention here ?

> +}

thanks
-- PMM

