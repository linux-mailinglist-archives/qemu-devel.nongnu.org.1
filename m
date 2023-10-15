Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E104F7C9C60
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 00:21:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qs9Sq-0002YK-Ed; Sun, 15 Oct 2023 18:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qs9So-0002XA-FA; Sun, 15 Oct 2023 18:19:58 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qs9Sn-0003qM-1S; Sun, 15 Oct 2023 18:19:58 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-533d31a8523so6526735a12.1; 
 Sun, 15 Oct 2023 15:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697408395; x=1698013195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQjqKhyxopWOkq8iLz+/+zqWDswR0pxoJ6GAPNG7LRs=;
 b=nHjiufAZOEee1ogcJ+yjRC3YaY4ei4Mh7+FsXMqIPWtbHBHaslem9e8BEjgyWmb6Z8
 +6FP1KRuuNGJkUbaSAGqmd+1OahVX0oy0D/+LRBVmepqtw32yTg4Ikm94vykOaJF2gBG
 HIz4QNALgftwW8RFtwG+SL5+aHx2QRfU7flki7R5sOiPcV/cN/2UnVDxheFThIeIgX9q
 81NKP7v/hF8+0L+IAHL5s3S2RoO8Gu1gq59ye5wYbtwJ063yZcSwuxAJpbM5w4ppypuA
 DipO6Ajoh88jFrm4pozERZjXinThAl3iSlx65dtJG8yxPRLYb+UV98ZrszTyymxwbjqJ
 Nxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697408395; x=1698013195;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fQjqKhyxopWOkq8iLz+/+zqWDswR0pxoJ6GAPNG7LRs=;
 b=YG0MVdJTU0OW9Ps5fwOSIJAaLhonBDXHfx8xesQlKFEfKibh6lux81sRwbPwBy6fTj
 +gRODDhfChPFMJK0O+CuM448OqJ4obbbPQT3c1CVOZmT5xjHDKcnuvLSx0vUxIspmTVD
 /XxdIf0Xx0Ayq9acj7AWa2MYjG8Zcyg8JjchGbGb5XPHapn93EGUZ2J+PfU2Z7o4DT6G
 ywrCz/ygHgp7AUzb/4Sq9SVpUEDjxiNx3eVrQaD/Y4DSm9yL39aN5990UsxPmhKkagpe
 y0x5BOmTMhiv7TIumofl42BHQYJeNnJOyT320oDnTwREt9YQHwBhfeSNKFezZLyGi5yU
 89SQ==
X-Gm-Message-State: AOJu0Ywy1HSCXVfXgMJIEHtqR+IOghpI1R6eWi1Rf6n4RexS9cRiJ1Tt
 B9FBfGRopaicErXEFynQS/mDfdG3snM=
X-Google-Smtp-Source: AGHT+IHF8NyBdzmxCocqfJZ7DxRiTKZxL7rtc0vIKcrJXcGVIUQiRGZoB2ihO3R2FVqZej3wJAxHTA==
X-Received: by 2002:a05:6402:2072:b0:53d:ec99:271 with SMTP id
 bd18-20020a056402207200b0053dec990271mr10012838edb.33.1697408394719; 
 Sun, 15 Oct 2023 15:19:54 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-055-006-021.78.55.pool.telefonica.de.
 [78.55.6.21]) by smtp.gmail.com with ESMTPSA id
 bt8-20020a0564020a4800b0053e4783afbasm3720485edb.63.2023.10.15.15.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Oct 2023 15:19:54 -0700 (PDT)
Date: Sun, 15 Oct 2023 22:13:31 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
CC: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?ISO-8859-1?Q?Herv=E9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/4=5D_hw/isa/i82378=3A_Access_?=
 =?US-ASCII?Q?memory_regions_via_pci=5Faddress=5Fspace=28=29?=
In-Reply-To: <20231011185954.10337-2-philmd@linaro.org>
References: <20231011185954.10337-1-philmd@linaro.org>
 <20231011185954.10337-2-philmd@linaro.org>
Message-ID: <F1DFDACE-0967-4F42-B5CE-EC43C82A6DBF@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 11=2E Oktober 2023 18:59:51 UTC schrieb "Philippe Mathieu-Daud=C3=A9" <=
philmd@linaro=2Eorg>:
>PCI functions are plugged on a PCI bus=2E They can only access
>external memory regions via the bus=2E
>
>Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro=2Eorg>

With `info mtree` and `info mtree -f` in the QEMU console before and after=
 this patch I get the same results for `qemu-system-alpha -M clipper -S` an=
d `qemu-system-ppc64 -M 40p -S`=2E So:

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/isa/i82378=2Ec | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/hw/isa/i82378=2Ec b/hw/isa/i82378=2Ec
>index 63e0857208=2E=2E95b45d0178 100644
>--- a/hw/isa/i82378=2Ec
>+++ b/hw/isa/i82378=2Ec
>@@ -76,7 +76,7 @@ static void i82378_realize(PCIDevice *pci, Error **errp=
)
>=20
>     pci_config_set_interrupt_pin(pci_conf, 1); /* interrupt pin 0 */
>=20
>-    isabus =3D isa_bus_new(dev, get_system_memory(),
>+    isabus =3D isa_bus_new(dev, pci_address_space(pci),
>                          pci_address_space_io(pci), errp);
>     if (!isabus) {
>         return;

