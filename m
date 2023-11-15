Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54EDD7EC75A
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 16:33:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Hsv-00060K-Lv; Wed, 15 Nov 2023 10:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Hsu-0005z6-B1
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:32:56 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3Hsr-0003ro-8O
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 10:32:56 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32f7c80ab33so4220118f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700062370; x=1700667170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=e/YXKgqJRecTApplA4lNpjlns2q7Ltjoo92cW7ea/ps=;
 b=ax+FdWPAWeqVYNW2K/+HmHIgoMSGngr8YJpF1lRYoQ6UaybS6N0TlxjbBpIy6rSZTw
 rsC8w9sMYnbJ0HyfcunkkvDpZYRQAYJSejEaaN6OCCuFEe/XAQ/CKpDw2026uC+sLhVv
 qPCcOcNy3Xd0W4YhwNUsb+exuwkgzTpwUZ8lbMpykrNKC522k+Au72T/bOk/xmXqxazw
 lYwN61uKIiZvCemx4+eSdncsPNWgyt4vrYnDBlvfErzHYZaSJXzobY3JMCqUsqAkr9T8
 q5vy5JmxlapPDpMfE14S5tBLLze83+l++7VGdBWh7Uo4DMMUmldhrisn+/O9/FwWx8ZW
 pGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700062370; x=1700667170;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e/YXKgqJRecTApplA4lNpjlns2q7Ltjoo92cW7ea/ps=;
 b=ipytbg5/jmr3mVCLyTSJiorR9qfCPASwnseaxhpVUHOj7ORSKtZrkVpmE4qpVaP4tv
 /7AwmWdJhPpRj3G2tQelZkhs4VBoyByBUijQ+91Na6HCUtNkWDwielnHyIzVBaOeOWEQ
 Do1Ctcz02l4H32XIye/4sBOtOidQ1fE2EtPi3OWQi3GOELqANlvlSuxpVLYTN6z7HDBn
 LldvH7Tk3QIKJw8PvQKDebujt7h6X/FMWj9wO0Uh79RB1gzcsrvRH0op2RhPTmO8WiEa
 8Ip7eNL5lA/3ht645OO1X+hGoNfOlnVf6RjMQLROHISjmrx81mgOkx6W0Ocr92zFvX6F
 gwxA==
X-Gm-Message-State: AOJu0Yx7BPvTBSwWbaQfXNH/TLPho5tAZveXH7xF7XEJAZz8IJmD0Ycp
 hGW1o8cX38k/wjHPW6jqf6cOlQpglOViGZBpYrI=
X-Google-Smtp-Source: AGHT+IFOChOMrP2XWmpVj9VrAhucoT8wf774ef9uRyh8BTIITjfVgPEpRbzYN8qUEf+miHdA0ZDmJQ==
X-Received: by 2002:adf:d1c8:0:b0:32f:7ebc:cf71 with SMTP id
 b8-20020adfd1c8000000b0032f7ebccf71mr8776123wrd.1.1700062370146; 
 Wed, 15 Nov 2023 07:32:50 -0800 (PST)
Received: from m1x-phil.lan ([176.176.130.62])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a5d68c1000000b0032fab28e9c9sm10868186wrw.73.2023.11.15.07.32.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Nov 2023 07:32:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-8.2?] tests/avocado: Make fetch_asset() inconditionally
 require a crypto hash
Date: Wed, 15 Nov 2023 16:32:47 +0100
Message-ID: <20231115153247.89486-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

In a perfect world we'd have reproducible tests,
but then we'd be sure we run the same binaries.
If a binary artifact isn't hashed, we have no idea
what we are running. Therefore enforce hashing for
all our artifacts.

With this change, unhashed artifacts produce:

  $ avocado run tests/avocado/multiprocess.py
   (1/2) tests/avocado/multiprocess.py:Multiprocess.test_multiprocess_x86_64:
   ERROR: QemuBaseTest.fetch_asset() missing 1 required positional argument: 'asset_hash' (0.19 s)

Inspired-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20231115145852.494052-1-thuth@redhat.com>
  "tests/avocado/multiprocess: Add asset hashes to silence warnings"
---
 tests/avocado/avocado_qemu/__init__.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index d71e989db6..304c428168 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -254,7 +254,7 @@ def setUp(self, bin_prefix):
             self.cancel("No QEMU binary defined or found in the build tree")
 
     def fetch_asset(self, name,
-                    asset_hash=None, algorithm=None,
+                    asset_hash, algorithm=None,
                     locations=None, expire=None,
                     find_only=False, cancel_on_missing=True):
         return super().fetch_asset(name,
-- 
2.41.0


