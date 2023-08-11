Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AE3778EC5
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 14:11:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUQyb-0006bc-9C; Fri, 11 Aug 2023 08:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUQyY-0006YF-M1
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 08:10:42 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUQyX-0003nc-4z
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 08:10:42 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5236a9788a7so2541523a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 05:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691755839; x=1692360639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R+YarypYTGCN4jmeBdUW732G4PzAZjpDFadIlIjD8OM=;
 b=jOI6++QGG/LU8u4G1T+IsW7+1rI3UAin/8X9x/hLyLHP5WqQ2A/usxeJDmKgivMNzR
 rZo4tFc4FcjRSyKPRQxyjcBuhLjkmO0HLzn1IiAU8k+5fo9MKWUpPj2uJ3BJ+Z/NL93I
 k4amU+c5z2fxyrr8YGlMZkjw0scGOXLSiJu9MbZTt1TGHDX6Mpj78uEjiVxjTLdrhl7b
 0YCByy7czyhD/wsHhtYT+v6IHZeI1j9PALvCXnXysYrBAQnwXzianGOtx7ig2kXFQ3Fq
 ahKAs6mm48rBajuFjEFlu+O1FJdBXWOcJo4TxcwaODxY1J+kpJaBqLBAk9+FL66xq3RC
 Hoeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691755839; x=1692360639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R+YarypYTGCN4jmeBdUW732G4PzAZjpDFadIlIjD8OM=;
 b=S+0u3PqktSIMpbAImGod5EgSgyciJUtpK9qgE9Z0wHFMb30IdkhJFYNOXm9NkNK98V
 arFRHd3vuIm+XzJ29C8UZQghYXwIZMz0dyc8+lxeHb/WelNKMaZfqNCc28JhOCAXWXUk
 +bSFiYGvthVDMEYJSfHJ1T3SUjlKz3HnatirKkeoCcwGv8pToUEX79ivGpzGd4L7gi6T
 vgVleeh4aluwHgtzeOKIDqsiZIdv1g9pQxwAlDByPLhNPM2dR38gx2t85KUangMusR+L
 kCitAA2yYgs0+rBBspBeRchEM5g3D1XyaiKc1IMyWkUjqF3TI8fqKA3YqiYrx2Y/5c4L
 G5OQ==
X-Gm-Message-State: AOJu0YyvuAFcTTaF+NZGW8y9FdoTdb0uRnKFkH+iOJ0xsxhHt/VaCsyf
 UmEv3AYWbjcJ6yht8TA1YdLSkQjz0wgGZ6yH3g/X9Q==
X-Google-Smtp-Source: AGHT+IHGWoicXdpRmtKOB+gbjVb2w3oE3j/o7ote0SMro6U27rm3uaEsGFx6zVgPWTopt+6rLT8e5aF3+WJBaRboebE=
X-Received: by 2002:aa7:d1d5:0:b0:523:102f:3ce0 with SMTP id
 g21-20020aa7d1d5000000b00523102f3ce0mr1569364edp.21.1691755839657; Fri, 11
 Aug 2023 05:10:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-24-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-24-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2023 13:10:28 +0100
Message-ID: <CAFEAcA8ox9sM-86a=U22fOnmV1wBROiaCyT6vaUrXA46Kk=X=g@mail.gmail.com>
Subject: Re: [PATCH 23/24] tcg/i386: Use shift in tcg_out_setcond
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Tue, 8 Aug 2023 at 04:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For LT/GE vs zero, shift down the sign bit.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

