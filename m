Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 045F4723D49
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 11:27:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6SxW-0003qR-1G; Tue, 06 Jun 2023 05:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6SxM-0003pc-Tu
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:26:24 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q6SxK-0005qg-E0
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 05:26:24 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5147f4bbfdaso7837660a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 02:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686043580; x=1688635580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kxB5MWsESAGVXQB5n7JaHZw0k5JNdaLUjhEPZw9gTng=;
 b=MpOLv9qZ39rY5UHyXsCJoFPkLbSe4Iv5a7wv0q5EX6O5kS3qev/kg1gXiDJRsGN1xF
 Kl1RjGjQKnWO2Zbf2cfdVClpwWm0R6E5WJocI1esnP49qOApNEbQTn4WpAWsivfbNDYT
 ThvY0vCY2Km3UvFTPDAHGfNIJKkTb9HpUT/c9u0Wc00UWrdbLPdNOGd/dFqJzg0KbA7I
 JeVV7kEnNn0PKXhVknhLLuE9c2wFw2GWP5aQwdnBuNzzbRV3tUBdhIcHFl1UflNgQB47
 edA4tCdkQTP1OxkUi7KHcHYD0O4H5i1kTbRMLmn8v1uKnDdUhD1slXjGeeduOmPisYkY
 atAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686043580; x=1688635580;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kxB5MWsESAGVXQB5n7JaHZw0k5JNdaLUjhEPZw9gTng=;
 b=koCuwoPrCcg2XBKhKh1B/FPOsp/MFzelwiH1aSRNed+OUwKV6mlU5vMWDhrVjyR8DT
 vJ/og1pxJhXzh0/nt/gY5WrF6ZODO3g/Md3yfcex+Z/idKfwhtBd/Iol7FCosixcl/no
 mT/pSvyG68mBzPpwy0bc8MfpYlq26Pg0NU/5kpU0eQVpjl5BibhJ3bdk5ACG4lFEL7ry
 PR/fQcZ+hImLfrb3/IoYL4WMBqgKkhDc+8CvhNKYfO3QEvt5lh30xbhltL29PGuZ5DnQ
 07AbVSKSN+PwfkyDBiwzrkEtrROXJDHLyQhmhxXS1wT1hkJ/Lk5nPb+iqgXtK8amfMdz
 HY3Q==
X-Gm-Message-State: AC+VfDzL5cXyaaar3HG2zmfoET3kkMhlqOHdaJSdK8izOGfX+ytPJl6/
 d1PeRMXazN5GxcPGXQt/ucwu9moh5I+13WJJdU1sXg==
X-Google-Smtp-Source: ACHHUZ4f/4zUiGgLM/i/4RVdMPVLlfyeD5cau1B+K+Q9FrnClidiIGaqk+yQwE5j6s6t3znvXRV5dbZhDOiz144lIjc=
X-Received: by 2002:aa7:d4d3:0:b0:514:9422:37db with SMTP id
 t19-20020aa7d4d3000000b00514942237dbmr1314993edr.39.1686043580062; Tue, 06
 Jun 2023 02:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230605175647.88395-1-philmd@linaro.org>
 <20230605175647.88395-5-philmd@linaro.org>
In-Reply-To: <20230605175647.88395-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2023 10:25:46 +0100
Message-ID: <CAFEAcA8SSjrwF+9K7XSN62GBYL5tktYGB3YLMp_Bvh5HrPeMqQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] bulk: Do not declare function prototypes using
 'extern' keyword
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Mon, 5 Jun 2023 at 18:58, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> By default, C function prototypes declared in headers are visible,
> so there is no need to declare them as 'extern' functions.
> Remove this redundancy in a single bulk commit; do not modify:
>
>   - meson.build (used to check function availability at runtime)
>   - pc-bios/
>   - libdecnumber/
>   - tests/
>   - *.c
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

