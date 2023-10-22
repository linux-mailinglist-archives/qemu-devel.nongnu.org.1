Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB737D2263
	for <lists+qemu-devel@lfdr.de>; Sun, 22 Oct 2023 11:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quUzZ-00063f-FA; Sun, 22 Oct 2023 05:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUzX-00061S-Qj
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:43:27 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1quUzW-0003dd-8o
 for qemu-devel@nongnu.org; Sun, 22 Oct 2023 05:43:27 -0400
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-99c1c66876aso338439366b.2
 for <qemu-devel@nongnu.org>; Sun, 22 Oct 2023 02:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697967804; x=1698572604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoJHL0Hcf7QkQsenqcaFSScUVImIDj9jR6Qp0SjA7lE=;
 b=NawijkFJ3L2A5eSCAoM72v7ji/7lyM5TaW38+fqyxSdQpnz1so1ZrZNZ1IAF/Ds7rc
 TAudJVbbdr6xGWz0+KQo8E4P5hT4vEpevlvsc0USt1Pl0KSYCcEabV10r5hAJxR4qCHH
 yJwJdbPTyspmYefg1OGLrlYFl0o74QfN/+IJdDdVKOuQR1tvdAENlp7eTvudtxZAKD18
 ZCzU0SPM9H3mBGrgG8H45Mfuiid5rzg2Tb71Agcu2cymyV5TBOMK/l3CUetKWyeNmdDm
 qHwL6PxHG/AY5dzf6DsXXnCYxBJLCOSYbi+gbpFu27UiEAtUhwN5DOBu1GUjCzajvmCW
 gSwQ==
X-Gm-Message-State: AOJu0Yxf+DMLci7czSbta/6X4+C9Qnt2DenDYXa5R4Z/XA8fLXIxWQmP
 lnzwaEglZpVY9xhUeuyoN00=
X-Google-Smtp-Source: AGHT+IF5+Dx+aEIacAnQptN2Kio4zA4QghGbiLhJNIWj0W3PuD3hGM6LJfkoFT7+OWFxy6YeQcwmjQ==
X-Received: by 2002:a17:906:da82:b0:9ba:7f5:8cca with SMTP id
 xh2-20020a170906da8200b009ba07f58ccamr5116351ejb.20.1697967804605; 
 Sun, 22 Oct 2023 02:43:24 -0700 (PDT)
Received: from fedora (ip-109-43-176-141.web.vodafone.de. [109.43.176.141])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a17090671c600b009920a690cd9sm4762843ejk.59.2023.10.22.02.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Oct 2023 02:43:24 -0700 (PDT)
Date: Sun, 22 Oct 2023 11:43:23 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 6/6] hw/m68k/virt: Do not open-code sysbus_create_simple()
Message-ID: <20231022114323.293cb101@fedora>
In-Reply-To: <20231020150627.56893-7-philmd@linaro.org>
References: <20231020150627.56893-1-philmd@linaro.org>
 <20231020150627.56893-7-philmd@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.48; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f48.google.com
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

Am Fri, 20 Oct 2023 17:06:26 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> Mechanical change using the following coccinelle script:
>=20
>   @@
>   identifier dev;
>   expression qom_type;
>   expression addr;
>   expression irq;
>   @@
>   -    dev =3D qdev_new(qom_type);
>   -    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>   -    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, addr);
>   -    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq);
>   +    dev =3D sysbus_create_simple(qom_type, addr, irq);
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

