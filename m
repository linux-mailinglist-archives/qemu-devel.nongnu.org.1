Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F54E75B540
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 19:11:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMX9r-0003wN-MA; Thu, 20 Jul 2023 13:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMX9p-0003w1-Tk
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:09:41 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMX9n-0000en-UN
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 13:09:41 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4fba1288bbdso1638522e87.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 10:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689872978; x=1690477778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5iaA+6Ta500m28WMLcFXycKifZZt1SSLyD8Olu6CtcA=;
 b=edpx7voUFK3OB+gtK8DA6CR2JGnEZLaS+tcWJAVmQC5vr+Urro9FEVSJIFi5i8yuDj
 AB2jDCXewjswaLGU4w7GHm2pU0QZOpRzFjrnSyUo0CB7yDtC7H5aXicGAvK0ty7YnnUK
 g8eVxWBOo/cCCYeVOvu8nshI3sAz1B3dWEvY2uyDSQDEOgDu1jK0v/aqaOHjKVQQYlq/
 I53x3VqFGK+RxB0g6tdz3GwjK/cRX7Y28a2tkWlZMFBu3YXIhWk0X7A+VJFoY5dnWMzG
 iD5elyxHu+aqZmu0KkJ9dEdhdZILHSFOjZDHmivo39WfFWXataV7rxRrxds4DTD//d50
 gxRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689872978; x=1690477778;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5iaA+6Ta500m28WMLcFXycKifZZt1SSLyD8Olu6CtcA=;
 b=cAlkJTlpRRSPhFUoc0z+rrD13CVPqGoCe6r7QxQ9u+QwWKiw0PV4UTXuQtWH+2LnL3
 aRYaX+4jXrUmNuYk04qC0axn1basCiE11lz+o6E9gfaXAGvGQqYftcxVtulNNy7F7Da3
 s5dBM3hv/n4cvqUsXg61gS/mISZQ8GZ0dPcyju0vfE5gI3MdM5v0PmLyFBudneTWaWyX
 Z1rrY7eWSAKTvTNJ0HG1h7jwvZ0Zw6C/hoqL6IRlFs5UVx7MOkya3Vb90NwQ8CVhzisE
 b5cjxRnwdHjG4iWa+4qQKkIhnXJcG9KDMVDgN0aD+2ktc9LpakECX658qP+z0IBrhafu
 uwNA==
X-Gm-Message-State: ABy/qLbJi57RYqr1aUB6lCl35Lu/fdOKZ17ozw87r2M9/KvirVgQUojM
 96ummhPA2dP/EQs1mHKXh196lJIIc9aZZifMQUh1hA==
X-Google-Smtp-Source: APBJJlGRbvCNpWa2qN+oU1b58b3KcBEVm2ygp6NxHFsRJA7RbK9V+pDImKX7WWeznsWtUBflbyOA8PV7iWIEPz1+0HI=
X-Received: by 2002:ac2:55b0:0:b0:4fb:8bab:48b6 with SMTP id
 y16-20020ac255b0000000b004fb8bab48b6mr2730189lfg.52.1689872977713; Thu, 20
 Jul 2023 10:09:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230719153018.1456180-2-jean-philippe@linaro.org>
 <20230719153018.1456180-6-jean-philippe@linaro.org>
In-Reply-To: <20230719153018.1456180-6-jean-philippe@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 18:09:26 +0100
Message-ID: <CAFEAcA-8-ekD_Hq7V-vYbZPJY+s6-S6hWtF45t_RZTHFmqmoZQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] target/arm: Pass security space rather than flag for
 AT instructions
To: Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc: richard.henderson@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x131.google.com
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

On Wed, 19 Jul 2023 at 16:56, Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> At the moment we only handle Secure and Nonsecure security spaces for
> the AT instructions. Add support for Realm and Root.
>
> For AArch64, arm_security_space() gives the desired space. ARM DDI0487J
> says (R_NYXTL):
>
>   If EL3 is implemented, then when an address translation instruction
>   that applies to an Exception level lower than EL3 is executed, the
>   Effective value of SCR_EL3.{NSE, NS} determines the target Security
>   state that the instruction applies to.
>
> For AArch32, some instructions can access NonSecure space from Secure,
> so we still need to pass the state explicitly to do_ats_write().
>
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
> I haven't tested AT instructions in Realm/Root space yet, but it looks
> like the patch is needed. RMM doesn't issue AT instructions like KVM
> does in non-secure state (which triggered the bug in the previous
> patch).
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

We should also implement the check that the AT S1E[012] ops have
that if FEAT_RME is implemented and SCR_EL3.{NS,NSE} are a reserved
value then the AT insn should UNDEF. But that's a separate patch.

thanks
-- PMM

