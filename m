Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F65728380
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 17:17:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7HNS-0000eb-JO; Thu, 08 Jun 2023 11:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HNP-0000dY-5c; Thu, 08 Jun 2023 11:16:39 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nks.gnu@gmail.com>)
 id 1q7HNN-0000NQ-Iv; Thu, 08 Jun 2023 11:16:38 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-4f62d93f38aso914609e87.0; 
 Thu, 08 Jun 2023 08:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686237395; x=1688829395;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oDG7RjBZajFtmztg2t6ujOfJaID2PqNFQAeyD3CFi+s=;
 b=VN45Mbl+09C6uDd+TgnHl2XOUstp4tDuEdT9cq6m64nzsEq7a50YTU24lcIwZ4yqJ2
 wE6WfVm3+G5GaCLJvIqgTjYNF0L/vtmh/+1iD54ShnECE8THehv2QOG1fV8M+truoWQ+
 lmIHf6JsYFIikxYybSXNI0cTgOwc7/7fMt5zGHdtjgwGs6rSHWfpOnOtoxCwOknvvlg3
 EeQ7klg6s+k4fvHkrgORPD8nH8vRgelosGZbeAX6E+zxZmlZrzfsQp8XRSSdG/9JoJxq
 YXah3nA7ZHXHLExXGzS3x8onPHmYWlAAC/MVFYr9/RhoL1LKjt643RhvVIn8nnB4mcQl
 aACQ==
X-Gm-Message-State: AC+VfDwvi4w5QqZkUHxhBe3J6cX8ed70Bx9RN4tX0vGZsf+POjZAcxgC
 NRVHTy+9CcnwJGRPjy9x19Qv8Wl9lTmaMiEwT5k=
X-Google-Smtp-Source: ACHHUZ7hicpFW4RVv6srD37eBYyKrWYAo6Q+fpCAuTElBBeP7WdbH1rFhqT5WZTvwtq7P0j6VBxSIA==
X-Received: by 2002:ac2:43d8:0:b0:4ed:bdac:7a49 with SMTP id
 u24-20020ac243d8000000b004edbdac7a49mr2961802lfl.54.1686237395235; 
 Thu, 08 Jun 2023 08:16:35 -0700 (PDT)
Received: from flawful.org (c-f5f0e255.011-101-6d6c6d3.bbcust.telenor.se.
 [85.226.240.245]) by smtp.gmail.com with ESMTPSA id
 b11-20020ac2562b000000b004f63d35d396sm213003lff.250.2023.06.08.08.16.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 08:16:34 -0700 (PDT)
Received: by flawful.org (Postfix, from userid 112)
 id F375B1474; Thu,  8 Jun 2023 17:16:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237394; bh=qHEpLcC2bs/b4ArbT2xps8PdOQ8V+R2bzrWbKodWxrA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BeLppSoTfqkZUKnWHGUUY00Z/vFNFbiRHUUlM43if2EnjnUr3dVg20wa42qbb7hCX
 nXlJ6SbI69GLOHqYmUKqBkPK5n4TH1Nflfr+SyaW/IVE+fSeOBPTmjwhNCI4RGNrbb
 FIfXH2JXx++M88MZ40LSiWASICmNq2nu2nU1g+AY=
Received: from x1-carbon.wireless.wdc (unknown [129.253.182.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by flawful.org (Postfix) with ESMTPSA id 6203A1403;
 Thu,  8 Jun 2023 17:16:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=flawful.org; s=mail;
 t=1686237366; bh=qHEpLcC2bs/b4ArbT2xps8PdOQ8V+R2bzrWbKodWxrA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SJwEUjpdCzAqPvetreMeTVa2+gkCYtL73ZAFGuj+O/y/8cmYFCtG0KL9kinK3klKT
 0E8qLDLND913MlTpQ3ZyDns8KKKJh9XTlFrqsfS8MwsuZ14GINn8UJ0Ci9unFi79JO
 cMIa3pv2/JAPYMt+SYhh5QGt73q5iFmr8dZ9wou8=
From: Niklas Cassel <nks@flawful.org>
To: John Snow <jsnow@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH 4/5] libqos/ahci: improve ahci_port_check_error()
Date: Thu,  8 Jun 2023 17:15:27 +0200
Message-Id: <20230608151528.143950-5-nks@flawful.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230608151528.143950-1-nks@flawful.org>
References: <20230608151528.143950-1-nks@flawful.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=nks.gnu@gmail.com; helo=mail-lf1-x135.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

From: Niklas Cassel <niklas.cassel@wdc.com>

Improve ahci_port_check_error() to also assert that PxIS.TFES is set when
expecting errors.

Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 tests/qtest/libqos/ahci.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 644ed7e79f..b216f61f14 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -409,13 +409,19 @@ void ahci_port_check_error(AHCIQState *ahci, AHCICommand *cmd)
     uint8_t port = cmd->port;
     uint32_t reg;
 
-    /* The upper 9 bits of the IS register all indicate errors. */
-    reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
-    reg &= ~cmd->interrupts;
-    reg >>= 23;
-    g_assert_cmphex(reg, ==, 0);
+    /* If expecting TF error, ensure that TFES is set. */
+    if (cmd->errors) {
+        reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
+        ASSERT_BIT_SET(reg, AHCI_PX_IS_TFES);
+    } else {
+        /* The upper 9 bits of the IS register all indicate errors. */
+        reg = ahci_px_rreg(ahci, port, AHCI_PX_IS);
+        reg &= ~cmd->interrupts;
+        reg >>= 23;
+        g_assert_cmphex(reg, ==, 0);
+    }
 
-    /* The Sata Error Register should be empty. */
+    /* The Sata Error Register should be empty, even when expecting TF error. */
     reg = ahci_px_rreg(ahci, port, AHCI_PX_SERR);
     g_assert_cmphex(reg, ==, 0);
 
-- 
2.40.1


