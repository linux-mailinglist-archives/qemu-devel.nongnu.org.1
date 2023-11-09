Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE307E6E36
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 17:06:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r17WT-0007nP-8r; Thu, 09 Nov 2023 11:04:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r17WF-0007iK-B6
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:04:36 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r17WB-0001Xz-AW
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 11:04:33 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5441ba3e53cso1605598a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 08:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699545870; x=1700150670; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wSAaFIMjbOUvTUCnLK9sawHNvp9MFTD1AlmSfBsbXN4=;
 b=mOz56uAUGlc+vSok9OIyUzmv4JFDaFbkPar6rbcAyr/bmSeMXf5OWpyU2Lfw8YbbjD
 djYNpbK0b8RI8a/rWvZV9SrriqwuKn74R1AiahrYkOWh3lNBgXH/3OHZdYT7rZ6stcIi
 Cg+us1cCUKGfVnODErjT5l84Rp+LWicRA3dIT6Kia6ceUvvIY9l3llBYEfb/jAJwJuUG
 VyRrzc1lQj1RWckJ15I/IX7SRs3nulCz1aojfGBsTS+kIf6CmKJ4guY/ZoCQJnkAF4yh
 YLG5NJ22zQ2y3Wsjda9aF5sIUB+3SKisnux6rG9AkseJcBNeHew5yTZw4A4zwvVenmp9
 DQbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699545870; x=1700150670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wSAaFIMjbOUvTUCnLK9sawHNvp9MFTD1AlmSfBsbXN4=;
 b=QG/yCatYcL+1vDirSKyb8eDRREDMP52IDqccN5Bj7DD2GuXXjOjR2zDJUUuGW+3ryK
 xQdOjLeg/MbUnWDIicEHHv+Eu2wU35BHHPU7dCblHOQzSFzVlLnwwPB5qrilyq2kKO3T
 kgfW6tKuYqUSCCKkTG6FQlQxny5ZE/zKGuXgIkpnlxrgW/MZN6PpfU207O6k12wBjt23
 EOfLzcdriTiQnQ+9YKQipRvCzJsGEM5lPfmZpIXIAoReiU0lFDNvhbbDD2ZltAOnPsCw
 WFcwcwLPeL4hrDnsu65B9PPUsarXdoXp2gAxNtZJtoK5F5c8hYuMnpZBL68s4KQbzSAM
 EYOQ==
X-Gm-Message-State: AOJu0YzYzXwx0vlDw05ZhwNYlWIbabf++TYyI1pUDrrMLYzQSj67bwAR
 PwfVDzpqd+f+S3nUAd1B0cyYWJjyTSSxv5DfMiKnQQ==
X-Google-Smtp-Source: AGHT+IH91DbfT5A1++uWQudUX5J7BBSI6b3R6xnaRanCdVuJCpMkLk4MvNet2Fcb+7qsAoDuJOcpeYvli6nDyIDZP9w=
X-Received: by 2002:a50:d7dc:0:b0:53f:f908:eda8 with SMTP id
 m28-20020a50d7dc000000b0053ff908eda8mr4372874edj.4.1699545869428; Thu, 09 Nov
 2023 08:04:29 -0800 (PST)
MIME-Version: 1.0
References: <1c312ba88e0928527dad6bc2e1b73d8cfe4b7f48.camel@infradead.org>
In-Reply-To: <1c312ba88e0928527dad6bc2e1b73d8cfe4b7f48.camel@infradead.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Nov 2023 16:04:17 +0000
Message-ID: <CAFEAcA9oyF1scfpmz-7wYX5j=nGgdG-7uD3nXw3dqhoMi8MHzg@mail.gmail.com>
Subject: Re: [PATCH] hw/xen: clean up xen_block_find_free_vdev() to avoid
 Coverity false positive
To: David Woodhouse <dwmw2@infradead.org>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Thu, 9 Nov 2023 at 15:30, David Woodhouse <dwmw2@infradead.org> wrote:
>
> From: David Woodhouse <dwmw@amazon.co.uk>
>
> Coverity couldn't see that nr_existing was always going to be zero when
> qemu_xen_xs_directory() returned NULL in the ENOENT case (CID 1523906).
>
> Perhaps more to the point, neither could Peter at first glance. Improve
> the code to hopefully make it clearer to Coverity and human reviewers
> alike.
>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>  hw/block/xen-block.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
> index 6d64ede94f..aed1d5c330 100644
> --- a/hw/block/xen-block.c
> +++ b/hw/block/xen-block.c
> @@ -91,9 +91,27 @@ static bool xen_block_find_free_vdev(XenBlockDevice *blockdev, Error **errp)
>
>      existing_frontends = qemu_xen_xs_directory(xenbus->xsh, XBT_NULL, fe_path,
>                                                 &nr_existing);
> -    if (!existing_frontends && errno != ENOENT) {
> -        error_setg_errno(errp, errno, "cannot read %s", fe_path);
> -        return false;
> +    if (!existing_frontends) {
> +        if (errno == ENOENT) {
> +            /*
> +             * If the frontend directory doesn't exist because there are
> +             * no existing vbd devices, that's fine. Just ensure that we
> +             * don't dereference the NULL existing_frontends pointer, by
> +             * checking that nr_existing is zero so the loop below is not
> +             * entered.
> +             *
> +             * In fact this is redundant since nr_existing is initialized
> +             * to zero, but setting it again here makes it abundantly clear
> +             * to Coverity, and to the human reader who doesn't know the
> +             * semantics of qemu_xen_xs_directory() off the top of their
> +             * head.
> +             */
> +            nr_existing = 0;

You could alternatively assert(nr_existing == 0); here, but I
don't feel strongly about that.

> +        } else {
> +            /* All other errors accessing the frontend directory are fatal. */
> +            error_setg_errno(errp, errno, "cannot read %s", fe_path);
> +            return false;
> +        }
>      }
>
>      memset(used_devs, 0, sizeof(used_devs));
> --
> 2.34.1

thanks
-- PMM

