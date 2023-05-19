Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB70709EF0
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 20:14:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q04c3-0003GW-E5; Fri, 19 May 2023 14:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q04c1-0003CC-1y
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:13:57 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q04bz-0000sJ-Fq
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:13:56 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-50bcb229adaso6490488a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684520033; x=1687112033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w0BuVyddM+kO7u/dxF1f7AjdElDSMWtMYsMQAW06IOo=;
 b=yVA8W3w0YaFqnA57WI+v0f+EoW7PzX6La34kdM0rErqvbdDh1XR+z9HU0PRiBoAzCN
 Ul1EZnl31cofrj0U+wnE4TT29NAFWZx/geCAY9uYICSAliFMdDGIkezkNanzif4WkxAB
 9aDyEjlEacrEq2ADNnMt3cO0jscti8pdBz5GWNosZOJHlIUiiikhAK+/r1oy76CewkQz
 agNh1paF3Jmluz9gCRkrZ4tSpQOibSFXiBkCJYoswyr0ac8dw8N4bwx7Y1HvmijqYaCt
 ALeLzCteTj0O385qkEZ3WWdLmInW2O16bk7ENxCuF/sSyAxBKVkX7GrBF3Iye691EfS5
 DiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684520033; x=1687112033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w0BuVyddM+kO7u/dxF1f7AjdElDSMWtMYsMQAW06IOo=;
 b=TK3KVB9PwTGPYeF+oztBA9w/8ltmw7CAVSfh6XbtacjfJJxZK2delmvlMAA4MzF6mj
 TIj9N90184NWwTlY5ZeGUjFEgllzuRdYlDtU4a4BroBx6Q8cubDkJ3uYAJ7279+1jI7u
 h9HMnibKUrzRTjEBrLB8d91L/zX18mXX+BfuYu1XSLkFpU6Ar45M8jey4LyLCLrpEAgY
 xe15ivirTdKiXMeLreCsSMPy1aGbVbPHzqJdU+efNxWuJ4ZZ8bCZoDoBf1D+CSX9dfI3
 31uhCN3RVifbT9Rj/fzKlkfUqqn/DlW6Am/E0ZZaE7kNvMAIPXdRe/MbsLsQmxxmXpy5
 mXSQ==
X-Gm-Message-State: AC+VfDwNnL5penEA3/OOu3hRQnkBJx5ro1Q+2IVCtsmTuZn2k/m3eHKC
 uDRDdVxONU9eMRcHoVZnSISi+Iw+Cy4r8nQaOi+zkg==
X-Google-Smtp-Source: ACHHUZ5jk6MWAJ4j5q1qV4YT8RXny+Q3dqUhBVteIQGRO9+yLijz4NQMGQJ7sh3aOFVzkZitOhEJ2usAhirMCMN2ei0=
X-Received: by 2002:a50:ed95:0:b0:50b:c8eb:96a6 with SMTP id
 h21-20020a50ed95000000b0050bc8eb96a6mr2305269edr.31.1684520033630; Fri, 19
 May 2023 11:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230519180812.1181871-1-pbonzini@redhat.com>
In-Reply-To: <20230519180812.1181871-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 May 2023 19:13:42 +0100
Message-ID: <CAFEAcA-Fur3Hy7Ca+T6RNbukkpLA-c7edb4Z2T5U2D4Qq_j+7w@mail.gmail.com>
Subject: Re: [PATCH] configure: fix backwards-compatibility for meson
 sphinx_build option
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 19 May 2023 at 19:08, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Reintroduce the cmd_line.txt mangling to remove the sphinx_build
> option when rerunning meson.  The mechanism was removed in
> commit 75cc28648574 ("configure: remove backwards-compatibility code", 2023-01-11)
> because it was obsolete at the time, but the Meson deprecation
> mechanism doesn't quite work when options are finally removed.
>
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

This plus the Makefile patch from the other email thread
are sufficient for the incremental make to work again.

Tested-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

