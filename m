Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561570F988
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pxk-0006J8-UJ; Wed, 24 May 2023 10:59:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxa-0006G6-1H
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:30 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxS-0006GV-O5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:24 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30a95ec7744so942380f8f.3
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940354; x=1687532354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/NFMmQbEi4QeLl7La/O/5nvyHdFAh48mXBKmtpD+Yyc=;
 b=YI1szJ4vjL0nLMYmSZAFXKFGmys/qnEFB6DRj6D1iCpxTgkjlqbtmUmtLMTfE1gvuH
 21eOV6wiKwBnGxJ6D9yxQvIiAUxCYbCwQkVIEJRwEpqfOk54ul6JjRyi43iIYQ8c4QjC
 j0S5dsse6AuVqaNFnnqloNv/OezbqhUGRlmeH+o4Vgb+m099AaoomaBVFb6OsTx5gWWc
 Cyz44YiWOiaFp8ptPukuiGGvgVzJepGPgesRz0CUycpa9kH1zboPKjhyTKBpQMFTHIGB
 O9DJvisqqZIt4os8Cy2pH2s+AjI7/yv5QBydd2Md45xsfQU5DRRPXo+vDQRkun29Gb4+
 Xh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940354; x=1687532354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/NFMmQbEi4QeLl7La/O/5nvyHdFAh48mXBKmtpD+Yyc=;
 b=D9JLF1f+kHOHO4dc4w/Ld+9cwLrSBnZgyp8e0yxxuosTaJ0q4MbLPgvrXrwk/rtyze
 1EHT9Ly2Qu1HATYWkZSfPrPpb8LCyWgRSCV2PaqE6ykEZq52ll1plVQipD0W3pqqEK7c
 sqXXK72fVbzvQSW9B/KYw/uuLqm0EoVoxDog8NzuvKzaZqD2wfsHNoCg9OUZs6yQ6Oyd
 pqd4/GG12MZflqRXAr5601PKRlUqHkH/flNkolPrnN8yUmEy+2vxeWc6Z3MGlf0WYWVS
 Q9QKAw6AjN5x4ZotUhXIh8znYvggQ0OfsblDB/nBGlxbpSHcugKY4YxgTuslKx+2O5Dl
 9vjw==
X-Gm-Message-State: AC+VfDyXRYyLSfoZ2uoKdiREWVosZRpIfOWa+ANM9rEg7T/K2OSnIIOs
 +JnXAJlo1JHmWqzMkA09cRs0Fb6K5Q3kD09k+x1cQQ==
X-Google-Smtp-Source: ACHHUZ6wih8bui6RfkdIg1Pjc2BZCakqA+T4Tl+yp0d0iaiSrnAtCWn01y9+Pgxn0+Q4ZrGIrpaKZQ==
X-Received: by 2002:a5d:5505:0:b0:301:8551:446a with SMTP id
 b5-20020a5d5505000000b003018551446amr105802wrv.2.1684940354651; 
 Wed, 24 May 2023 07:59:14 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 s5-20020a1cf205000000b003f180d5b145sm2576037wmc.40.2023.05.24.07.59.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:59:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 01/10] hw/arm/realview: Simplify using 'break' statement
Date: Wed, 24 May 2023 16:58:57 +0200
Message-Id: <20230524145906.33156-2-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230524145906.33156-1-philmd@linaro.org>
References: <20230524145906.33156-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

The 'break' statement terminates the execution of the nearest
enclosing 'for' statement in which it appears.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/realview.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index a5aa2f046a..a52ff35084 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -88,7 +88,6 @@ static void realview_init(MachineState *machine,
     I2CBus *i2c;
     int n;
     unsigned int smp_cpus = machine->smp.cpus;
-    int done_nic = 0;
     qemu_irq cpu_irq[4];
     int is_mpcore = 0;
     int is_pb = 0;
@@ -294,14 +293,13 @@ static void realview_init(MachineState *machine,
     for(n = 0; n < nb_nics; n++) {
         nd = &nd_table[n];
 
-        if (!done_nic && (!nd->model ||
-                    strcmp(nd->model, is_pb ? "lan9118" : "smc91c111") == 0)) {
+        if (!nd->model || strcmp(nd->model, is_pb ? "lan9118" : "smc91c111") == 0) {
             if (is_pb) {
                 lan9118_init(nd, 0x4e000000, pic[28]);
             } else {
                 smc91c111_init(nd, 0x4e000000, pic[28]);
             }
-            done_nic = 1;
+            break;
         } else {
             if (pci_bus) {
                 pci_nic_init_nofail(nd, pci_bus, "rtl8139", NULL);
-- 
2.38.1


