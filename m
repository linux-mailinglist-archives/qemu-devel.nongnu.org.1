Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1F182DC26
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 16:14:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPOeu-0001tL-O6; Mon, 15 Jan 2024 10:13:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOeo-0001sL-Fi
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:13:46 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rPOem-0001d4-9a
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 10:13:45 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50ea98440a7so9238336e87.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 07:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705331622; x=1705936422; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=k/boiXL+zL3S34IXYq0iuvfMSVp+pYWubNO4fqSWEe0=;
 b=nijbG4N/JSi/vTfIqBwje9+ved7mSk1vkpFL3jNFGvT8azXyluB2akINaZyWBQPhAy
 nq8HclwMb+b1AbYIiSUuksYTNtE3BiARpkXH4xaDrND8sRDmsdiQfKAnFLCLjWy29Giv
 4Oe0zZzEhz5QSVzoK+LGN1r7lmhTlk7sykszX4KAbBZJlc06VZs7+aAyTbo4MQnVKN7c
 UvWg9Y/XacnHJQwdvW8aQuBNsjQWdPoyBPOnvbD5HyBnppzZNbxuEFfRv64GFYTKi8qT
 ujM0pex65d2ABAgSAcvC4+KxgoAlfKC4AT+gFG+MhV/PZmxheyqRTtju8dFgqyOG1CSc
 vJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705331622; x=1705936422;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k/boiXL+zL3S34IXYq0iuvfMSVp+pYWubNO4fqSWEe0=;
 b=RhYSY1eCW/PtVj3JHcZeP701n4FPi5cLsUOD9YtAqwxUnH7yCwpd+Wc1nFVEY/V2p4
 cPEpYGXSrGZ6Xjuoh68obOCZhH8IU7JrNZ/hRW97n0NehCF3V9tZnuZmVNfwZRuksNHb
 2/25b4PRXJVr++Ofm+Lf0jcKJhPJkACXzudRth3TvPoEu4cZfcMljW8BPhJ3xdOcW+xi
 +83Z2/NIYkzPdfvcBm8Jihh70KQLsZzIXkGujpSp9TcTBWALB4fonD7rOt7bZKCosDgV
 8MvlchzTVoNmRwgsxiw2wzYomKIfmYohKfTroyUGDp25k9JwJYX/Fiz6kniRMrz6N+jg
 fz+w==
X-Gm-Message-State: AOJu0Yy1EifNwjE5zNSu3GQFZC0gJF5e+Ut85Y1q4zAJ7k6P1qWyzcjI
 /IgRoLM/R7I8P/kz9XBc1dTyFkfpSJNdNm2XpBYh5Uv/FDPN4A==
X-Google-Smtp-Source: AGHT+IHAApHqeMcWEwCZpQ5Bp5JZD6jY1Ehiz7meJ2IcTjYRQRk2Frpq2CxDBoutpc5YCPh+PQ9kSb8Ks5TY/qAlSQA=
X-Received: by 2002:ac2:5d47:0:b0:50e:8e94:bcfe with SMTP id
 w7-20020ac25d47000000b0050e8e94bcfemr1588156lfd.64.1705331622244; Mon, 15 Jan
 2024 07:13:42 -0800 (PST)
MIME-Version: 1.0
References: <20231208023145.1385775-1-sergey.kambalin@auriga.com>
 <20231208023145.1385775-33-sergey.kambalin@auriga.com>
In-Reply-To: <20231208023145.1385775-33-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2024 15:13:31 +0000
Message-ID: <CAFEAcA-PoHE0wOm_sL1dkvrzk43F2woJe-ynh2KEoYd0=jp9DA@mail.gmail.com>
Subject: Re: [PATCH v4 32/45] Enable BCM2838 GENET controller
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Fri, 8 Dec 2023 at 02:35, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> ---
>  hw/arm/bcm2838_peripherals.c         | 16 ++++++++++++++++
>  hw/arm/raspi4b.c                     | 17 -----------------
>  include/hw/arm/bcm2838_peripherals.h |  2 ++
>  3 files changed, 18 insertions(+), 17 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

