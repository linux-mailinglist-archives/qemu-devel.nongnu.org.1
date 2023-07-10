Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B3074D95E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 16:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIsI3-0007TS-2z; Mon, 10 Jul 2023 10:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qIsI1-0007Sf-LU
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:55:01 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qIsHz-0005u7-WE
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 10:55:01 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-4f76a0a19d4so6891067e87.2
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 07:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689000898; x=1691592898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KuukenZcuC3POp6fp7XZmh0oSDn+VaLz2/wG6xVeHY8=;
 b=S99aeUQtl2K8ci2c6tU58Yyfyb9uFdUYEFhW/qOkMGODvoPSNVWcs4YiRgzgGuLSiY
 ABiXAxZqN/kLzmBR+2osvaZ5ge2TXpOpdlNj6wpH1WFHhFUQEvAQ4J2/CnMk4gIvaFUU
 J3y9kJHkZ5LKFiakJeTheHHBiVqg2l2gZOzDDEAiXAAWcag307WeMxOZc+jmPocS9q8Y
 cS5cQUOub3rjdVB6W5QPi+GM/y1j/sEmCihdesu6klULLaSRZH83c0a3Y5bciXTJuMJs
 PRjIzQsEGo5uROUYJI9yl9Fhx79qez2LlZWy/KCAAdehfZJKwwAfawhst0XXF49Fo2QB
 HDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689000898; x=1691592898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KuukenZcuC3POp6fp7XZmh0oSDn+VaLz2/wG6xVeHY8=;
 b=Wbs9WnKQo4fuYOe+KefYfIeLt6++lKyDIJVrv4LLnEjbs/qCVMVim+4V06waCWjzeO
 hq2lT3gmgF3ww9y3RAhW3KhLwWlL1yARWXhRS+NYB7K8+jTo/8K0RhwDNnLjPp6M0UHy
 DOq2UjTjjHZPQgGBXpI0gRBXpymqcrZ9c/ahB1B/DviTeQKhPkhYx16L6bbLukv44r0u
 5beJwyY4vIVyhd9pqcllDrP4zWU27LtgPPflbv20tFA3wK+4Z00Qm7wkk9bq/RH4q8hI
 tY+sOtFIpQo/IIB9igCDUcQvOfnWgTsk8huE4LpmV9dgZx3DwJDqopIeGC4rA5Kmb2oR
 Reew==
X-Gm-Message-State: ABy/qLbuskBjIrS8mQ8zKVzPEHKoXrTywSsSC+Zyy+uxRzNiY4HcCfTA
 e9MnLPINXlHV1K0wSmxipdwIAtqdco+CYqMVbwPO/w==
X-Google-Smtp-Source: APBJJlESX9hEh9WlI8RgcT0e7RZuI0eoBkDlsR4YIhfEPzEBs9wA/GSF096HJnxkVyzpYMCfelO+xyFmGxqMo9fnNPE=
X-Received: by 2002:a05:6512:3b83:b0:4f6:45af:70b8 with SMTP id
 g3-20020a0565123b8300b004f645af70b8mr12258829lfv.58.1689000898160; Mon, 10
 Jul 2023 07:54:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230710144348.239441-1-thuth@redhat.com>
In-Reply-To: <20230710144348.239441-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jul 2023 15:54:47 +0100
Message-ID: <CAFEAcA_QTRJwtQxh1FRHtwjSARAptF-j1ZeyGen8xBfrhq7tww@mail.gmail.com>
Subject: Re: [PATCH] tests/avocado: Disable the test_sbsaref_edk2_firmware in
 the gitlab-CI
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12b.google.com
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

On Mon, 10 Jul 2023 at 15:43, Thomas Huth <thuth@redhat.com> wrote:
>
> The test fails occasionally, see e.g.:
>
>  https://gitlab.com/thuth/qemu/-/jobs/4196177756#L489
>  https://gitlab.com/thuth/qemu/-/jobs/4623296271#L290
>
> Disable it at least in the gitlab-CI to avoid failing CI
> pipelines due to this problem.

I'm not really a fan of disabling flaky tests only in the
gitlab CI. It means that plain "make check-avocado"
is useless to the average developer because it can
have all manner of broken or flaky tests in it that
never get tested by our CI. In fact I've had to develop
the habit of running "GITLAB_CI=1 make check-avocado"
so I can run the CI tests that we think work and not
get distracted by intermittent failures.

If we want "disable this test except for if you're
trying to investigate why it's flaky" then we should
have the test be opt-in, not opt-out, the same way
we do with QEMU_TEST_FLAKY_TESTS in the qtests.

thanks
-- PMM

