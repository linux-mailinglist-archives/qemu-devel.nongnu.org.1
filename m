Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E87A417F
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 08:46:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qi80n-0005fN-G6; Mon, 18 Sep 2023 02:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qi80l-0005eN-FA; Mon, 18 Sep 2023 02:45:35 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qi80j-0001jz-97; Mon, 18 Sep 2023 02:45:35 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-565334377d0so3388892a12.2; 
 Sun, 17 Sep 2023 23:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695019531; x=1695624331; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j5ZJwuGN+d6OvAR3CgZHe6wyB/YmpQWBJ5h6uuURc3E=;
 b=McBEv8wxmL4rkCUpLeW0T9xyHoZw8hPweTvHGEnMLTrXgG3EUcfPdKwLRQEI1avZE0
 Xon+14dZ1pYd3yBQrPDl6yMAk6nVracmY/BtqFxdunosxs0v+WO75+Wt4K8ZdvtshxWS
 ADDk57M+gH5EXAifAUMUDWSJUjJXCApxJV6XT8/grtPU73V03s6+8bIrKrR3mFsfozfR
 +SBNY/b/LThkqL6mAavLKqV+3HWRLtULFf8JgSIyimjKH6dNH1ROtI4At1USLHXFoFth
 ah07+Rz0tgxT9RWn7d57fpw5ZGdgnFu1i3cQh0OV21FmKhBydEfSo2c73C/cr9esK46h
 MLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695019531; x=1695624331;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=j5ZJwuGN+d6OvAR3CgZHe6wyB/YmpQWBJ5h6uuURc3E=;
 b=ZUqmPyrxNaOwHTQErJe+uMnNbrRDSha5O+8xt8svoZ+l30JiFg6XMhL0l3LcRL3ZgW
 9h6hSM/8BXq/kIzdbfLtfEc8Rc0LbZlnjAm3JxPrwBIoL9wfuOzGAdfZqH1WNvJ7i+td
 EeyQYgw96ihUpcrcbaFclYx82sr1C7x+YUeJpnKsy0t9XFsW5ceY2W9NtTMCLCPAYACZ
 khIH2AvVmmwAfYvLAZ3MoHtp3nJDvVpz6cegToIIVAOiWmHWVsJv3SGufCcTzrJddfCJ
 KCuZ5Vu6M5fMdomzcS7daYlbz+loDfyTTJiqz6Sowf2zYUGAarC+rQhoMnxukOch1k+y
 3JPg==
X-Gm-Message-State: AOJu0YzLtJ177pkT9WjB6tI+cgN5ZrMdMbVXfHkOKm8eNh/OxTMXGmzz
 yLKZzQ9DdtfDJeDDBsOrRYw=
X-Google-Smtp-Source: AGHT+IHOrqhnBSMPcHcbL5CU4TjkaoTF4kE9nHjjcPnDFSKHRq8a5p0kVwjSQonbGD7m+gjGKEgzVA==
X-Received: by 2002:a05:6a20:4407:b0:143:f4dd:dfae with SMTP id
 ce7-20020a056a20440700b00143f4dddfaemr11386668pzb.43.1695019531444; 
 Sun, 17 Sep 2023 23:45:31 -0700 (PDT)
Received: from localhost (61-68-209-218.tpgi.com.au. [61.68.209.218])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001bd62419744sm7613815pld.147.2023.09.17.23.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Sep 2023 23:45:31 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Sep 2023 16:45:26 +1000
Message-Id: <CVLU9WN6M895.27GDUJQUWD3UP@wheely>
Cc: <qemu-ppc@nongnu.org>, <david@gibson.dropbear.id.au>, <groug@kaod.org>,
 <aik@ozlabs.ru>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Subject: Re: [PATCH] MAINTAINERS: Nick Piggin PPC maintainer, other PPC changes
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230915110507.194762-1-danielhb413@gmail.com>
In-Reply-To: <20230915110507.194762-1-danielhb413@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
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

Oh, I forgot:

Acked-by: Nicholas Piggin <npiggin@gmail.com>

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


