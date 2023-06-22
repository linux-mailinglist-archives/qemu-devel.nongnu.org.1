Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 652E9739D7E
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:36:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGi8-0000qV-1y; Thu, 22 Jun 2023 05:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGi5-0000pa-Mi; Thu, 22 Jun 2023 05:34:37 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCGi4-0003U3-6Q; Thu, 22 Jun 2023 05:34:37 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-553a1f13d9fso4120379a12.1; 
 Thu, 22 Jun 2023 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687426474; x=1690018474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rv71JeBwwQJhPyfOZ/Amh5Fh3qe8tcffbjWWcskdp/U=;
 b=V88PR0S/TfNkRvNfAwZU7MaGaUoqn0fkMoV9TOlJbtu9mtb+1kFG6ytx4oooNYPl7d
 6w536OWroG/nq3yThVBibSpD5jWhJb5VdjgQ1KAjSn2682BkIof1aHfT2yUdqXAq4/B/
 wZNwgTlPaEFEMPN80xayChamxU46dG9jne++mrvX9ax1oIMxydbePUrMvToCaSgHOhEk
 h/ff9zh4VHJVDTmla4w8Z075NF1l6egfLkn2u0rQmIuPGCp0xsHpBER58dJC0XWgWoY3
 +2bEyYkuUVzlmF+3iw2CXuXbyGWMHwa3HqUoX0B60yaI2n7V+ayH8cJYA/McEQ4Fjeit
 XoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687426474; x=1690018474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rv71JeBwwQJhPyfOZ/Amh5Fh3qe8tcffbjWWcskdp/U=;
 b=OMTMsugEXHwNhOMBfhZQ81iwJkVxkMIXDY1vmAVjHbgegUMcYFnO3lbI5/aW4G5I2I
 4CSrESZJ5HF+OicuK6CsxLXDwu0ceJlQT6P2UlRuRRoB6JXgupedDg9bwA6E/QxqmldX
 6tgtOBheqpEEObUpkHHKRUQSGkpw+fm1xdrCSsZ9Wu2nJjsj5X9FzIvBftt/aXkQmZkx
 sur9cO+zjI2k64YBXt4Qa1glb67JtKdVU9DRmFBPXvpX1ghGV3Pqk+eWoU4TNXH5Lbd+
 ccFaJulWcpyaDow4Lu6ML8tGZRHMVc8iBE5HlRuV/M6i2RpPzsnMXcRbTLHOxXvKmHFX
 WIsA==
X-Gm-Message-State: AC+VfDy8bq/TWkJ73a9vN6dm/Dl3VvwRp9yN3iCp2qcyUy+VpeJr2n1W
 0ab/BIHJO67Bx5VsCF8DzAOf4d4dsoU=
X-Google-Smtp-Source: ACHHUZ6hNwC1ZAAOndiE+8dKIItpzujQ5fvzPRQzUJOf5PlpyFkNwWbvvhavVMV21j/vm967cZfUYQ==
X-Received: by 2002:a17:902:ee51:b0:1b0:1fc7:cbc1 with SMTP id
 17-20020a170902ee5100b001b01fc7cbc1mr17254017plo.27.1687426474276; 
 Thu, 22 Jun 2023 02:34:34 -0700 (PDT)
Received: from wheely.local0.net (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 x3-20020a1709027c0300b001ac2c3e54adsm4925662pll.118.2023.06.22.02.34.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 02:34:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 6/7] tests/avocado: boot ppc64 pseries to Linux VFS mount
Date: Thu, 22 Jun 2023 19:33:56 +1000
Message-Id: <20230622093357.255649-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230622093357.255649-1-npiggin@gmail.com>
References: <20230622093357.255649-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x530.google.com
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

This machine can boot Linux to VFS mount, so don't stop in early boot.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/ppc_pseries.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/ppc_pseries.py b/tests/avocado/ppc_pseries.py
index d8b04dc3ea..a152cf222e 100644
--- a/tests/avocado/ppc_pseries.py
+++ b/tests/avocado/ppc_pseries.py
@@ -31,5 +31,5 @@ def test_ppc64_pseries(self):
         self.vm.add_args('-kernel', kernel_path,
                          '-append', kernel_command_line)
         self.vm.launch()
-        console_pattern = 'Kernel command line: %s' % kernel_command_line
+        console_pattern = 'VFS: Cannot open root device'
         wait_for_console_pattern(self, console_pattern, self.panic_message)
-- 
2.40.1


