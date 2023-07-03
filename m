Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE90974584C
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:25:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGFnm-0005Xz-UY; Mon, 03 Jul 2023 05:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGFnl-0005Xr-Mc
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:24:57 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGFnk-0004zr-5M
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:24:57 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-4fb863edcb6so6723806e87.0
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 02:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688376294; x=1690968294;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apImeO7Yp+sW3Vq8Pq7YXzMRP4hDiet9X46j+VygS/o=;
 b=cSqIBivgi9BXZcStozQCaAR0wnhpA7mgBDh/ImiwRRmbEhYvfHEJ5levCu4fqEStzy
 mLzxJjP1DCH4bHQ9N57TkWdic034GFKcmmUtZMeD4RrszLKPLugFwwcsM/vJWRZzwfYB
 yMx2AENyX5mckwZQBkXMpnLYUF+AOepPrlTl95PRsuSx+Nq+vZByVs7XH7C+TGoW66m+
 HHFqdKaD5/lqneCn2rmCfkbgh7FoRm+iBZoEuitymSJZ1/1NF6taWbEgWpcF0uLz3MzV
 8LgwaPZ0DN88q854EAbRbzJBPVmVA9QhQW5pfFFfJp96/NyZYF9mJ4VHGcBLqzsfXLbA
 xWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688376294; x=1690968294;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=apImeO7Yp+sW3Vq8Pq7YXzMRP4hDiet9X46j+VygS/o=;
 b=DclSooHo7csGShY2vOWXjazA8rE8q2w06B7DM4EkL3jc5ytf2rh2Lu6viAybx5SY5v
 PU41KmJcjEvXLFa6kCJDt4iSiUO/Z2Wh3sUPua7Fj6fgooRrWmpyDEYoeEPTcZFb7HFu
 Rh5QZaUI8jcoNyzVJ93DSceFsiMjJwndxh0PJwvJPQck2RDpT7xYNW2M5DpB2CTzG3ex
 dUqwvO5O9OsPd3CEJsYGgDGlaTYDct100GLJV+5JggfOIozFSHwD40ZFfb8UWnVk3EYt
 KX+DtUsXg1LugdpsQbhbbcseu/2DuYW3vrOHRrNzIp89lGL+QCW7Jr1Z1eO6ahtbi7t9
 +ZRg==
X-Gm-Message-State: ABy/qLZ5n/9WAhtBy8FEp/F2MsiA8eQ+YW18JFdTgHz0hQ+Xax3HMq1h
 X9OA43mC3vSDLgrhIuD8rHuAoA==
X-Google-Smtp-Source: APBJJlFdoKoVnYLj+Bo6Qawx7Hyx/NrR8wvEoRxixKmuJvj9gahNE8Bl/gNyNzvrWWX76JKei+A/Kg==
X-Received: by 2002:a05:6512:78c:b0:4f8:5e49:c613 with SMTP id
 x12-20020a056512078c00b004f85e49c613mr5999582lfr.43.1688376293824; 
 Mon, 03 Jul 2023 02:24:53 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a20-20020a05600c225400b003fbb06af219sm14633688wmm.32.2023.07.03.02.24.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 02:24:53 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 105341FFBB;
 Mon,  3 Jul 2023 10:24:53 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-4-richard.henderson@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 03/24] linux-user/strace: Expand struct flags to hold a
 mask
Date: Mon, 03 Jul 2023 10:24:48 +0100
In-reply-to: <20230630132159.376995-4-richard.henderson@linaro.org>
Message-ID: <87jzvhjqje.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
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

> A zero bit value does not make sense -- it must relate to
> some field in some way.
>
> Define FLAG_BASIC with a build-time sanity check.
> Adjust FLAG_GENERIC and FLAG_TARGET to use it.
> Add FLAG_GENERIC_MASK and FLAG_TARGET_MASK.
>
> Fix up the existing flag definitions for build errors.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

