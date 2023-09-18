Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E167A4047
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 07:02:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi6O8-0001HY-Sd; Mon, 18 Sep 2023 01:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qi6O4-0001H6-6L; Mon, 18 Sep 2023 01:01:32 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qi6O2-0006GS-FX; Mon, 18 Sep 2023 01:01:31 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1c4586b12feso6453285ad.2; 
 Sun, 17 Sep 2023 22:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695013288; x=1695618088; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rqk1cG0c/tqdpN3tg7ISH9Z/OZFPEi+iwb25jbJ+SMc=;
 b=P4gYb9D6YrqbRjJvwfW25HNxDd+2K0ABdGzpLogLrFzj8EBWI89cjf6Cq6Z+oSOOMB
 +SYRg67Jhl3s2OCeibFQT6vsq51sPB2tlYtZ+8WuYl6P85/2+HyAvlwHmjH/aZpKzlrz
 N6vcL+PBoe0dKIPFEqnLAECcTqAqMaNBqjr0VgR9TsfgEZHKA3m5RGClZVNm+EhiXu4Z
 5gP/JarpSg+PuqXdPw6jhFFnPItmmeAXuzpsopk1GjYfh1B/V1ndbUhOjjbCWsDwI8TG
 JnI2Mo8zI35D45nESkvQxNxdaz9cW7CTLkPOeBszit6dtuSJG0mEgU5jsAqidR8UGSog
 41FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695013288; x=1695618088;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rqk1cG0c/tqdpN3tg7ISH9Z/OZFPEi+iwb25jbJ+SMc=;
 b=d+UWhWLi69/AJVOFU0CAiVL/WhGau9w8t9TiKydlhgejuSRzs7XD1PALxOLmJX6mUw
 W4gLw+5Q/26u0nHVgWHKv9o5KQ8zmFO4nVu8yKlvl1FHuYxgdZ/TGqjlCTpb8Wcd/RtM
 t+Y8Cx+zB9SrCJwMU1FgiH7x78biamIVPdWDVFfffyZbTq6Gh0pW1WzL8W48VCK+G04T
 a26UhqrZZyTlljSoc3oeXmGdMUOfJTFOaBpJGGy29qTpDaQdUH/MHSRu0XYt/UfNdIXw
 W2ofsZKOjmN4AGz817RIDDdKH86Ev1pZZFfIHUNvNxo8OIwhxmSuMs2E2ogjEbhJaqsD
 Vdhw==
X-Gm-Message-State: AOJu0YwrLrXdK+MVe99QAP+0nNbvM4ZTbvEhKSB4qi8tdSu3Lio7aFx2
 C9PiEFxKrD3VApylSDQR0t1kNYZUntM3lg==
X-Google-Smtp-Source: AGHT+IH/5K7NL+MuOQXjZjmXA68DjKkBSBQKcoJKISrT6UsyQSGJAgECub5uiPckTmdBTOZv/xmn8Q==
X-Received: by 2002:a17:902:6806:b0:1c3:7628:fcb5 with SMTP id
 h6-20020a170902680600b001c37628fcb5mr7108695plk.62.1695013288197; 
 Sun, 17 Sep 2023 22:01:28 -0700 (PDT)
Received: from localhost ([1.146.62.141]) by smtp.gmail.com with ESMTPSA id
 e6-20020a170902d38600b001bdb167f6ebsm7460431pld.94.2023.09.17.22.01.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Sep 2023 22:01:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Sep 2023 15:01:21 +1000
Message-Id: <CVLS27TKE0YM.3DW0F4YAP5BFA@wheely>
Cc: <qemu-ppc@nongnu.org>, <david@gibson.dropbear.id.au>, <groug@kaod.org>,
 <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230915110507.194762-1-danielhb413@gmail.com>
In-Reply-To: <20230915110507.194762-1-danielhb413@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

Hi Daniel,

Thank you for your stwardship of ppc, I might hope to do half as good a
job with it as you have. And to Greg and David for all the work over the
years.

Thanks,
Nick

