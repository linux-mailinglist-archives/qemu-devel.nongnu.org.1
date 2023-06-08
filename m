Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9E7282EC
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:43:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Gqq-000424-RS; Thu, 08 Jun 2023 10:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Gqo-00040s-Ko
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:42:58 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Gqn-00081v-0o
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:42:58 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-97460240863so130989366b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686235375; x=1688827375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HODhGSMOoQB3YcLIahDn+iD2YU6SRVySIuGAxcv7UE=;
 b=huIL+bSM9Bn5fYMpa//8GbDPSO/NhbtklzNpEQBz3q7WCyRK8Gc8iKVmRs18cYYrEJ
 tcBkpj8Q6P+M+VuaxMjtslhx5yIJpcpaVuN8TKcFdyy3lllg7mnfukJmHi+/5ICF0gxH
 xAdsfoLZG8hkTJu1wJrQwFu1flH8GOQ97GXRBQ0rjPhWZvrqLpZqyt25JnpP4muw6j07
 OU8y3Fhfdv4rOEwlve0O9oirXLJQkgCogcPHJ1N4mIA2mKnWl2eGn8jnMKAgBnrGFL7+
 tGgZ4iwB9mAdnVAiNyGqmKxhBSFhgkulUUf417j4gdvEYmxkPbGa/G4Q3c7jhb6Qt0xE
 Jmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235375; x=1688827375;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4HODhGSMOoQB3YcLIahDn+iD2YU6SRVySIuGAxcv7UE=;
 b=BFL71/MYfBV4NIKnfIPWPhtwdOypy0sJKJamI+AO+vcCmMOXezPGbgJvLn2jPWOI04
 nykifIIwLG+eU+clSuIYWK3n2hCwzCEW16GCN6CJBU2QW8dKA5Iz4vvVrN67mKBu8wfR
 rJVvEWP5FLogg/7lNB+mZRuRjg1DcAXYksyTXBkkQnIQ/pVdc1V0fDRLI9uZXEGG072p
 pkquOGTZwJccw7cwbQ/alGwOvKOn/qieTcRt6G9cY2Osi99+it9Ng5EcCBpICRF54wjf
 85AFYHEnkv2bPhu1W/s6pd2/0AwEtX+wTeW87p87km2rrNrcRHmfNjg0rQZLvkvQ/SXM
 QXig==
X-Gm-Message-State: AC+VfDxNUYk+6PqH3RUtulYVdNa1rpTf6FAVpVnIUKyPD1l89lGbTHJM
 zeZbHDCaHZh/Oyr+D7YjH5si8dbbxfIYUhn9wMygxw==
X-Google-Smtp-Source: ACHHUZ5YSw5K36N87uQeESU/j/CyLygxW4HHxw+fvefpBteAYUm62tfOzGZeTs19ZGlezhmGbwQTe12881oA2oMd7rU=
X-Received: by 2002:a17:907:6e0b:b0:959:6fb2:1c3b with SMTP id
 sd11-20020a1709076e0b00b009596fb21c3bmr9180075ejc.39.1686235375299; Thu, 08
 Jun 2023 07:42:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-6-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-6-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:42:44 +0100
Message-ID: <CAFEAcA9_z941M2XejThLB-M++1u9PJZvO7DjXCsEOgOgHWn7BQ@mail.gmail.com>
Subject: Re: [PATCH 05/15] hw/timer/arm_timer: CamelCase rename icp_pit_state
 -> IntegratorPitState
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x633.google.com
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

On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Following docs/devel/style.rst guidelines, rename icp_pit_state
> using CamelCase as IntegratorPitState.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

though PIT here is an acronym so I think style would prefer
IntegratorPITState ?

Either way
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

