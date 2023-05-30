Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2AD7162E7
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 16:02:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zup-000587-VY; Tue, 30 May 2023 10:01:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zum-00053R-3z
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:01:32 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zuk-0003wZ-Kg
 for qemu-devel@nongnu.org; Tue, 30 May 2023 10:01:31 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5147f4bbfdaso5803709a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685455288; x=1688047288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DHVH2pXxxsms3rIR28hUmggnaPwb/mZUwkYDH+pklI4=;
 b=dYDhBTDgaeaWGxmnXG7SKabppwbbuBZBaHUpVZ35qrv/RbXr1FNNyY22E3Lg+xzJWY
 tyxdpubEu8IJmSiTNxkBu3mB97I2HtDIX5NGjfjjpPKGRvCQ/4pxaLuW4+rUyjxauH11
 Zacqi+GLMYUcd5oJIORC2s6laH16rr6NyrJKJZw6sVXT2ukGIXVsiGUiSE8imApLHgli
 0fB0BaATG//EbkJFhKH9F5ICusrxsVqlBG+CkVnlTvX5bnTXozpMian4eZRFu6N0o5z0
 apTqkClJfElealOfFfJp/WiPM5KQfc0p/gF9/HvFHDhbU/l4jAo/cDccTyqT/pXSk/hR
 nkdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685455288; x=1688047288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DHVH2pXxxsms3rIR28hUmggnaPwb/mZUwkYDH+pklI4=;
 b=dJabjLXPUNFcy259+tgr7yAm+EnmI9EMP4NHd7YFsXOK88cYsiGWA9JXhIPEhLnHFR
 dDepln/O+9s2YOtqbJEQzFDsEza21abIUNXkE7PsXmN/WoVEaY8+yLINm/l3cpMZHekT
 vyobeqh0AhNwNKL37vUEDaYcqHXzq/c0XhoOb3sap3g231Cli4m/wEdclncJ+aEByrJA
 9L4RnZ8cbYyop3aXMgyOuH+Qw7gdGh4Hmj3TbS1wzbnD+1zGe7rqk3yDJAvT3tDtYfup
 hPaSLGbLNIHJI+8B17utyAcZvLc4YZ/0eiPUXB6rztIcv+36MdYnu2Jyr41I31uv+qKf
 yOxg==
X-Gm-Message-State: AC+VfDz16nxZlulNDuo820GdmQQ/QHPVOXmscFENDxdbZ4pMK5PDpZNO
 RgWLTmPilbttZOArQVvL7U7KxuCeYYNyPelYLA9UrXz7ismTUTqA
X-Google-Smtp-Source: ACHHUZ51+xjQBMAfNlnD754s85+DeTgneWourhLwF4bruq7W1NvYO2KeSrSXv1ZuksqwUxyqP/ykmHyubqxwwJTufNc=
X-Received: by 2002:aa7:d387:0:b0:510:487a:ca3d with SMTP id
 x7-20020aa7d387000000b00510487aca3dmr1964426edq.23.1685455288429; Tue, 30 May
 2023 07:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230526002334.1760495-1-richard.henderson@linaro.org>
 <20230526002334.1760495-15-richard.henderson@linaro.org>
In-Reply-To: <20230526002334.1760495-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 May 2023 15:01:17 +0100
Message-ID: <CAFEAcA_QP0Df7m7ZnLNV+EB06rcAsvEZH+ynvS-3gMB0DhithA@mail.gmail.com>
Subject: Re: [PATCH v4 14/16] accel/tcg: Add x86_64
 load_atom_extract_al16_or_al8
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Fri, 26 May 2023 at 01:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  .../x86_64/host/load-extract-al16-al8.h       | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 host/include/x86_64/host/load-extract-al16-al8.h

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

