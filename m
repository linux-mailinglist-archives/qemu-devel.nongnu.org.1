Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B8C7E9CD7
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 14:15:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2WmI-00068d-Kr; Mon, 13 Nov 2023 08:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2WmG-00068G-Rh
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:14:56 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2WmE-0000qz-Qx
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 08:14:56 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-5079f3f3d7aso6270162e87.1
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 05:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699881293; x=1700486093; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ARblDR+RgZsvFggZ5aLFDC/QEmos2VHlirN6bW0crxU=;
 b=i8x9+KjSVb/fCr38zzO9CWgNxJaoy4swqQmuZeAtYg7cj+/4Q9rV7zecmnAkYNM5TW
 CPpDzDyog2BXQBWa/dninzd1kq+u+YNHpp/D1wi7GFHXt1GZYl3fM7C1q2yna7PFtcpq
 yoKlCA0F5LNBDFcQJ5shVFByGXbOfOtmpAX7zMFa0wEAT/CsfzIyhFl4xN6Nf94FdRFB
 CsAOpTVU689PvxYQz3wegsRE4Dh2eN4Y7bO1woM/8PD3G7mNmp+bqvP2+jf+On18Ftiv
 MZ1o3QzgOcMbtpZ6QExNtTHlY9sEZv+tAddHdexRNBlcXLhnygiIxSOvGZkSbVa4Giib
 UZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699881293; x=1700486093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ARblDR+RgZsvFggZ5aLFDC/QEmos2VHlirN6bW0crxU=;
 b=pctsBbM91TlY+gTOco7/40tWOJK/ViTiMaJF5E8xmQQVzthT91VQHIfNO6mXFUydAZ
 eZ+hqK3F2d4kWLQAdWtsff7RWT/KuMfEwVPpp8644Chv/BztobI2pxsj8qe5V3kGO1E0
 pCjPv7N2+X2ViZl9q0aCDxmOD86qN4y2DMFZbvOfJv6Y8aGRiK05quTUoP435xVAgZz4
 tJKEMzDlBlD99gt9XyyrrQ6WBT/K6m9hmvCqqLIbNFmTmx08YNnZEsk5/yrRwVuapztd
 qXihsOJfSG4OXoAv2683irR2xhWjShEtyMjN2gO5F9EHWLXZrgMFiPTtf4KXDKrbY0Oa
 sPqA==
X-Gm-Message-State: AOJu0YxJHEBf5ZABZHHH8R0yOo8oWBIaPW/qEBcdhuRZJbDwuewh9lqy
 QnHCvyx+yV4ZZYpGY91b1oSI3ma9K9HoiwQrAjv0Uw==
X-Google-Smtp-Source: AGHT+IHRGRcyYgt6olLbMQuZFUZtGHU1+BmowyMUPllq1cThM9WT/yeJO8xIwmnyni+Y4hwk0Vd9udqeP91dAcTOH7Q=
X-Received: by 2002:ac2:41c3:0:b0:509:4655:d8da with SMTP id
 d3-20020ac241c3000000b005094655d8damr4152386lfi.53.1699881292458; Mon, 13 Nov
 2023 05:14:52 -0800 (PST)
MIME-Version: 1.0
References: <20231110090557.3219206-2-jean-philippe@linaro.org>
 <CAFEAcA_Jja7MT_cSiEJ2it+wG7LnUXfnuoo1vmoUf1-+KSgtAA@mail.gmail.com>
 <20231110114537.GA3358536@myrica>
In-Reply-To: <20231110114537.GA3358536@myrica>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2023 13:14:41 +0000
Message-ID: <CAFEAcA9y-8Dy+5-TEERZhWuHf=+U9WEeOtnPjVvU+RaiUrbRhQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: fix GIC maintenance IRQ registration
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

On Fri, 10 Nov 2023 at 11:45, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> On Fri, Nov 10, 2023 at 10:19:30AM +0000, Peter Maydell wrote:
> > On Fri, 10 Nov 2023 at 09:07, Jean-Philippe Brucker
> > <jean-philippe@linaro.org> wrote:
> > >
> > > Since commit 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic"),
> > > GIC maintenance IRQ registration fails on arm64:
> > >
> > > [    0.979743] kvm [1]: Cannot register interrupt 9
> > >
> > > That commit re-defined VIRTUAL_PMU_IRQ to be a INTID but missed a case
> > > where the maintenance IRQ is actually referred by its PPI index. Just
> > > like commit fa68ecb330db ("hw/arm/virt: fix PMU IRQ registration"), use
> > > INITID_TO_PPI(). A search of "GIC_FDT_IRQ_TYPE_PPI" indicates that there
> > > shouldn't be more similar issues.
> > >
> > > Fixes: 9036e917f8 ("{include/}hw/arm: refactor virt PPI logic")
> > > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >
> > Isn't this already fixed by commit fa68ecb330dbd ?
>
> No, that commit fixed the PMU interrupt (I copied most of its commit
> message and referenced it), but the GIC maintenance interrupt still needed
> to be fixed.

Ah, yes, I see now. Applied to target-arm.next, thanks.

-- PMM

