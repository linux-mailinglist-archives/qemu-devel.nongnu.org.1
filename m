Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 083BC7874AA
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:55:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZCg3-00047s-25; Thu, 24 Aug 2023 11:55:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCfp-0003dF-NE
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:55:07 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZCfn-0008CF-B0
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:55:05 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52a39a1c4d5so61292a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692892501; x=1693497301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xM76Dis0vR8jkC3H92UUsvM5/0nATYMHEYN5C/Cl5zE=;
 b=ujJRQLVt+JqWpRnacXiFIi1DJWWW1kwygTMIL+PCBhqWqMAfxFGSdrO7AUNd/GX5Xd
 PUyi/dqudrA2AenfyMruThTr3l41r/PyQRI4VwdNTDw5BBxKW/YZ3dpaxf2cIn+uWPHE
 QDj/yh1EhxTR6g3EgA31tbHWocPYe75bq/UKuty56BDKPhVQoG1nzGXLcnXdct91aaba
 oUlr2AzmxDStwiMrvqMxPMf+iQoyMOO1yvC6jn7Y9iaHVLC3cTdZ5g0F7DiogCzit7Ka
 xPGup2X2hcfCCl69AkWDwkyjpIAJdEnMPVygoJxawY7nHVTYdARmJEmIJE0q2UkB7Wah
 exgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692892501; x=1693497301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xM76Dis0vR8jkC3H92UUsvM5/0nATYMHEYN5C/Cl5zE=;
 b=SxsXWLF9AJEtmVWnyVbCDI2g5hCMhLW+kV2oh1tjJEtlMVUGgqg71m1s+27dFXR2jn
 dwFM+qAlzwr1H4pLWlZX0OFG6f60gp8d+X9k8lXsv0StsLyZ+5ZzoDA/opnpSd7Z6S4m
 q8sboQdghRY57oCa6IzddRFv/fcIUnx/cobEWy3DY1JrueRHP7Pg8jgzdQihtNdwTHEJ
 yS3DuRTgGL29/6j3TS1ZmCT5Ib806byjcpHH74jypurPyey7b0wf7c38YOjWiHuZpvNh
 ijghHh22W6SuPmH4QG8TL6HySt2Ko0VkMrCOPnBYL4herLAP9dmenwPRKYV1s6cNkhBe
 rOuw==
X-Gm-Message-State: AOJu0Yx8lNwNkxSZIyX1LMhNw3kBwNXJvZ1OqtW2USo937/j2OT0bbcJ
 7mOaOvbxe6WNzKdojoEpuJCznFrfASZ5PejgYLkfeQ==
X-Google-Smtp-Source: AGHT+IH0NSCi1Vy6GG9iZDiZhdFdiC4nOfDwuChqX/J1RP8ZlPLDW0DQF53T1ULwv37XYmdNT18NQWUwITzEIekcJvw=
X-Received: by 2002:a05:6402:31ee:b0:523:4acb:7f41 with SMTP id
 dy14-20020a05640231ee00b005234acb7f41mr11765904edb.14.1692892501413; Thu, 24
 Aug 2023 08:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230811214031.171020-1-richard.henderson@linaro.org>
 <20230811214031.171020-8-richard.henderson@linaro.org>
In-Reply-To: <20230811214031.171020-8-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 16:54:50 +0100
Message-ID: <CAFEAcA-cuHX1bzW+nD+NrxX42z-exNtM8Ge3SO3LDKsAWR2sFQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/11] target/arm: Apply access checks to neoverse-v1
 special registers
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, 11 Aug 2023 at 22:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There is only one additional EL1 register modeled, which
> also needs to use access_actlr_w.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

