Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DA7737E0
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 06:22:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTEEN-0001d3-Ej; Tue, 08 Aug 2023 00:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEE5-0001JQ-Q1; Tue, 08 Aug 2023 00:21:47 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qTEE4-0007rq-5s; Tue, 08 Aug 2023 00:21:45 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-56c711a88e8so3477443eaf.2; 
 Mon, 07 Aug 2023 21:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691468502; x=1692073302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Jfr1QqEwPHm/0cW4fOVkjgbOw65i5uezh4p2+HDHZI=;
 b=YsJ3bJbM7+RAQ0J2QtR2MEsk6G1lUdNdwjuXa8m0wHqdKBVar2NCeSIWDX9vcU1glg
 yBo1lp+NAkaxyU0BS99jiWMd+VTSGqr6V39L8NzCdTg95lCB9Fm6kAchLTe3EKDMBRBM
 /JdD2baQfZSVSBnB+yFQYiaVvHY37RstOFWW4QWhooNbCwFvlL536BD4D6RgZaYLHGbf
 cRhBkNMfXeVLtulO6UK96oYPbceUKR/dItC8lmOGTM1q+nfs86NA2NdzXZWYZooNYqe0
 oJWVc359eC8MmgSOcTpgKz02di/apTpJJrWjbKzhQD71oUISRjiPrWWBXR4qiSyl6N1h
 J5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691468502; x=1692073302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Jfr1QqEwPHm/0cW4fOVkjgbOw65i5uezh4p2+HDHZI=;
 b=IDK1nsihzwK5jMt3v+UPhPUGEPpSVghfrkVgF2CDpsut//3QDupS/A1eacrCTedSNR
 6C9fANdFs1aNWRINfTn1bwBigqBUB2Mhdg8+a6BVaBrCrO/gL3T+t6X8baeS+8F6Z7f+
 CnYp25H4YNPiX7xqqTDGM0LhyOT3x6bApmNMrXs+OFO8cnhynQzvc2zqmMZpm86vzzxB
 bSui90MgR+lggc2BKfnWA+gJvlTAV3dDqYx7G0FhXkpMUtTiAjFMrha8D7CfGncMIrZs
 taPeJNKBsm7Ol/2LoD/nW06xgduIyXTzHNpOhBVgkQ5/24fBTBgbzkTZo6qF/lNDY8OG
 JTag==
X-Gm-Message-State: AOJu0YyiY2br0tAhSj5TGXQWkGyVtABaU+JFE2tXWoSddgzyiT9Fi7pc
 O3ekV6yH60YFjyt+s3fsVFE=
X-Google-Smtp-Source: AGHT+IEdsElLzT9blUAn29xmVZSXyFAjFTOKXiv5mT2it5pJrGDbuABbKHq5LAhny10QDfJwIXGbWg==
X-Received: by 2002:a05:6358:9041:b0:135:4003:784a with SMTP id
 f1-20020a056358904100b001354003784amr9497659rwf.19.1691468502168; 
 Mon, 07 Aug 2023 21:21:42 -0700 (PDT)
Received: from wheely.local0.net (61-68-137-140.tpgi.com.au. [61.68.137.140])
 by smtp.gmail.com with ESMTPSA id
 fk10-20020a056a003a8a00b0068718f6a035sm6979207pfb.33.2023.08.07.21.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 21:21:41 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH v2 19/19] tests/avocado: ppc64 reverse debugging tests for
 pseries and powernv
Date: Tue,  8 Aug 2023 14:20:01 +1000
Message-Id: <20230808042001.411094-20-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808042001.411094-1-npiggin@gmail.com>
References: <20230808042001.411094-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
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


