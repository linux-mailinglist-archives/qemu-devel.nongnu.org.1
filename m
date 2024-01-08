Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 019688272C1
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 16:16:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMrKO-0004JM-4L; Mon, 08 Jan 2024 10:14:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKL-0004Gk-Ml
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:09 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rMrKA-0001YJ-WC
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 10:14:09 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e45504006so7481445e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 07:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704726836; x=1705331636; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+qYSiNuHCw9vpeOMvQUbkSg7Ml8q939vYKp9TceBTU=;
 b=o/FI/5r+Uum1O0bvD5lHergn1BHTM4ASLdPgayHTsdzkBUPQ6k56oa7um9OeiAEMn5
 SjS/7/04CzB62fEuoUPmy1dgABJJcG9DyD6nbzBWT1+pmh756qMSh0J7eYJeR4Z0C23a
 P+HpzMolEoOu8phodHcMoudtP5iS4cESy/liOUs76CORtRmOlyjvSFBxxELTpz8rafgI
 CK8+Sq6bSEzFvF4bDRWDRb0mtSsiHg46BmaY/3CthBBQ6Vq5UA25MLEsQkM94lpwNfQs
 jf5kFQkgjBMJPNHvCT6zgRH/r2yTGNTeQWBDpTPRh846+/DjEO4qD4UScr3WIL3unYkO
 6z2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704726836; x=1705331636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+qYSiNuHCw9vpeOMvQUbkSg7Ml8q939vYKp9TceBTU=;
 b=HhJrrTZyHvE2DpQTyatNPaS3vdZK6uCNx0oRfQHbVP8RYvwHSIGRbEh2WtRUnWv4rL
 j8dSNs7tPhKhgUyt0EujL8mGYaLfYVBEWKjSNgbm6dvcxV9o5PWkgI8NoSftv/RlWWLq
 jlgnzQeCz1j1jXWmFpVL6YGrKG8gteh0CIfKqpEgVRsEGIDrI4hV5KezlIlbeieiYtVY
 Bqvcaehz+E0XPm/4DWo52eFIrk0LuoHSBVESTGa41/NdZoG3T/iczPEEqsUPjowkjYl5
 uDx+RNcagZg+baz3dnumVBx7tfSYhPrKiFIITk/qGy9Xk011xjY4JJsM3YZduvx2+qH4
 6Ouw==
X-Gm-Message-State: AOJu0YyMnSxhjZf+XTBJv5eHwC7nB09pnzzZ2e2o9nbsJNcy2DmQORH1
 0FN/bWMlpJkKUL1unHYlbIluk+1EH7TMeA==
X-Google-Smtp-Source: AGHT+IGe+V6MY3TPFeAtLiA4vZSH1BScP0G7fuTXInxOfUpbJCIpolLDd++4X1KI8Ag+gzV7dZgJ7Q==
X-Received: by 2002:a05:600c:3f87:b0:40e:44c3:e0eb with SMTP id
 fs7-20020a05600c3f8700b0040e44c3e0ebmr1167197wmb.28.1704726836343; 
 Mon, 08 Jan 2024 07:13:56 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 j23-20020a05600c1c1700b0040d8ff79fd8sm150554wms.7.2024.01.08.07.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 07:13:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 28A885F942;
 Mon,  8 Jan 2024 15:13:53 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 03/13] tests/avocado: modernise the drive args for replay_linux
Date: Mon,  8 Jan 2024 15:13:42 +0000
Message-Id: <20240108151352.2199097-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
Message-Id: <20231211091346.14616-4-alex.bennee@linaro.org>

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index e95bff32999..f3a43dc98c2 100644
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


