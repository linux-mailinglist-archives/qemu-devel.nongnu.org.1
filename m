Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D08275867C
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 23:06:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLrrI-0002WH-Ph; Tue, 18 Jul 2023 17:03:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrD-0002Ui-QC
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:43 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1qLrrC-0007C9-An
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 17:03:43 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6b9ed0831bcso286833a34.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1689714220; x=1692306220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ITC06tAv8it+14eRfCM87hviKOvSRNQ+9QY2tURFyk=;
 b=AbY1Ah4wPL2i6KzkKnHi4ksJeVDaGfRurmTh/2aJYHOthdBCvjGd5BfDtD2znsLePq
 7nzEuz7okze2/sng2jnAQYzRadVGLcgXOR0tgsPO+f9TeMFmQMsKEluVCvJ6TS/lrtAu
 A86HyLhbmHxXlzuzymI0UYJvdJlKuGoAZ1u4Hq7Tcmfk9FFYhBdfbUksFgAFzq2Y8SNI
 WIBsTz4CrrQK47R9LZwoeGFUd6QVq17rr9rPtqKfNTNIzSbTZ4VbZCGPxOMXmR+UOto2
 ufTWqDlGBeETPterMBopMy7ZFeZ2dQZaHv+ysT+mkpMP1quRwdclnb1rHqm2/iZz8y0o
 3iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689714220; x=1692306220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9ITC06tAv8it+14eRfCM87hviKOvSRNQ+9QY2tURFyk=;
 b=SAXP4yFjeTXcqDjG2gBkb3yC26eVhUqQPZFQPrsIYIm4149/8U2LBdSw0pqoKL8qXW
 VkqdDletRFxJ6/nJ3E143DYepChtTbCnjVfCTQD6lUC6h0BM7XBO5feKSkbuiSZYiDh9
 p1bVRQqdGcRZbhc6Y6/VzSG36xA2U2jAjg14SusBTfMZl//wLytWrKL+CaFImgKOh5yl
 pWfyYDXiO4P6A/hpOJ0GXnd7zrcaWg5ctGBpDOZOsiswTCGScXM/ldvK9W8MfTODhk+0
 wovIvtXnhLLs59/E2fahIrifLw+TN7av34NQPKJ6m6BpHiQdsgjP5BnztWzjTtZAWPK+
 VPCw==
X-Gm-Message-State: ABy/qLapkmFWuJJF/Ain/hoGF811U0LzGTSe6vqVck9kXVGXZoBGwWse
 Av2fhI0qNewXNiD18TocuiTF3hkKskAP1mojnrCdVw==
X-Google-Smtp-Source: APBJJlFa3t1EGtvJEsq//7DZ9g1nxGzGmHow8LxmX2yDyi0Fl3vJv4BxVc8DHHEz/m4fyXPcxuExwQ==
X-Received: by 2002:a9d:67c2:0:b0:6b9:c869:862c with SMTP id
 c2-20020a9d67c2000000b006b9c869862cmr705953otn.1.1689714220664; 
 Tue, 18 Jul 2023 14:03:40 -0700 (PDT)
Received: from grind.. (201-69-66-211.dial-up.telesp.net.br. [201.69.66.211])
 by smtp.gmail.com with ESMTPSA id
 v2-20020a056830140200b006b96384ba1csm1160657otp.77.2023.07.18.14.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 14:03:40 -0700 (PDT)
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liweiwei@iscas.ac.cn, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PATCH for-8.2 v4 02/11] target/riscv/cpu.c: skip 'bool' check when
 filtering KVM props
Date: Tue, 18 Jul 2023 18:03:20 -0300
Message-ID: <20230718210329.200404-3-dbarboza@ventanamicro.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718210329.200404-1-dbarboza@ventanamicro.com>
References: <20230718210329.200404-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

After the introduction of riscv_cpu_options[] all properties in
riscv_cpu_extensions[] are booleans. This check is now obsolete.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 587a5a9548..29f2543f6d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1905,17 +1905,11 @@ static void riscv_cpu_add_user_properties(Object *obj)
              * Set the default to disabled for every extension
              * unknown to KVM and error out if the user attempts
              * to enable any of them.
-             *
-             * We're giving a pass for non-bool properties since they're
-             * not related to the availability of extensions and can be
-             * safely ignored as is.
              */
-            if (prop->info == &qdev_prop_bool) {
-                object_property_add(obj, prop->name, "bool",
-                                    NULL, cpu_set_cfg_unavailable,
-                                    NULL, (void *)prop->name);
-                continue;
-            }
+            object_property_add(obj, prop->name, "bool",
+                                NULL, cpu_set_cfg_unavailable,
+                                NULL, (void *)prop->name);
+            continue;
         }
 #endif
         qdev_property_add_static(dev, prop);
-- 
2.41.0


