Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABD37D2679
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 00:11:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qugeq-00015R-DS; Sun, 22 Oct 2023 18:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qugen-00014D-Kd; Sun, 22 Oct 2023 18:10:49 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qugeX-0000fr-Ck; Sun, 22 Oct 2023 18:10:49 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-53e08b60febso3959929a12.1; 
 Sun, 22 Oct 2023 15:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698012630; x=1698617430; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=4d7FBk6mKpSrFGEHyf/DaYSTvG6DvWB3M0KGguvtStM=;
 b=JKL13CFULq96Z5uSTfHySKE4/QW7/OxnGPSzddkgSWclUwszSHA4YAtB6BjOK4pK95
 uDN43DzFKCtGctGA1tgzewyKL6RLCV7aHKznlNmfr8FKdX/zSxrMJ4ZUu9XNHsvat6Gf
 SJksjNwksmMgjjiE5lotcTabhNs4S2U9tf7K8lY79VQgsG9ZekxW4LDv38J2HtPKuKu3
 BuYKgVVzvDYLHzQ8xu/xirFiWelNOVVHRhe+lhAY3dxK6+ZiB5HPGvY9CDO+eHKsiaxG
 jnBNOLYdxFKq1k0zrxjS+2Mf9FCoBcTjAZVmfnVGpG0RYdgbGiSV9G4Ba6eTvDswrX1Y
 7A6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698012630; x=1698617430;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4d7FBk6mKpSrFGEHyf/DaYSTvG6DvWB3M0KGguvtStM=;
 b=HlSrj09g01p4EWA8cIOATyK5+S/7yz29HJIcTWckIHNYVCbHH5FyXceBfP92G2jhz0
 ZrfqtQazKi6SLeH+zhd8ujGaPPhVsHjXwdORmDA+CAKGksB7pXJdODPOLkq/AdQ7Aqsm
 N8UymKWypZnG5yaRuz1iViP2db3mDWxCPxYSjtiaTQ2PUs0Il3Ega4gnvYvWhz3MQFil
 dbR+AMfvfQBl4jqoYbq9HOBuXg5S8NxB0Iv0yZoTusCl0+6CqVtegsQvHBIFp0qwkmd+
 /V3SU6oo3x/+sfFKJOEFSm19Tf67LrNySrUcRYmro6gQMEPNkHtdQy/OigXyfTwLJfng
 JcNQ==
X-Gm-Message-State: AOJu0YwYGLc3cfZ6mXVWGnuHu4e1Jor6QLVo99giDmvc/eXtJ8Gq6yLL
 2tpcEJoa3I0osH0vPajqI9Q=
X-Google-Smtp-Source: AGHT+IHqjRE07MqMnB0gYiXUlOTugbFecMwavUTGCjB/mB2MgUa9qqLiS+67iZMNJeyp/3LWf+B5Lw==
X-Received: by 2002:a50:99da:0:b0:53f:25c4:357d with SMTP id
 n26-20020a5099da000000b0053f25c4357dmr4403244edb.6.1698012630147; 
 Sun, 22 Oct 2023 15:10:30 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-013-189-152.77.13.pool.telefonica.de.
 [77.13.189.152]) by smtp.gmail.com with ESMTPSA id
 cw3-20020a056402228300b0053eb69ca1bcsm5302075edb.92.2023.10.22.15.10.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Oct 2023 15:10:28 -0700 (PDT)
Date: Sun, 22 Oct 2023 22:10:20 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, balaton@eik.bme.hu,
 philmd@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_ide=3A_implement_simple_legacy/?=
 =?US-ASCII?Q?native_mode_switching_for_PCI_IDE_controllers?=
In-Reply-To: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
References: <20231019130452.508426-1-mark.cave-ayland@ilande.co.uk>
Message-ID: <1C2A3DE2-A4E8-42D3-BE70-710AA8EB53E7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 19=2E Oktober 2023 13:04:50 UTC schrieb Mark Cave-Ayland <mark=2Ecave-a=
yland@ilande=2Eco=2Euk>:
>This series adds a simple implementation of legacy/native mode switching =
for PCI
>IDE controllers and updates the via-ide device to use it=2E
>
>The approach I take here is to add a new pci_ide_update_mode() function w=
hich handles
>management of the PCI BARs and legacy IDE ioports for each mode to avoid =
exposing
>details of the internal logic to individual PCI IDE controllers=2E
>
>As noted in [1] this is extracted from a local WIP branch I have which co=
ntains
>further work in this area=2E However for the moment I've kept it simple (=
and
>restricted it to the via-ide device) which is good enough for Zoltan's PP=
C
>images whilst paving the way for future improvements after 8=2E2=2E
>
>Signed-off-by: Mark Cave-Ayland <mark=2Ecave-ayland@ilande=2Eco=2Euk>

I've successfully tested this series on top of my pc-via branch, so for th=
e series:
Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>

I've added comments to the first patch=2E

Best regards,
Bernhard

>
>
>[1] https://lists=2Egnu=2Eorg/archive/html/qemu-devel/2023-10/msg05403=2E=
html
>
>Mark Cave-Ayland (2):
>  ide/pci=2Ec: introduce pci_ide_update_mode() function
>  hw/ide/via: implement legacy/native mode switching
>
> hw/ide/pci=2Ec         | 90 ++++++++++++++++++++++++++++++++++++++++++++
> hw/ide/via=2Ec         | 20 +++++++++-
> include/hw/ide/pci=2Eh |  1 +
> 3 files changed, 109 insertions(+), 2 deletions(-)
>

