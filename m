Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71774722BDC
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 17:48:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6CPs-00086Z-0n; Mon, 05 Jun 2023 11:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6CPN-0007rw-Kn
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:46:13 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6CPH-0001Mh-OD
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 11:46:13 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5149e65c244so6611017a12.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685979965; x=1688571965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RK2epgLfJZg7sBA9WkIiTYOggoFxRhWM8DjPulhiTng=;
 b=onXKx8lAJ42qE4LCdTpzgMXCnG96doOT+1DEVjGAeOsFSExj7l7ZMALlPEFVN/J9gL
 Ve09a7ZkXIvNmkT309ALWP483lQUZG0qpsKNFf9NZG72XbhmeU0Ng0m6+tMDSCtSC/iG
 PxIdRMIvbZuLTrSh/t2eJWQTG//3kz+d6SRUbshpmWwVY5hYT2rBjWwCAwwvNw/3PdKE
 CJCpayeOTLLtyM6XB/db31G+Rb4dvoFV98NoeDTig82TYIdds8f9m8elxEKskASnwqlt
 9/hGfRguZpXQFOedNLMY5PK7ks6SjM3uYA0xF2URxE2ye0+3ACsV2DVpdyQMgZRN9IE6
 +jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685979965; x=1688571965;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RK2epgLfJZg7sBA9WkIiTYOggoFxRhWM8DjPulhiTng=;
 b=aZuqOfGhT2Nu3qILeACp1fQmi2SkRkuGgnd59gGsdfX/fxhEqyrVZN+2YhI+40wYvz
 OBjQWxU74btkHURrRrlzCjxmsSbWQR0M7hoLbdIJAL7ISofDZkW68svgGK45mtrTZjYA
 svKmvwYVUyXE6YhcamF+sdOQ7A877Z8Wa/F8tOQjdhao29ABF1TdfecqVMu7jRpJbDkS
 eeYtL5eYLJILgECqixcy7WpcDQIAFs3kFnMftkX5PtmueXBY+RNHN4kT7LC1G8yaELL2
 jXddYN+lrxY4nAI+cSfTtSVpOzpHON6WRZrGQBfIS60hfYviuxDoncFSskhXG6JKtMYs
 qgcQ==
X-Gm-Message-State: AC+VfDysRiL52oqWLqrzAPeK2YbgsQojNGeUiL7bhCkpO16Mfv1Rz/gz
 Pz/T1CvbVpSxJKPYhi8iYWUPC8jyHqMLaG1+IAjO5g==
X-Google-Smtp-Source: ACHHUZ6pBoXmAwCdK5V+Dd64KfuVU5/h9NQGST2T2K3e8/HT9Y5UckVCvo5opiIktCTVaaqLtt74+oCKJ/87t4ma4Gc=
X-Received: by 2002:aa7:dd10:0:b0:514:9422:37db with SMTP id
 i16-20020aa7dd10000000b00514942237dbmr6732781edv.39.1685979965492; Mon, 05
 Jun 2023 08:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230601163123.1805282-1-berrange@redhat.com>
 <a0bb4c2a-92ad-4290-3eb8-4168b8828d76@redhat.com>
In-Reply-To: <a0bb4c2a-92ad-4290-3eb8-4168b8828d76@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Jun 2023 16:45:31 +0100
Message-ID: <CAFEAcA_Rki4zcS8v9O=AhhHXVMMCskEebzKqfYirKYH8LcFujA@mail.gmail.com>
Subject: Re: [PATCH 0/6] tests: enable meson test timeouts to improve
 debuggability
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Mon, 5 Jun 2023 at 15:08, Thomas Huth <thuth@redhat.com> wrote:
> When I run them manually without the timeout patch, I get these
> values:
>
>   qtest-aarch64/test-hmp             OK   168.66s   95 subtests passed
>   qtest-aarch64/qom-test             OK   646.37s   94 subtests passed
>   qtest-arm/qom-test                 OK   621.64s   89 subtests passed
>   qtest-arm/npcm7xx_pwm-test         OK   225.48s   24 subtests passed
>   qtest-ppc64/pxe-test               OK    96.95s   2 subtests passed
>   qtest-sparc/prom-env-test          OK    95.94s   3 subtests passed
>   qtest-sparc/boot-serial-test       OK    92.96s   3 subtests passed

The qom-tests being slow is kind of expected, since they have
to go through every board and device, and there are a lot of
arm boards and devices. That npcm7xx_pwm-test runtime is a bit OTT
though for something testing a single device.

Would one of the Nuvoton maintainers like to take a look at
that test and make it a bit less of a hog of runtime ?

thanks
-- PMM

