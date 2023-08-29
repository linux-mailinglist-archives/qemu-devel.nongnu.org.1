Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 316DD78CB65
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 19:37:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb2e6-0003A5-JI; Tue, 29 Aug 2023 13:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb2dw-00035R-4B
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:36:45 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qb2ds-00044p-On
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 13:36:42 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-31c3726cc45so4063698f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693330599; x=1693935399;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O9wiWFJBKzOC6/vEswdX6bA5mqVb8E8xirV4sWrczaI=;
 b=iWdA2sb7GuvVbkP0r6f7tRXqml2enOIWx1ttShYYN4Q8KvCj0FZxw8CUxEcrCSFVGX
 8f0uJvXyL9sOW3x42s+VM62vi2XfdVlkQwY6LZB0aIpnVREBOlRyNhH8oxcMEmeCRslm
 34SsxBUGpCMsKMu/XlU62nyPmg4DdB+WFRgyLrtYn+8UXJLmv4PlUYQFa/Dfg5o1YARo
 XCPTi9Q2mbJvxhDR6U89eBjDkUYA8nDyq6k1cQ58FNb8PkA8fKInRr7V7vpxn2icBmaC
 ai6lH0RShYoKc8IV8iK/Z9eeDjUU0Igmo+LM3MK+2zL9EXJyGnleSDPJ11iC2UJjVE0S
 DM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693330599; x=1693935399;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O9wiWFJBKzOC6/vEswdX6bA5mqVb8E8xirV4sWrczaI=;
 b=WldBXhdzcIrHxinldnhvvniY0mlDUsyRaB3qFotJC/5droUpbZ1IW/IQfRQ8+bemeP
 kiFkis8QwDKDNEoPfUGjxMGPmfZ3A3ZaEvJgnrM/DxZH27IRN0OauS7Vpbq4qujIAFH4
 K6guuEKP/E1uTw4A5OZRaCZbzZhdGQk3YPlZwMX/rwPbmXJIRyjbsINW+ePd2PYyI3kz
 gRbGAzKeOpmxQQ9Y8KGn2L7J/K6pgkHHoNBT9q/GwHbV3+xoKApAmw3+LAk9G3kJOwWo
 MsmrRTAvdennAWVYe9vljd5Z052uD0uKpjWl2dpKR6b8EXyNlQ31FJSNQ3UHnjZyFlLV
 GrCQ==
X-Gm-Message-State: AOJu0Yy4v28lrm1muf4wWDkBS3OgopXlArngJTVJLN08NpUCrZ7rXYeh
 HHnUWlG9CcaMdG7l26+TInRaBg==
X-Google-Smtp-Source: AGHT+IFnGP4lawoDuKVTuCR4AuC6YGh2miA31qVpX5pt3upD2Rbc/gsbjfOWZAIjUEbVJrzimYPHUA==
X-Received: by 2002:a5d:4586:0:b0:31a:dbe0:ca7d with SMTP id
 p6-20020a5d4586000000b0031adbe0ca7dmr20890024wrq.8.1693330599206; 
 Tue, 29 Aug 2023 10:36:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfea4e000000b003142ea7a661sm14405485wrn.21.2023.08.29.10.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 10:36:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 544CE1FFBB;
 Tue, 29 Aug 2023 18:36:38 +0100 (BST)
References: <20230801154451.3505492-1-peter.maydell@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Subject: Re: [PATCH] target/m68k: Add URL to semihosting spec
Date: Tue, 29 Aug 2023 18:36:06 +0100
In-reply-to: <20230801154451.3505492-1-peter.maydell@linaro.org>
Message-ID: <87bkepu4wp.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> The spec for m68k semihosting is documented in the libgloss
> sources. Add a comment with the URL for it, as we already
> have for nios2 semihosting.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/m68k/m68k-semi.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/m68k/m68k-semi.c b/target/m68k/m68k-semi.c
> index 239f6e44e90..80cd8d70dbb 100644
> --- a/target/m68k/m68k-semi.c
> +++ b/target/m68k/m68k-semi.c
> @@ -15,6 +15,10 @@
>   *
>   *  You should have received a copy of the GNU General Public License
>   *  along with this program; if not, see <http://www.gnu.org/licenses/>.
> + *
> + *  The semihosting protocol implemented here is described in the
> + *  libgloss sources:
> + *  https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dblob;f=3Dlibgl=
oss/m68k/m68k-semi.txt;hb=3DHEAD
>   */
>=20=20
>  #include "qemu/osdep.h"

Matches what we reference in emulation.rst so:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

