Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CFF7DEF77
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 11:07:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyUaZ-0001rB-FH; Thu, 02 Nov 2023 06:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaS-0001qP-Tj
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:04 -0400
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyUaR-0003JT-57
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 06:06:04 -0400
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-53f9af41444so1250411a12.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 03:06:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698919562; x=1699524362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XfSBtjeRR8hDddEpuaBA++vCPriC0XRmlADvTR1I9Og=;
 b=ZkVH2l+OCiJv/SxYRApFjOdtjKXJrooGCp7M7lpRkcTlFGPXzwbL7aGU4o1ITU8VSD
 Kw1h4vMgjpyY8mnQcsYtCpu0x0sckO0Sk68AXYvZp+CGtxDK6ZNtrDApY1DWWylE/mGn
 P6QXA8CwKh/lUSBCQKz9EbipwFPjXWqfdO+2Sxco2pJ4hKRD6UAtB5sas1bKPgtfwxF+
 hT97SPyhLK/FJcO0uqNeFd6qWb90HTyzEgSmPND3l7MvTc0t/yOJcamMApVb+de8r0Mb
 n3JUhyhmNTDEvSQ110Vypbm2wz9hIvUkzaOUrWD22X2bx6Wjl7SM+aFpmuKtRZHNpSZ2
 jagA==
X-Gm-Message-State: AOJu0YySYqCDEQled98Xr1FqhM25TCmhALXs9IuNVdCRnXhL7xjGPXx5
 8RjsQkwrsdFKbuVNoLWTPMSpBu4k460=
X-Google-Smtp-Source: AGHT+IHpNKq5Jcn0Cgsb7Pux6mo+OFfWysvwE8CVm0bn4iNo75Xev+LLbe+1E1sZNV7iRm0SMRDXYg==
X-Received: by 2002:a17:906:fe45:b0:9ad:e298:a5d with SMTP id
 wz5-20020a170906fe4500b009ade2980a5dmr5193230ejb.19.1698919561745; 
 Thu, 02 Nov 2023 03:06:01 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 o21-20020a170906359500b009b97d9ae329sm927236ejb.198.2023.11.02.03.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 03:06:01 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 10/10] tests/avocado/machine_m68k_nextcube: Fix the download
 URL for the ROM image
Date: Thu,  2 Nov 2023 11:05:43 +0100
Message-ID: <20231102100543.4875-11-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231102100543.4875-1-huth@tuxfamily.org>
References: <20231102100543.4875-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.41; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f41.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

If Avocado has to fetch this asset, the download fails with a 403 HTTP
error. Use a different URL to fix the issue.

Message-ID: <20231101201934.27637-1-huth@tuxfamily.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 tests/avocado/machine_m68k_nextcube.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/machine_m68k_nextcube.py b/tests/avocado/machine_m68k_nextcube.py
index d6da2fbb01..f1205d7fc0 100644
--- a/tests/avocado/machine_m68k_nextcube.py
+++ b/tests/avocado/machine_m68k_nextcube.py
@@ -30,8 +30,8 @@ class NextCubeMachine(QemuSystemTest):
     timeout = 15
 
     def check_bootrom_framebuffer(self, screenshot_path):
-        rom_url = ('http://www.nextcomputers.org/NeXTfiles/Software/ROM_Files/'
-                   '68040_Non-Turbo_Chipset/Rev_2.5_v66.BIN')
+        rom_url = ('https://sourceforge.net/p/previous/code/1350/tree/'
+                   'trunk/src/Rev_2.5_v66.BIN?format=raw')
         rom_hash = 'b3534796abae238a0111299fc406a9349f7fee24'
         rom_path = self.fetch_asset(rom_url, asset_hash=rom_hash)
 
-- 
2.41.0


