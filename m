Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F29AA70DDF9
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:51:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SPV-0000eF-7y; Tue, 23 May 2023 09:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1SPR-0000R3-7a
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:50:42 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q1SPP-00022N-4z
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:50:40 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-96fbc74fbf1so545886166b.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849837; x=1687441837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=seuBDgT9aF3afRV8J7nFDrWYb03Aj0cUgIJWViRMfsE=;
 b=qHPK1/n4lZCOh5w5zb38bjb2SIHP5Jt4xh19NAW9RK0HcB69vXlOygCatqSrgNFkJ9
 mWWjRk2Nxax0iBxNiVbYLyzXwKy/C6RKOGUZZetDHehdjW0xvvWDqe4/01jXbEKtmUkk
 3kNgO8kuXG400MfksNG2tF4hqQxaTUl8gJjcjhOKcxWCcAtTaBqXWh+aL7zarBj3Pt5S
 NBQQSTdgU5dtUkFnCsFvvZqc0YoXvSHnU6DzhHsQsA7Sg2K/Ls+1TzLv2JKzfsKd82Qr
 QTVN3FmvTB4Vu/e5w3Xtxzlwqs2ENF8WQAJX/rPbM3MjU36R5jFpqPUZbt0gFqV4SWBV
 o8Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849837; x=1687441837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=seuBDgT9aF3afRV8J7nFDrWYb03Aj0cUgIJWViRMfsE=;
 b=jEtYPFBDi35btXJl0lzBRo0tlnLwEluBPLBAt1Hd8Ch/67uYX9dTlpvU0wWnBIOMTr
 znxUsi7WICKRjTOziCgP9r8vOw7RbI/FgTeVfGUlLnYF1CDheHKsGRatgfob78m2jJhh
 j/SRs8hJyg3Q7oplm4u6PZuBQQpEI0IhBjdVSTzJAyXC7KlqH0ysUsNXsBlwIpWzQgy/
 ve1mmb7b5T//FVDo8tZdJ+lyNd0IOw51qTq2zcnJkjvMVYLCCKwICnM3x0AjnoyHyt5H
 73t4qjJKooIGhg1Cun/WuWPl2rjiu1M04cvnWAk4Q7J5qaHOP1eNHzLGRg86p/7v9qdv
 ZjGw==
X-Gm-Message-State: AC+VfDyNcnWn3LZ/gjPdDUd48SwuH9QEGvDkMWQPO1JKNVrsibSQyPF1
 AoPcief5fiQrZwIXxRVG4O+0SI9EeZAuX/JzdTt9aA==
X-Google-Smtp-Source: ACHHUZ4JmGc2W0IHalbXmi4dzrL3aEVT8JfOtAyWutZKNsZuPprgZKzf8O3yRSRB7GPJBWWFR8Mu9TzYiZkVt6EIsK0=
X-Received: by 2002:a17:907:26ca:b0:969:bac4:8e22 with SMTP id
 bp10-20020a17090726ca00b00969bac48e22mr12548923ejc.26.1684849837343; Tue, 23
 May 2023 06:50:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230517105303.453161-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230517105303.453161-1-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 May 2023 14:50:26 +0100
Message-ID: <CAFEAcA9GamGybSzd8FKBtmZ2qMgjRFy6D=Vhu1y0dL8m9Sa80w@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm/sbsa-ref: add GIC node into DT
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 17 May 2023 at 11:53, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Let add GIC information into DeviceTree as part of SBSA-REF versioning.
>
> Trusted Firmware will read it and provide to next firmware level.
>
> Bumps platform version to 0.1 one so we can check is node is present.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Are we documenting anywhere what the format/requirements/versions
of this board-to-firmware interface are ?

thanks
-- PMM

