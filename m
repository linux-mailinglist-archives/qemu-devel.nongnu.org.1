Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B487D60D4
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 06:23:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvVOe-0005l9-2o; Wed, 25 Oct 2023 00:21:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qvVOb-0005ks-Su; Wed, 25 Oct 2023 00:21:29 -0400
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qvVOa-00067L-6W; Wed, 25 Oct 2023 00:21:29 -0400
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-3b512dd7d5bso927099b6e.1; 
 Tue, 24 Oct 2023 21:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698207684; x=1698812484; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lR89SBamKAq1xFw1YXQNFcCrWX9bGLJWRsF0P47NOSo=;
 b=km8Hg47iLNzf86+qxjjlcF80u3iMrZGic7o+QzycwPSAxxmmiFb8QOL/+FTKQex4Bi
 3UTXiZYUHqJBvjk/+q6vs6C/EPE/UmjrVhauJ9/O02pTvb+lNK+PZOUXTJHauP6+A5Es
 4DxF7/q6o+usQySLbrKkvkd+qEcbhxPrxCGs+3+QiY060pZddCssQGHhnoE99e23FUQ+
 fMtTgYu3UTmqmprm+d55s75yWohFuDE/GK3oUVKl09JeSgKg6TcNaeVURAo5bmY1bIUC
 xFqkij4i6HUuoQExpMEsCnKNiQFRXD371OQi+ntMgQeDXG8VJpGLjN+9zmDG8dg3kuV0
 3cNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698207684; x=1698812484;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lR89SBamKAq1xFw1YXQNFcCrWX9bGLJWRsF0P47NOSo=;
 b=QcmWglaC/2mAmiSO1r6hU5SaRpk43QsVOX5WhVaQuG/Wf1a3ejxWemFjYpkfRX2aKs
 RZXbzwjuJN2aJ8x+PrLb3G61d2ke/Nc272NfM7fYWqXS5HGfI4JRhfUTj8h1cF+BKGLg
 odYhf6pz77iQVTMQqJAIaKgkrEwS1N1nXGIE6t7HVQEwnh6gkrSjFdxg8LGlnUj8OFxj
 zf9QYR2mZDpSlBKTbJtFFC+g1bWSDoMNzlyqw0D3PNF6HFChcaEuZoJiP0lDGWnKFe8Q
 9MviPyOjoEShaJ9tYJg9a9gTsRfkgQEtjFwBvpx8uO8S1Iim6wyhWlUZexYtgmFEJryt
 UpSw==
X-Gm-Message-State: AOJu0YwM/+v8wLpDFTOKAxN+r/wOz7BhDRRG4ivZHain2arrjx/1NP/w
 vPHGnZ8Rav6emfiPX8k+qcc=
X-Google-Smtp-Source: AGHT+IHZz5hwMIYvvWh/dqVQwZBauP3Pp7E6XnYhlcBdHIuMMGxh4LNfPSl+Z6LU2gvajTBPkjwrIQ==
X-Received: by 2002:a05:6870:1f0c:b0:1e9:bbfe:6457 with SMTP id
 pd12-20020a0568701f0c00b001e9bbfe6457mr17132841oab.6.1698207683715; 
 Tue, 24 Oct 2023 21:21:23 -0700 (PDT)
Received: from localhost ([203.63.110.53]) by smtp.gmail.com with ESMTPSA id
 x27-20020aa78f1b000000b006bdfb718e17sm8360411pfr.124.2023.10.24.21.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 21:21:22 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Oct 2023 14:21:16 +1000
Message-Id: <CWH8DOBKCA46.7I53VPCZYZSB@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <clg@kaod.org>,
 <philmd@linaro.org>, "Bernhard Beschow" <shentey@gmail.com>, "Mark
 Cave-Ayland" <mark.cave-ayland@ilande.co.uk>, "Rene Engel"
 <ReneEngel80@emailn.de>, <vr_qemu@t-online.de>
Subject: Re: [PATCH v6 0/3] Add emulation of AmigaOne XE board
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <cover.1698190128.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1698190128.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::22d;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22d.google.com
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

Okay good, I could merge it via ppc tree then.

Sorry haven't done a PR yet, I've been struggling to get much time :(

Thanks,
Nick

On Wed Oct 25, 2023 at 9:49 AM AEST, BALATON Zoltan wrote:
> Changes in v6:
> - Dropped patch 1, now it's
> Based-on: <20231024224056.842607-1-mark.cave-ayland@ilande.co.uk>
> ([PATCH v2 0/3] ide: implement simple legacy/native mode switching for PC=
I IDE controllers)
> - Added Tested-by from Rene
>
> Changes in v5:
> - Fixed avocado test
>
> Changes in v4:
> - Found typo in comment in patch 1 so ended up rewording it again
> trying to make it more concise. Also take the idea of using
> range_covers_byte from Mark's patch
> - Added RFC patch for avocado test (untested, I don't have Avocado)
>
> Changes in v3:
> - Update values, comment and commit message in patch 1 again
>
> Changes in v2:
> - Update comment and commit message in patch 1 (Mark)
> - Fix irq mapping in patch 2 (Volker)
>
> Regards,
> BALATON Zoltan
>
> BALATON Zoltan (3):
>   hw/pci-host: Add emulation of Mai Logic Articia S
>   hw/ppc: Add emulation of AmigaOne XE board
>   tests/avocado: Add test for amigaone board
>
>  MAINTAINERS                             |   8 +
>  configs/devices/ppc-softmmu/default.mak |   1 +
>  hw/pci-host/Kconfig                     |   5 +
>  hw/pci-host/articia.c                   | 293 ++++++++++++++++++++++++
>  hw/pci-host/meson.build                 |   2 +
>  hw/ppc/Kconfig                          |   7 +
>  hw/ppc/amigaone.c                       | 164 +++++++++++++
>  hw/ppc/meson.build                      |   2 +
>  include/hw/pci-host/articia.h           |  17 ++
>  tests/avocado/ppc_amiga.py              |  38 +++
>  10 files changed, 537 insertions(+)
>  create mode 100644 hw/pci-host/articia.c
>  create mode 100644 hw/ppc/amigaone.c
>  create mode 100644 include/hw/pci-host/articia.h
>  create mode 100644 tests/avocado/ppc_amiga.py


