Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B19CE763F0B
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 20:53:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOjN1-0000nN-4G; Wed, 26 Jul 2023 14:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMy-0000mq-TS; Wed, 26 Jul 2023 14:36:20 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qOjMx-0008O8-16; Wed, 26 Jul 2023 14:36:20 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso833695ad.0; 
 Wed, 26 Jul 2023 11:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396575; x=1691001375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbEjOnkySITmLw82s9WCGkUqlGYptTamWi06s3l0n7s=;
 b=lrJYSj/CKxLoBVwnudwupTv1NE9+vgiguez8ZPCHLa7sFdG2gYaykTPeeJ6sLTRn2B
 uwo2ghNk/QtV1KM9xK+RR7W3QZAHD+WHs9R2UnMMcgc7AwxkmR13n2ItoEeuciEMjFUu
 e0WkRAmZQkAObtk4QQJQRlWpzE8OJuwKz46rg4LJgYBi2wQCsmxZPiZAzaelfKHqKTQ5
 4UrlmTPPKaNpwGzhpkI2XGDA6b4c8R3QxNgqMLTvsDNOxLaAalXXLz/zgvu8I94rNXWc
 phU5A0a3RciiD1DonXDKwFlLM0udwzGXUjZtfytZ50QOC28duU6hpjgScFC6oH3MUnP2
 IioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396575; x=1691001375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbEjOnkySITmLw82s9WCGkUqlGYptTamWi06s3l0n7s=;
 b=QvnVUSSrxH5WZh0ZAj3hd76IRSUuJ901H+NqXLI/h22kIFfoUNmDIC+Ny/Gtd1HVQK
 PvWUXw1gJ9xeMJHaE9CEaZudju9+ax56nFI08M2QRc0KpJd+6MdMunlt9rv3cmJkIr+f
 hE03229H5gjxbactu3a/SI3sQ8YdkbzaT44vSeUH4bR7dH/uhppRJN+DC15i6ahXPzz+
 SssaQpf7p/Kki3KHbrxDj9rUCKMAAFgTE0JrJjpauoSZUuq8pPzk8MUwK/7PenpO6OSL
 9Y6dblykE8FmEeSCE4MR8oUG4gd2TnFS4D55bvC890OF42VgeLs+iN8rGM7RPX8qvR/d
 sXXQ==
X-Gm-Message-State: ABy/qLa1Y0OfkVDNhp7u8hfYJOai63993RyWTemVJJOvx8kKZKVw3E3I
 DequTTU26QSk7txvabVC8QY=
X-Google-Smtp-Source: APBJJlF5/fDOPSw+Q1LCBloGJicZ0hEasezVw9N/HnVZQl1W2EG9jOIxWwa1HeHzc6WwR4FZMG8oPQ==
X-Received: by 2002:a17:903:489:b0:1bb:961e:dfbc with SMTP id
 jj9-20020a170903048900b001bb961edfbcmr2503911plb.20.1690396575474; 
 Wed, 26 Jul 2023 11:36:15 -0700 (PDT)
Received: from wheely.local0.net ([118.102.104.45])
 by smtp.gmail.com with ESMTPSA id
 e13-20020a17090301cd00b001b83dc8649dsm13485670plh.250.2023.07.26.11.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jul 2023 11:36:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 7/7] tests/avocado: ppc64 reverse debugging tests for pseries
 and powernv
Date: Thu, 27 Jul 2023 04:35:32 +1000
Message-Id: <20230726183532.434380-8-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230726183532.434380-1-npiggin@gmail.com>
References: <20230726183532.434380-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
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

These machines run reverse-debugging well enough to pass basic tests.
Wire them up.

Cc: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/reverse_debugging.py | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tests/avocado/reverse_debugging.py b/tests/avocado/reverse_debugging.py
index 7d1a478df1..fc47874eda 100644
--- a/tests/avocado/reverse_debugging.py
+++ b/tests/avocado/reverse_debugging.py
@@ -233,3 +233,32 @@ def test_aarch64_virt(self):
 
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
+        # SLOF branches back to its entry point, which causes this test
+        # to take the 'hit a breakpoint again' path. That's not a problem,
+        # just slightly different than the other machines.
+        self.endian_is_le = False
+        self.reverse_debugging()
+
+    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
+    def test_ppc64_powernv(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv
+        """
+        self.endian_is_le = False
+        self.reverse_debugging()
-- 
2.40.1


