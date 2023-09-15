Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E02037A20F4
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 16:30:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh9ow-0006gd-GB; Fri, 15 Sep 2023 10:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qh9ou-0006fp-QV
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:29:20 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qh9ot-0002Fx-8O
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 10:29:20 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-502e7d66c1eso3298987e87.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 07:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694788157; x=1695392957; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9svSgG7YN8+asSGiL3ULeSkm2S7SnRq8qEawkaWRqAU=;
 b=jnsrr9iDY2jCD+9x8NkDMw9oFxmxRYGRwz+jSB0FanN8fXAUJfMivIwaXYe7NIkVeP
 50cZrW9AyDJlZmQy+h4kalAaPyKvNxQjtuuelF1m0eW7sh7ErIwLKQT16eykr4o2v6/4
 mm3fa6Jg3vHRiDrLtLyHCICD6ADtCdTfIUtN0kLI+STE6Y3to+Qgf5nLm02jtCqanVXt
 zXevgSDlrHTCYYv2K1ZhYI7Ol+OLrhPI2E91Tg+eWsOW31OU8FILlAqU9StDYJ0O28PE
 dqyX4+JekLAE//7jj941o+QrOsXkCGcAu3vrTXRQyF9NDmApZUikDWDnhBQRe3t4LN+a
 R6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694788157; x=1695392957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9svSgG7YN8+asSGiL3ULeSkm2S7SnRq8qEawkaWRqAU=;
 b=sTqvfbUBMI4Ribffeyaz9RnYhvQ//vJb1YooLX4BmCyDaBOBszcX/fAxmI2DClmHua
 fR6ikm7NNP8YJrn3YEppVUY5CVkhdh0LaEKxfSagYzyim99kF+kTrfkN6lO09Qza/Uvy
 rn6wwTFrITlwleECLV8wQVqQzw6qPwx/BOzLk6k6gor53nkaiyLFKSDusnIrGiQrr/xA
 0kG97V1F9BVYJtJOSQoCpDDp1eX7GI9KGG5WbLCkxA5ggFNn1Cv5TKngHszjQO2WVm+8
 dBtyrHIk54mhAkhAX3RMyiPOaLWVr5dwzZxcc9iUkzYTqLTGSYX61fLjbYxZ5QrS613A
 gLZg==
X-Gm-Message-State: AOJu0YzeMxRfS7f5lpqbxiclPWTgxTD0ranQxOl7hxYgMgIs3HB3TNSW
 9qIlXqGe9oCHEgwG4QJoKpiCDHb5e951jmQMtm9aaw==
X-Google-Smtp-Source: AGHT+IGtwu3v4Jl6NDa9nu4DgY/mLpFSYZ/YzLCsORFG/pIXYjKdricRBilfsHOk5/N++Yu8Qo2F2A6rcBPxYiWzxI8=
X-Received: by 2002:a19:761a:0:b0:4f9:7aee:8dc5 with SMTP id
 c26-20020a19761a000000b004f97aee8dc5mr1660135lff.19.1694788156673; Fri, 15
 Sep 2023 07:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <4831384.GXAFRqVoOG@linux-e202.suse.de>
In-Reply-To: <4831384.GXAFRqVoOG@linux-e202.suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Sep 2023 15:28:57 +0100
Message-ID: <CAFEAcA_pAcmej1XY_NCPhLxm5qO55AdAHqQXtfXxe5oOJ_MguA@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/boot: Set SCR_EL3.FGTEn when booting kernel
To: Fabian Vogt <fvogt@suse.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x129.google.com
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

On Wed, 13 Sept 2023 at 12:58, Fabian Vogt <fvogt@suse.de> wrote:
>
> Just like d7ef5e16a17c sets SCR_EL3.HXEn for FEAT_HCX, this commit
> handles SCR_EL3.FGTEn for FEAT_FGT:
>
> When we direct boot a kernel on a CPU which emulates EL3, we need to
> set up the EL3 system registers as the Linux kernel documentation
> specifies:
>     https://www.kernel.org/doc/Documentation/arm64/booting.rst
>
> > For CPUs with the Fine Grained Traps (FEAT_FGT) extension present:
> > - If EL3 is present and the kernel is entered at EL2:
> >   - SCR_EL3.FGTEn (bit 27) must be initialised to 0b1.
>
> Signed-off-by: Fabian Vogt <fvogt@suse.de>
> ---

Applied to target-arm.next, thanks.
(We seem to have a habit of forgetting these...)

-- PMM

