Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA1712DF1
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 21:53:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2dV4-0005YO-Ds; Fri, 26 May 2023 15:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2dV2-0005Y0-Go
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:53:20 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q2dV0-0008Li-Vk
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:53:20 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-510b6a24946so1906900a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 12:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685130796; x=1687722796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WGYGgnRSg1L5fVfzwVFSShPMH5yW3bsAxJki25IcVD8=;
 b=mg4/z3qkjguGoSa5v2GIW6mwEeWC8hLrLx95+v6iZhYRYpelaBzLy1shD8A8npoDp8
 osNKoqTP6lOpenZoMoG9hBqBmXWGrfrArtavtZDzdYbptbFf1tMuIReVLrU+24b6NqLe
 pwpNAyn4blccht+FkdPHuxmg1INXLzyCXK/ETGYAltWdYT51J4vJ3yxmXfUSuTkf4gEK
 VgoqgomycYd44HOU91My9NqyXspZ6C5prMWLpJiIhYKZoXFlQzmIPPefcwVDkuqlOQpw
 aiq3Nzo2jf2PoPjCgWVCbLacUwsat53HmBXx3HQlE6w1kcnumISDirmWV4jGZxfT8J8t
 yoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685130796; x=1687722796;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WGYGgnRSg1L5fVfzwVFSShPMH5yW3bsAxJki25IcVD8=;
 b=NByDI2KQn26JUdVjaNw5Dp4bl//4+EvEDwLLzjkgVpDBjc1ZErUyXxe5oiQZF//CFa
 TaUmBTXa2al6ZCmxe+e/C9Erj4nMZmaYSBVxy0KevWWWTzBAWGgLe24NYlCn7BTfocSO
 f5zIc2+XliZ2nMIGgsHUnGXCa5E7pmRJ2ocvkagNr9MP05T2ziYqb8hac3UMGKaGikqS
 b9C9JmrXtXiQKJFGu1yVdsx7wiCETt9jUkFsMqfsINfu6Ib4N3iTr92ApFVyeT3dlB5C
 Ai0osdk5AHT8T3vZiDMTMrVDNerm33utcjf6WsoFgGSVv6SbtzGrMqPbOMTJvSWAQb0E
 If0g==
X-Gm-Message-State: AC+VfDwa+bfwYHEYHkcGfCFmgU62gML8t6QXUPahI/gGcjCisDrySql3
 MmW09D07/Srr239se0DuxBztbX2cnb9PnY/5PJjGD3PnGH2f6g8E
X-Google-Smtp-Source: ACHHUZ6+vJgswi8IIOiDgwE6mYl2fzJqwbLc8H7f9CcD7OTm/thv2K/UOEzzbiTKCbj1daQqutXP82ehwJJtyoCKliE=
X-Received: by 2002:aa7:d9ca:0:b0:50b:f654:8846 with SMTP id
 v10-20020aa7d9ca000000b0050bf6548846mr1885013eds.19.1685130796122; Fri, 26
 May 2023 12:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230526174005.1801043-1-richard.henderson@linaro.org>
In-Reply-To: <20230526174005.1801043-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 May 2023 20:52:48 +0100
Message-ID: <CAFEAcA_PWUB-+qRLMzqtwPsegSzs73N5sFryj4GGcBU9b0OWrw@mail.gmail.com>
Subject: Re: [PATCH] decodetree: Do not remove output_file from /dev
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 26 May 2023 at 18:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Nor report any PermissionError on remove.
>
> Previously we were testing with "> /dev/null", but that's not easy
> to do with meson test(), so we want to use '-o /dev/null' instead.
> That works fine for all of the existing tests, where all errors are
> diagnosed before opening the output file.  However, PMM's named field
> patch set diagnoses cycle errors during output.  This is fair, but
> we need to be more careful with the remove.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  scripts/decodetree.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/decodetree.py b/scripts/decodetree.py
> index e4ef0a03cc..a9a0cd0fa3 100644
> --- a/scripts/decodetree.py
> +++ b/scripts/decodetree.py
> @@ -71,7 +71,12 @@ def error_with_file(file, lineno, *args):
>
>      if output_file and output_fd:
>          output_fd.close()
> -        os.remove(output_file)
> +        # Do not try to remove e.g. -o /dev/null
> +        if not output_file.startswith("/dev"):
> +            try:
> +                os.remove(output_file)
> +            except PermissionError:
> +                pass

Maybe rather than hardcoding /dev, only try to delete the file
if it's a normal file, i.e.:
       if os.path.isfile(output_file):
           os.remove(output_file)

?

-- PMM

