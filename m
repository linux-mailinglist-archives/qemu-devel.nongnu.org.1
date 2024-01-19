Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B76AE832727
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 10:59:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQldF-0005S0-SH; Fri, 19 Jan 2024 04:57:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQldD-0005PY-J1
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 04:57:47 -0500
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQldB-0001iw-TL
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 04:57:47 -0500
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2cd1a1c5addso7348191fa.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 01:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705658263; x=1706263063; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0OHtAXpbs8YPFthSorDb7Il8UQHAIKMQH305jEBQ7bE=;
 b=yk30PTKA8aJFARQj5YotktmXgO+3grdC9nHgbi64lqi2+Ez6FvZ0AXkS3WWYTipQA+
 R0FS1pDUVS05nvGY3wGUYhuHNmdVxdyGe0FdiOudq5K9A6/EwuSpi6UtAAIWYL9VJU4W
 yPSwc4o7EwMaHULLKZliPdBd3MAqEdkqiYgeQvob0iqDXw+cbzDeUltqduSXX0km/Ag1
 XPLY1Z/dvgOPopx7LlVcBmNQcVRzkMaF8SbFsuFzEKxQhcbDHtRfPEKGfRziFyvA3PIQ
 oyR3iYIxXyuvFMb+uQHeZYjOYQb4VVcPw/LWYpwl2UluWo7PjhQLFtZlBKxDLnGe0Pqh
 AjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705658263; x=1706263063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0OHtAXpbs8YPFthSorDb7Il8UQHAIKMQH305jEBQ7bE=;
 b=VM5WoNFT+Lb1sVTMimazB9oxD6lP0pE/xhA4z4zCBfr8TzPYfqGjgm4GgM1o8VGF2A
 fphOpRsKQML/wryl3H70C8LXxHgt1D7hRkphbzM0prXaf0PA9Jj5qTC15EAd1M5f+rOB
 vI7XUu2f3uZi2CSKyTd88t6DsQeTpl1WeFPiX/wvbSBGiqelM9LvtgHhR+J2MuTp4vl5
 NVxq8Er1N//vIQ3kw/mpzET3pAK45hnmZABta0LO6wWsYi5jAY4LCn+6iUtb8IOxyjLo
 HjC3HsNl0y5U3Rl/SpYobsxrFaFqdYhFHGopCKqrTPs5xCdjIyJs6tTh6pbaPvY2zv0Q
 WweA==
X-Gm-Message-State: AOJu0YxAVt80jHy0oNXwHIkO+9vAogr0oaQaZ65MIiCldKrcuyyC8UBs
 o5/acYL32dZv9F3LJSY5QD9VFx1ql1hpmWQb6P4wUQU5ylIfcpCBmKSQKpLQcwyPRxgbmC2yLlG
 jYT540OXI316LT5JGCLaTM6hS3M/d/o1HswR4pA==
X-Google-Smtp-Source: AGHT+IGKtMOMMWKAWR8BsYX65eRdYJ7okHi8g6I+DCR1KaBF6NApx7tK55Ss+aGAHXpjBHqYs1ouF85N8f54qaNXYW8=
X-Received: by 2002:a2e:9991:0:b0:2cc:e5ec:f6f9 with SMTP id
 w17-20020a2e9991000000b002cce5ecf6f9mr1136984lji.40.1705658263479; Fri, 19
 Jan 2024 01:57:43 -0800 (PST)
MIME-Version: 1.0
References: <20240116075744.219169-1-thuth@redhat.com>
In-Reply-To: <20240116075744.219169-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 09:57:31 +0000
Message-ID: <CAFEAcA9_2O0eiBwx_5tvgidxqx9e7yvTu39TNW2Gm+v1BEA-ww@mail.gmail.com>
Subject: Re: [PULL 0/5] qtest timeouts and ROP mitigation
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x233.google.com
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

On Tue, 16 Jan 2024 at 07:57, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e393c:
>
>   Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad/qemu into staging (2024-01-12 14:02:53 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-01-16
>
> for you to fetch changes up to 7ff9ff039380008952c6fd32011dd2a4d5666906:
>
>   meson: mitigate against use of uninitialize stack for exploits (2024-01-16 07:25:27 +0100)
>
> ----------------------------------------------------------------
> * Improve the timeouts for some problematic qtests
> * Enable some ROP mitigation compiler switches
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

