Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB882AF742D
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Jul 2025 14:31:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJ6A-0004Hm-1j; Thu, 03 Jul 2025 08:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ5d-0004E7-11
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:30:57 -0400
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJ5V-0006EN-MH
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:30:56 -0400
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-70e64b430daso60972097b3.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751545844; x=1752150644; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tkAbWC5TLmnYScx+o9N2DERmKBTU7is23HCejASsWdk=;
 b=U7qJck+N+u7fUA80IIxgligpyxVX7JQVr1IAMGDOzwavFnh8qTCD/8WP2cvwKZCekf
 ynlqkMUe9z9lOe6EsRACS+GYcO3qZViy3OZ6o0N6IvFexoBG3H5YGm/x4KZo8o6nC4bD
 DCpMfiC1S/FRiMFaKpT48I+hQlFxt8VUkZYbbvQz5Qftkka3TGTTRCW3mKCZX+exnbM9
 DNdiYVGpeOokyz+Waacv8jgKcdHoSc12t1PkaGGry3w3syFBt7/sAYE/UvEivTfJElf4
 mExE9KjBXNhfoQk6a80bU4jMoH3GkCZbw9nD5xBM8xJjmlD145MVBMEGPPRLnmyfC+vX
 nAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751545844; x=1752150644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tkAbWC5TLmnYScx+o9N2DERmKBTU7is23HCejASsWdk=;
 b=NdMQda5aERhoZKTQQ6sZvaKyQqbGPm5+GzmK0r3eTMwxo9e07WamDmCLgKXlX6oirh
 UkLGn+pXYF5aM0TPx/BemVYQT0vnuqNJ+MyRgluHKQmju0NM3oKfiTkdsdugwTAcDpoh
 KWdMs2QL1VgemPC+oudS47+knkOYXilp75Sv51E1mGVzcXrz9wTgHqtpAskb6IoU5y30
 iOc49K3UCI3o7QorMGbi3jcbPHG1j5sTMhyAUXJdxvmu/rKuMQcR8qXsCL90EoZnZRwF
 a2f413TtpghdIfb+JHc5j+bQ/4lksxe/orSt3/Q97p8mRRpAoo63/Y1g7PV81Yl3KxNi
 o6CQ==
X-Gm-Message-State: AOJu0Yyys54biVJP/S7K3OfkZdw6/D6KbjgQ4Giw4sVMNr54oFFWzsLY
 5W1YE6tq5CX0MJzyKtx/q17JiD2SdYUxMpfz4eaxhnjFv33YG1T7uke8p89l6OAOIRf+dUgbGxd
 te+kI8UUBMOL+EJrYAwQmFjUAL/ojpixljV2+paWHe0qgrWujHcDu
X-Gm-Gg: ASbGncvVtUWMXHD/9bw30gI+RDMzixjCBoHRHVniUuLrR1DOcrMP9Cve3+on1scixSz
 eJ1yWZ/1cXZge+0J3rV9nY/I4cP3w5V1QpbEb2Wl7pw0No704OEakHqyIFGIk5Tty7YyArwZcyO
 wdcAyDm+wr7gDe4/m5SRWB+r3CIZ0RYiJd9XDUcxvMr9WKwE31JXSMOYs=
X-Google-Smtp-Source: AGHT+IGI20e+EoShZVnoWUBmnU1KsDxHC8XVN8UCJ/56Lq7Do+Vky6/PKY8HC5gcqQmZ4nvAUw377wNYyPraJbuBRCA=
X-Received: by 2002:a05:690c:318:b0:70e:18c0:daba with SMTP id
 00721157ae682-7164d476981mr84347807b3.25.1751545843699; Thu, 03 Jul 2025
 05:30:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-84-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-84-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:30:32 +0100
X-Gm-Features: Ac12FXzAdUv6Rr86Q0IC_G5Y3RSSGie_T6WyG7dP3rTdIGoGgf7s4NXYzlLfs1Q
Message-ID: <CAFEAcA8j7+dcqwjXhyZZ1fwBEpDzg72gyXogoTioJ=0pOVE6zg@mail.gmail.com>
Subject: Re: [PATCH v3 83/97] target/arm: Split the ST_zpri and ST_zprr
 patterns
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 2 Jul 2025 at 13:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The msz > esz encodings are reserved, and some of
> them are about to be reused.  Split these patterns
> so that the new insns do not overlap.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/sve.decode | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

