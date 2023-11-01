Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE957DE6B9
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 21:21:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyHgp-0004dn-SH; Wed, 01 Nov 2023 16:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyHgn-0004de-E6
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:19:45 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1qyHgl-00046X-C0
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 16:19:45 -0400
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-9d2d8343dc4so34015966b.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 13:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698869981; x=1699474781;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FLHH0VaKbgLNo8e7Z5+JMXie2068snGsps0M8AslTrI=;
 b=ETwrPXKsb+j2EdIuOgPspEoI4FefigxdzPj8JFrWWsFwRs/xx4gGwaGy3goEThLMAM
 QbsaUN/vROvY9xHII7kpUBLMljgHk3UI2VbWlUTpbZzBrKKmekh15aClw/FieO49trrS
 EXksL627IkFtHhussVDlhz9gsAgzg2SdDNFtsVfRdhwa+BJ5/shOo7C4T3G0tTSg8n1S
 TSRvkmPydxiA6WgCMr5j/BpKFPnc355r1tS1P0Vl8NaWQqILPKj0jdOsHltWU577oA8h
 CXMncmXORGwEeyYDCnkYYtP2+OYM9gGfwt5L9FPAIzWXdOB2gFLRK4UuTuecRN+lcL0U
 3nmA==
X-Gm-Message-State: AOJu0YxTF1dwLsosfISaOWvrUP0R67QyBzAtwvRkVaiFz2T0CDmozYK/
 dfkl+mKpK88ksGRA+9kNhDC7hjoycp8=
X-Google-Smtp-Source: AGHT+IFZtGDSFY1xF+0bmCWHYILDerrC0358vRB3gMAA7qax7uWp4j06qtGw5Ue1sCFfXj48FPabvg==
X-Received: by 2002:a17:907:807:b0:9c5:158e:f61e with SMTP id
 wv7-20020a170907080700b009c5158ef61emr3072266ejb.34.1698869981347; 
 Wed, 01 Nov 2023 13:19:41 -0700 (PDT)
Received: from localhost.localdomain (ip-109-42-115-39.web.vodafone.de.
 [109.42.115.39]) by smtp.gmail.com with ESMTPSA id
 lz9-20020a170906fb0900b009a13fdc139fsm316341ejb.183.2023.11.01.13.19.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 13:19:40 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/avocado/machine_m68k_nextcube: Fix the download URL for
 the ROM image
Date: Wed,  1 Nov 2023 21:19:34 +0100
Message-ID: <20231101201934.27637-1-huth@tuxfamily.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.47; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f47.google.com
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


