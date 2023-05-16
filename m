Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9027049FE
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:05:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrYb-0002ax-99; Tue, 16 May 2023 06:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrYZ-0002aO-Fw
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:05:23 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pyrYX-0003oc-Tx
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:05:23 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-50b383222f7so20350035a12.3
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684231520; x=1686823520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QzxgDcYwQp88v2YbsYtCLeF15hP9kQIN6nEJJnHCTe4=;
 b=x1t9D3vlq9I+g4TfXU6j2z6h/droLBDqntcLRGTmnxobM4tz/IuqjeH3bq9jAWid5r
 uUEFRsU2ECymnl2jQ9zILm9TOkrMaUNIvtf0UPeKsTYgoJ86A7CPaxywkNQTvfGVFC0f
 /bhGzdskK59rA+2nUHmAHu+CIVcKZ/A2RRhsqTEHfkS+nn0yK2/E8LtF3K0Or1hIB4DF
 IEAbC/UB5CXyTHpOeIExK9c2QBxA3bNPjSYjIdC/iOQqeC0S3juI/+fBCy13e3tkcIHZ
 qWVP0HZWHsCHfyjvqaR8V39dnogheDTFDOf7TU9cqhjO9z524scB5O4mQLVo0hS4ZjPN
 NVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684231520; x=1686823520;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QzxgDcYwQp88v2YbsYtCLeF15hP9kQIN6nEJJnHCTe4=;
 b=fOfXcbbalQn3YBgsQ2Hf7oB2HkWVBWCUaW+pdPEXCQ7SDsaJFWjVtS2h5zt26hC3wE
 h9K7FW0wYqKgfRlM+0+UnzR7vo3EhWYoTv7cRuH9fwsgCSSxgdcUFud1DAqH1b1Vf4lk
 U60fv+obcCWiSdsxbI+HVmVGAF/DNlyRIXtq48RAHPuRqc9u5DbLLYJZojxCyLdFdxeI
 1/h7Cj2dS3trPFzIdB3ie6lSqjlSMsrrMIS5V68eSonXZVh9o6w069HWRTutrHfNBZkM
 ehvNC8boBC6nFCpVLl40KbaKNSoOzIULdRj/GpH6K7ElNnqFfJcNIYprHH/B+wPXsKnv
 VcDQ==
X-Gm-Message-State: AC+VfDx2KFHgkJ0cY5Jn0wPazWxcpkLXwFKGvbZDXa/6TYiZNtA0XAPA
 8O5X3hRrnvcHSkjHOxn9JngvNm+dQM2T2Axo2Lyd7A==
X-Google-Smtp-Source: ACHHUZ7WnPKLnUV64qqXmyWVy15/mhO3M5ubjBFeoo2zj4a7igsUe+leNrPdUHhwZ6N9npp3GBGHsNsjWMxSWNpk6u4=
X-Received: by 2002:a05:6402:352:b0:50b:c804:46c2 with SMTP id
 r18-20020a056402035200b0050bc80446c2mr28656087edw.23.1684231520096; Tue, 16
 May 2023 03:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230515143313.734053-1-richard.henderson@linaro.org>
 <20230515143313.734053-38-richard.henderson@linaro.org>
In-Reply-To: <20230515143313.734053-38-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 May 2023 11:05:09 +0100
Message-ID: <CAFEAcA-oFi3Mq6V77PAksyeNfvT5erj_Vwsu6a1xCrLcxei+Fw@mail.gmail.com>
Subject: Re: [PATCH v5 37/54] tcg: Merge tcg_out_helper_load_regs into caller
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Mon, 15 May 2023 at 15:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Now that tcg_out_helper_load_regs is not recursive, we can
> merge it into its only caller, tcg_out_helper_load_slots.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

