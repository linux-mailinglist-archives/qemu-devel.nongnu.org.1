Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 408DC81B05B
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:35:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGEWa-0003CB-Kf; Thu, 21 Dec 2023 03:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGEWY-00038C-Eq
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:35:22 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGEWW-0005DA-UU
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:35:22 -0500
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-5537114380bso403033a12.3
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 00:35:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703147719; x=1703752519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OTkmHR7XtUXlGWNXOOPSS9u+ED+CUjZ65BTdyyeOfh4=;
 b=uYyPwHCh3ZKsiw9DQUf+eafwJ2fSFVwZNdwlMq5umSzFZf2vw8ANkQWXx1iQ3uPrGl
 /Cx7VWbPGwGbrGkyug4JiaE4r0bifKJp5hlRw064BUhEXrEA0DaKtH0tMn3CdLvSyrwn
 gT6G5L4I4c3Wp6l8zd35XVpy1mWw4GQAcS7bWKmf4aR4CAAxiN/CEwCFbkKlCmGEhwwx
 XYSnm3CrkFjCaGIyO7CvbUnqYFMe1dZoxgR6i7syqxr8M3RqCitRulERGw1LIST8RthP
 1MRnbRVtMYARDLKPzFbfep6I5UHXYTnN7k6po3UHBwbfBfcqFp1tFIaV7nofGGXpYH2+
 1J0A==
X-Gm-Message-State: AOJu0YxCJle0PxjOE85R2GLpK3YcBWub0xHP7DLUlAcr/rZB1qvwyZ5q
 oXgp1hjynbhUGx8DRFBWPT75f2NmT5Y=
X-Google-Smtp-Source: AGHT+IFdc8p1j6eG+inaZvRCMNzC2evEysaNVJearDxDPbfNKBiZP8N0Ey3VK0ojIAv4yehBLO3nNg==
X-Received: by 2002:a17:906:8882:b0:a23:6051:d335 with SMTP id
 ak2-20020a170906888200b00a236051d335mr3262989ejc.71.1703147718940; 
 Thu, 21 Dec 2023 00:35:18 -0800 (PST)
Received: from fedora (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 et10-20020a170907294a00b00a2699a54888sm699663ejc.64.2023.12.21.00.35.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 00:35:17 -0800 (PST)
Date: Thu, 21 Dec 2023 09:35:15 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/11] next-cube.c: remove val and size arguments
 from nextscr2_write()
Message-ID: <20231221093515.3e29f7b5@fedora>
In-Reply-To: <20231220131641.592826-11-mark.cave-ayland@ilande.co.uk>
References: <20231220131641.592826-1-mark.cave-ayland@ilande.co.uk>
 <20231220131641.592826-11-mark.cave-ayland@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=209.85.208.45; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f45.google.com
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

Am Wed, 20 Dec 2023 13:16:40 +0000
schrieb Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>:

> These are now redundant with the scr2 and old_scr2 fields in NeXTPC. Rename
> the function from nextscr2_write() to next_scr2_rtc_update() to better
> reflect its purpose. At the same time replace the manual bit manipulation with
> the extract32() and deposit32() functions.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/m68k/next-cube.c | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

