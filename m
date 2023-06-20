Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE905736DEE
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 15:53:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBbme-0007S2-1B; Tue, 20 Jun 2023 09:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBbmb-0007RN-R0
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:52:33 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBbma-0003Z9-Aq
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 09:52:33 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-51a4088c4ebso4531719a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687269150; x=1689861150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/L6k17gpEI8D2h8BVhU/DBfxSXfsmLSiexMsP6WVg/0=;
 b=ZGtY9CySt4DtRMfzFBjsgxq104cF+hOvdgAK0EbP/H/rfqLnouMzpM+muXVHEqlH/P
 Oz24HDoga46sreGhkAR04n+Rzx63WlONX5eUi/r6EKijIS5qH0xRxCFTEDMKEU+QnEdk
 P8OCmWDGYYMoUoVySBjlbAgPjcnVw9yzuMDVv7tYSEpIkZZOQeJbMQ9Pci6LaKw0z9mQ
 gRFH4tGLeWWoTRkxFuVEdxvtc4HQGrdFATH8WwMHf8KvJmNX5WP429BwrBMf4qpRa7Es
 Tx04IBpCuLGqi7ToS14cg0dEMzkpS49c22uu6f1CFsBSV/DA94c1QHAreyLui+gGY4ZF
 wGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687269150; x=1689861150;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/L6k17gpEI8D2h8BVhU/DBfxSXfsmLSiexMsP6WVg/0=;
 b=ftwIjg5O5lV3JSVnqMH+UyKYt8fMpv0Op884M7/emmNpNqz3vX5P78/5A6r6PUbP+1
 EctsANRoegycENk+S6yk/et2dw1l8+ByffbW9f+hLSy1KKJOVIxjpAQenGbSvuZhmWVt
 3YdqQnHZHyxKAUPLHqTbojn2RNBpADT/eTOblLnRHBesld7hpNIAWoB3Gv1cPZnhtEYU
 Pr0z/P+ac1e4MMqSx28y10WvT5BYXPjFH0xjl+pos3ok1IYniF4Tf8MUrIzdBOLbWmsE
 gca+807i89Ke0R7ZmtAMZpHMdL6sOQOEu2UNYlAJp9lUZeG7wV9+rxyD3bm48bwsiYGi
 aIbw==
X-Gm-Message-State: AC+VfDyFznqDuX3lO+jougZHBUVfMfYPHZGXB0BsdhmaGbGG3VWTmH9P
 s00fqYKlydXGJRSRxHNbXnl89hV5pGnC644OL2Smfg==
X-Google-Smtp-Source: ACHHUZ5LvzPOg+1FksvjYQ3n2IaTxoL8fv38+aoPmD2oNcBIDa58qfm9R6my7rScxyBIOqfeYQyVJUA1RCxkqwo5Z5w=
X-Received: by 2002:a05:6402:481:b0:514:666b:1e04 with SMTP id
 k1-20020a056402048100b00514666b1e04mr7692584edv.35.1687269150511; Tue, 20 Jun
 2023 06:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230620124418.805717-1-richard.henderson@linaro.org>
 <20230620124418.805717-21-richard.henderson@linaro.org>
In-Reply-To: <20230620124418.805717-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2023 14:52:19 +0100
Message-ID: <CAFEAcA-MpN2kM3c4F=ihSEgetSQJVd0T9-BTUakTu=CAc+4HTQ@mail.gmail.com>
Subject: Re: [PATCH v5 20/20] target/arm: Add cpu properties for enabling
 FEAT_RME
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 20 Jun 2023 at 13:46, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add an x-rme cpu property to enable FEAT_RME.
> Add an x-l0gptsz property to set GPCCR_EL3.L0GPTSZ,
> for testing various possible configurations.

Looks OK to me, but I think we should document these
(including that they're experimental and future syntax for
enabling RME will change) in the "TCG VCPU Features"
section of docs/system/arm/cpu-features.rst.

We could mention in the commit message here why we're
making them experimental x- properties too.

thanks
-- PMM

