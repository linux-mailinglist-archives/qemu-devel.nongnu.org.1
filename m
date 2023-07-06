Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3AF749BCF
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 14:31:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHO7T-0006ij-4A; Thu, 06 Jul 2023 08:29:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHO7K-0006iJ-Qk
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:29:51 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qHO7J-000477-0w
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 08:29:50 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-51de841a727so953753a12.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 05:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688646586; x=1691238586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9WuXS1bpnCIT0yUrBldYGQxYo/Xm6JygWdrvtRk+JkE=;
 b=sLVIDt4vGua6yIgv/UWU3fQVpzsnHMSoOtzIPKk2Y+hNspPUZ4WC7JEM3wKwtH37sn
 aZF+h1Oq9i2+4+b2rTEQDJLOZ7tLWzlz3osaLVhQxRzOg1rnuSPJJpj04DY1yucTC76D
 mg47D/z2N2AuiRrrT5UxEoNX0jbhnHzHJyjp0fV8oLQNF70BwFzpOnyuouWYoE/zt0/X
 mJximP4LaAf1OMSjIBBako3aAQ7uWnh/WwIckHjyaU1vDVESUclSXkBR9/Dty47liv3N
 QGLrYGrwjIbP24cNLBmucOQz9ihyqu2sbyS9AV15RCSfAyUmhHxXK11GwkGCcxOW+dCp
 AZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688646586; x=1691238586;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9WuXS1bpnCIT0yUrBldYGQxYo/Xm6JygWdrvtRk+JkE=;
 b=k9grErq5tkbqtrHe2sX0Gvf5DcvgIJfjeQHssGxLQ22ESNVk/m0smTW4HXJN63IcM0
 7IuYYbcxmA65YTviQE403v/1/3vTqjL1whp9eDcybbHaPTXf+5vok+2oEfMROscCWq+D
 1RTfQ1sxPwnRHcFx7gefg7To6Elz9uk4Rk0BwcOFNwaOxNGBFqefY+m4f/NPWr7kGtl/
 OnPHvPjb48ILFRwSRsj9aazaul2znb6BQv4lfPGFMIEA1KulL0MPZTS+Nt6El3Ux9fmI
 IzRHeWIhwTU9CvcUDHck0v+1RAYMSjcySlYdc0/21Mhj49T0V0QIWRRmUu9zinCnAV88
 PHxA==
X-Gm-Message-State: ABy/qLaEqsN2LftqoXJNE2wA+UHBWI0FUsr5+dd6t1SYEKRA3et6At/J
 yoNpJRxPlcLOEYxlfzRADM9O1WDFiEzj9tg+gz2cPg==
X-Google-Smtp-Source: APBJJlF4fHWxch2udr2Ob7SbGxmadMyI25ISD9VSsETmdNr+DuSx4ahmMWn0mbO8R0MU8I79RH4wpgJo8NmdxrZOh9s=
X-Received: by 2002:aa7:cc15:0:b0:51e:1690:1b97 with SMTP id
 q21-20020aa7cc15000000b0051e16901b97mr1436602edt.19.1688646586659; Thu, 06
 Jul 2023 05:29:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
 <20230704130647.2842917-3-peter.maydell@linaro.org>
 <efed6e67-beb2-dc60-18c5-af0fe1431f0b@linaro.org>
In-Reply-To: <efed6e67-beb2-dc60-18c5-af0fe1431f0b@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Jul 2023 13:29:35 +0100
Message-ID: <CAFEAcA8itOZACU_MWTzZHUf0Nt64LBGcSLJ9Qry9xn4PCw2W+Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Define neoverse-v1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 5 Jul 2023 at 15:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/4/23 15:06, Peter Maydell wrote:
> > If you're checking the values against the TRM, note that the
> > summary tables differ from the register description in the TRM
> > for ID_AA64DFR0_EL1, ID_AA64ZFR0_EL1 and ID_PFR0_EL1: we
> > trust the versions in the register descriptions. Also the
> > MIDR value in the r1p2 TRM isn't updated from r1p1.
> > The CCSIDR_EL1 values in the TRM unfortunately seem to be wrong:
> > the comment in the patch describes how I've calculated the
> > values used here.
> ...
> > +    cpu->isar.id_aa64mmfr2 = 0x0000000000001011ull;
>
> I see 0x0220011102101011, not in your list of exceptions above.

Good catch -- I must have cut-and-pasted the neoverse-n1
code and then forgotten to update that value in it.

-- PMM

