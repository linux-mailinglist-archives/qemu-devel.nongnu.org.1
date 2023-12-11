Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6102F80C41F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 10:15:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCcMN-0001PG-UD; Mon, 11 Dec 2023 04:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMM-0001OK-3F
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:54 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rCcMK-0004Kx-Ek
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 04:13:53 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3333224c7b9so3810856f8f.1
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 01:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702286031; x=1702890831; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D8qIrlEoKyQAUiAn6AfdU5hmEAuN6bNA20M5VlLbvng=;
 b=DQcc9shT15cDH5S99vTzY9vQnuJHID8z1AeLjeMIiamNTbqGdnZ5w2wwnE1CXqoOiC
 6xUX47l4GOyuMqiY1fgKv6WKTuizRKlYj8ojAOAqKY55O47bMc4CVGZeQgvbNhYMgfkc
 WUrviVsvA5AetB8FnI5ti5rr3kFSDESRDQ3UxypSITUzu52WGEHZRkCdHkIgWxoaXUVQ
 yTcshhDaO4Jcj9lfMzZUTQSwesKJV5awp9YB9L+IpTsjXqnifOhk2fsW5VuAkk8Z5smr
 VsqiZuAwDEGcOJeaJlh4WihkQZLM/MWDTuQixkgzfxjDZ6Uue5jy2Ehv85SWGcf5u+f/
 UzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702286031; x=1702890831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D8qIrlEoKyQAUiAn6AfdU5hmEAuN6bNA20M5VlLbvng=;
 b=Ijaz4mHriUviwH0VgY+qo0fttNH24GKQlAdz7vJT8s54ljP0CKyRQgs9iQynWlu9nb
 Xidde9IrVpbDcfFN2kvz9eaQYjPXae+eoCKzY3/RGDuAjX6Mvw6FGD+vPGmPjHouNZJe
 h3bD4VvOsxENBTT6CSS0n7UYGNmyM9kP6glpSnZzU1nid9fQEWLurWsCg3sAstEBKU2E
 7FOSCjf6V0WYcAolyKLtg+RTd4peTpjMxNLGsvD3H25ibob3UjclebsA2K1rQAlp9sRE
 pA8IYQ/oBsfx5nmrMhA1o0ksGHJmrC9Q7N7dp8gRMCuIkqfWTyidnkL74NPkc60V4rfQ
 A5Lg==
X-Gm-Message-State: AOJu0YwalmGWU3FdhFGNapmZqGUlICVuAggJwStSvrT9eVYDs9N0Xz4Y
 gCnvBYoE7Pt8CmjUxJqnCi3knA==
X-Google-Smtp-Source: AGHT+IEfwlK4WgQD6vz6T6qHnCM/7xygG/i9lQMlFyYbx4VOdcZMWvwX8ObZiHV01NtnYs61/ctUVw==
X-Received: by 2002:adf:f58c:0:b0:333:3f8c:b5fb with SMTP id
 f12-20020adff58c000000b003333f8cb5fbmr2432023wro.135.1702286031072; 
 Mon, 11 Dec 2023 01:13:51 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o12-20020a5d474c000000b003333dd777a4sm8120545wrs.46.2023.12.11.01.13.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Dec 2023 01:13:47 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 588085FBDE;
 Mon, 11 Dec 2023 09:13:46 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 03/16] tests/avocado: modernise the drive args for
 replay_linux
Date: Mon, 11 Dec 2023 09:13:32 +0000
Message-Id: <20231211091346.14616-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211091346.14616-1-alex.bennee@linaro.org>
References: <20231211091346.14616-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

QEMU complains about us not being explicit with setting snapshot so
lets do that. Also as cdroms are RO media we don't need to jump the
hoops of setting up snapshots and replay disks - just declare the
drive is a cdrom and nothing should change.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/avocado/replay_linux.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index e95bff3299..f3a43dc98c 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -48,12 +48,15 @@ def vm_add_disk(self, vm, path, id, device):
         bus_string = ''
         if self.bus:
             bus_string = ',bus=%s.%d' % (self.bus, id,)
-        vm.add_args('-drive', 'file=%s,snapshot,id=disk%s,if=none' % (path, id))
+        vm.add_args('-drive', 'file=%s,snapshot=on,id=disk%s,if=none' % (path, id))
         vm.add_args('-drive',
             'driver=blkreplay,id=disk%s-rr,if=none,image=disk%s' % (id, id))
         vm.add_args('-device',
             '%s,drive=disk%s-rr%s' % (device, id, bus_string))
 
+    def vm_add_cdrom(self, vm, path, id, device):
+        vm.add_args('-drive', 'file=%s,id=disk%s,if=none,media=cdrom' % (path, id))
+
     def launch_and_wait(self, record, args, shift):
         self.require_netdev('user')
         vm = self.get_vm()
@@ -65,7 +68,7 @@ def launch_and_wait(self, record, args, shift):
         if args:
             vm.add_args(*args)
         self.vm_add_disk(vm, self.boot_path, 0, self.hdd)
-        self.vm_add_disk(vm, self.cloudinit_path, 1, self.cd)
+        self.vm_add_cdrom(vm, self.cloudinit_path, 1, self.cd)
         logger = logging.getLogger('replay')
         if record:
             logger.info('recording the execution...')
-- 
2.39.2


