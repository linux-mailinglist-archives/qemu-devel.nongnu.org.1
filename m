Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6AC728316
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:52:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Gzq-0005bf-DZ; Thu, 08 Jun 2023 10:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GzZ-0005BN-BU
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:52:05 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GzG-0001lN-Fi
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:51:57 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-97460240863so132537666b.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686235895; x=1688827895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JxL1c+8WHNEQTzF53nQ27ehYDd2x3vCVLz9vMBU59zU=;
 b=vXkM4aq6/9WtZm3ru6jcjPr2ImX24/tDFfJ6UTO2ZagK4XKhR/hA4ddE/+v+OBRWOb
 +HqcEah9dykdso+0W/Cwv/qsWb+y8asWBKyrpeNHht+A36RA9ivaBvVVUjKcYPSgGVbf
 Jg7nZrcZwEqT9yL76Su5W3tWUmRmuc5Oo4m/UsBPxXqGBuYlFJRe9LV/2PEYg62mlyp2
 OzaelIOlcLMRNfXZmHbIzSuLeFQmjaObTnB4INR/zEUhmSBzripaqgR6b7AKz1dG8Q5S
 mzylI/ehDMp0tFuj30II3woYVU9VnKgvOROHIsND8Fnj046hT0Yv+m9bo210MgZVw4Ep
 8RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686235895; x=1688827895;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JxL1c+8WHNEQTzF53nQ27ehYDd2x3vCVLz9vMBU59zU=;
 b=SukquxCW+8rgCHCFeV2BI8kO3EpzcGfzdU03J+GwzWMNCMw6C3R0/Kkt+UcV4sBGPE
 asqdILsF5OlQNN1lww8+LYNcXTSM9sTHvjeNeOpWAelLWqofs7cGWPQNbJR8jDzvX3ZT
 ZAJsK12CvLShNogNM2W042J61Pufcb16ZxaNKMXS6lsJ3yu6kbvZH7yqSpLGLI4Tbq9y
 dISOn97xdZt8r+lToZPE9oOvxRHfkHw0lcXxkeCVDyMuf2DKs2GXNtj+y14+uaLY195e
 o8MboJpimgf/cqa0KBq4wuenhdoCuZWMcJjz2UlxetnqR4Fw5qL98hZN+deA3cZqQeuv
 MrbA==
X-Gm-Message-State: AC+VfDxMHo1W3qh+iH4tcJ6a4ddGo4aiq3wSr/Zavph7q/+DP7KXTh0m
 YrXxFp0E8tXVmFwJ2J+vFFBcCDbeUTlOsIbM2MdVraDbDIgwm0dn
X-Google-Smtp-Source: ACHHUZ6j9RisQvUoiRvbIpSj0pO87CnphOvSRxJrf6SqQsYViT9m+x9vzijLG5JxqVxcY0NUH8FZxdC/dbnY7IbrUn0=
X-Received: by 2002:a17:907:3f97:b0:96f:be1e:bf1d with SMTP id
 hr23-20020a1709073f9700b0096fbe1ebf1dmr9827813ejc.69.1686235894975; Thu, 08
 Jun 2023 07:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230531203559.29140-1-philmd@linaro.org>
 <20230531203559.29140-12-philmd@linaro.org>
In-Reply-To: <20230531203559.29140-12-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:51:24 +0100
Message-ID: <CAFEAcA_J6w_Lopq4RR3nZPMo1fOa_B4CdckbnpkjBCFfW0CDGg@mail.gmail.com>
Subject: Re: [PATCH 11/15] hw/timer/arm_timer: Iterate on timers using for()
 loop statement
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Sergey Kambalin <serg.oker@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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

On Wed, 31 May 2023 at 21:37, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> The same pattern is used for each timer, 2 or 3 times. To avoid
> too much code churn in the next commits, iterate on the number
> of timers using a for() loop statement.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

