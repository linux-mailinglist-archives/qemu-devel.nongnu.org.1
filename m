Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDBD81CAE4
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 14:47:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGfqv-0007cf-AX; Fri, 22 Dec 2023 08:46:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqV-0007RX-NU
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:50 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1rGfqT-0004I1-46
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 08:45:47 -0500
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-33687627ad0so1507054f8f.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 05:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703252742; x=1703857542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=436yFkmg3Ji/R5zo/zbZS+f6FCYm4Jfg6mBATZIPhOc=;
 b=azMwRthuYZtPnv3BWZHdZWHnuXzCys1WuPKqlR/vSB+YiHNK6ir8u1DDzfclt5HtLj
 SjqNaWGTv5F9u/mn+NORwsfCEJbaYMS0WnWkc3FhQDPqUKq8JUj77/t4dFFapI9Xfnmj
 3cIG3TkjGY3/UZTvhMycgHycCEioXZiRxjZiQe2sA/t3MK5Saysj4tQ+aFdTg9AzuZMI
 3h9KtXZyNpMSbCH/LFCcBvWuIAw9h0ydTiqMI9LemWa0rvbvWVswLbybObH8PD9M3ZP+
 WuNj2US1tkblDyQTFr9ucZcU/G8XhIOXSpaUcaDqLAmUMfQ/usNcGt8qYiszp2BkPqgA
 96Jw==
X-Gm-Message-State: AOJu0Yy+/u5G5k0xLCoO0LOZ4M4crLdgGTdlW15/YN+0DOQJMkdiytWJ
 ir9e3QNOD+Se9/2B7xYO6Y1t1z5GbEk=
X-Google-Smtp-Source: AGHT+IEbE9xZEXdtJKo6TvqJ02KMC9lCBIOUMvCl3U9X39iji6j686ZiIF52N1NOJVAYA0/Ji7bD9A==
X-Received: by 2002:a05:600c:6020:b0:40d:4967:4de9 with SMTP id
 az32-20020a05600c602000b0040d49674de9mr322396wmb.180.1703252741288; 
 Fri, 22 Dec 2023 05:45:41 -0800 (PST)
Received: from fedora.. (ip-109-43-177-45.web.vodafone.de. [109.43.177.45])
 by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm7047333wmq.27.2023.12.22.05.45.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 05:45:40 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PULL 01/11] next-cube.c: add dummy Ethernet register to allow
 diagnostic to timeout
Date: Fri, 22 Dec 2023 14:45:17 +0100
Message-ID: <20231222134527.15705-2-huth@tuxfamily.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222134527.15705-1-huth@tuxfamily.org>
References: <20231222134527.15705-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.221.52; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f52.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Add a dummy register at address 0x6000 in the MMIO memory region to allow the
initial diagnostic test to timeout rather than getting stuck in a loop
continuously writing "en_write: tx not ready" to the console.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20231220131641.592826-2-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index fabd861941..feeda23475 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -429,6 +429,10 @@ static uint32_t scr_readb(NeXTPC *s, hwaddr addr)
         /* Hack: We need to have this change consistently to make it work */
         return 0xFF & clock();
 
+    /* For now return dummy byte to allow the Ethernet test to timeout */
+    case 0x6000:
+        return 0xff;
+
     default:
         DPRINTF("BMAP Read B @ %x\n", (unsigned int)addr);
         return 0;
-- 
2.43.0


