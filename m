Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52238787B60
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 00:18:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZIc3-00083j-SD; Thu, 24 Aug 2023 18:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbn-0007p1-Lg
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:28 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qZIbl-0006En-0t
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 18:15:19 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-1cca0a1b3c7so210921fac.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 15:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692915315; x=1693520115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pO3wz5fop7wDys5r1Ax7UI+xFmY6OiD4k73j8kol0RM=;
 b=N2fczt3dhPAEILgdP6fgrKOTfx626sOGK1B0GLWJD8ZiL1KEdGHChN84k3akxC30Yh
 8Rf8sSn/AIItk+K0ZKgKhC07DU3QxpmZCu4RKck9mcMIVCsuojZAeSVHAcLQThJKr3s7
 57UjJvE0wQ/UGLGx9JUtLRTGzMSMDxorxz1aHYl0ZMr6smdZf2Y3/AQaTUIP4hGRqcu3
 SQm3NMrclsUDnTR4B7BUOY1zGVYVVPlKmRH/9LepyGPksxMlYZGsf1bKDp6oQIi1uVF6
 HlGo0Z0mpboA7SETEOkZr4MaoiSa6EyRzfe8f2CDsDk7zq+o0XvVbmY7zDEsp4j2UJCv
 KjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692915315; x=1693520115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pO3wz5fop7wDys5r1Ax7UI+xFmY6OiD4k73j8kol0RM=;
 b=OE5mDztuk0+SM9g1e1wqA0ccojRUmOHSZ7rdEvgfgIqMwfhNdzcOkvNLU6waG0WM5M
 5ZzupxP2g71wT0TnMkgP3UFaLBrgUZHBReTVorN/6ihTqm5fbPl/FI34Wf40mMAkhP4H
 s1nut/tZaoc1uSgPTw6SU7tOq58wemwB2VTHcdizGgly4d1E6WRYnyNeGKDEUQB0WmPS
 e05bsQaS749QKKJtHWS9J83EfBW5Ptq+oCAEw3lt+ayS4reIYR1laJagBa0XWspNR+oU
 Vo3VgBoyNjSsW2JEeitXQtm0tE8dpl5TmMmsDH2WUiqwCEXmQ7RXOpA9Ue2Iu/pLBYn5
 YBQg==
X-Gm-Message-State: AOJu0YwsQozShB/bhfPEHB9AtCQEFjXAIoHlLVWh07Z9ppj7AY8KrNRa
 Kq2wOh3YqXMsEJQFSjVM7IjDj+Bk6ebjIb5S5x0=
X-Google-Smtp-Source: AGHT+IGPSR20a6p7ErqCKnR6/dUQUXU/h1cnToeTkQkQCLl5n+haZEr+Bme0FS04v5F/nuDx7MxY1Q==
X-Received: by 2002:a05:6870:808a:b0:1be:d49b:a3c5 with SMTP id
 q10-20020a056870808a00b001bed49ba3c5mr1085055oab.29.1692915315527; 
 Thu, 24 Aug 2023 15:15:15 -0700 (PDT)
Received: from grind.. ([179.93.21.19]) by smtp.gmail.com with ESMTPSA id
 o129-20020a4a4487000000b00565fcfabab8sm256338ooa.21.2023.08.24.15.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 15:15:15 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH RESEND v8 11/20] avocado,
 risc-v: add opensbi tests for 'max' CPU
Date: Thu, 24 Aug 2023 19:14:31 -0300
Message-ID: <20230824221440.484675-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824221440.484675-1-dbarboza@ventanamicro.com>
References: <20230824221440.484675-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add smoke tests to ensure that we'll not break the 'max' CPU type when
adding new ratified extensions to be enabled.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 tests/avocado/riscv_opensbi.py | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tests/avocado/riscv_opensbi.py b/tests/avocado/riscv_opensbi.py
index bfff9cc3c3..15fd57fe51 100644
--- a/tests/avocado/riscv_opensbi.py
+++ b/tests/avocado/riscv_opensbi.py
@@ -61,3 +61,19 @@ def test_riscv64_virt(self):
         :avocado: tags=machine:virt
         """
         self.boot_opensbi()
+
+    def test_riscv32_virt_maxcpu(self):
+        """
+        :avocado: tags=arch:riscv32
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        """
+        self.boot_opensbi()
+
+    def test_riscv64_virt_maxcpu(self):
+        """
+        :avocado: tags=arch:riscv64
+        :avocado: tags=machine:virt
+        :avocado: tags=cpu:max
+        """
+        self.boot_opensbi()
-- 
2.41.0


