Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4E37282EB
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:42:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GqN-0002aD-Hr; Thu, 08 Jun 2023 10:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Gpx-0002Ys-3k
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:42:05 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Gpv-0007r8-K5
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:42:04 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-51494659d49so1193684a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686235322; x=1688827322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70bsH49AzGumdTVaeRG8oYnZdP9PrBRY8hnkfgrFChM=;
 b=GXb1IOpFGJE/UC7ykik9TDfEu5bueGr6YMrlEetqV4nE6+DkitZH/K6tvGpzT+jITb
 cequCQwuMQ7ymC6X+oG6xuaAluUfC9shL2QVLmPqxljj0Me9+VsyU/IRt5fwgeOotNGI
 jooovMegbOCcVJYJB8y43K/auC5OreJjjxjfXNtBcT57JMjOOUr7VL0h8BGYQ1iwaMj9
 CNLTtTFTbH3GTayDGjOjg9J/AlSokv0Gk1vUQ3EHDk39idx7vLJrkr7apWR3sbHvJIo9
 1nnHYAuWvb+V4IMf+7JPFaxpaDtCwjTCR3CUVOpn0mYwyBcALroQ1caZHixNwl6yanMO
 fjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235322; x=1688827322;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=70bsH49AzGumdTVaeRG8oYnZdP9PrBRY8hnkfgrFChM=;
 b=K/Dsj/KS7trsN9SuVElHv8EaA6glxpJ/matXy2T0mGxDqmkiT7DwJ1s0ILRM1kYnqb
 5iZSOrV6BduzNf4bUnHs1KkvK7umUCmlzMyvWYDB3thNGBl1WpzQ1byvUWQsZoUuhRbC
 uftihGupKJvJTFRAqwPHBn1Rn2uO5LK77mC/bniYcRYZq3d8Qf219fsAStc5W2XDmMG8
 TnhCgSRDk7PrnvQL17xUZJ4Lyy7JJ7XJTCC0uj57SothlQsbHtpeXhaDYAa5Xqg+iPtw
 MlStqnKDVqmrQZbYP/8h/q443/7MghB/BIlQI/sjT3N3lpdRghqeIMLD7SmNuQoHhTxD
 sEHQ==
X-Gm-Message-State: AC+VfDygZNfMFCcu4vfWeN7K/6ZywDQZRk+yjl32QXheTZNzmpP9K8Cd
 SZ1T+P6mquMorEh9VO9nZb/31KqBfr3STEadOSE9mg==
X-Google-Smtp-Source: ACHHUZ7CAlv7qfZoto7PmDhJwauFxCyeL/5JJ3GiU9n+HgP3F6ByEkoqEqdfnggbaWWW+BMH91rhBNiM/bvrmwz/KRQ=
X-Received: by 2002:a05:6402:1299:b0:505:4f7:8a50 with SMTP id
 w25-20020a056402129900b0050504f78a50mr7921452edv.5.1686235322120; Thu, 08 Jun
 2023 07:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-5-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-5-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:41:51 +0100
Message-ID: <CAFEAcA_Ux3-VDx+N_4PK_aiEp60L=d_WO+2C3+Wdh-7+AAcOrw@mail.gmail.com>
Subject: Re: [PATCH 04/15] hw/timer/arm_timer: Remove pointless cast from void
 *
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Wed, 31 May 2023 at 21:36, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/timer/arm_timer.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

