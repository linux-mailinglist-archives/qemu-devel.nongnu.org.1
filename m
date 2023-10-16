Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDF97CAF56
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 18:32:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsQV0-0004Gz-Dy; Mon, 16 Oct 2023 12:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQUv-0004Fz-K4
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:31:20 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qsQUu-0001RR-21
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 12:31:17 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-53df747cfe5so8454426a12.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 09:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697473875; x=1698078675; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UDbIkGIte7+LhCbpOIpk2uv96+Iwg/JEeOro0vOBeXw=;
 b=vspPJqDEtzK5fvh/PKMa1skGt+c+4mtk0/NY17Q18GHBFDiHgBzN20sSFSqT9otDAD
 k1VBHx1/gSsUjm6XMYkb4+qU4TyInFacSJL33QuZssEWQiYCyH2zmPgqxo295Cszl0W4
 6VwYDlyPuHmBLqHOIQfbKALUA623iSwBRlLemDPSP/tMI8HPxOe9IVWgWnNjULj0wAx9
 8spr1xv2bevlPqbe1FF3Y6zjM7fx7xR91U28LNEEogPbygZaGb0OfPvkXT2mPUQrdfsZ
 +G8Ua8TlAd7bWRrg60p1eaVIIKqbbhj14oG3ohyMNM6r4l/ncvmBTF59UTc5c0RUu+zu
 b3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697473875; x=1698078675;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UDbIkGIte7+LhCbpOIpk2uv96+Iwg/JEeOro0vOBeXw=;
 b=HXpKF2U2kSIUsAQY/36JtBj34Jk4KzDxAE2r5wffh4UxoDjmnZqBwukEEQZ/OJfK4M
 yIX/Sh/vTIQ9LVv7ksIbtov9QOHw6RJnnkmkktHGLHzcEUe4dVqPrFXvmxDgycokbFCX
 8A9Lp6hX3KEwWuPl3+D9ibSwx8VmIC74tKQARmcQZlec1Kfr41TXwTlFcMjjuAq7sVPk
 pgsJMZLc0TjEOPsvVyv2SrPADWUjci9IlM+W82THVnNTHdEKTagMFZutk1Ig5AZbBldL
 6SCHv+BFPEBVwWJRSjXb4jS3mX6g94jy9TiX2DnS1X3YR6WSrmmabRm3n37CHaEKy9R/
 8xvA==
X-Gm-Message-State: AOJu0YwCL7EHMyaljkbWhyrMZM2hOGjL+Eh4UKxn3wu/on6ZwPB5e6aK
 x21VBLXDpFEAlkppPbrHd4zkk3PHlsjRcY0slq2JB9qcZxTccAcR
X-Google-Smtp-Source: AGHT+IEjnd7gVSycNfYfPh1r4mj8tC2mieb1tiDU29nTSrTFm/meHI9LfuEoQHiVTBrcpu6BQApJKjRRF1zCJS+Cuq0=
X-Received: by 2002:a05:6402:5008:b0:53d:ef29:19e8 with SMTP id
 p8-20020a056402500800b0053def2919e8mr13245468eda.12.1697473874862; Mon, 16
 Oct 2023 09:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231004055339.323833-1-tong.ho@amd.com>
In-Reply-To: <20231004055339.323833-1-tong.ho@amd.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Oct 2023 17:31:04 +0100
Message-ID: <CAFEAcA8-6f7f3Ai3uahz9F06rZC1Ad-OrQGTsWo5H0oLNiXKTg@mail.gmail.com>
Subject: Re: [PATCH] xlnx-versal-efuse: hw/nvram: Remove deprecated device
 reset
To: Tong Ho <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, alistair@alistair23.me, 
 edgar.iglesias@gmail.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Wed, 4 Oct 2023 at 06:53, Tong Ho <tong.ho@amd.com> wrote:
>
> This change implements the ResettableClass interface for the device.
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---
>  hw/nvram/xlnx-versal-efuse-ctrl.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)



Applied to target-arm.next, thanks.

-- PMM

