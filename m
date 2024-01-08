Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD3826F81
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 14:18:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMpV0-0005qx-8a; Mon, 08 Jan 2024 08:17:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMpUt-0005pn-En
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:16:57 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMpUr-00010s-OA
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 08:16:55 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-555e07761acso2076566a12.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 05:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704719812; x=1705324612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cq6zbSpPaMegW9jDBOGqQn6o3L4sJ1psytReOr8+HwQ=;
 b=PmOtnafB8zZoBsFeeS6jotvfKMJTiCmRv1HSMJcXHeRuTbO1iAnA3+7UVWqNQzeCRH
 wvp/TAHCgi6nl4tTPtd6U/z6cUJXofAzo4RLSPfkgsk79pmRSWsGUGhm/BbRWi0d1QoX
 a2Z7Opy3QDouqgqmTBWRMONkpYJEw2O+uRIwunG2Jm7DmTan9s/I+YMF3gBsTBFwhSkN
 CcmiWUvHPnZBq9SHqo37fM31tutRcKP+4zVDiMsf0lQLrs46Vyg3Lhdi9pkwFXUIQNgA
 XPAc+59YsFukidAxJRtj45CV0cmqcfhfYdcR0WWfjY8ilWtYPWkr6DpjToq65RYD9ZIh
 9fBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704719812; x=1705324612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cq6zbSpPaMegW9jDBOGqQn6o3L4sJ1psytReOr8+HwQ=;
 b=q7VkYz/HKzF0YQ+/AHaYNckBlKLVUgAsLgkShZH4pFozCYDGkW7ADE0UrW3krPydm8
 qFETv1ZCfSdmzB7ADoWHzo7uJdIhlyRdpkElzyquNps9tntDb6OpCJXkFtHRndBJlhR7
 2Ir655FL1ubV35t0fVndtYrASe9PeOQBg/HHzhIVxsEx6F6ikN4QVKt+7sOmoNRktS5N
 yRucNqhk/3T4Mm1VV1blH4Wb1ufvdwhuilyRiDuQ6Xo7RaTfk9WaeQOSfSxHwQoJBKQB
 sKh3Zayu/cReby6rLM4+SoIC+ztr5CrFPx4W2mkB82E1ulYgIlyLw66L2VSdIw0hir+6
 Ge0A==
X-Gm-Message-State: AOJu0Yybu3FvwGQvZ9bYCkg/N3qPSvIQs/ZhqBwo2DTwC5oQYFvKz2BB
 dND+0IQ+9kA1WoeA0MOguWgb4ns6QknES+QU/XFZV6VxkJX0yUJ1+IrEtYh7
X-Google-Smtp-Source: AGHT+IFMtwHazkYDnYtYw3JH3lbZo91tN7kC1lUVUgluxFM627p4UeUPEu5HRIYWQvEuVf+N/lVkxwgpmZ0rroGMxNc=
X-Received: by 2002:a50:ab4a:0:b0:557:3f98:39 with SMTP id
 t10-20020a50ab4a000000b005573f980039mr1468917edc.11.1704719811901; 
 Mon, 08 Jan 2024 05:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20240106021211.1418324-1-gaosong@loongson.cn>
In-Reply-To: <20240106021211.1418324-1-gaosong@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 13:16:41 +0000
Message-ID: <CAFEAcA87n60-ZvvX6xCYXo=vGGwQBeef4tnoYiiYHLmXHmL=6Q@mail.gmail.com>
Subject: Re: [PULL v2 0/2] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Sat, 6 Jan 2024 at 02:25, Song Gao <gaosong@loongson.cn> wrote:
>
> The following changes since commit 0c1eccd368af8805ec0fb11e6cf25d0684d37328:
>
>   Merge tag 'hw-cpus-20240105' of https://github.com/philmd/qemu into staging (2024-01-05 16:08:58 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/gaosong/qemu.git tags/pull-loongarch-20240106
>
> for you to fetch changes up to 5c23704e4725f935b3171787f00e9922a7fc58cb:
>
>   target/loongarch: move translate modules to tcg/ (2024-01-06 10:18:52 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20240106
>
> Fixes patch conflict
>
> ----------------------------------------------------------------
> Song Gao (2):
>       target/loongarch/meson: move gdbstub.c to loongarch.ss
>       target/loongarch: move translate modules to tcg/
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

