Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 041B378EEE5
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 15:44:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbhxp-0005Ne-0O; Thu, 31 Aug 2023 09:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbhxn-0005MS-P0
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:43:59 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbhxl-0003bd-HR
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 09:43:59 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-307d58b3efbso621459f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 06:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693489435; x=1694094235; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=irkvSQpNZre+Z0M7OS3ADSzmUcddRSofGIUv38Rn0NI=;
 b=FcD4MQs3eF5qaIYAnnzSwztuY/HPsdabAGk7zHEjWkv3V+N5S22Ig3X3+srCDognLB
 Xfg0BOd0DRqVBV2QmXjLjXi+ec1TVZT68+MChfsBlzAaUZrkkJ/uXGfknypmbrY1bUen
 dfj+h39cJBjRAhNeUJeLPew1qP/xziYkNR7WUFbatRf24zQzkpS9hqClG5qtFf1fQosA
 ZRvyVU/6/6VoyWidXixJKcT136X/RBjuayMd0RircxGAHlUD404hcyRQ71Dm50enSkLN
 xIjyuJLTcxQs8iEelMbvgzkfVkGVEKGIUxguYDzTJX7Ho1z+7/ss8pP0kmWB42KMjI3y
 c07g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693489435; x=1694094235;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=irkvSQpNZre+Z0M7OS3ADSzmUcddRSofGIUv38Rn0NI=;
 b=FBmtGgrrwTIq2J/CDN9Faeh2g/aOkP9ynIn9TgWMbOu/D1QPabdOdrNHV3qliP+tul
 jIjgcpNdcpqsjBk57NPePkojIzsoOHKHHclNKppE/UjSxlSrHEajzfq5FND2aOnd7Gr5
 PikohHQ4u/SAaGgu1g0UgSundy8G1ujwf+fwLwQ1M79aWeFQtgUgeFwbuIEqvo/eJC0i
 FdhBfCwlNB9uJSzUxk0rDaGeqDU1tBYGiE6LayPu6u/bhasKsYf/AYyE9nD5A4n3VIfL
 fSmSPcck6j+VKx72ywmsCAidpuo/6m6fxDKNA9QloZ+8WzoqayVnCwGdNHbZe8/camvH
 v9Gg==
X-Gm-Message-State: AOJu0YwZtn9BW1EgEXfC/QBQkNx6erfYWwjki7W92tHPvrnxiqzl7xbq
 fr3NcRmFEIM3FzqbJkvvL8oz8Q==
X-Google-Smtp-Source: AGHT+IHGKtt4eXQkzzOr2qYPtO4KM+Tj89UpfqxnicLqE+KFEWduC64R7pHfaxJjUFtfVrScfKYauQ==
X-Received: by 2002:a5d:6145:0:b0:31a:ddf0:93b with SMTP id
 y5-20020a5d6145000000b0031addf0093bmr4379046wrt.33.1693489435317; 
 Thu, 31 Aug 2023 06:43:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 h12-20020a5d688c000000b0031ae2a7adb5sm2253802wru.85.2023.08.31.06.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 06:43:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 707851FFBB;
 Thu, 31 Aug 2023 14:43:54 +0100 (BST)
References: <20230831131348.69032-1-philmd@linaro.org>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-arm@nongnu.org, Shashi Mallela <shashi.mallela@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/intc/arm_gicv3_its: Avoid maybe-uninitialized error
 in get_vte()
Date: Thu, 31 Aug 2023 14:43:49 +0100
In-reply-to: <20230831131348.69032-1-philmd@linaro.org>
Message-ID: <87zg27nx7p.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Fix when using GCC v11.4 (Ubuntu 11.4.0-1ubuntu1~22.04) with CFLAGS=3D-Og:
>
>   [4/6] Compiling C object libcommon.fa.p/hw_intc_arm_gicv3_its.c.o
>   FAILED: libcommon.fa.p/hw_intc_arm_gicv3_its.c.o
>       inlined from =E2=80=98lookup_vte=E2=80=99 at hw/intc/arm_gicv3_its.=
c:453:9,
>       inlined from =E2=80=98vmovp_callback=E2=80=99 at hw/intc/arm_gicv3_=
its.c:1039:14:
>   hw/intc/arm_gicv3_its.c:347:9: error: =E2=80=98vte.rdbase=E2=80=99 may =
be used uninitialized [-Werror=3Dmaybe-uninitialized]
>     347 |         trace_gicv3_its_vte_read(vpeid, vte->valid, vte->vptsiz=
e,
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~
>     348 |                                  vte->vptaddr, vte->rdbase);
>         |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/intc/arm_gicv3_its.c: In function =E2=80=98vmovp_callback=E2=80=99:
>   hw/intc/arm_gicv3_its.c:1036:13: note: =E2=80=98vte=E2=80=99 declared h=
ere
>    1036 |     VTEntry vte;
>         |             ^~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

