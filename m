Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57780295F
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 01:28:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9wno-0004m7-4X; Sun, 03 Dec 2023 19:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnK-0004V1-MI; Sun, 03 Dec 2023 19:26:43 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1r9wnG-000082-Mp; Sun, 03 Dec 2023 19:26:40 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5cbcfdeaff3so46278587b3.0; 
 Sun, 03 Dec 2023 16:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701649596; x=1702254396; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfD0K0aibjreKo4OGd+o7D2cWSxh06lmc6TQmHfOTns=;
 b=RYHWLj8xcv4rX8B5pOViUwWc8S4fxoaZsalX8YgxlcJwFeNracNXX5qdWPM3q44yDL
 z5dlBAMgU5IJOdD6o6g5nqhO8n/7zT9hUplakb1BvudyzB5pC/ueqGrBMnGdbE4fM5s5
 +SK7+sxcxIh/3TqezPOq6q7xIijhJ8LtUzR5pfP7T/Ng0ng2GgzOXqFn989Zdh+1z1vO
 TAJqKKeEQuMV83pqHphtpzeGHi79wJXy/+EN1szpMQt8+lHGFkfuworzZ6St1kvTUr7R
 UEegPHQ4R9yGUftOu0gCfyefTvTc56LWnH0uRho1Zw4a/NZPfFYgKHOp5BoeoXZ0Hze/
 4HTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649596; x=1702254396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfD0K0aibjreKo4OGd+o7D2cWSxh06lmc6TQmHfOTns=;
 b=Q5VerX7pIeZLSDXDMcsUe69GQVzSB8W5SqxL7RIGokphHDzBjtZr2K7O8Q81f4xk9b
 r2BcrCz++Jo3cQQGqr09N0WLJkjcAcdF1zQ5ml3zNsdzyqRiZKMfiKaG3Y6r4sOUZ9iG
 8ldK+xwoZsJxdKzl+zxTEAw0Ii0BNMk7cs03IbaM2iNGakWfR4/Ejg005n9As1l6eSMX
 x/rk5L8fNJFuWI+wvNwjkuSwHGz/p57XoY82W51enBiqnJZIypekW5zR3LmCYketvING
 vLSLfjnhx9PEMzogF6YtfRkvrUDH9QbmAYW4goVxbCnixR6zePlLFiktE+vgedibx58u
 C4Vw==
X-Gm-Message-State: AOJu0YzvX2OZ+H7N3MZRFrYbEPvpNPbY2Rs9Ryhd60gXtFSpJmDyPJ9K
 zy3Q5aQ0XXbJgL8OpXCHmBqgFGEQ0OZLCw==
X-Google-Smtp-Source: AGHT+IEzMQlqvHytbzn/QE/Xfb6gD+vIPqerkVulVY0kJcYHtBsJUAo7XhE+n1R+ogIwjJxQ3uOvBA==
X-Received: by 2002:a81:7956:0:b0:5d7:1940:f3ff with SMTP id
 u83-20020a817956000000b005d71940f3ffmr2360633ywc.103.1701649596590; 
 Sun, 03 Dec 2023 16:26:36 -0800 (PST)
Received: from localhost.localdomain ([201.206.180.22])
 by smtp.gmail.com with ESMTPSA id
 l63-20020a0de242000000b005d3e6ce07e7sm2443187ywe.6.2023.12.03.16.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:26:36 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v3 10/45] Add BCM2838 checkpoint support
Date: Sun,  3 Dec 2023 18:25:44 -0600
Message-Id: <20231204002619.1367044-11-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
References: <20231204002619.1367044-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112e.google.com
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/arm/bcm2838_peripherals.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/bcm2838_peripherals.c b/hw/arm/bcm2838_peripherals.c
index c147b6e453..196fb890a2 100644
--- a/hw/arm/bcm2838_peripherals.c
+++ b/hw/arm/bcm2838_peripherals.c
@@ -22,7 +22,7 @@ static void bcm2838_peripherals_init(Object *obj)
 {
     BCM2838PeripheralState *s = BCM2838_PERIPHERALS(obj);
     BCM2838PeripheralClass *bc = BCM2838_PERIPHERALS_GET_CLASS(obj);
-    RaspiPeripheralBaseState *s_base = RASPI_PERIPHERALS_BASE(obj);
+    BCMSocPeripheralBaseState *s_base = BCM_SOC_PERIPHERALS_BASE(obj);
 
     /* Lower memory region for peripheral devices (exported to the Soc) */
     memory_region_init(&s->peri_low_mr, obj, "bcm2838-peripherals",
-- 
2.34.1


