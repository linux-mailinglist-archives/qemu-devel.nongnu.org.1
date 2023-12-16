Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19831815BA6
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 21:21:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEbAJ-0005DE-Tg; Sat, 16 Dec 2023 15:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEbAH-00053v-7U
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 15:21:37 -0500
Received: from mail-lj1-f172.google.com ([209.85.208.172])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEbAF-00042X-Jm
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 15:21:36 -0500
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-2cc3647bf06so18386181fa.2
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 12:21:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702758094; x=1703362894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UJkNr93Csa+mxHXMYr38sy6is+ya9lv89E1xq+m2oGE=;
 b=pFhxII4sE1ReHHkV5eaeePCNlRGkzzG2bFli78ksn0ulBqYAXujRXRc30ivjWUmXXt
 2d9kD2ArDywAWa6XsyoKQHNc6H2Y79ns1oIB6+m5/QYgzJDrSNxzA9oEwlbnlwP6B3g0
 +TpGp+SnQpFO3F8thyPlzRu4czbsZUIhSZaU9UAtnhqJzX0/fPOEn3R/MSncNgEj0Go/
 Bt/hw3TeeJnUYKexotK9mKizWz0Hz8xVVmKeCC1idryMrnO6dkCkmoe9OMlYlloPawzO
 bLou5lhhg81tvQ/ckJD1+L1aKu7fN7C0QLEK6M8ZXwyB5rkRdfhSqp714en+Ei59ERxg
 W4/w==
X-Gm-Message-State: AOJu0YyVaTbVrnh4TJDDTHevodhOL/jV2edCKPLqrbqihVILfDLyce0X
 7dVAQyDX7w5WsYUozHwFjhs=
X-Google-Smtp-Source: AGHT+IFIgY0dFR81DGLIKspPAgxjLsAidMGeYn4hIQMIbNniBo+h6CYrOAtVVtinAoLdPxEXNP6klQ==
X-Received: by 2002:a19:740d:0:b0:50b:c227:9b2b with SMTP id
 v13-20020a19740d000000b0050bc2279b2bmr3958906lfe.63.1702758093549; 
 Sat, 16 Dec 2023 12:21:33 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 hu11-20020a170907a08b00b00a1d2a13c425sm12194183ejc.30.2023.12.16.12.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 12:21:33 -0800 (PST)
Date: Sat, 16 Dec 2023 21:21:31 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 12/12] next-cube.c: move machine MemoryRegions into
 NeXTState
Message-ID: <20231216212131.38ee68d0@fedora>
In-Reply-To: <20231215200009.346212-13-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.172; envelope-from=th.huth@gmail.com;
 helo=mail-lj1-f172.google.com
X-Spam_score_int: 19
X-Spam_score: 1.9
X-Spam_bar: +
X-Spam_report: (1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am Fri, 15 Dec 2023 20:00:09 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> These static memory regions are contained within the machine and do not need to
> be dynamically allocated.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

