Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A67282B6
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:30:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Gcq-0002tD-FU; Thu, 08 Jun 2023 10:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Gcl-0002qz-Lk
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:28:27 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Gck-0004ap-5e
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:28:27 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-51494659d49so1165934a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686234504; x=1688826504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pVmdQf3hZkY6Ied59nd4b0nJHCnXpoRkH2wB3KpIV4A=;
 b=OFBoxf2dr5EBfu+LsY1VyQ+FRQYfupEWYK5OrUKtgJ+3QYG6FCIKZ7dijHXfHm8rME
 Ms/wLaI/Y253WWpsVvXAYXrQYa+sHvYou0oJuDJKm3nDcGz8c7/GKVBg+et34iDjNGCw
 Lym5IE+It4PLqYXdHIP/4P0TsZgoqm09YCfjlbxHqt1+Tlu+ZDQ4c5uLcrCJSOZZeTKu
 lvIVUyVBCCAw79tltu/eg371BCE2yDOoNG+7cTUzxowGTSKkSTp27Vcgp64SI4ho8K73
 l0FVInZbDw6Z6Y8WXcLOvPSp6AZ/ZMZcEgeIl5E3biRFXG43uFBi0UcE0YP4tvtKAYCp
 gcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686234504; x=1688826504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pVmdQf3hZkY6Ied59nd4b0nJHCnXpoRkH2wB3KpIV4A=;
 b=E/2mOgasFUW9lGaW5hwxdmraF3i2LxD3y1uvNQ/i+Kg9HAIp4G0d6vZNYzVlQTTukd
 IwxX59hdRNf0FG8pXtwvdhXrhwuYFk+JzGaprlCSQ1Foh9PL74rJhmFbqSPzCo606z3A
 lLTr2F3LDpcf8eiHB6nn/+rWJkVd9YeMm5QQLwIBpSW9JfJsjLDTgHrjYDnLeEfCcXzq
 GGR+qj8DNvtNkcSYPycGn5Auah8mABTpxkUP37SE02lsTqHkkIy8FPOZ8b1sgQzw1ZyK
 UJnD2SOrICWOfQu5K44pZsqxCz6WIW/Yj1Dad0B5kjsQWEYvMylOzGNxc4EaBLPdACsW
 fw8Q==
X-Gm-Message-State: AC+VfDyNsF9epFnmu7kc9Tk9L97Q74+T9k4k7CTN84ZGSbXvOZUvwgfe
 3BaqfVL0hyHyQvKMTEhOW6+bv4QC2sYm6Uu7Kquwlw==
X-Google-Smtp-Source: ACHHUZ4UDa6Z84yDgSunuQy1G5lsI/IMUQUCzDhdKVYF5WPJsgLf8eCdvpWc7oKKgchlIAu2yCNABjp+SFmwsWOH49Q=
X-Received: by 2002:a50:ed0f:0:b0:50b:d18c:620a with SMTP id
 j15-20020a50ed0f000000b0050bd18c620amr7288796eds.25.1686234504350; Thu, 08
 Jun 2023 07:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
 <20230517081204.30333-7-m.elsayed4420@gmail.com>
In-Reply-To: <20230517081204.30333-7-m.elsayed4420@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:28:13 +0100
Message-ID: <CAFEAcA9LzbbLwNy810=wVtfF34XvSph4OAaiGtKrECq1E9HzdQ@mail.gmail.com>
Subject: Re: [PATCH 6/8] tiva c general purpose timers implementation
To: Mohamed ElSayed <m.elsayed4420@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x533.google.com
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

On Wed, 17 May 2023 at 09:14, Mohamed ElSayed <m.elsayed4420@gmail.com> wrote:
>
> Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
> ---
>  hw/timer/tm4c123_gptm.c         | 495 ++++++++++++++++++++++++++++++++
>  hw/timer/trace-events           |   5 +
>  include/hw/timer/tm4c123_gptm.h | 131 +++++++++
>  3 files changed, 631 insertions(+)
>  create mode 100644 hw/timer/tm4c123_gptm.c
>  create mode 100644 include/hw/timer/tm4c123_gptm.h
>

These look like they're either TYPE_STELLARIS_GPTM
(hw/timer/stellaris-gptm.c) or a minor variation on them.

thanks
-- PMM

