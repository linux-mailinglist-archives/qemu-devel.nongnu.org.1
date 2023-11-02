Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E49737DEF55
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:00:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUU2-00079n-5V; Thu, 02 Nov 2023 05:59:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qyUU0-00078z-BM; Thu, 02 Nov 2023 05:59:24 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1qyUTy-0008IL-Jg; Thu, 02 Nov 2023 05:59:24 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so152243566b.0; 
 Thu, 02 Nov 2023 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698919161; x=1699523961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:from:to:cc:subject:date:message-id
 :reply-to; bh=o4kNLxNW6GoGk5ERMBQ1l4n66RoV5YMHckzIeSuI258=;
 b=QZML1Z56a9mK/veiwd+IwmYeBRuL0/Ier7rqxfqKhZePrGpB3E/W11VXDN5EsYf4Du
 fVYRvXYjgc0ECjjjyMs0fRqH345jQoX1McEpMtx1oRJzBMwoT5IWOI3JYGPoo9KGdT/A
 ddPY9WFpD4kop97WKMUS6XswgRLqqmt4eT+OcdHN5hsZanY7g45ck5K2mZSg9E+2nT1j
 j0berh9I6XlryRogFV/nmdvn9qlVXaUOQ4seITcqVwhtp5q6tfqoK2q9y/mkvqSXflE0
 nzSDGg1cMJ0NTPAbtnWh3FJu+KiwR/r+mPPU6fIbKd0LikvxypAOGfEa5QoHP5xalSlu
 a7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919161; x=1699523961;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o4kNLxNW6GoGk5ERMBQ1l4n66RoV5YMHckzIeSuI258=;
 b=jWtW6TN3U0uu3lYfoB3V7WnD8TyVFDHIGJdD+ImLKLqs/WPu8DDakmTK3XbnYwf5eB
 6zYxtjh0j+pop+EUDb/bwLBnttTgTUcpLms8Q3rJSAuqsFM61UQXuWR2KTbJH+tQPFxD
 xsgCGPVTWZr4A0E6MW1JfL30X4gC1g2LCtbjYYRjsdwcmdgAe5RVxMvldolzlhJsvKG0
 7Kf5DsVi1yBfuIgZMNNFoOrAaRRvVZpVnCH+nwrRLib6I7gMfb9q53E3v+EEEldx9ikQ
 POvnKoCTrhNODriH4gFryCPDLLP3bR4zIGLS6VW+cWVY5+5kpyFXuBh8UFMKtZ9PWoOG
 jf2Q==
X-Gm-Message-State: AOJu0YziC6q7FGD76wSxkuyut+Mc18pW0JylyinEYMviAzpH6EllD7jf
 B99k9p64R/o6FgnmBkMQbolleGnQa28=
X-Google-Smtp-Source: AGHT+IHcBH7ppQsalrVqEDTHUtBPxE+ieHamvWwH3zPV1QqzTg9vnKVyO1hxfvJ1oVreBAcLBZC6Jg==
X-Received: by 2002:a17:906:f9c6:b0:9c7:5186:de2a with SMTP id
 lj6-20020a170906f9c600b009c75186de2amr4034361ejb.6.1698919160684; 
 Thu, 02 Nov 2023 02:59:20 -0700 (PDT)
Received: from [127.0.0.1] ([90.187.110.129]) by smtp.gmail.com with ESMTPSA id
 t20-20020aa7d714000000b00536031525e5sm2098096edq.91.2023.11.02.02.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Nov 2023 02:59:20 -0700 (PDT)
Date: Thu, 02 Nov 2023 09:03:02 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, balaton@eik.bme.hu,
 philmd@linaro.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_0/3=5D_ide=3A_implement_simple_legac?=
 =?US-ASCII?Q?y/native_mode_switching_for_PCI_IDE_controllers?=
In-Reply-To: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
References: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
Message-ID: <60E06D0C-329C-4A84-A53D-745730F10487@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 24=2E Oktober 2023 22:40:53 UTC schrieb Mark Cave-Ayland <mark=2Ecave-a=
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

FWIW:
Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>[1] https://lists=2Egnu=2Eorg/archive/html/qemu-devel/2023-10/msg05403=2E=
html
>
>v2:
>- Rebase onto master
>- Mask the bottom 4 bits of PCI_CLASS_PROG in pci_ide_update_mode() in pa=
tch 1
>- Add patch 2 to remove the default BAR addresses to avoid confusion
>- Don't set PCI_INTERRUPT_PIN directly in via_ide_reset() as it is alread=
y set
>  by pci_ide_update_mode() in patch 3, and reword the commit message acco=
rdingly
>- Add Tested-By tags from Zoltan and Bernhard
>
>
>Mark Cave-Ayland (3):
>  ide/pci=2Ec: introduce pci_ide_update_mode() function
>  ide/via: don't attempt to set default BAR addresses
>  hw/ide/via: implement legacy/native mode switching
>
> hw/ide/pci=2Ec         | 90 ++++++++++++++++++++++++++++++++++++++++++++
> hw/ide/via=2Ec         | 25 ++++++++----
> include/hw/ide/pci=2Eh |  1 +
> 3 files changed, 109 insertions(+), 7 deletions(-)
>

