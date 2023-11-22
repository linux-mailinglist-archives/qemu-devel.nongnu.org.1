Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF087F5023
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 20:04:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5s8J-0005ZV-6p; Wed, 22 Nov 2023 13:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s8H-0005Yj-4B
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:39:29 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r5s8D-0005eA-AC
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 13:39:28 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40b2a8c7ca9so402985e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Nov 2023 10:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700678363; x=1701283163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YM81nRS1PdRTSiZLcvsNd6hR3BC88PLF/OJUv0Zk+ko=;
 b=EE4mK1C8k4wntRlp1dZcyiXWzF97UsxxU/kns5asfHiJF9HcM6D4gciFG/MRf8WI5t
 AiFS5AZD//4PmP5NC03x2xvA+ti7tIDv4pSoRWUTjyTzO8qaqfL4Q6ev3qAWaHg/+tV/
 HUSpF/Vid2jcWFtms2OySmldsBe6gg5O63wSgLTINKGnXfb93l6nrL6lkFMJVUSMK7SR
 wkQSim5At5oc4BTbUZbjhR4KYa9uE5agBF5RiTbX0r+pjhn43ojEZmQXQyTfpKWkn2WI
 /tdIo2IWSFkeLE91pJpTy5GdKQOAXYWmYjCMHUzrLdcLi34c6y2eUoAlPjtK+5B4iH2c
 7EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700678363; x=1701283163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YM81nRS1PdRTSiZLcvsNd6hR3BC88PLF/OJUv0Zk+ko=;
 b=UG9/iRCI+jZWSt4vtVLNiul7g6tvKT+efuqurMWFEDp+CWomdz9lRLWY97tY2KhkS4
 MbH9EiqWa41Q0eOAahVwyXUsztTkzzZ+PHeUqUjh64zvgMQbVdyAmSHwOjZuJeGio4SO
 bR9qO0UU/0TIIJWPDDrP0oyjjEmmxU48++s1h4qLsi4ezbZy3MtS2bhr5djh8V7cI7p6
 LCKSy8bUs6AMZ9RBeHooy4JpaDLHP4rG03xDTXv24+iB8sBFU/WDdxrtbzaB9XEvJ3NT
 RlhhplNyoI5mWg7YwnenK7JFkPsmDZXUrwCAmy8Fsb7FuET/x3mZOKIGHpLsyko6yxtA
 JUaQ==
X-Gm-Message-State: AOJu0Yww47G+LQUJEZIyBDDTFOCNfa3uSiah94ZsJmAe7/5DMGday1BC
 hElRDMtTQseoNyKYBUXD8dIm5ae2LSoK5mrJRws=
X-Google-Smtp-Source: AGHT+IFVr6qixZFdgvf5i+IT+v649d/euUY59l+zAg1f3baRu7UTFOr6FseOoBif1lEBB+gQiYfnxQ==
X-Received: by 2002:a05:600c:4690:b0:40b:2be0:1483 with SMTP id
 p16-20020a05600c469000b0040b2be01483mr963837wmo.26.1700678362787; 
 Wed, 22 Nov 2023 10:39:22 -0800 (PST)
Received: from m1x-phil.lan (pas38-h02-176-184-5-64.dsl.sta.abo.bbox.fr.
 [176.184.5.64]) by smtp.gmail.com with ESMTPSA id
 j25-20020a05600c1c1900b0040523bef620sm94382wms.0.2023.11.22.10.39.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Nov 2023 10:39:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0] hw/ppc/xive2_regs: Remove unnecessary 'cpu.h'
 inclusion
Date: Wed, 22 Nov 2023 19:39:20 +0100
Message-ID: <20231122183920.17905-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

xive2_regs.h only requires declarations from "qemu/bswap.h".
Include it instead of the huge target-specific "cpu.h".

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/ppc/xive2_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
index b7adbdb7b9..816f5d0e84 100644
--- a/include/hw/ppc/xive2_regs.h
+++ b/include/hw/ppc/xive2_regs.h
@@ -10,7 +10,7 @@
 #ifndef PPC_XIVE2_REGS_H
 #define PPC_XIVE2_REGS_H
 
-#include "cpu.h"
+#include "qemu/bswap.h"
 
 /*
  * Thread Interrupt Management Area (TIMA)
-- 
2.41.0


