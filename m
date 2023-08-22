Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 888C1784667
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 17:58:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYTku-0007z8-9K; Tue, 22 Aug 2023 11:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYTks-0007yv-Cb
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:57:18 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qYTkp-0004aa-Uv
 for qemu-devel@nongnu.org; Tue, 22 Aug 2023 11:57:18 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-4ff882397ecso7084305e87.3
 for <qemu-devel@nongnu.org>; Tue, 22 Aug 2023 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692719834; x=1693324634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FPN0cPZcNaLRtOH4pLvChHbk3zVlrh0C1HqcEYX5ko=;
 b=PjE2cV0lPcLaP6ZnnsnNcjpIvOCyOqAr03SiZoqMpxyxb/4Rj29H4Hkf8Bl0I1Hj8O
 takAMfeNSPEcV9uqR1GBwecSKAkgHoaQtxwGXtamk0cQiEC0Lss8frMQE+mBqSka5skf
 QRscAI/CFFy8yR7U8IujjrjKQWClT5cxdpFhJ9urbKMRhWL78TN7UdT7W7nfJx27IZrp
 E5XemsXX7bILVA8ua/0DCI2ktls+3WIiAnHY0ktOkjw2pVm9ErSMT1l2szPFmgOY1ovi
 TowdA4jSo/2o4ygckT209aMcYlBCyoJTtkmbI4rJhei1cXwarKrfBea9be1KJENyAoeR
 EOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692719834; x=1693324634;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5FPN0cPZcNaLRtOH4pLvChHbk3zVlrh0C1HqcEYX5ko=;
 b=NLKZo6gHp4AOFRUml7vNJbqLYqiQku1q5ay4tQWDooccGbYWWmuimzUPffxIlZ8dWb
 ROwV3SifOxEDm97nz/Vd6sAPgiuFXrcqapd5Rlkf//GOcHKNOVOWmyZPhR+NTy7G4oA5
 78T0McynQwmnYoMvIAV+5UMdIpBQbMgd9IPwyGycNnBn/e8ZKbfK9ULi+ZTmY2jFtlNV
 un5zL+BWqSX9XMZEeTJK0mRvPBk83/sdGLXGwLwPdW2fMJ//8z63gbiWKsejApany3G6
 6ApP7bX9VcYDPH89vPllC3AUO4tzegjeSZbmrkrz+tWz9qBy+oGfLRfAQfkmiKDibDeG
 JV1w==
X-Gm-Message-State: AOJu0YxFjWvE18fagRnXGUM2+TeQ+J225/hUfF8Cj+R20nMQJYR+tNun
 WyWRmosyG8+HUaa+L4AexaVWQaAP4cxqtLQ7hU+9Kw==
X-Google-Smtp-Source: AGHT+IELu0IWpniK9Ext9q2cYlvjDEfkluLdIEF4ZldFkIOC0QXD7H20cAYLqVBzEuILiD1BsjV1eIid6309dzsctl8=
X-Received: by 2002:ac2:4f16:0:b0:4fd:f84f:83c1 with SMTP id
 k22-20020ac24f16000000b004fdf84f83c1mr7890847lfr.64.1692719833616; Tue, 22
 Aug 2023 08:57:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230822155004.1158931-1-alex.bennee@linaro.org>
In-Reply-To: <20230822155004.1158931-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Aug 2023 16:57:02 +0100
Message-ID: <CAFEAcA8_tqboXDen6OPY-AeZ3BY7p3vYMeG77YQJ=cKA_GRMaQ@mail.gmail.com>
Subject: Re: [RFC PATCH] docs/style: permit inline loop variables
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x132.google.com
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

On Tue, 22 Aug 2023 at 16:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
> I've already wasted enough of my time debugging aliased variables in
> deeply nested loops.

In theory we could try to enable -Wshadow and deal with
all the existing cases of aliasing, which would then
allow us to turn it into an error and catch your bugs :-)

Anyway, I think declaration-in-for-loop is OK and we
already have quite a lot of instances of it.

-- PMM

