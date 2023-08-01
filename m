Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF576B46A
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 14:07:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQo9g-0005Dt-9U; Tue, 01 Aug 2023 08:07:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQo9b-000596-Jd
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:07:09 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qQo9a-000811-0N
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 08:07:07 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-522b77956d2so4122486a12.3
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 05:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690891624; x=1691496424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M850cRbkeF12K78EW7Ri9GvUclJuEdDeipPXj8dJI/Y=;
 b=vubYbVcYDZAHE0GcWRQ186LRGZBZcNel04B6t/CE+ENCRnTfYxXubS28kBkWHE9Hiv
 RJ8U5FU67Qp7oJ/x3mvf6u6F0KjRKR6mF5V133w/V/WQGykVrjtkWkokzpipUjllGbxd
 LEVq3ZnIxMyhu1z7HUmqBkocWr927bmlQyq1uzHcNdlKfUlR0nAQ9N4PXTyuvyWYaaCM
 QDwyB99r7kbXKS15uyOa+kziZ9sepuNjjkf/OqUQ49au5LmYteYrc2ZtzQlhzrsc0I/4
 1a8Q4UOaVD/K8lmO/zYxOBMheLX+cz3GMejK3XwqZvDxMwF3ssGMaRV3hztZg6DrwXxF
 MAHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690891624; x=1691496424;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M850cRbkeF12K78EW7Ri9GvUclJuEdDeipPXj8dJI/Y=;
 b=A1pqs/tvYrLt87FmdBr1qM1A8lu7KrBmM74RCtuctwyy2HdKAw59ZJupttxAP9ozwU
 gkG0m8ljM1ql19maArS6EKCduPhrqwCr0hCHYDFM4MS1l+S2XQvWnAhmOg+FEMIy6KoO
 fz2LWVsfZwZBlFdxr+l5smDQfmCZrV2eMmh2bPsysWZ2Bb0H+hwt+vQqsbrpfEP95KW8
 QObrKQI3HLPdo41ysf9jtAdadF2ZfVosxu/NApC8vY+2gnoDkgGdQ8UzAankW/JRmj0I
 da6KtPUDoiNVoTsGdTxB0NlLFWhD7F1KcE/OElTxy3vEuqO7NKZiCdEhqSuqMgxHMO9w
 4Heg==
X-Gm-Message-State: ABy/qLbwsC0oE+Ge1jFcbwnf7Z917HQdQp8pwbBW9+UjZ/ogIEXIXFJY
 Zu8z8t6VDvOEa+vuwONHlmZxseBFnY/bhVijivMxKg==
X-Google-Smtp-Source: APBJJlHSCIfPRrjnpLldzGN3L4cDdDJsXUoaL+ay25lZHc+/zSGwqYhP+abQSKin/kc1vpvH+AbbN9Wl1GQS7Ebqyyo=
X-Received: by 2002:aa7:d699:0:b0:521:62a2:d36d with SMTP id
 d25-20020aa7d699000000b0052162a2d36dmr2297680edr.18.1690891624319; Tue, 01
 Aug 2023 05:07:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230731235245.295513-1-keithp@keithp.com>
In-Reply-To: <20230731235245.295513-1-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2023 13:06:53 +0100
Message-ID: <CAFEAcA8Q_qjJV55v0M4LwuK-2tuM4DaBVsmP5vAVogt8Hq98vg@mail.gmail.com>
Subject: Re: [PATCH] target/nios2: Fix semihost lseek offset computation
To: Keith Packard <keithp@keithp.com>
Cc: qemu-devel@nongnu.org, Chris Wulff <crwulff@gmail.com>,
 Marek Vasut <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Tue, 1 Aug 2023 at 00:53, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> The arguments for deposit64 are (value, start, length, fieldval); this
> appears to have thought they were (value, fieldval, start,
> length). Reorder the parameters to match the actual function.
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
> ---
>  target/nios2/nios2-semi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/nios2/nios2-semi.c b/target/nios2/nios2-semi.c
> index ffd1f095f6..fc1df1dfeb 100644
> --- a/target/nios2/nios2-semi.c
> +++ b/target/nios2/nios2-semi.c
> @@ -170,7 +170,7 @@ void do_nios2_semihosting(CPUNios2State *env)
>          GET_ARG64(2);
>          GET_ARG64(3);
>          semihost_sys_lseek(cs, nios2_semi_u64_cb, arg0,
> -                           deposit64(arg2, arg1, 32, 32), arg3);
> +                           deposit64(arg2, 32, 32, arg1), arg3);
>          break;
>
>      case HOSTED_RENAME:

Fixes: d1e23cbaa403b2d ("target/nios2: Use semihosting/syscalls.h")
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

