Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF07E75F576
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 13:51:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNu5x-00086S-Dt; Mon, 24 Jul 2023 07:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNu5t-000867-P1
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:51:17 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNu5s-0007np-1d
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 07:51:17 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-521dc8ae899so6190397a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 04:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690199474; x=1690804274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iBEEU4QoK/ApdpPay41MZnt0KTdPMHmBuWLJQHqvqEk=;
 b=VBkB6d5TYD3kQNjt0T2i20DN6NaZQz4aoQ4I9lXndPYSEFi3V5jTr0xhiUFcgMaogc
 mzmTvmqs+MhqIXSjgwWAiyJ0dj4A3IO34AGRGuhQheQ12ON0KPjLtQ2uUuOQdZUOtprv
 oeclwbvUMOkr7FQtdU1EYm1NIDNvAK+JzgUjL9b/JN9HSp2L+nYKiyAko3Wg9CDStis6
 uF0FuXoLNhwiQVTD1knNGNlpCIPzDylQ1omwjzMrxcMU6ZwkvWQGQDJ3heGvg1tZLK86
 2ciMEuBbQF6t8hybE57diJsnwgcqB9EQBhXBn/LBthNvRvSCj2gs21YDCbYfurv8bvsZ
 16MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690199474; x=1690804274;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iBEEU4QoK/ApdpPay41MZnt0KTdPMHmBuWLJQHqvqEk=;
 b=K/8Qe4fibREpUZQuurADv8APxKp+3ekIX7NzfjcYr0ETJcfwhQX8/qoT1qdeXBhDRr
 yVInFDdDnqBbcynY9vkMTfdDMrcKY16kCgqJsDXvhXqy+67mcfmLdG+5iaEn9h0LMdAn
 EvWneV0VmV9M+sjNiPZer1APCOU6ra6ggQpOv8f3ZjJQg1lPJQhQeL0Ohviw2y4AzogP
 Y8td7E57uB0Vsz5wjkkQeMwiZuspcwr6wfOx/FCHCuUDnzr/885df6LK0ilqi1C5S7qv
 KrbcRBZfpAOd5OGChCDOa6l2xmIojrKIhZQYxP4cXgjdHZsjxHKUKIEiFW//kx3jWSRY
 qb/Q==
X-Gm-Message-State: ABy/qLaHPBI0BHkcIWGLrAQw9NwmaGBzF3ZwkjLCH9fKTyNFSTgDtH8w
 LktioINF0fvcXDKwZ2Mdv/SnX8FSJCdS8RNOK5/KmQ==
X-Google-Smtp-Source: APBJJlF5CyAqBAw2zAoyk1SEZcWjCO+fbzyGQBbUjyiKQrg3EfYKd10yeN20N/YbTPImul/5hvjn+XVY8D087VuUwko=
X-Received: by 2002:a05:6402:1382:b0:51e:5254:1d89 with SMTP id
 b2-20020a056402138200b0051e52541d89mr8587801edv.19.1690199474726; Mon, 24 Jul
 2023 04:51:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230722214422.118743-1-richard.henderson@linaro.org>
 <20230722214422.118743-4-richard.henderson@linaro.org>
In-Reply-To: <20230722214422.118743-4-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 12:51:04 +0100
Message-ID: <CAFEAcA8pHMx1bfsFWn1CfiPdHK013tU4mp3vA0TFFkh5TuKZXQ@mail.gmail.com>
Subject: Re: [PATCH for-8.2? v2 3/4] util/interval-tree: Introduce pc_parent
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sat, 22 Jul 2023 at 22:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  util/interval-tree.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

