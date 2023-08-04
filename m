Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5D3770714
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 19:28:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRybK-0000jb-7i; Fri, 04 Aug 2023 13:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRybG-0000ir-Re
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:28:30 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRybF-0004ZU-C2
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 13:28:30 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-4fe27849e6aso4066996e87.1
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 10:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691170107; x=1691774907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HKSGMt871RVYZS+5tOox3pOxnzR9gBOIV6Eu0azAJPw=;
 b=KFjb51Ij6sPuGiIKf/YMU2Em4OZDiUVowdxbaUgfXrjvLlRFUtmlrB3jyjS1fkYHHX
 fRbv9E0e2sp6u4KPOndYQHxvpzwg7B7LGtNUS77C4AB0evzBJBKFSJsQPyrbL9lLCZVN
 x28yvuUy8/xJ4bP/25Xvk0mPVszJpJ9bWkkfcie9VMFzYJ6a9BqQUXULFBn43OmREDln
 mJhMmpggF5AszKv76UrLnF20hp73dDRbzcttvyq7LDrsW6fMmubHwPZ1bGX1l06Tg27T
 2pj97XveFkCMBNGrHIyoojCk0U15omluXF0XBspurRzrayrTFprQ1wpU6hUip8FEKuD6
 rZng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691170107; x=1691774907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HKSGMt871RVYZS+5tOox3pOxnzR9gBOIV6Eu0azAJPw=;
 b=EfbXQAUpGiXm1AUGlH84lWDeIFSrqEO0uo0YWSjN4L4YEP2D+JPIbd4SNNXPsKjJ4H
 k1XGz9M8onWh8UyAwrNEgJBvdi78YFxzMNO9fUncvfgSTo1wMXH6BB7MHo1cVhs2XMoD
 2aNn0Bf2h0bVV3ZdWngfcKJmYs8+LkIz6CFT8cVLshNbyJD5+SItu2GEksh1HVZcUt/0
 Sa6nT9StCj0Bj7kbLJTlfix80VbXL/iRWtrJMOI9wGz3HSrvAun6Pz2ZZyMMhTVjrr4E
 i0oueWDVSN21GkaWeYFq35pYOymJmKSLKUK6BjE/jmQNf1JKBZgwcrVfaAxzSglUXPHU
 VGRA==
X-Gm-Message-State: AOJu0YySm8BwdXsYDE7b2YVsIMeA3G4awATKMc4OSN3AwUq+7IWstQRV
 4vS6Cs0+ScVyMV+7BE/xWFRqmbgG6pcl8gpgoXc83Q==
X-Google-Smtp-Source: AGHT+IHQxkeA2nas0OeekVbqY2UD/Pz61dr4YS4Lam7gY5N4UR6qkwnyZ8ouTkqpaET9sgHNbrrZZD96j8sd7Q3OxmI=
X-Received: by 2002:a05:6512:3b8f:b0:4fb:8948:2b28 with SMTP id
 g15-20020a0565123b8f00b004fb89482b28mr2407101lfv.63.1691170107789; Fri, 04
 Aug 2023 10:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230727073134.134102-1-akihiko.odaki@daynix.com>
 <20230727073134.134102-5-akihiko.odaki@daynix.com>
In-Reply-To: <20230727073134.134102-5-akihiko.odaki@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 18:28:16 +0100
Message-ID: <CAFEAcA9dGh4iq+gVOoMRHhkS-VhWwUUtoeQ4r-1YuK1kDMRABw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] accel/kvm: Use negative KVM type for error
 propagation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12e.google.com
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

On Thu, 27 Jul 2023 at 08:31, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> On MIPS, kvm_arch_get_default_type() returns a negative value when an
> error occurred so handle the case. Also, let other machines return
> negative values when errors occur and declare returning a negative
> value as the correct way to propagate an error that happened when
> determining KVM type.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  accel/kvm/kvm-all.c | 5 +++++
>  hw/arm/virt.c       | 2 +-
>  hw/ppc/spapr.c      | 2 +-
>  3 files changed, 7 insertions(+), 2 deletions(-)

I might have put this earlier in the series, but we get to
the same place in the end whichever way around we do it.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

