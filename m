Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1001278CA05
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:57:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb21v-0006MA-MD; Tue, 29 Aug 2023 12:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb21t-0006Lf-D7
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:57:25 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qb21l-0003rd-RA
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:57:20 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-529fb04a234so6142892a12.3
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693328235; x=1693933035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4PEQ8prfuj7Vs3t5T/c11K4GJ6QoPwJ/2hzh3sdovP4=;
 b=pnCkioc6m3fWFKoGEoMcai8oIoAJ1W4wFf/lEAJrmVE+qRL6NGgbtSlQiMJFalvVND
 0z3AxbuAQmbe+QtQEQj2GuPTC0bK+jfXgEoUzbJTvy7lzKUq+o7uYmw1XYY6E06HC22P
 9sBiryW7pQnXuqWLXyZz73a2Y98eApvcV3bY/PVSiMLq6QwfmGaQT/BK2fUMQ54bSRiC
 KqlZSQrhyazR3go9bw6IL0Ik/Mbr5OagGBsJ7E5ofpDBlFCqULdZuJGtPcH2Spgb7DFz
 I85UD2bRzkyaCcaIrTD6lSlx9LcngNHt5czS5Kr45AlwJzFuSaGuG6ncdYHZykXd+96d
 8VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693328235; x=1693933035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4PEQ8prfuj7Vs3t5T/c11K4GJ6QoPwJ/2hzh3sdovP4=;
 b=Ls6+TX7vzbM+h/+nUIE7dXVWck4gOkXR4vw/MvtRMziSCrglM47aEA90YD7o7fq+kf
 84Ntommy4AsD+NKPc/PQaJg3LSw5Kw03Zy9GB6awFsLQtXzNh2BCL/aR2vGvBfPZEvbJ
 mxMITMD8aj5mM1We/A3s+EE8LvZgPMXBlxJQpNMeS584XY92lGDmlGEuybDiT6xXJjrd
 6O1oCPYxQVN+js+VB8SWUGVeG9IbOJExH11VzNSg62UJNNTU39YUt0UoMh1sBZZKAcVf
 t6Q2ekM3+jDOC0TW193rPz7djK31Bdui0ZVK8U/Lj7/9dSTsuQU/PCVGGt6KoaBxJ94K
 U8AQ==
X-Gm-Message-State: AOJu0YyOKe8wGwgj6F2Ex2BvnbblKP+xM01+ugPs/yGX9ktcixTxPoKt
 tmfyOmFHTAOr/lL6tJIrbZeq6ak1aQC+V6ZwsGAkXw==
X-Google-Smtp-Source: AGHT+IFtPnTmfHZBXye7ZGqymx4HYSWKAkixquW4lQU7+MoC74xohhhEE6I8eLW4QvxnRG6WZMGIrWF7cNq8tF8693M=
X-Received: by 2002:a05:6402:1610:b0:525:70b3:72c2 with SMTP id
 f16-20020a056402161000b0052570b372c2mr23203700edv.14.1693328235181; Tue, 29
 Aug 2023 09:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230829082931.67601-1-pbonzini@redhat.com>
 <20230829082931.67601-11-pbonzini@redhat.com>
In-Reply-To: <20230829082931.67601-11-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Aug 2023 17:57:04 +0100
Message-ID: <CAFEAcA-+BGMNhztB8gUKSk+Sb74MWOnNBmTSUT-aJ5x8Efvi7w@mail.gmail.com>
Subject: Re: [PATCH 10/10] configure: move --enable-debug-tcg to meson
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Tue, 29 Aug 2023 at 09:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure                     | 11 +----------
>  meson.build                   |  3 ++-
>  meson_options.txt             |  2 ++
>  scripts/meson-buildoptions.sh |  3 +++
>  4 files changed, 8 insertions(+), 11 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

