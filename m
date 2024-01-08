Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0F88271C8
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:48:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqvr-0000iK-HA; Mon, 08 Jan 2024 09:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMqvo-0000WZ-W4
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:48:49 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMqvn-0005wu-7I
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:48:48 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ccbf8cbf3aso23657831fa.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 06:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704725325; x=1705330125; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3FspZaKQHG1i5Q/8nnciNdbHwWn9XktaWFfP7cDi+wU=;
 b=wl7wKZ1oZYqLqEc8KFB4YF5/6CUYylkHjtkyCvS9jHQjUJPZN/Z4d6bMEyTGYO/Lz6
 JH/4FBS1AK69JFbbdEGmQ+/IdDlEhk52h/1NdE4p6LbIEHLC9Dp8slCq4CtjdbiQM99D
 DfgYNrqNQ8ui8TzRLL2ddjRRJ22cTuyd2A/cLNayacd/FML/GiD52AY4eSohEwLq2B/9
 vm06wgw29KYZaSSFA3QfVaPaLn0Bk3IaKu5of0GCLM+1giZeNhNNNcngDG3ioedKMbS7
 nSiS+yawXd3ss7dngGZaP9Vi3Aii6dqbcGj9QOedCLGA1U1l7bI9zOFo9CPBUggoyH1E
 LPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704725325; x=1705330125;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3FspZaKQHG1i5Q/8nnciNdbHwWn9XktaWFfP7cDi+wU=;
 b=XSa5QwC+4oxHLQgNacCgHD+1DJzhEJPEa2LHe80tEgpTFhs1SzUhUQUyacnFmzLDTA
 Sl/IvQ0R6tghtTcjiyewykidfH9qFQ2OZnO3L1ScYB+/IWx+udtU6cXAM1B6lhqygwvZ
 yOn2B9IF/U2jk/xSmYjBzFYzHpYK050xlV719cOgy+dQMR/zKrO5C0o5o+rumVWWwKPz
 4KeLAQCh3rQ9o9n6GJheiegnIqf3MTQajZMr4/5fDfq6nSDiH7zEGcNSya9GNwnLutXI
 ceXraUHKbuXd7FXrAmokGCh5LiR+zXxJCO/i02j2AfxWoZoJStVn27qyYeqHgjpbDpij
 QVjw==
X-Gm-Message-State: AOJu0YzsufCS7b1ffRVChSN2cUytx1a2o0cVZnTuBOPlQIk5Aqlz8bnA
 8MiqPhONFZa2V6YSDvQCWg1Pg1mOk9futh/0UhQX70dk/FA5EQ==
X-Google-Smtp-Source: AGHT+IFGWfv5d+Va0HBX6zePiPmg06Q1YAqicwcovGOSvSVTZ38K8iapFXkRrXxHzAffpqSM+A++Hb30MReEVe8X2DA=
X-Received: by 2002:a2e:8091:0:b0:2cd:13bf:78d7 with SMTP id
 i17-20020a2e8091000000b002cd13bf78d7mr1607359ljg.10.1704725325618; Mon, 08
 Jan 2024 06:48:45 -0800 (PST)
MIME-Version: 1.0
References: <20240104141159.53883-1-philmd@linaro.org>
In-Reply-To: <20240104141159.53883-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 14:48:34 +0000
Message-ID: <CAFEAcA9uUMpBPxggnrN5tkCxjYwsNYvQGaxEjCOw6-PM+6DUsg@mail.gmail.com>
Subject: Re: [PATCH] hw/arm: Add missing QOM parent for v7-M SoCs
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 qemu-arm@nongnu.org, 
 Felipe Balbi <balbi@kernel.org>, Alexandre Iooss <erdnaxe@crans.org>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Thu, 4 Jan 2024 at 14:12, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> QDev objects created with qdev_new() need to manually add
> their parent relationship with object_property_add_child().
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>



Applied to target-arm.next, thanks.

-- PMM

