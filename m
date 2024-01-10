Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A100829E6E
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 17:23:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNbLX-0002BK-KK; Wed, 10 Jan 2024 11:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNbLW-0002Ad-6v
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 11:22:26 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rNbLS-0005UY-IH
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 11:22:25 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-555f581aed9so5069827a12.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 08:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704903740; x=1705508540; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Oo54KFymR/TSXwQNyoX3TwFxxLpTGuKsOz/RqEI6Kjo=;
 b=jSyWzGf0TSC0MEDHZVdK160i93XPsZNLWxr8KXg/GFB2r8oFyPBJv+Xgwm7GtS3Hpq
 xT7Ko0tZN6+FFcE/ayVZDuMeYvZm9y5cX0VtiPNED9pL8Nx9+bslhkf20S91yXVpwZ7K
 BG6nftyM41UH+nO87PWkk+YzNfk6qCpYrDXDgxXAdKcnFCwaZyvySyIAjnR4sUSc73oC
 b5gnYa5sH3AmWLtYizmmNLMSKHr+QPaPINGa58VvCqW7TnM567QCHPAoW1ONGq4xQ5vI
 zltJb3j7/354BJ+Vo0ZCFH3QnIlcoKz9aoRGcE0o8OpuXLLERl+fow9XjCwz9lVHjMLn
 kXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704903740; x=1705508540;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oo54KFymR/TSXwQNyoX3TwFxxLpTGuKsOz/RqEI6Kjo=;
 b=L5mesEL/Qckzq/qGC629lI3XgFkwoM9oQjqTDvh7bIGnaYPNWruzSyVNlaI/qJvG63
 sTruFSk1hG9KBw7+hqOZcWPrqhTEtyb3le9190e82qTBTYmIwP7iDxrzvHI1flOf49pm
 8SSTqwj93cFEAslpv+CAQXtf1zU33FGBcuGzcGv6HCd16RXpfG91z44KQjJD2+2N6yvu
 JB7BZI/WG8ViZfAPo9jLWZ95dA0qG4Jgc2mXgqV7/T6bZTwCtN4wjWAIaebn+0TBHtr1
 mAoiZR1/LeRHpHknBTZy2CuZZYT9CPWiRAvzFlTqazLyZAqFlBCsQ8k9zKfLEPC9zFaI
 xDjw==
X-Gm-Message-State: AOJu0Yywop6LVZOdXfl4cRZePNJGz/7E2xacXzkDLZAMAo0oWDkUesYv
 QSKM4xW4kcDMCrAQiEzdNlvTNddrf2FWorrEeLSGjwwm/n692w==
X-Google-Smtp-Source: AGHT+IFsnyKeIrw6xrNmqzrKbVVOTanF8vtyAJ/lApf0Jyfh4crzqBENn5sHQ60KteyZtxE6V25HTtxJsvWA8zJLW4k=
X-Received: by 2002:a05:6402:22bc:b0:557:dc52:32e0 with SMTP id
 cx28-20020a05640222bc00b00557dc5232e0mr618720edb.24.1704903740421; Wed, 10
 Jan 2024 08:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20240110085733.1607526-1-alistair.francis@wdc.com>
In-Reply-To: <20240110085733.1607526-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Jan 2024 16:21:47 +0000
Message-ID: <CAFEAcA9b59b91b=FO4Yg+or9PwFMRe-UvCNT77ENtJOiSDe2EA@mail.gmail.com>
Subject: Re: [PULL 00/65] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Wed, 10 Jan 2024 at 08:58, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit 9468484fe904ab4691de6d9c34616667f377ceac:
>
>   Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2024-01-09 10:32:23 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240110
>
> for you to fetch changes up to 71b76da33a1558bcd59100188f5753737ef6fa21:
>
>   target/riscv: Ensure mideleg is set correctly on reset (2024-01-10 18:47:47 +1000)
>
> ----------------------------------------------------------------
> RISC-V PR for 9.0
>
> * Make vector whole-register move (vmv) depend on vtype register
> * Fix th.dcache.cval1 priviledge check
> * Don't allow write mstatus_vs without RVV
> * Use hwaddr instead of target_ulong for RV32
> * Fix machine IDs QOM getters\
> * Fix KVM reg id sizes
> * ACPI: Enable AIA, PLIC and update RHCT
> * Fix the interrupts-extended property format of PLIC
> * Add support for Zacas extension
> * Add amocas.[w,d,q] instructions
> * Document acpi parameter of virt machine
> * RVA22 profiles support
> * Remove group setting of KVM AIA if the machine only has 1 socket
> * Add RVV CSRs to KVM
> * sifive_u: Update S-mode U-Boot image build instructions
> * Upgrade OpenSBI from v1.3.1 to v1.4
> * pmp: Ignore writes when RW=01 and MML=0
> * Assert that the CSR numbers will be correct
> * Don't adjust vscause for exceptions
> * Ensure mideleg is set correctly on reset
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

