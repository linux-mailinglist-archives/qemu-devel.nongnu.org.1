Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBAF77D3FA
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 22:17:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW0T8-0001iB-Cp; Tue, 15 Aug 2023 16:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0T6-0001h2-4H
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:44 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qW0T3-00057g-W4
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 16:16:43 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-56d0f4180bbso4303628eaf.1
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1692130600; x=1692735400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pO3wz5fop7wDys5r1Ax7UI+xFmY6OiD4k73j8kol0RM=;
 b=Qk8qEsQ7Oap0rO4/dmESf+FGyxAX/N6Ptw++P+t3NuGCNCs14OCMKMe/o58KUn2h5v
 DoWDn91woZ5kqyJnIi64dvGgYhYUIqQyOhiyWp2SgBnVWxsHiyzJWO4KN6erdcY9E8Fo
 yrnnFUOvNNzGaDw62pAeKEHXGHlP7cFDy9ZK5olAifl8LEB8RAq/J/XI/Zslom8BGu7+
 6rVqmKLxc3il87ZCzXdGw/TPOzzhlbW+tm49tao9UcxLv8grXDsGrF2ubHKdkJ3nv1EN
 7G+rM2PVIdpD+0f8H3YYZcdGvV6vyfDk6Z1Y4n7bXJY/obaCQly1wKY0yjoSR02ThL+o
 Xo9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692130600; x=1692735400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pO3wz5fop7wDys5r1Ax7UI+xFmY6OiD4k73j8kol0RM=;
 b=NHFwydP/b4OL8iAfwMkZVVljs5VqQNavu2rkmGMNFylIPNHccbFjqqpZHTDuIObWbr
 mJ2s1ccePXykSsx29mR04lELxKhh7cV3Olfgo0PS+ws/hVdpSp9QEucQWPXDtezXtGdH
 KCR6/kRUv/VAjbyVaReHPaSS/Z5U7P3M9XmOPCwRCtcSWyF/tvEe8wSNGZRm1brlByQh
 R2scLPGD5+vyuztftlJMi6zl75JJerkTQkhTsCNcRZIic7cH/to+NMgZwyn4jR3s7mBp
 IkSorP3CeHcEUv5F2wuFHxeUcBscfGJ6bbjH/NYPVnlPN0O75lnkevnc/1XC+mHMS5fX
 gCxQ==
X-Gm-Message-State: AOJu0Yw/yB0ycevTOjgFcA5N9K8Ql9xpvamZvXsAP9R8ggArNnT1nKKA
 P8HNP1H3r5505j1s3xBNisFkkmbhyCp/r8EmXBc=
X-Google-Smtp-Source: AGHT+IHAxYdFaeFyjR9KpuIaRf+PuBmvtTQn/JwH/ddlTGp4HqQf2TWRTgnF1Ah1n9eIWxZuK5ePQg==
X-Received: by 2002:a05:6870:3102:b0:1bf:d8a:b5bf with SMTP id
 v2-20020a056870310200b001bf0d8ab5bfmr16341109oaa.36.1692130599168; 
 Tue, 15 Aug 2023 13:16:39 -0700 (PDT)
Received: from grind.. (189-69-160-189.dial-up.telesp.net.br. [189.69.160.189])
 by smtp.gmail.com with ESMTPSA id
 o14-20020a056870e80e00b001bb5b2a958csm6658203oan.23.2023.08.15.13.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 13:16:38 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH v7 11/12] avocado, risc-v: add opensbi tests for 'max' CPU
Date: Tue, 15 Aug 2023 17:15:58 -0300
Message-ID: <20230815201559.398643-12-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230815201559.398643-1-dbarboza@ventanamicro.com>
References: <20230815201559.398643-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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


