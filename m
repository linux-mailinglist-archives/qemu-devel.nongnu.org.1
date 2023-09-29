Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 988157B362A
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:57:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmEvI-00086i-S8; Fri, 29 Sep 2023 10:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmEvB-0007rr-8v
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:56:49 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qmEv2-00061J-88
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:56:48 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-31f7638be6eso13451725f8f.3
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695999397; x=1696604197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrml2Sn8uzGPxQd6lhoN85R1Upx7mYBA7z54epasSVA=;
 b=E81LMBfLhONs5m7QunPrs6azXxJrSjw5Oq9yRa1cdhhCAHd9IIOZJrdO2RCPs0PJ7S
 5kyZ5iOzr0IS6LaAjrLTqvpq/wg9qmPtvPW3AFbi+e1HYENsFc1F6prfaqKpddu7xsfv
 7QY+VWLcn7KEsm8MoFaEL6BAANghrE8pdBGj9c3od82U1/r4UhSfRFWEVkW/7w80Pye5
 FL/WodxoZ1SDZSToaqFVyjBX9ORt8rchsCrc5DqY+O1FaXSpxah2YGU8ZB5Xvs1o8Q1l
 d/a9CuWDbzjWnZiPZehVqbBYEE3jUziQV273X3ikzmRKbj0CYnuY2udJgX/Pt6juVP7P
 sXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695999397; x=1696604197;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vrml2Sn8uzGPxQd6lhoN85R1Upx7mYBA7z54epasSVA=;
 b=wOBSPhlFJ0CPxmHwzFTnN8p233dLPWVBFmxn0HDjZn3TvfED8bJ577KgI0hfiboWGz
 mvGRPNbaGb4edw3qeyRF+RhInw0dzUQ+Slg8vFsBaNJtkvY9urghPHj9TYYXuXvqsZY2
 qsoBd2rCryfEErLT2iBlvPfCzUq6L5PETTrrRZFmI9Xxpj7DTgDa9n6Fcz7P9uH5PJD4
 gbTSyFQ1TadTQ0FWzzTiTY35tSLGitNHVJpoOKxuTvrYvf2wdaWLYcjwSnwFV9lIVvnr
 +DajMiosielwc6PiigeV7PEbVc9unAV6zI/e3mbrQiC2bgQwmmgWJVU67H/54/hhyG1n
 YOFg==
X-Gm-Message-State: AOJu0YxhgweRCftXJ9Witb+JIkQwi984ZwHXJd7cPSUFJZaOyYlmHHL5
 BE24cV+0+akVo837Ewu1pwNC/w==
X-Google-Smtp-Source: AGHT+IEd9ocee7rask/G1g8jMyMdr6z/tVJYuCmA575sv5D2bLRVYltfUWSaITw/XGCMU2mfqVqh2w==
X-Received: by 2002:adf:dd91:0:b0:321:52fb:5703 with SMTP id
 x17-20020adfdd91000000b0032152fb5703mr4299528wrl.13.1695999396659; 
 Fri, 29 Sep 2023 07:56:36 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c5-20020adfed85000000b0032196c508e3sm21692994wro.53.2023.09.29.07.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Sep 2023 07:56:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D5E641FFBB;
 Fri, 29 Sep 2023 15:56:35 +0100 (BST)
References: <20230929131636.394715-1-thuth@redhat.com>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: Add the CI-related doc files to the CI
 section
Date: Fri, 29 Sep 2023 15:56:05 +0100
In-reply-to: <20230929131636.394715-1-thuth@redhat.com>
Message-ID: <87lecpni3g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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


Thomas Huth <thuth@redhat.com> writes:

> The docs/devel/ci* were not covered yet, add them to MAINTAINERS
> so that the right people are put on CC: for related patches.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7ecf3fbc2d..3914bbd85b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3888,6 +3888,7 @@ F: .github/workflows/lockdown.yml
>  F: .gitlab-ci.yml
>  F: .gitlab-ci.d/
>  F: .travis.yml
> +F: docs/devel/ci*
>  F: scripts/ci/
>  F: tests/docker/
>  F: tests/vm/


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

