Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A1773573B
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:49:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEIG-000303-Cf; Mon, 19 Jun 2023 08:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBEI7-0002xd-GX
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:47:31 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qBEI5-0004iR-Hj
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:47:30 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-51a2661614cso4679783a12.2
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 05:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687178848; x=1689770848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yO5HTCbV8+OhT/dG3GwV0vZHGfgvFl7yMSPshyeEcVI=;
 b=h+TbEd5v81sdQKqvumZqzf/8Crr4u61dU2XoiJn/NLKkLEEgkul3xLeo1bqqNwGvIS
 sUnmp9b5TT3Zb2oFd7aXsvnfxIgt0vDTpM+cIRHR6HtzZIhXLW2keozrX76UWJnLZBaB
 Wiv7P3ejEFACTeW7vb6vg6GbC8/VNcjXo/TXf2/rV9SeguodSb+scQ3H5fM13Nm96DJc
 DzGaxf+a9afkQSM1M9qJWkwmOccGIJg9Qkn2FZsfPIZ8/b2zRyXWvm2opOnnBXhauCH8
 nLg1RE30PRgruJTr3N7lxu73pc6iysSod9F7BYLuwGwf/v5SCSN3dNEOFvp3/H/xrzMV
 LBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687178848; x=1689770848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yO5HTCbV8+OhT/dG3GwV0vZHGfgvFl7yMSPshyeEcVI=;
 b=LfV84CGYtfqf/sbBvH/D74lRionHqm8qb85keURT4d61Bj1CCtzumd/WYQ622uSxXE
 /iJrGesZFENOMt/V9qJgLpXNdNuwQLm0pYBySfwYesoNMJqGGMuE+HVBwVPDIt60vP6e
 TVMjR1t0FZ6ZR68EamIdVxNL3rnBFXVh7sionBFVrpg1gpVBaQ8bEQCWuKGkigFYC9ax
 ZOojDSgD6qEFhQ4WtKl4ygnzUUULkYauGn+WObmO3xVhQRFtOxLdEW10xZub7ZkkYYZM
 DMW1NmKL53GC1blpXT6+T9PAPUjyO2rua0V3DBwPgi7Qr0GXNZ04MelGAeasq7aYv+C1
 ui/Q==
X-Gm-Message-State: AC+VfDw50GERu4kTP0QWhvU0CYRPGEb5+GYYLN+BFPKhZSly4V1P1g5z
 EBE5JOSygOrBWMmUIpw+8jSikIIIGpHU2hCZCsyUfw==
X-Google-Smtp-Source: ACHHUZ4etacxUUaJigeF9erT2eoCrUoeKqc2H4phd56m88h0vzlkUCBdACe8u7VXJh9Y24nZ6/ZfzS0+PDjP8d7POc0=
X-Received: by 2002:a50:ed0d:0:b0:51a:263f:8da1 with SMTP id
 j13-20020a50ed0d000000b0051a263f8da1mr5979230eds.5.1687178847797; Mon, 19 Jun
 2023 05:47:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230607023314.192439-1-wangyuquan1236@phytium.com.cn>
 <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
In-Reply-To: <20230607023314.192439-2-wangyuquan1236@phytium.com.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Jun 2023 13:47:16 +0100
Message-ID: <CAFEAcA-B6Pbc2KyTVP9hheGfEecfTbwu-zi7_9EmjJH5opbiYg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: rad@semihalf.com, pbonzini@redhat.com, marcin.juszkiewicz@linaro.org, 
 quic_llindhol@quicinc.com, chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 7 Jun 2023 at 03:34, Yuquan Wang <wangyuquan1236@phytium.com.cn> wrote:
>
> The current sbsa-ref cannot use EHCI controller which is only
> able to do 32-bit DMA, since sbsa-ref doesn't have RAM below 4GB.
> Hence, this uses system bus XHCI to provide a usb controller with
> 64-bit DMA capablity instead of EHCI.

"capability"

> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>

The change itself looks good. We could probably mention in
the commit message that existing firmware/kernel images
still work (with no USB support) with this change.

Is this the sort of change that we should increase the
machine-version-minor for ? The comment says "updated
when features are added that don't break fw compatibility"
and this sounds like one of those.

Leif, do you think we should bump the minor version here?

thanks
-- PMM

