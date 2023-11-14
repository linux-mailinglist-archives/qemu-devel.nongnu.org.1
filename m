Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0C17EB2C1
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 15:49:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2uiW-0003Ru-A9; Tue, 14 Nov 2023 09:48:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uiU-0003RL-I7
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:48:38 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2uiS-0001DC-Ph
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 09:48:38 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c773ac9b15so805820266b.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 06:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699973314; x=1700578114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gien3tKD1uU0a5g3Bm5UWg97KBauF+zI5VueJWKK7QY=;
 b=CqzOPSUI3BHhSN26lGeGZkMgFD7XS53f2bQYnfgvdpxB6M7HxmSjxoUGDN3Ca7loiz
 KNelB6l6LY8NaMiw5QM7id/z7PBz3AuJvM3Q4yNftGPCE9bovGBQxqlS7/5ThfdXLN6X
 cVHHdafjmfdBSJ7lAAKTw91O5Qdjhtt8Zf8w8LFOgjYwSmKSVX664JP4p3sTzQ9+MmbE
 bDsI5CP+hXV1MKSNw6ob+HqKn1g+DE1FcxfTVbMe1myv0IL1/SPzjUkzqZGG7GztVwQg
 nLwKzejRwigxRcXS9KhJtMDlHQqN78HV68BpAOqVNdvPUb1pm0ztwRQJBW1ZWdrQJZFW
 DE6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699973314; x=1700578114;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gien3tKD1uU0a5g3Bm5UWg97KBauF+zI5VueJWKK7QY=;
 b=leSsBX0v0lnJwraZ0e6yQPL/euzuQJc7RkdMTse4JQqCA4wrbOx1jdJb8XfORTYYxm
 0PyOCgdnjyiGFOie+9jWOQBtxXuCECDrc2L8LrsJdBy1HtQbBY3tRGy1Y9ueXbS6o3bV
 KjswK6rpHYGbEowqdQ/UclsmTScTPK6PfSXgXa/b0ag77aaChNYXOJtTTTOJgPKE1NKn
 +NTsjaK1uqWsefYpvZu+GF2GP+dHZPNRJl2yK6cxCee5O5+aN4v66oktjr2XGPd5Tw98
 GMniHzByN9qgclCJJfKcThjUuOjgs6tDCWN389uHEwy/dUEMRO/Q6i3pcXAJTz6O+9tn
 iwEQ==
X-Gm-Message-State: AOJu0YzMVWFLAscPf0DXgPxcxqAEWCTJuVomV5IGjaCGwLO4gaSSSMOp
 QBBj5e+bQxyt8Jqwi+E3DD6ckKiOLb/ieCtZK3E=
X-Google-Smtp-Source: AGHT+IEu91zKC7LC4/S0QO2ncwyx8uhR6TfmFNS7In6xq4Ki75zEwTcPr69VvFtNgJOJ2XPvcXKX4A==
X-Received: by 2002:a17:906:2587:b0:9dd:7133:881 with SMTP id
 m7-20020a170906258700b009dd71330881mr8091353ejb.40.1699973314648; 
 Tue, 14 Nov 2023 06:48:34 -0800 (PST)
Received: from m1x-phil.lan (cac94-h02-176-184-25-155.dsl.sta.abo.bbox.fr.
 [176.184.25.155]) by smtp.gmail.com with ESMTPSA id
 w14-20020a17090652ce00b009ae3e6c342asm5642422ejn.111.2023.11.14.06.48.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Nov 2023 06:48:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH] tests/avocado: Replace assertRegexpMatches() for Python 3.12
 compatibility
Date: Tue, 14 Nov 2023 15:48:31 +0100
Message-ID: <20231114144832.71612-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

assertRegexpMatches() has been removed in Python 3.12 and should be replaced by
assertRegex(). See: https://docs.python.org/3.12/whatsnew/3.12.html#id3

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/testing.rst   | 2 +-
 tests/avocado/version.py | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index fef64accc1..0af8f32fa3 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -1016,7 +1016,7 @@ class.  Here's a simple usage example:
           self.vm.launch()
           res = self.vm.cmd('human-monitor-command',
                             command_line='info version')
-          self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
+          self.assertRegex(res, r'^(\d+\.\d+\.\d)')
 
 To execute your test, run:
 
diff --git a/tests/avocado/version.py b/tests/avocado/version.py
index 93ffdf3d97..c6139568a1 100644
--- a/tests/avocado/version.py
+++ b/tests/avocado/version.py
@@ -22,4 +22,4 @@ def test_qmp_human_info_version(self):
         self.vm.launch()
         res = self.vm.cmd('human-monitor-command',
                           command_line='info version')
-        self.assertRegexpMatches(res, r'^(\d+\.\d+\.\d)')
+        self.assertRegex(res, r'^(\d+\.\d+\.\d)')
-- 
2.41.0


