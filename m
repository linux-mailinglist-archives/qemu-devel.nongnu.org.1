Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0FA815B7D
	for <lists+qemu-devel@lfdr.de>; Sat, 16 Dec 2023 20:58:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEan9-0006lb-It; Sat, 16 Dec 2023 14:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEan7-0006kd-Op
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 14:57:41 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rEan6-00030w-87
 for qemu-devel@nongnu.org; Sat, 16 Dec 2023 14:57:41 -0500
Received: by mail-lj1-f173.google.com with SMTP id
 38308e7fff4ca-2cc5c9be934so9134891fa.1
 for <qemu-devel@nongnu.org>; Sat, 16 Dec 2023 11:57:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702756658; x=1703361458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wURBnNQqpvVKLDhMi7udNlbodmksItJNZmGIRi6EQyA=;
 b=oSLChsSd7xLC1vefWFJz9eF/yTcB6A77y+mDA5yDcSlACdI7Kl/hXNwdMFtjXlSIal
 Otk3tNOIIAdCcPMj3egKbcPWZLudaUWAw/+Gf11Twwc/zHI9eGwTsOkUWvrpASAMcRHO
 rK2o6LqLeyXCsgfzk3Ne3NBnPjllI2pzFkBRN48PuzeT0vgnuv0Q9o3LlfhDOuUEq2N8
 iHZQaQV3jsZeC0yEtn07Na0md9iT7OXp74VVzbD/EBM+NYg3gxPbfhIVQyXYt/hctio4
 hbhb0p+Cj3ytUJU3+w3Snkui9CRdHR/Z4DpE0qKMUsNkQ+haDWTYZdCdqe1yjrbEkzj4
 rpkQ==
X-Gm-Message-State: AOJu0YzTwH+QyXS7HFHMZWXNTPjC+F/vTqX1Ur/gdjwkhAPE7d+RTw9x
 6VIZzH2ND0vT0Jqh6ZSiSVq0notXNTM=
X-Google-Smtp-Source: AGHT+IGAVhSWy8khUc36dlhhZM5MGu8vDTbU3drLM7Vak2f0vVGfmBvFLZFGA3osXgEv5jQdnlrntQ==
X-Received: by 2002:a2e:bc29:0:b0:2cc:41b9:697a with SMTP id
 b41-20020a2ebc29000000b002cc41b9697amr3565656ljf.4.1702756657811; 
 Sat, 16 Dec 2023 11:57:37 -0800 (PST)
Received: from fedora (ip-109-43-178-144.web.vodafone.de. [109.43.178.144])
 by smtp.gmail.com with ESMTPSA id
 x27-20020a50d61b000000b0054bcb2b77b3sm9121367edi.70.2023.12.16.11.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 Dec 2023 11:57:37 -0800 (PST)
Date: Sat, 16 Dec 2023 20:57:36 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 06/12] next-cube.c: move static led variable to NeXTPC
Message-ID: <20231216205736.230cc1cd@fedora>
In-Reply-To: <20231215200009.346212-7-mark.cave-ayland@ilande.co.uk>
References: <20231215200009.346212-1-mark.cave-ayland@ilande.co.uk>
 <20231215200009.346212-7-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.173; envelope-from=th.huth@gmail.com;
 helo=mail-lj1-f173.google.com
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

Am Fri, 15 Dec 2023 20:00:03 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> The state of the led is stored in the SCR2 register which is part of the NeXTPC
> device.
> 
> Note that this is a migration break for the NeXTPC device, but as nothing will
> currently boot then we simply bump the migration version for now.

Ack, that's fine, we don't have to worry about migration here yet.

> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

