Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F62C75F81D
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:22:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvV8-0008Ry-Cs; Mon, 24 Jul 2023 09:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvV6-0008RX-6w
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:21:24 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qNvV4-0006XS-Lo
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:21:23 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-51cff235226so9169294a12.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 06:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690204881; x=1690809681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5jPevRM0ebCLCD4K8IoIbONvOICW50+k6KptnuTajBw=;
 b=LLu9r1bwrLZnFIHM0wBCdP12IM7t+WTcAWPv/SRwUzUBxcNsnGiz/ox2+KhcyO+b+0
 vGz4ol2wHC24qM90NmC6BwibC6aYo4edcGkA1RdjQV5/wOqQIoyGedMIdBFddgOpbHIW
 RxnAeUD9vqYgT3CUyzGIWnhPpG0cYllqOXRqG7iONJ5D7V+AOZoF17Sh+hOssBg1bXz/
 55Pq66iVVyS6/acOJqyIpBOA5sX5vsKnbAHDUujKHplwoK6wpwd8qhjJ6LpTNeuop2zb
 tq7R/iI0hSLM2xu5G3A13vO8uTVi0IYliLZA46vn3I5v3iUnJvpr9Ls37NgpvlM0BD5r
 3ceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690204881; x=1690809681;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5jPevRM0ebCLCD4K8IoIbONvOICW50+k6KptnuTajBw=;
 b=Y83TVRng80Fa96e64W3KNDxWCUA3Nrm3m750aESSP5d3zCeRgN6IwQMTEmmmkPhspu
 /FNpKlwZYvypreu0myKe5Ud9huCYE1av7Ki+d7UX5ZvcHkHeBkp8b7RZSb4RTRjfqHDq
 ipQMXMKBIawXS0TXUragFmZa5yG91tOYQuWY3WeVyxdYg28qEdW0INz6SAZdMucjLpPt
 SDJ/k27BYaB+ZlDU25My5s/JkRywIq8b0AVly8E1bGMcLSe5y7e0PDX2iqtUSsicn+JS
 Y3eG32POI1Ht4UQyqm2u+0uK2oe6EZEWHT+EcNcu3L55hIRcGFi5c8GyISmLh1lJpWDK
 SFxw==
X-Gm-Message-State: ABy/qLYb1EwUGMV3H+X0mhsYfxnrx/DSZx9WmN3so/JGOOuYd6Pqk39G
 XPBwR4qsAjTNWUnY3kCFM5nuWUR2G2kgBgLfWmMih1B1quCMrW6h
X-Google-Smtp-Source: APBJJlF+5Y9VHqjHIc6osCQGH1FHQb6GGj1bWlzfDiC/Q5NLwGX1mUlQtFgByEKke+/S3qCY+ZfYKDjSuKUpUUrfkGQ=
X-Received: by 2002:a05:6402:11d2:b0:51f:ef58:da87 with SMTP id
 j18-20020a05640211d200b0051fef58da87mr18826349edw.2.1690204880644; Mon, 24
 Jul 2023 06:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230723093414.859532-1-alistair.francis@wdc.com>
In-Reply-To: <20230723093414.859532-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Jul 2023 14:21:09 +0100
Message-ID: <CAFEAcA9fXPN1OT_irRafsKJsuEJC_AXouwV6ifE7QB-iJiYsnw@mail.gmail.com>
Subject: Re: [PULL 0/1] riscv-to-apply queue
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

On Sun, 23 Jul 2023 at 10:35, Alistair Francis <alistair23@gmail.com> wrote:
>
> The following changes since commit d1181d29370a4318a9f11ea92065bea6bb159f83:
>
>   Merge tag 'pull-nbd-2023-07-19' of https://repo.or.cz/qemu/ericb into staging (2023-07-20 09:54:07 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20230723-3
>
> for you to fetch changes up to dcaaf2bf9bfd2c664dbeff0069fcab3d75c924d3:
>
>   roms/opensbi: Upgrade from v1.3 to v1.3.1 (2023-07-23 19:32:02 +1000)
>
> ----------------------------------------------------------------
> Fifth RISC-V PR for 8.1
>
> * roms/opensbi: Upgrade from v1.3 to v1.3.1
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/8.1
for any user-visible changes.

-- PMM

