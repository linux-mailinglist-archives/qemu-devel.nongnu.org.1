Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A0708511
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 17:35:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzfeu-0006Ab-GG; Thu, 18 May 2023 11:35:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzfes-00068e-04
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:35:14 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzfek-0005GJ-6B
 for qemu-devel@nongnu.org; Thu, 18 May 2023 11:35:13 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3078cc99232so2081971f8f.3
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684424103; x=1687016103;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=65mbSCl4qhjx8yLaKgwZoCu5/+bZUkogNpGe3qPlx4w=;
 b=VG5InwNjb7inV15ZZgCa5Wi7ivFR/aYW1iRLsl1Zf1RoabLceo/Kbt1xdx6GvccB8p
 8eox+wX8U0atkg3JGayvWzc5F6jk/9grdjfRLFGUenC41HIOBSTnGXSUtX6I/0PzEyNX
 hTs/jg7RGv1Xi2HnZ7Kf9G5I9w9elWnDHWKGSwZysuWQKaaSLlndPRfD1jJA8wjnk2wG
 WTOEKh9Jy7B40551Gg8fyoar+xa7rDN/kvC1Hr0bpMD9FBa2+6mEY2QgOjXN7zXXGONX
 70fPSaR3Pb6BQs2IfD1Z/KIdQt2Q2ys2KE3i5nJfH+oOiURun7GNgPokV7Bde72Txf5a
 rDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684424103; x=1687016103;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=65mbSCl4qhjx8yLaKgwZoCu5/+bZUkogNpGe3qPlx4w=;
 b=E9PouqWcEL5sMftSItQYLu/Vq424QRj63hZL7mJ4yr/pTptHO1ccR5RJCzUJf+EAM6
 vYnpt3o9i7G4BF1VA/dlIXUKSMGsi0rF+YvI7ttDQZKYwMAInULN51WWbLWroIkG6sWB
 9goJl2nHgzzeUasdu/mRa77swm2iPJmex0tGNsT+lH6CbGR5iu3Ls+xCO2+efTw4ZHQs
 Rhj+vO66lw9VNNKjKr2gJB8gje4UND3v3+t4JaYGIhE3dO6zQm0l+9+727mA2usxt5K7
 CMo7UMez/L04ejOTeEIU6V9cnUnPM6k7hXymveuQ2k2gckDrhcxLz8Qa+z2dWfWY+6Y9
 X6Iw==
X-Gm-Message-State: AC+VfDwlUR1FLRE2xQpL3uoA2Cy3EkhYS3vLdMo7Zo/9azaRbQELT4rC
 cMBpT/jcPIba6El8Ok7TwLn84Q==
X-Google-Smtp-Source: ACHHUZ5IQvp/MwLh8u12OKyk2AHKb2OUuhM51ZnVzxAxEhtO5u4AW9kO08QPZedWTYRDM87FZ4JjsA==
X-Received: by 2002:adf:f591:0:b0:2f9:dfab:1b8c with SMTP id
 f17-20020adff591000000b002f9dfab1b8cmr1576309wro.50.1684424103385; 
 Thu, 18 May 2023 08:35:03 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w4-20020a5d4b44000000b00307a86a4bcesm2506149wrs.35.2023.05.18.08.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 08:35:02 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4CE241FFBB;
 Thu, 18 May 2023 16:35:02 +0100 (BST)
References: <20230518145813.2940745-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org
Subject: Re: [PATCH] accel/tcg: Fix append_mem_cb
Date: Thu, 18 May 2023 16:34:55 +0100
In-reply-to: <20230518145813.2940745-1-richard.henderson@linaro.org>
Message-ID: <87sfbtlkk9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

> In fcdab382c8b9 we removed a tcg_gen_extu_tl_i64 from gen_empty_mem_cb,
> and failed to adjust the associated copy, leading to a failed assert.
>
> Fixes: fcdab382c8b9 ("accel/tcg: Widen plugin_gen_empty_mem_callback to i=
64")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

