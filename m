Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF38C726265
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 16:10:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6tq0-0006sP-LY; Wed, 07 Jun 2023 10:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q6tpy-0006s9-SI
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:08:34 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q6tpx-0001XT-AH
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 10:08:34 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f732d37d7cso46063925e9.2
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 07:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686146911; x=1688738911;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RomZUkoTtHzCWCG1ESR4VA91ZiSsX+Xz1hyNwD/m9j8=;
 b=TctUHRxrl89c1xnTW8/njP71HYZktRFGzlYQApM6yrkVAmuucTT49Ustcv2mYp2LcG
 QU1g7wrD93+Kk597WESUWz8GclAx4VejU+JExRyUYAs6v71QA1dabqXnGoyL2v1/zW+U
 GTWL8JAHa35/YDqUw4mtUVpdzplhKfHQsk15BrrVXNShiRbxoEZs1lGUyRhfmjLkvGL2
 znaNSpns1e+EJxi35xWjb4E9eRlChAt+xudh8HoHPdAFXf5xo4olYMWBRlMFxeYOjTA5
 M9tRUnowllLg5qvOuCIHv1HU6VojhtCVNgl3/fXyahBAUleUwhcCnUs3FX4gv/dOSuoh
 9GdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686146911; x=1688738911;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RomZUkoTtHzCWCG1ESR4VA91ZiSsX+Xz1hyNwD/m9j8=;
 b=hnH7/PAXalbUO0C0pYmzM9id41WvwWHUDl0lhQxraPLoBCYDFZFpsR2+v/zwyzRTd8
 aTCQMncMxTTXrbSymXFLNyTpGcmzhnL2ACdh4CbnOiPbGn0upwuUZ/12AEQFFID53e7D
 fzRq4QGvcPiGz7WTpMKdgbYXwjOJMmPAbPHRkz/+YEqc+Pf7TEIKw6TEUI5aGv+pqtGb
 xE23aZy1nSNWH146O/CljY6JLcLqL3jQab+DbNlxl6XUXFHDwLDJBGNbMWdtOniagHPV
 0eD6Z+VM4S3LAlOUexydJhnDoml7hGayWrzwK3p12kTVfNVKMP/wpmZ6DFAJExk2J6dD
 SHFQ==
X-Gm-Message-State: AC+VfDxfpOh5IFyHRz0dsDfxjzGlNpa3L/gNSHydgSBOfzKnQyIhmPtm
 GZDK5aDZyVIBZpW2IccWfkNuJw==
X-Google-Smtp-Source: ACHHUZ6QbeV5lcPxzY/tq4laNY5tasefQzGBZcfJ9QWMEhk2xvyGYUrhbeBqABxmrwELpxIcxvWotg==
X-Received: by 2002:a1c:f611:0:b0:3f6:a44:73bb with SMTP id
 w17-20020a1cf611000000b003f60a4473bbmr7892064wmc.8.1686146911499; 
 Wed, 07 Jun 2023 07:08:31 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 6-20020a05600c028600b003f41bb52834sm2234387wmk.38.2023.06.07.07.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 07:08:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B90E11FFBB;
 Wed,  7 Jun 2023 15:08:30 +0100 (BST)
References: <20230606192802.666000-1-thuth@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-ppc@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>, Kautuk
 Consul <kconsul@linux.vnet.ibm.com>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>
Subject: Re: [PATCH] tests/avocado/tuxrun_baselines: Fix ppc64 tests for
 binaries without slirp
Date: Wed, 07 Jun 2023 15:08:25 +0100
In-reply-to: <20230606192802.666000-1-thuth@redhat.com>
Message-ID: <87legvfjq9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


Thomas Huth <thuth@redhat.com> writes:

> The ppc64 tuxrun tests are currently failing if "slirp" has been
> disabled in the binary since they are using "-netdev user" now.
> We have to skip the test if this network backend is missing.
>
> Fixes: 6ee3624236 ("improve code coverage for ppc64")
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

