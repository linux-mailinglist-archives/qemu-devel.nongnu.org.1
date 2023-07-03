Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA967458B9
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:47:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGG8t-0004R2-PO; Mon, 03 Jul 2023 05:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGG8l-0004QG-UX
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:46:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGG8j-0001yg-7X
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:46:38 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbc244d386so44101985e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 02:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688377594; x=1690969594;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=exyzw2CBVKqr84tDr8YOM5XCxFcJfH9Gd1308tVtnXw=;
 b=XD7Wc6p8idzEK+xOBa5QIlul+HB4E5izp6rar39IbunDUyvaTAiWa7UthmKr/D7tDZ
 0K2h3RVuMZLtlFrfiu9ruhjYINZhF7PkmZ9J+eX4NXZYWUHFkGn278KCN0U1M9MW7SXA
 6Cj1vMgTb9K59MuT3YviwHHwI5WHJX1/88/7L8NpH3/GseaMzins+poEyGv+vqZhYILd
 MeG8C6KRQsF8FXUyKoBPLpuaT+hYUUNBIWq4t7XVzftUaV2sMuKLy7FUbYflwm1xWcyh
 JPIt2t6MN/uYkdaB8IAD7cQkUg+rL7fMMXkRUFArjEDhpt5To1civULHD+owaT5/DmAA
 QKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688377594; x=1690969594;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=exyzw2CBVKqr84tDr8YOM5XCxFcJfH9Gd1308tVtnXw=;
 b=B7LlXCw2YHcCrN0r0/+vY83r/tV5h9FllkSuHyy7sVU7uexNipt0RtYl8wUUEqYxVr
 H8UplD0xI0AOvHV5yEpRJNHb055F0itc1w8ZzFvnfiq0SsB8W2OjSFnNa29OVdhZH+/O
 cBP8gAKxIMi792W6tiC7x3qMy9wmTSMKVKE/UxybSE5mkUimfiKbAfaM+6X7Hmqi4sRK
 bq9xlmI1pWLWkGfJ8Yh5mtdohbgnKGqGPScgjjDaUZ+gyLJedyrhT11osDMMzX4asq2/
 j8EOqgZYS6VZL4hHFahR/yFQBdrMoPBDJY8p7tXk8zHrNmqIQ3IFlznOGWOJFx4Psu+B
 f4FA==
X-Gm-Message-State: ABy/qLbaUIrp0C971NKksHldqw8A+sxsP3+qBsvKAUD1M+QdnQeNrh1c
 ZTkd+WTZfUPfQhbbD4iyhX9TGQ==
X-Google-Smtp-Source: APBJJlEejyRJLOPdV5AhivGeqqRYlnM3HPL/DGoMlxVvFVNp2qq6azODjCZYHCLmPO7VqFrMWoJP4Q==
X-Received: by 2002:a05:6000:92e:b0:313:f862:6e3e with SMTP id
 cx14-20020a056000092e00b00313f8626e3emr8137701wrb.40.1688377594648; 
 Mon, 03 Jul 2023 02:46:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v11-20020adff68b000000b0031424950a99sm7920315wrp.81.2023.07.03.02.46.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 02:46:34 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D8A511FFBB;
 Mon,  3 Jul 2023 10:46:33 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-8-richard.henderson@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 07/24] accel/tcg: Introduce page_check_range_empty
Date: Mon, 03 Jul 2023 10:45:06 +0100
In-reply-to: <20230630132159.376995-8-richard.henderson@linaro.org>
Message-ID: <873525jpja.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> Examine the interval tree to validate that a region
> has no existing mappings.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/exec/cpu-all.h | 11 +++++++++++
>  accel/tcg/user-exec.c  |  7 +++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 8018ce783e..5b2c230d52 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -224,6 +224,17 @@ void page_set_flags(target_ulong start, target_ulong=
 last, int flags);
>  void page_reset_target_data(target_ulong start, target_ulong last);
>  int page_check_range(target_ulong start, target_ulong len, int flags);
>=20=20
> +/**
> + * page_check_range_empty:
> + * @start: first byte of range
> + * @last: last byte of range

* Context: holding mmap lock

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

