Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D7673B851
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 14:58:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgMk-0001G7-Pn; Fri, 23 Jun 2023 08:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgMg-0000vT-6T; Fri, 23 Jun 2023 08:58:15 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCgMc-0006UJ-Ml; Fri, 23 Jun 2023 08:58:13 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b52bf6e659so3159195ad.3; 
 Fri, 23 Jun 2023 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687525087; x=1690117087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekB+n0pvhBE4oDDClDofItiQvFeklJBwzGHlLI89v7E=;
 b=bM01o8W6fXegQg6teU++MN3kFduP79ib8cQ9oCQ8TybDYucVrpGIx9cg/5USi6Qc5V
 Z9hmAfmmSauEPEoSEsL76QVI5c8+1GWoXEoS0VxHwV06ijufiJJZ1UhZvU9iLzUwdCIw
 QWR8RTtwlZ+KH3tcewYhkrjJXE6OLrPDIVZXjl+oxZgrSGGs4SnqGgMjs3G4T7BiiPQn
 s+Jf2BrW6FfwJE8cdZcKw8oc66x7sOiUBiDdQ/PgbIjkRb/Uht6w43xgU9qT4bAU3j5X
 aGSddKdE668efaqyGKX02hwy40CCcOGi56QUHWFecDjVRcZ/epxGnA2lqesWYrksZvHd
 gMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687525087; x=1690117087;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekB+n0pvhBE4oDDClDofItiQvFeklJBwzGHlLI89v7E=;
 b=afjkmjJvgzU+gz19vfLTNUdrVkhTyBcoTClAf99yUa5o2HvytSNBeaBw05/fMCs6iG
 mQPMDSIkj1w25v+Uyrk86/Hwc/Y3+T5lWEYgHqRAzj5zbXhMyEcbBGEG/2SKCzJfOi58
 8uh0beMeVv7pCxRzyLjr+sB6aPKKwMl+RDhzzRyTzuIFhOMd0gQBWNIQbuDfilp3YaKn
 mQ1FVGnVh1l1bNB4hAeMLq8k/TSN7nSA8YKgQwNIh+CRwsSc6uXaLMvgArUSqmAp3XLq
 slcm3EiDrubRErRUSFme0U/PBk/JIMPVAaBBffD/4oAtIK72CJfaXo5fBkFb/weiM5vR
 HTyA==
X-Gm-Message-State: AC+VfDzOONM6EiZc9OQVMhc7GdR78UCMzraCQeXL9INX6aeXzUevVLxD
 bICbfhzNiPK2ubrJagTxD44lbw2TE+s=
X-Google-Smtp-Source: ACHHUZ72NqcPGF4j0qG9coVxAGsxQpD2shhae0rDv8SVsZ+LCs/W3mC4geMwZY/UbwxAH2T9/F41NA==
X-Received: by 2002:a17:902:6b43:b0:1b6:7d4b:3f97 with SMTP id
 g3-20020a1709026b4300b001b67d4b3f97mr8970048plt.24.1687525086915; 
 Fri, 23 Jun 2023 05:58:06 -0700 (PDT)
Received: from wheely.local0.net (193-116-198-102.tpgi.com.au.
 [193.116.198.102]) by smtp.gmail.com with ESMTPSA id
 b12-20020a170902bd4c00b001a04d27ee92sm7141795plx.241.2023.06.23.05.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 05:58:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 7/7] tests/avocado: ppc64 pseries reverse debugging test
Date: Fri, 23 Jun 2023 22:57:07 +1000
Message-Id: <20230623125707.323517-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230623125707.323517-1-npiggin@gmail.com>
References: <20230623125707.323517-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
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

pseries can run reverse-debugging well enough to pass basic tests.

There is strangeness with reverse-continue possibly relating to a bp
being set on the first instruction or on a snapshot, that causes
the PC to be reported on the first instruction rather than last
breakpoint, so a workaround is added for that for now.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 680c314cfc..553c931994 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -94,7 +94,7 @@ def gdb_bstep(g):
     def vm_get_icount(vm):
         return vm.qmp('query-replay')['return']['icount']
 
-    def reverse_debugging(self, shift=7, args=None):
+    def reverse_debugging(self, shift=7, args=None, initial_skip=False):
         logger = logging.getLogger('replay')
 
         # create qcow2 for snapshots
@@ -135,6 +135,10 @@ def reverse_debugging(self, shift=7, args=None):
             self.fail('Reverse continue is not supported by QEMU')
 
         logger.info('stepping forward')
+
+        if initial_skip:
+            self.gdb_step(g)
+
         steps = []
         # record first instruction addresses
         for _ in range(self.STEPS):
@@ -216,3 +220,25 @@ def test_aarch64_virt(self):
 
         self.reverse_debugging(
             args=('-kernel', kernel_path))
+
+class ReverseDebugging_ppc64(ReverseDebugging):
+    """
+    :avocado: tags=accel:tcg
+    """
+
+    REG_PC = 0x40
+
+    # unidentified gitlab timeout problem
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    def test_ppc64_pseries(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:pseries
+        """
+        # start with BIOS only
+        self.endian_is_le = False
+        # reverse-continue fails (seems to end up at the start) if a break
+        # is put on the first instruction. initial_skip skips one before the
+        # first bp, and it works. Could be due to break at the same icount
+        # as the snapshot?
+        self.reverse_debugging(initial_skip=True)
-- 
2.40.1


