Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E7687560BA
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 12:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLLfA-0007DC-In; Mon, 17 Jul 2023 06:41:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLLf5-0007Ae-UX
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:41:03 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qLLey-0002m6-CW
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 06:41:03 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3fbf7fbe722so44180785e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Jul 2023 03:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689590454; x=1692182454;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=msGfijVxJXyEYc5RqzN54Vj9fnewJKFB3xuV4h78nck=;
 b=W/ybpD3CgmfcTIoLPgHOtu1r7ymjeqoDCvIC0YzP/LP/kfBmcSAoK7EGwFNM+V5bA/
 zQaLZj+AptuhylQu4Mvnldg6MwhauBStBWlu0vc49my7goxdX/KSHpeBCdPwKlsJyFw2
 FmfTm8iMRs7YkHr5Cf8Bl9nzXrrD2IGHxRYEuHf+buj19uvhEl76blgG/HwSVaPQU6Qo
 uCS2qOF2EL2gRT+VQ33DNnBAY4S0pql//7afAtgfuYkjPoGsXxFPE7zowsVlIbWkrmeU
 Gb14D4ksmkgFRPonPooK8Sifq653hYSVP+xJQ0YJbIMbMk+0J41wJL3F6aYh1RBgiZ8m
 fM5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689590454; x=1692182454;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=msGfijVxJXyEYc5RqzN54Vj9fnewJKFB3xuV4h78nck=;
 b=FnMcDbi7F8gkJMVUSl1Nnb0XcPdFUtAmyCRpjqCuLeGUT/E5F53nDUkq5lMEiaGWzo
 T6i9ufeTh6Sp5e72vUXCsUB2tvI1xJwoDNIWj1YN2Rak8cFu41jzbGSiO9w4kyI0ecGK
 uzxegPeYYbCrFzzixR2riRJgNCG/nayPO/JjHnZMGjzdaoKzo93fpxM0OokkifLZCHIZ
 zNl7mPRjAT3K+H4EDr5e0lEpd9837MUtC/2y6dBe6U8W+5+h58kybtCSxC5a+9xl8t0S
 QY2pstwKniTaa68J9H4gtv8XhTzBAW6LsfdjnhJ6PdGMasRMSe66xaGqQaTjBqWMkgz3
 Kbrg==
X-Gm-Message-State: ABy/qLbCLtWgLbBi8gOFTTZFymUyuyEbdfy0ZIspLRtVVrnAjREGWagE
 afl+yvJfCa7hwPJRYG5aNF0mU7RbkXkm1Rp7QUk=
X-Google-Smtp-Source: APBJJlEqaGnlOveJ3yiU85KObZ1sMJuRG+TQjGXbkor41JexRZ9WQNWa+gcmXk6A1ngHkFHZHa7+uQ==
X-Received: by 2002:a05:600c:280b:b0:3fc:855:db42 with SMTP id
 m11-20020a05600c280b00b003fc0855db42mr11622358wmb.34.1689590454382; 
 Mon, 17 Jul 2023 03:40:54 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 23-20020a05600c229700b003fbb25da65bsm7716128wmf.30.2023.07.17.03.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 03:40:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9B9FA1FFBB;
 Mon, 17 Jul 2023 11:40:53 +0100 (BST)
References: <20230716170150.22398-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.9; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH for-8.1] accel/tcg: Take mmap_lock in load_atomic16_or_exit
Date: Mon, 17 Jul 2023 11:40:24 +0100
In-reply-to: <20230716170150.22398-1-richard.henderson@linaro.org>
Message-ID: <878rbeyg5m.fsf@linaro.org>
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

> For user-only, the probe for page writability may race with another
> thread's mprotect.  Take the mmap_lock around the operation.  This
> is still faster than the start/end_exclusive fallback.

Did we have a bug report or replication for this?=20

>
> Remove the write probe in load_atomic8_or_exit.  There we don't have
> the same machinery for testing the existance of an 8-byte cmpxchg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Otherwise makes sense to me:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

