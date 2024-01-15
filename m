Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBD282DE3D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 18:13:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPQUx-0005dg-08; Mon, 15 Jan 2024 12:11:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQUu-0005dF-VP
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:11:40 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPQUt-00042f-D0
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 12:11:40 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so2441345a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705338698; x=1705943498; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x5cJgup9N8+JgV8cXJIj6n8LxMr6G68seLpHIpNG5hQ=;
 b=fAlzBEprYgaDdbzvYENMo0JrzPXztrkmL1UukKzJA0zd/R5sTCSxkYj78FAiAEBIt9
 +AuY6sbX/Ms2m8yle8Mm/rMWPEQkCPQloWPwkFtMMufnHfTTMyCPG1oYHI6ejNv4vO4I
 AJ3XRkudGSDq7RfamYM0jZCIi+WciuOjmgleRIdyBGEQg/OvBCV8jfZ0iqgxqmbPII60
 yE1Mw+2nzyQRRU2Ec5b+DrKpEcnKge9M4RgCs7MeEasfz95j4j+jnTOu7KQ260MlCXLU
 CVfbZtmDODDgGDzBzIqBKYKJidrrx+2n+t55YOE02p6xDk140BgtjIonceaxj/3Jo5E4
 bEEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705338698; x=1705943498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x5cJgup9N8+JgV8cXJIj6n8LxMr6G68seLpHIpNG5hQ=;
 b=Ibd3s2Pmz4sTHLzeD3KxXciyWDb9oQLlj/v6oYrcQjQ/ljAbUeCDPVnJCr1sGWlOic
 MerY/Dl9oTbObyC193H+2bz90MUcu9E28Dg0wAR2N4BboyMUy6r1DLTU+O+MfJW5rMkG
 64MYSQLiX/kWgoLRDywqfDhnmop4hBWNIk2/7ooqPO5rWuQbgqJZbrxYLSPLAgRJngNL
 4Goc4/ObdkpokA+qEeV0p6FfW+yKZGnVqCLh9MV3GIJxOB/1I55mi6tOiPK3QWnZGWw8
 RKTEVIjXG0u3rLlHvWzYn3+F5E7Cevhg6HZeWNdnEaX/LvmJXFKD1yUncjiWxyd7e35Y
 iNHA==
X-Gm-Message-State: AOJu0YxvHMCAITNgACIWc9CApiUiNT2EjJIdgp6ajYvQepKM44NK6Mci
 FdT445ZTTP/jHb187+LMVp0rXvhO513l9ofO0GngLaBmTqdKDQ==
X-Google-Smtp-Source: AGHT+IF81XJuQlXllhd3MQU6hz1RvcP2wCD9az44bJvd3rlS3nRtr7Lvr+dHcAweEg8J6mYByDlGX6XmsEiZvrCK0Yg=
X-Received: by 2002:a50:ec83:0:b0:559:56a7:ed25 with SMTP id
 e3-20020a50ec83000000b0055956a7ed25mr331108edr.93.1705338697730; Mon, 15 Jan
 2024 09:11:37 -0800 (PST)
MIME-Version: 1.0
References: <20231219182212.455952-1-sam@rfc1149.net>
In-Reply-To: <20231219182212.455952-1-sam@rfc1149.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 17:11:26 +0000
Message-ID: <CAFEAcA__cuJaphqWJKSRJ2Zn+2t0xaxOGgzSLE9OCE24jNxSfQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] tcg: Jump after always false condition
To: Samuel Tardieu <sam@rfc1149.net>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Tue, 19 Dec 2023 at 18:23, Samuel Tardieu <sam@rfc1149.net> wrote:
>
> Unreachable code in an error handling block is listed in issue
> https://gitlab.com/qemu-project/qemu/-/issues/2030.
>
> After removing this code, the `fail` label is now immediately followed
> by a test whose condition can never be true when coming explicitly
> via this label. Moving the label down preserves the fall-through
> case while avoiding testing an always false condition.
>
> Changes from v1:
> - Add a comment explaining that `buf_rx` does not require cleanup
> - Use a unique cleanup path for the function by setting `errno` before
>   jumping to the cleanup block.
>
> Samuel Tardieu (2):
>   tcg: Remove unreachable code
>   tcg: Make the cleanup-on-error path unique
>
>  tcg/region.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

RTH: I'm assuming you'll take this via your tcg tree.

thanks
-- PMM

