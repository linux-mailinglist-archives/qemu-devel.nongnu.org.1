Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C173F82C544
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 19:14:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOM2T-0000Zn-QV; Fri, 12 Jan 2024 13:13:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOM2M-0000Z7-CQ
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:13:46 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOM2G-0001UJ-0K
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 13:13:44 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5576fae29ffso6923137a12.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705083217; x=1705688017; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFA69dXixckMaOLLBw0WEFfpYsDDEMys/YpQXb/K2uk=;
 b=xZltlSKIjDXyDnfhjZd3nrUjGqenn0C9uKdfgK/f1qP356SfPgZ3U9AGXV7WQGcpo0
 QpD19A+84NgmGPITl4RoeY7qUERHD2i6HjUYDNRTsYzg1Av2OHwZehuYDmcg1mHkp/LS
 L+tfaAu1BsUE9d+xmY2/wsWVNd49Uh+xrHXvbRDrHHGmYu6eWLIGMy8y/boxjb1QhWrz
 VrWXWBqEh2wvK/kDVMyF7fb14ChP+x+gf517+/FnAiAo8NN3NpfuD4V/6zIDRDtnMtbj
 oNHNFCu5OKaUpOAcftK0UNjg/oiIKHo0WY1W4GOdUwPqBhGYhN8/TNpkqsvovIh8HzJ5
 jmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705083217; x=1705688017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JFA69dXixckMaOLLBw0WEFfpYsDDEMys/YpQXb/K2uk=;
 b=WOk6AiDCCBeQhXd2vUEFWQWhGrmJxv+vzHPHlNm5bYSsJAseutM6KPFTczpwIhtZkg
 I+fNJbdAZy2oxnTmuillGETBE96UCWK3EU00L854fJ+4I7Sk5o66qPsvKf9zsDrTotCf
 lRuSF4iH0xHeKc4iOQPZ8BOiV8OSN5Oo+GbUyrlwwu+nffN5hjwnmlk/G9toG+pO8arU
 vuyFpTUvMxO7oOZaaoNoZ2EEoYy1jlPyOSua+ubyQmPdULeiH2ze/MHuN/7AWCEs4ncr
 O/8EtN8/16l1L92Jjpqk+wy7dkypVrzfesfdZ8JSlh2W2Y5E0CCwmH752Bh2n+x0OPkI
 P6hg==
X-Gm-Message-State: AOJu0YwVK8j5SLCwnOdgmuElatAIVVuZjKWra9AUylRB6aa/jGNu7JDD
 +3Aj0O2ubfFgh1BvbVVK/UchzZt4F97bFspkhwf8DK0Fcv683A==
X-Google-Smtp-Source: AGHT+IF4SIFoX3e1kbz2YNcKwIyQ57QSZ2c+sy19mG8tPILQ/EIyzXvnLSJUgE1v7cB0rRHnjADsIg2WApvc3B7c75M=
X-Received: by 2002:aa7:dac9:0:b0:557:77db:efc7 with SMTP id
 x9-20020aa7dac9000000b0055777dbefc7mr827506eds.53.1705083216858; Fri, 12 Jan
 2024 10:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20240109160658.311932-1-ines.varhol@telecom-paris.fr>
In-Reply-To: <20240109160658.311932-1-ines.varhol@telecom-paris.fr>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 18:13:26 +0000
Message-ID: <CAFEAcA_vCA828g_Sz_0iDtEaZAM_Dz0k2HmFYHYVCWzUoYvS7g@mail.gmail.com>
Subject: Re: [PATCH v8 0/3] Add device STM32L4x5 EXTI
To: =?UTF-8?B?SW7DqHMgVmFyaG9s?= <ines.varhol@telecom-paris.fr>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org, 
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>,
 Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Tue, 9 Jan 2024 at 16:07, In=C3=A8s Varhol <ines.varhol@telecom-paris.fr=
> wrote:
>
> This patch adds a new device STM32L4x5 EXTI device and is part
> of a series implementing the STM32L4x5 with a few peripherals.
>



Applied to target-arm.next, thanks.

-- PMM

