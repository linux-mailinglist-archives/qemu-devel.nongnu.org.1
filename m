Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D90657755E3
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 10:50:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTetT-0006gr-NR; Wed, 09 Aug 2023 04:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTetS-0006gc-6m
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:50:14 -0400
Received: from mail-lj1-x236.google.com ([2a00:1450:4864:20::236])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTetO-0004kQ-MK
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 04:50:13 -0400
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-2b9dc1bff38so101115351fa.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 01:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691571002; x=1692175802;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A9zNV0CQgrBhe+TOw2jOHSpH/oqJPN/ge/v7pNembWA=;
 b=MaAjUVzPwhZHBqrX8aZqA0IWMgdHNyNJl8yCaAP+JjWe48Cq7QGDTphEfxY/netksc
 TOsBWQM7PSIUcoiZntiHIvqFPw6ZU7BWnTNHB++t5ye87lVctuKM12+IiZALrm0C3aMC
 v/Ig1bj2KTIJeOz60BURkon1z9awb3dSE72qRc/Bs5G1cWVQO81tkfZMW0wDmIZdqEsi
 BCWftwH9O1SlMkK8rGimb77StVoPe3uGv6oyv407VAvScifrc+B238p0WauuY/UVJAco
 lcFPg52wGLVhHr6r8KPCBuJOp+/pOGqbDw5oKmJtTg8Ta5aYh5TbnSde0FNExavtWHDS
 S63Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691571002; x=1692175802;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=A9zNV0CQgrBhe+TOw2jOHSpH/oqJPN/ge/v7pNembWA=;
 b=fc39cB8Efx9gfKHNK++83T4YpMVd8CQQNuXGfSqydtRbK/OecNdSMlbOl1AGYD4mnb
 JTMrpjjj3eY13X4rXpoKbRtL1/67PT0B8jjZjAYDtYUx4BfcwCCxYcAWe9kyqe3EV9/C
 eMFQSru84Uq1B1Oz5x/fWpFSANeMfTt/Bj0OxCAv/w31mHZjf6p12gYvg3P/My7lbMSu
 ts9Bv9J/wNfvsONnbLJc53lNUAVWHfCRbruWv+TgB44zl8hakMakllkgZzGz4XxJmnJb
 cGUBzGo/kcwHNiTxbliclzLaZAUkxSk8zNLMzTth6rwGq6guVg3EwH45k7az0C6MBxAh
 DLeQ==
X-Gm-Message-State: AOJu0YzCapJFS0oNe+eKaBaPXpjWH6W1whOHSDq/FMca+hBX4OqpR51N
 rT5DGY7c6dVsXJji6J3xWB7Nrw==
X-Google-Smtp-Source: AGHT+IFoGq8wxBgsxj/AR0zosG5pBy5pDv56vCQX0ymwhl5kzjt0L97hyBJnSVmzXXG+VsfbeThwzQ==
X-Received: by 2002:a05:651c:1047:b0:2b9:b904:74d7 with SMTP id
 x7-20020a05651c104700b002b9b90474d7mr1441775ljm.18.1691571001962; 
 Wed, 09 Aug 2023 01:50:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 v8-20020adfe4c8000000b00317046f21f9sm16119588wrm.114.2023.08.09.01.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 01:50:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 335591FFBB;
 Wed,  9 Aug 2023 09:50:01 +0100 (BST)
References: <20230809082946.747668-2-pbonzini@redhat.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, kbastian@mail.uni-paderborn.de
Subject: Re: [PATCH for-8.2] dockerfiles: bump tricore cross compiler
 container to Debian 11
Date: Wed, 09 Aug 2023 09:49:56 +0100
In-reply-to: <20230809082946.747668-2-pbonzini@redhat.com>
Message-ID: <87il9o61mu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::236;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x236.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> With the release of version 12 on June 10, 2023, Debian 10 is
> not supported anymore.  Modify the cross compiler container to
> build on a newer version.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/debian-tricore-cross.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/debian-tricore-cross.docker
> b/tests/docker/dockerfiles/debian-tricore-cross.docker
> index 269bfa8d423..5bd1963fb55 100644
> --- a/tests/docker/dockerfiles/debian-tricore-cross.docker
> +++ b/tests/docker/dockerfiles/debian-tricore-cross.docker
> @@ -9,7 +9,7 @@
>  #
>  # SPDX-License-Identifier: GPL-2.0-or-later
>  #
> -FROM docker.io/library/debian:buster-slim
> +FROM docker.io/library/debian:11-slim
>=20=20
>  MAINTAINER Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

