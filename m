Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1837D225B
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:33:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUpF-0005Mj-Gn; Sun, 22 Oct 2023 05:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUpC-0005Mb-AN
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:32:46 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUpA-0001vw-85
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:32:45 -0400
Received: by mail-lf1-f41.google.com with SMTP id
 2adb3069b0e04-507a55302e0so2986953e87.0
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697967162; x=1698571962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+iFmUqXBxoNI1ygM8rUxSXjD1MMRNdDeKtKmzK6VS4Y=;
 b=jJRuP7zjL3CDZX1UTA/YtpS3Ryrbr7G8drziYJvZjR7LLc+TtdrtPUM0A+wFAtTmGb
 HVmiUckb3kFyCe4xw8JyOSv5b8LRKV/ySqkYCLxGTmaPVD+XRjTMz94PhKpbzp3ObYe5
 iOEwIiTJVzp+UbZtl6dnx4/IGcHzACWgwCYrCTlvQduMBJrOR94P7DoBDfqwDy5Od57y
 es46p1GLasB63urZyJtd1/6K+ua5qKaRMtWe/bdYspmZvv20dg2GInZYoAIAu8MlmGCt
 NRngtzQh6zyMe94nn0b2yxyfhWShgdiD3GBFM0MYRhYLtY8E0kJou4yAA/jrY0lR4i3u
 jymg==
X-Gm-Message-State: AOJu0YyVNBCw8fdOK3tqxFGbjvUxsXhfw4x8kW65iO6lWAvEtlMmTp3n
 2lrui9J1DQcdt8L0KwrT8GJZrO4ecGo=
X-Google-Smtp-Source: AGHT+IEPfL3s+vgSFXjicIpZ9qN1/CDZw1z4cV2hVl0qrSrKmQ/SoiJU1KEudG8ChsdxWR8KjvH90g==
X-Received: by 2002:a05:6512:5d5:b0:500:b7dc:6c90 with SMTP id
 o21-20020a05651205d500b00500b7dc6c90mr4006744lfo.36.1697967161936; 
 Sun, 22 Oct 2023 02:32:41 -0700 (PDT)
Received: from fedora (ip-109-43-176-141.web.vodafone.de. [109.43.176.141])
 by smtp.gmail.com with ESMTPSA id
 i7-20020a50fc07000000b00534e791296bsm4551536edr.37.2023.10.22.02.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:32:41 -0700 (PDT)
Date: Sun, 22 Oct 2023 11:32:40 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 3/6] hw/m68k/mcf_intc: Expose MMIO region via SysBus API
Message-ID: <20231022113240.7b5724d0@fedora>
In-Reply-To: <20231020150627.56893-4-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
 <20231020150627.56893-4-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.167.41; envelope-from=th.huth@gmail.com;
 helo=mail-lf1-f41.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Am Fri, 20 Oct 2023 17:06:23 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> QOM objects shouldn't access each other internals fields
> except using the QOM API.
>=20
> Here the caller of mcf_intc_init() access the MMIO region from
> the MCF_INTC state. Avoid that by exposing that region via
> sysbus_init_mmio(), then get it with sysbus_mmio_get_region().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/m68k/mcf_intc.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>

