Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 721D37D2262
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:43:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUyK-00055f-O6; Sun, 22 Oct 2023 05:42:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUyI-00054k-Fl
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:42:10 -0400
Received: from mail-ej1-f51.google.com ([209.85.218.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUyH-0003YY-1q
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:42:10 -0400
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso339547666b.1
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:42:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697967727; x=1698572527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MW5bFEYDB4qJVSNuWrULT9tfH/5d4Ld6NikWNFAibfU=;
 b=ZGRPgTisUbRutJDDkIcwyJrNt8sPsimydmm6xCdSCC2hUeEfAir5QnJ3uvagMeD62I
 FZ3jyr7CIBSNACTllbBN0DoYhMhOHetRX7TcQttgsuMri9eaVNQxZoLbHcPGTnduClEy
 Rml6MtWYmDhuOn4OVg2dVwQW0/AFriAwQcl4a9hZMq2ZHJ/Y5PQjf42L+qcl3NuB09Sj
 nvU0C9tNbhOEG7+b9pIw7ZLXm4optprFU6tKWHRxFdqKRQWZtEKhg2c2eWLVBI/HsfRC
 rCoKsayD1Gn3Nf7w0gKNAC5EKgW0mkbu/MhsOuNAQkJG/BMphGPkIu7sXb2T+ggsKzbq
 TzPQ==
X-Gm-Message-State: AOJu0YyrfNHu6ALrSr6OKt6zluQML93ErUyGsayXOgpL/+J9Vbp7gSr3
 E619w6z9YuLgGVGkJxVFHlw=
X-Google-Smtp-Source: AGHT+IHPDEGu3fedU3wGq7QwGV3LgyVENu2fDxchH7i1+WvKK5XQb8Zqzf3+7rWgQXlMBkOEZfrYYw==
X-Received: by 2002:a17:906:7951:b0:99b:ed44:1a79 with SMTP id
 l17-20020a170906795100b0099bed441a79mr5432631ejo.3.1697967727486; 
 Sun, 22 Oct 2023 02:42:07 -0700 (PDT)
Received: from fedora (ip-109-43-176-141.web.vodafone.de. [109.43.176.141])
 by smtp.gmail.com with ESMTPSA id
 gu18-20020a170906f29200b00977cad140a8sm4831533ejb.218.2023.10.22.02.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:42:07 -0700 (PDT)
Date: Sun, 22 Oct 2023 11:42:06 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 5/6] hw/m68k/next-cube: Do not open-code
 sysbus_create_simple()
Message-ID: <20231022114206.767df917@fedora>
In-Reply-To: <20231020150627.56893-6-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
 <20231020150627.56893-6-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.51; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f51.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Am Fri, 20 Oct 2023 17:06:25 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> Mechanical change using the following coccinelle script:
>=20
>   @@
>   identifier dev;
>   identifier sbd;
>   expression qom_type;
>   expression addr;
>   @@
>   -    dev =3D qdev_new(qom_type);
>   -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>   -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
>   +    dev =3D sysbus_create_simple(qom_type, addr, NULL);
>=20
> then manually removing the 'dev' variable to avoid:
>=20
>   error: variable 'dev' set but not used [-Werror,-Wunused-but-set-variab=
le]
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Tested-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>