On Fri Sep 15, 2023 at 9:05 PM AEST, Daniel Henrique Barboza wrote:
> Update all relevant PowerPC entries as follows:
>
> - Nick Piggin is promoted to Maintainer in all qemu-ppc subsystems.
>   Nick has  been a solid contributor for the last couple of years and
>   has the required knowledge and motivation to drive the boat.
>
> - Greg Kurz is being removed from all qemu-ppc entries. Greg has moved
>   to other areas of interest and will retire from qemu-ppc.  Thanks Mr
>   Kurz for all the years of service.
>
> - David Gibson was removed as 'Reviewer' from PowerPC TCG CPUs and PPC
>   KVM CPUs. Change done per his request.
>
> - Daniel Barboza downgraded from 'Maintainer' to 'Reviewer' in sPAPR and
>   PPC KVM CPUs. It has been a long since I last touched those areas and
>   it's not justified to be kept as maintainer in them.
>
> - Cedric Le Goater and Daniel Barboza removed as 'Reviewer' in VOF. We
>   don't have the required knowledge to justify it.
>
> - VOF support downgraded from 'Maintained' to 'Odd Fixes' since it
>   better reflects the current state of the subsystem.
>
> Acked-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  MAINTAINERS | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00562f924f..c4aa1c1c9f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -298,11 +298,9 @@ F: hw/openrisc/
>  F: tests/tcg/openrisc/
> =20
>  PowerPC TCG CPUs
> +M: Nicholas Piggin <npiggin@gmail.com>
>  M: Daniel Henrique Barboza <danielhb413@gmail.com>
>  R: C=C3=A9dric Le Goater <clg@kaod.org>
> -R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
> -R: Nicholas Piggin <npiggin@gmail.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: target/ppc/
> @@ -438,10 +436,9 @@ F: target/mips/kvm*
>  F: target/mips/sysemu/
> =20
>  PPC KVM CPUs
> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
> +M: Nicholas Piggin <npiggin@gmail.com>
> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>  R: C=C3=A9dric Le Goater <clg@kaod.org>
> -R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>  S: Odd Fixes
>  F: target/ppc/kvm.c
> =20
> @@ -1430,10 +1427,10 @@ F: include/hw/rtc/m48t59.h
>  F: tests/avocado/ppc_prep_40p.py
> =20
>  sPAPR (pseries)
> -M: Daniel Henrique Barboza <danielhb413@gmail.com>
> +M: Nicholas Piggin <npiggin@gmail.com>
> +R: Daniel Henrique Barboza <danielhb413@gmail.com>
>  R: C=C3=A9dric Le Goater <clg@kaod.org>
>  R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>  R: Harsh Prateek Bora <harshpb@linux.ibm.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
> @@ -1452,8 +1449,8 @@ F: tests/avocado/ppc_pseries.py
> =20
>  PowerNV (Non-Virtualized)
>  M: C=C3=A9dric Le Goater <clg@kaod.org>
> +M: Nicholas Piggin <npiggin@gmail.com>
>  R: Fr=C3=A9d=C3=A9ric Barrat <fbarrat@linux.ibm.com>
> -R: Nicholas Piggin <npiggin@gmail.com>
>  L: qemu-ppc@nongnu.org
>  S: Odd Fixes
>  F: docs/system/ppc/powernv.rst
> @@ -1497,12 +1494,9 @@ F: include/hw/pci-host/mv64361.h
> =20
>  Virtual Open Firmware (VOF)
>  M: Alexey Kardashevskiy <aik@ozlabs.ru>
> -R: C=C3=A9dric Le Goater <clg@kaod.org>
> -R: Daniel Henrique Barboza <danielhb413@gmail.com>
>  R: David Gibson <david@gibson.dropbear.id.au>
> -R: Greg Kurz <groug@kaod.org>
>  L: qemu-ppc@nongnu.org
> -S: Maintained
> +S: Odd Fixes
>  F: hw/ppc/spapr_vof*
>  F: hw/ppc/vof*
>  F: include/hw/ppc/vof*


