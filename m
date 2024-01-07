Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E58826536
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:03:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWXf-0001Z4-QC; Sun, 07 Jan 2024 12:02:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWXc-0001Ty-9a; Sun, 07 Jan 2024 12:02:28 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWXa-0007Zh-Km; Sun, 07 Jan 2024 12:02:28 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d3ea5cc137so9399415ad.0; 
 Sun, 07 Jan 2024 09:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704646944; x=1705251744; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R4QwoejbFxocsaZb3oiG49cglGKrIuMcCW89VqSauWQ=;
 b=Q1AyRAHh2DQn/mx89hQYplg2ogYLRdsHHxUuynaC6KDl+/GA9ANL9GfLQJN5A3Z2J7
 JVTqUK2rRA7AM6wO4Mfx9lqzjZBaH8sk9KFnqQn2QN2qZ62zTCWsrf4pBLXnHpkL91Zj
 pmu2JnejyLwkpCuSRsxtJXlrGMbKuQDad+DHZAUaJbiVlMCj3gtM2t2lKQcytRDpoF2I
 J6h7b3lES+4XdCQ24tee1JScnIiDcf/W4ScXEvYIXneruBdGXQ7+zat+S3SM8bSIY4pn
 qp32j4Pl/ybs+NEV9aAFaldLboMTXBKfhYvc1nXEECMzGjQWT+PuyJGlFgKw/QqIckbP
 TxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704646944; x=1705251744;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R4QwoejbFxocsaZb3oiG49cglGKrIuMcCW89VqSauWQ=;
 b=na6pi1xjNyNKw0/CwtpYvFgSSNKAZ4AdRcVba8iEpJvI8tmQp8EB6zufrbX+3rxgaf
 EzQEQ8iymucRYpl4FmpponDF2K2mkMV0hVdtsAzUV5eG8bXrz51hV/aditHRoDDXJuQc
 R446pZELEpdQbKypUQyGrtoM19QNvcDTzY/ide76Q5UBKkwFBvSAJnNl0NhrbJ8yeHxj
 9GJwLoSFCHb7MUbjcsqz7qlU3pge7xwOZGR5mtZum6U8ancgZChQM0sMuOdJOwDgu76q
 LGqLnbkW2SQVhddYjT/rwhCMhm8UremQtPhFuGI6YpHcr9+XNr1XhA62YNi7U8ggro1B
 /Zbg==
X-Gm-Message-State: AOJu0Yy4B3PObYooAUsQNcg89ltYP3O+IVL4Y7KwuuUBTY88K6gwEnm+
 fOYdTGJJElD91tFQBJfXf/CFvSFl40Q=
X-Google-Smtp-Source: AGHT+IEm99aQrYCXbLMNyK/X3LZ9oL4b8eBNRSUjQPiysbkRPZoiYOuApRbftWhzlGqWtx3VNWvz0g==
X-Received: by 2002:a17:902:7483:b0:1d3:eade:bdda with SMTP id
 h3-20020a170902748300b001d3eadebddamr3111178pll.77.1704646943890; 
 Sun, 07 Jan 2024 09:02:23 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a170902c1c900b001d3ea8ad878sm4632883plc.290.2024.01.07.09.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:02:14 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH 5/9] tests/avocado: ppc add powernv10 boot_linux_console test
Date: Mon,  8 Jan 2024 03:01:15 +1000
Message-ID: <20240107170119.82222-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240107170119.82222-1-npiggin@gmail.com>
References: <20240107170119.82222-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

Add test for POWER10.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/boot_linux_console.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_linux_console.py
index 3f0180e1f8..4f05bb7441 100644
--- a/tests/avocado/boot_linux_console.py
+++ b/tests/avocado/boot_linux_console.py
@@ -1386,6 +1386,14 @@ def test_ppc_powernv9(self):
         """
         self.do_test_ppc64_powernv('P9')
 
+    def test_ppc_powernv10(self):
+        """
+        :avocado: tags=arch:ppc64
+        :avocado: tags=machine:powernv10
+        :avocado: tags=accel:tcg
+        """
+        self.do_test_ppc64_powernv('P10')
+
     def test_ppc_g3beige(self):
         """
         :avocado: tags=arch:ppc
-- 
2.42.0


