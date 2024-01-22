Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 147BE836CCC
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 18:17:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRxug-0001uo-Jv; Mon, 22 Jan 2024 12:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxuX-0001sI-Au
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:16:37 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rRxuU-0008OJ-SC
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 12:16:37 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-55a179f5fa1so3770098a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 09:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705943793; x=1706548593; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qTYTAokmYn1QlxaW+DX1tM+T4jTh8+nH3A72Ydzb2cc=;
 b=Ejop6geCExNj04IMBtN9K3GguOoveiMGKdD46TTVhfYMBGKPbuq8ta1Q1Jh8W+cgSe
 hhvUy2okRgs6oQVLjN+v/PYiFVCJQdqMYTwkwSEt/SZgsh1G6iuNA8iI2cB/DeBjZdnt
 abmo6U6gPGGLJ03XpgaF2TkmfQwaatJ5Fycgm0b23CxshDOlR99miNZT8qBjf88+nW1R
 mCl1XLXe5gWtNnKNVKxKpbtFtMIPNrqTXWOfxxFtD8MzYgW8YkrCBJ22/KOyVRutwIdT
 II8OkTseNxsexmCGECnn1VDhrS8y6stK7QxqEnWM6xNgBnPaH7/a808CrCwdDjZWJucx
 3L1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705943793; x=1706548593;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qTYTAokmYn1QlxaW+DX1tM+T4jTh8+nH3A72Ydzb2cc=;
 b=Z1BzNhxJg/cXebLKFoGmPsRnYQm+KkNexWcB9Ly72dqMNR5ZCXj6MkffqFNM7B7D6m
 4S+Ng4uCFpNTxEjhtnkCI23tLpoPtTDNoGDtcMPZTzD/WrcG9gssW1AeZHKTyYa+Fp92
 oFYY9nEW05mNiLJoNf4moOXWtm9wYkXzmZQpgGShpEd1RBpA/BgiuzQTNEyMA9Bj8ecp
 eYR1P9T/9ZMiVUhB7vMWeS1nofWk2GiOwiICi04y1K+BOngzzpq9EpBStgcXyrY2i0z8
 Ue5Am87MJetgkkkCSmT2E/pgCiq0szZIxKylbtMq9jBVPaSaXVrlW3CngZsfMkyXzRtF
 xHoA==
X-Gm-Message-State: AOJu0YxF57kAkrw52yOcVXGNLWLXlep+XMdydWauOeNE4mR5wO1n9TCs
 IkmkqYbW6B4e9D8IbDzUQiUn2cUSN1werdTL7nq2zx1fo9/Egn36RGlY/TQjsuZzbwlaIJ+78eo
 sWFTlBz0gUmodzTEyHnpSOvo9a7xzVdSWX1vWFg==
X-Google-Smtp-Source: AGHT+IGnPykCduUnpC6bwx/bn6fVQ4ouCQ5OxE3s0WxhdZAu1OwUoGtWGdq2qe3i5aAl/EqX6yq/al8117c5FO+w0eo=
X-Received: by 2002:a05:6402:3507:b0:559:6c9e:96fe with SMTP id
 b7-20020a056402350700b005596c9e96femr138164edd.37.1705943792970; Mon, 22 Jan
 2024 09:16:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHP40m=_7zOT5bnp1FR12ohVbm-miUorh6+rrk2Rwd1jArR1VA@mail.gmail.com>
In-Reply-To: <CAHP40m=_7zOT5bnp1FR12ohVbm-miUorh6+rrk2Rwd1jArR1VA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jan 2024 17:16:22 +0000
Message-ID: <CAFEAcA_ZyphRxH59VHEpnS_8D4YuBFSZeODwRbMjrqhkggD-Cw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] Exclude TPM ioctls definitions for the GNU/Hurd
To: Manolo de Medici <manolodemedici@gmail.com>
Cc: qemu-devel@nongnu.org, bug-hurd@gnu.org, 
 Stefan Berger <stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 18 Jan 2024 at 16:04, Manolo de Medici <manolodemedici@gmail.com> wrote:
>
> The Hurd currently doesn't have any TPM driver, compilation fails
> for missing symbols unless these are left undefined.
>
> Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
> ---
>  backends/tpm/tpm_ioctl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/backends/tpm/tpm_ioctl.h b/backends/tpm/tpm_ioctl.h
> index 1933ab6855..c721bf8847 100644
> --- a/backends/tpm/tpm_ioctl.h
> +++ b/backends/tpm/tpm_ioctl.h
> @@ -274,7 +274,7 @@ typedef struct ptm_lockstorage ptm_lockstorage;
>  #define PTM_CAP_SEND_COMMAND_HEADER (1 << 15)
>  #define PTM_CAP_LOCK_STORAGE       (1 << 16)
>
> -#ifndef _WIN32
> +#if !defined(_WIN32) && !defined(__GNU__)
>  enum {
>      PTM_GET_CAPABILITY     = _IOR('P', 0, ptm_cap),
>      PTM_INIT               = _IOWR('P', 1, ptm_init),
> --
> 2.43.0

This looks plausible as a change, but looking at the history
of the file in git it seems like this is a file we import
from a third-party swtpm project.

Stefan: should we get this change made in the swtpm project
too? Or have we diverged from that copy of the header?
If the latter, then the simple thing would be to delete
this enum entirely, because as far as I can see we don't
use any of the values in QEMU, so we can avoid the
portability problem that way.

thanks
-- PMM

