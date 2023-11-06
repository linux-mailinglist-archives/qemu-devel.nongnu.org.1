Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4DDC7E1D2D
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 10:27:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qzvse-0000MC-KK; Mon, 06 Nov 2023 04:26:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qzvsa-0000Hv-Tk
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:26:45 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1qzvsZ-00031B-F3
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 04:26:44 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-49618e09f16so1674783e0c.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 01:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699262794; x=1699867594; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgBg17yc0RZukCZpMjAWchUiOeRRIqInlX1XTPSIHbs=;
 b=gM4inNC+c9P8nsvxbMvnSR5jQYFyhyWfatw8leGMMx2pPW0j+4wzSVCj+UkpY8Qth9
 n/fsBjgrDPzZcDAykVDU2AFSARdBgYj/a3CwgpEzVh+Ys0TAxV1HBDhhJmWmRP23bSJl
 O1/yUwOpIwftHRTGCDt6/4ntWy2saT8Wa9mNHypK4hrjkngBx0AM1WiojR9XAqTECpqm
 ndvYPRtp6cvC5k4R7cgpI5/3uxsQb0whX0DCuyT90xb5em38V4hyOoEBbDLXSuMalCgb
 M1EM4M6orjsIMCZbacSRKKJutPEei1hQ+VJQ6VZs2XjoHoIfsg4l9iGe4RSRzAgY1Awe
 TyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699262794; x=1699867594;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgBg17yc0RZukCZpMjAWchUiOeRRIqInlX1XTPSIHbs=;
 b=f+OQ1JE4HDkhlnv+0xmK2LikJDawBzflLYHOBptmOlwVf1QsfiRLArin7ERRB9akaM
 cMLIrIPDXLj8ED7MwBh5P2pUKu49DgkfW0stPcBRJiLd5jyNHSkmzmJNIUCMkxpoLqgi
 DSWVmYHvSM8sb7gAw+AKskFXnaHHu2tsipZbkHFNufVMYvHfz28m4+Wy6S9FzADGOWCM
 KsqNTqvcQ4YGkX19wACbmJ39QUY2yaG1fK/KyY6yFrghJUDhvccOVDdWmyt5lpkw4Vy0
 VPbdn6892s/tsW8U1cDTs1xRWTFQxNZfEGJGBtjE+4J22Z2SEer13I/NxmD67H+AumL2
 G/Ag==
X-Gm-Message-State: AOJu0YwGvjiODsxZMHTyeaJwQHjHX9G4lQ3a2ryGK4azM36SAE8LIcCH
 fdHG8L01nfz5xuA+923sOJe63eFuK/xD3JlprTM=
X-Google-Smtp-Source: AGHT+IHVFJmTyv1+pcx4N4TSK9aKgUoE1U8bO8X4DTWRYPJnaREu/KrJpGOblaeNAAmY09AwXYJrccI4SaYgxKTzEcU=
X-Received: by 2002:a1f:b6d6:0:b0:4ac:22c7:89d5 with SMTP id
 g205-20020a1fb6d6000000b004ac22c789d5mr3235871vkf.2.1699262793643; Mon, 06
 Nov 2023 01:26:33 -0800 (PST)
MIME-Version: 1.0
References: <20231106065827.543129-1-richard.henderson@linaro.org>
 <20231106065827.543129-49-richard.henderson@linaro.org>
In-Reply-To: <20231106065827.543129-49-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Nov 2023 19:26:06 +1000
Message-ID: <CAKmqyKNdjQfTq+kfbi+bSEy5O1hEqCWjH74mJV3BF5_aT92UMw@mail.gmail.com>
Subject: Re: [PATCH 48/71] hw/riscv: Constify VMState
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, 
 farosas@suse.de, leobras@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Nov 6, 2023 at 5:14=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/virt-acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 7331248f59..d3bfaf502e 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -374,7 +374,7 @@ static const VMStateDescription vmstate_virt_acpi_bui=
ld =3D {
>      .name =3D "virt_acpi_build",
>      .version_id =3D 1,
>      .minimum_version_id =3D 1,
> -    .fields =3D (VMStateField[]) {
> +    .fields =3D (const VMStateField[]) {
>          VMSTATE_BOOL(patched, AcpiBuildState),
>          VMSTATE_END_OF_LIST()
>      },
> --
> 2.34.1
>
>

