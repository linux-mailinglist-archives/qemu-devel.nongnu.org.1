Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7835570E276
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VDb-0005Yf-Uc; Tue, 23 May 2023 12:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VDF-0005TC-DZ
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:50:22 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1VD9-0005C1-Hz
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:50:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f611ccd06eso35105e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860610; x=1687452610;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JubtRe+D2p/2EODFhYb+rNFTEfoYf9zClUqt/rPW878=;
 b=JA4zHtM6SyHBbqlc3Lo57pcMB+PrWAVchf8zGUzNxIy4EJXEpeKSMWenICvJ7NO258
 wZGAKsE52RUSmolo87zRlqJZuttZGTWEcm7ZFLZGK2yopPeCtVya+iVSt8eb77bcSRff
 Lkrs3TZSNo/24etVeVL4FwF2R+JsCaPR1+yQfozg2k15maBNsOsE+e8tnx/VUXj+39EI
 xwOP7xijsQc3ODpxy0f+FL+RVd6RMriDP84V8vnCFhyg8gfjqi+q0MyscegTiDAHgcuY
 /AgE1KzCZwnH5DqQ9AXLMyFR4eKsqsp5Gb5mFkf/pU5/BPxsrW6voshHBOI46fk7b1SV
 ny3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860610; x=1687452610;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JubtRe+D2p/2EODFhYb+rNFTEfoYf9zClUqt/rPW878=;
 b=KRqE3UEBqLMmk6qComh+M15ocBIC/f3I3C1sOz1+B2OJnCKQAo/PgCDB8VZJCUI822
 1Oi9wltiexoj0NE31dbLRWkHI9uMOnOrSQRZq/EfwHjrQnZU8eteqo/9hLE4Zlz7V7WQ
 ud7dRbp9/N4arYWzKMobISEJzzckob4EwTuwBGfmHNXeV4U6c/ln4bAyT+c7Ph/yYERK
 vPPi/jQUoBeTl/sytYAtZl9Hz494I0hGaY/cbqCcEQU7iplh0REA6KxxWe2Kd6F/tGLR
 Gv4WBXxaJWq7hR1iVUTvBZCCDuvWQOk4eb1xooMBJe5SBwxhvJ9F62IG3/FkwEWnRO/i
 7whg==
X-Gm-Message-State: AC+VfDzTnDzfaqPzXNrczy4jKsvTrX64+pvOSsgFB0bF5E+tQGHXZAWJ
 Z6qwmwUJjuJK5oa0Cw/sZZoGfg==
X-Google-Smtp-Source: ACHHUZ7Y5AMtA7mnJ2qIeTapJfWG8z3sSkX8Sl8CnyIBSvIfPlmIM5PgtrUCCyEyyCNaSphaXWt8FQ==
X-Received: by 2002:a7b:ce19:0:b0:3f6:787:4a84 with SMTP id
 m25-20020a7bce19000000b003f607874a84mr3788937wmc.7.1684860610061; 
 Tue, 23 May 2023 09:50:10 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l20-20020a1c7914000000b003f607875e5csm5521182wme.24.2023.05.23.09.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:50:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B1A41FFBB;
 Tue, 23 May 2023 17:50:09 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-24-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 23/27] accel/tcg: Correctly use atomic128.h in
 ldst_atomicity.c.inc
Date: Tue, 23 May 2023 17:50:05 +0100
In-reply-to: <20230523134733.678646-24-richard.henderson@linaro.org>
Message-ID: <874jo3you6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

> Remove the locally defined load_atomic16 and store_atomic16,
> along with HAVE_al16 and HAVE_al16_fast in favor of the
> routines defined in atomic128.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

