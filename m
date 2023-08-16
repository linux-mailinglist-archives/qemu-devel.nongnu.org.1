Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8279177E5C6
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:59:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWIuO-0000G6-HM; Wed, 16 Aug 2023 11:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWIuM-0000Fn-Up
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:58:06 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qWIuK-00087Q-I1
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:58:06 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5236a9788a7so9136298a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 08:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692201482; x=1692806282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/onBnGYWBpEvODTn9KuA2kXebr8dIIB15hSCLZRnzaI=;
 b=hwMaNVR6+tXkcksd4YyMjmKvA5KJklZXXgpA+MzcgYLuy4H1/SKd6AZmbLfpeXE/W2
 wG+MBV3EKXW5cwBv1UaIveaDg3QGZviJmVFbyVXkunq0+jNFTzP3wIRzvluHMPclN/lR
 HXhcQvNhsLwNK2wy+6n2oOs6znHbWvs/fUj++v6NveAva5j4/rz/cbu/4MCK+l7b0YKm
 mhqn1lTBoxs1PAaFBOzTgUVBIn5MeP/mDN9PaRbDpSKyTHO4WJFLT/gcNj2RCA1fDdtX
 To4+gQCWIcQPQlculDRgoLF59OQt609wduJUGYOm4NhmNZnZHXTqJwhR4njhyi+ENbId
 V5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692201482; x=1692806282;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/onBnGYWBpEvODTn9KuA2kXebr8dIIB15hSCLZRnzaI=;
 b=bfQcDVYOPdTJSjl+ZwuUhKZjnPiJgV8xk5cUwXlR5Wgjkg5ALW/+7je2SiFg1tT1Ua
 c3U1LtFJUeDQTUm+sFY8/R210QtsUV720o+aYVKZPTQQKD2KWXNxyrt5wjpB6C0Sc3Jl
 ygpPixpVaEjXfdmN0HGhtx3mvXuZZJ3Wi6KyMG/WkQPUPTHWXtpVPz0vgZUzqFncDaBp
 07idDR6JYbInpAtuU1xSnSaMeg9I9hjg81+gT7SvMjcnHXF9wsYTVCP0WGvW6qz8VNLQ
 bBMMOyF56iGNcgnbS733i/uOveKRqQyoT5paNV/XiQBej0Pkp8afcmCCK9CkJV5NJkHV
 7nyA==
X-Gm-Message-State: AOJu0Yyr7CBC7lEwBcEFF6cfk1St+UdiPHquDQ6q35EIFht6k6k2iEQZ
 MlcxzSMyCuMlbs9cafIoLwPFmwvGZfUD4AmQyIgxyQ==
X-Google-Smtp-Source: AGHT+IG38BPl1vb8S8Lq8+Rwi2BJXANb+zIZrMaPpjwPD1xizN1Zh7wfdibjmglLfiQwkloe+nBbCH7vWVXV/Emeckw=
X-Received: by 2002:a05:6402:2050:b0:525:70b3:72c2 with SMTP id
 bc16-20020a056402205000b0052570b372c2mr2233858edb.14.1692201482349; Wed, 16
 Aug 2023 08:58:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230816091522.1292029-1-thuth@redhat.com>
In-Reply-To: <20230816091522.1292029-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 Aug 2023 16:57:51 +0100
Message-ID: <CAFEAcA8xna5-ewGMUjoVjJTsFKVeBbOPXJj481+GEC=ZzqgVug@mail.gmail.com>
Subject: Re: [PATCH] subprojects/berkeley-testfloat-3: Update to fix a problem
 with compiler warnings
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Olaf Hering <olaf@aepfle.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 16 Aug 2023 at 10:16, Thomas Huth <thuth@redhat.com> wrote:
>
> Update the berkeley-testfloat-3 wrap to include a patch provided by
> Olaf Hering. This fixes a problem with "control reaches end of non-void
> function [-Werror=return-type]" compiler warning/errors that are now
> enabled by default in certain versions of GCC.
>
> Reported-by: Olaf Hering <olaf@aepfle.de>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  subprojects/berkeley-testfloat-3.wrap | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This seems like a reasonable place to ask: should we just pull
in the testfloat and softfloat repos to be part of the main
qemu repo? AIUI we've definitively forked both of these, so
we don't care about trying to make it easy to resync with
upstream. Having them in separate git repos seems to have some
clear disadvantages:
 * it's harder to update them
 * changes to them can end up skipping the usual code
   review process, because it's a different patch flow
   to the normal one
 * we get extra meson subproject infrastructure to deal with

Are there any reasons to keep them separate ?

thanks
-- PMM

