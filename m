Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2322181B058
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:35:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGEWH-00030O-UY; Thu, 21 Dec 2023 03:35:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGEW6-0002yS-K0
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:34:54 -0500
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGEW4-0004xr-LZ
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:34:53 -0500
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-54c77e0835bso645391a12.2
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 00:34:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703147691; x=1703752491;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0k0EebmXgOze8wL5mbT/UZRKDS9omhUMj2EArEcx6Zg=;
 b=sqf5nR5gb2a7GTh9gOJ73AFtVXjZI8lqN+fIHvsFzhM0MTd8Ur3AkqicBGOi5evamn
 LalCeHzCvfgc6fru8hTKVr9j8ipjsrJQIRpr/RsOdCktMQNCsSEH1gbytLCDYsz87g0P
 gygjEtKnUKvxBnfBNzwRBSMx6j+vGaO+mMaH3mVBlPT7q0DB9jMY0U2DGMzpNLYdoOKY
 I75mD/+973+EVHTyT+j+Lp1wEE1tC6GB3x9PDHA1Q4kKRjNo4+kwFNOAps/boPFRUKcH
 VSZjjU+FyJwgrgXTzTtWashBGl5/vuDHoOjduZd2Ab5zmQWSOUWC1aN1EeGXYtgC3wuM
 r3TA==
X-Gm-Message-State: AOJu0YwtcFlkwET8llu6cJ6dp1sAT7FI/D1vqGHwn3wEWLmczUitIOqd
 jQ9XSBg6c+tO8GgGuPnt+OE=
X-Google-Smtp-Source: AGHT+IH+S/WnE3yel5iDWQQA2zFfG9cMtwSav3p6EIrJAZBGvroKnWjYUMxCT3hgQtfYvB9Jfkma8w==
X-Received: by 2002:a17:906:6a0b:b0:a23:60b1:216d with SMTP id
 qw11-20020a1709066a0b00b00a2360b1216dmr4137156ejc.111.1703147691199; 
 Thu, 21 Dec 2023 00:34:51 -0800 (PST)
Received: from fedora (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 mf8-20020a1709071a4800b00a26a4b935b0sm442886ejc.166.2023.12.21.00.34.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 00:34:50 -0800 (PST)
Date: Thu, 21 Dec 2023 09:34:48 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 09/11] next-cube.c: move LED logic to new
 next_scr2_led_update() function
Message-ID: <20231221093448.6d253bdb@fedora>
In-Reply-To: <20231220131641.592826-10-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
 <20231220131641.592826-10-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.49; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f49.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am Wed, 20 Dec 2023 13:16:39 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> Ensure that the LED status is updated by calling next_scr2_led_update() whenever
> the SC2 register is written.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

