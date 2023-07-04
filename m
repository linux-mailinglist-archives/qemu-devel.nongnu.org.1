Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3D87472FC
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:43:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgJS-0007gg-0R; Tue, 04 Jul 2023 09:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGgJQ-0007gR-Aj
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:43:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGgJO-00050Z-FI
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:43:24 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51d7e8dd118so7092923a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688478200; x=1691070200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g3WKTMbCl14QBI4gfWNbliS4G7A4xV+8OkuzTjE7ap8=;
 b=sh5Vs7PntejJsry0A4R2zQ4DT2EVIf7xWN8ismR08/RHQ1QkxRHkh75NM3Dca3BJxF
 xuXZ5EQhrd0rmb+Fb72PcpWuzEShCXeTZoCjxz6HuCiRD2XLRPL0Ece+wj79/WoARsMk
 Y22WVe7LnHlECDfY4nFtY4tjCGpi5dNqGZU93SoXL7Q/D/ZnHI2AsMTVR4xcqU7Ski5o
 H9SdNDe4NwxSaLOIfh7/9xWhKFu3jhgNSeNvoMxAMJUHQOs5kC7GK53US/gJmNlaZAa0
 7kYrQN/NTyONxHPiF0Uy/DhOxGo2GkrmmSiDowcJ9lk5iARth7yIxSj8sMau+bb7wWOP
 ASTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688478200; x=1691070200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g3WKTMbCl14QBI4gfWNbliS4G7A4xV+8OkuzTjE7ap8=;
 b=GRLR+AjPWyJ6B7YcMSdW+otR9iFY3EuGHYq8Y0snW/p1yWdIVXGGRMfCWWx65Zzrt8
 iOpklkDDt+clptbQKW/be7s661y65l9QFXUaRWEr83YlLd4pvTEFCSJt5GA0JMNwbt/t
 /4g/+ut9+Y5Tpplc8EzJFYYumzA7lvhjsTWloRnSeW8GWh9RDh+XNgQB11v8HlTCSOCc
 bu8ticIE9VFSaJQJI7+zZy/buDTm2e2MpnJF7EZVE27YBgNI1GH8zLRoG11Wz8H4sFPO
 gmzJFHUUMmcTSDL4CUHs1O7y4s+dnx4xJB1qzSZqK+sxF/ylUJa0GRZ482XWh3M1fADs
 ihig==
X-Gm-Message-State: ABy/qLbi5ZJyOgXI7dkN6poDGL+/JZrzmyZPjdIKvHbfPj9gqAOTzsur
 fVPkyMS3RN8Glh+zLPWKGW+X0BcOrAsgmsUrrRsVGS2B4f9VOc26
X-Google-Smtp-Source: APBJJlEcuLKTcNJ6WlGFZWIo0jTMJlh0p2VQSpCg8vaMmBhaHP8NtzF+wF7X13zsZGd0F/7QcAXBPrnc4xVfGh+hNjU=
X-Received: by 2002:a05:6402:b28:b0:51d:d5f2:121e with SMTP id
 bo8-20020a0564020b2800b0051dd5f2121emr10860178edb.5.1688478200125; Tue, 04
 Jul 2023 06:43:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
 <20230609172324.982888-9-aaron@os.amperecomputing.com>
In-Reply-To: <20230609172324.982888-9-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 14:43:09 +0100
Message-ID: <CAFEAcA_j+3VJ4Ldbo5zf8mJfXTfHC26x8a6YnMbQCRTy45_qAA@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] target/arm: Add CPU property for QARMA3, enable
 FPACCombined by default
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Vincent Dehors <vincent.dehors@smile.fr>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Fri, 9 Jun 2023 at 18:24, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>
> ---
>  target/arm/cpu.h   |  1 +
>  target/arm/cpu64.c | 48 +++++++++++++++++++++++++++++++---------------
>  2 files changed, 34 insertions(+), 15 deletions(-)

This patch also got RTH's reviewed-by tag in the "v3 from March"
version and didn't change subsequently:
https://lore.kernel.org/qemu-devel/20230322202541.1404058-9-aaron@os.amperecomputing.com/

So:
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

thanks
-- PMM

