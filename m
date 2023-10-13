Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 704F27C8111
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:57:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqA-0007vm-9a; Fri, 13 Oct 2023 04:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpd-0007U1-Vs
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:42 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpc-0000p6-CQ
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:41 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-317c3ac7339so1722859f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186858; x=1697791658; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOsZ7ZL5JHN7RjGpQtBamH1YbH9vqmibRGYngEIRT7E=;
 b=VWs1JSSYh9LaCRO1uVUBNTWmOZ1SFnYYBMNmb1VPHZSPlhduU+u7F1LwawvgCHaCNN
 e/G0BNqYBVk4BnRF2jvFFrShveTz8v/Qi4/y+J4KR0aj0mGfWe6J4N6fw5CouiIYosdJ
 kTV5p0g3QxdTiBrwE6xqD4e6Q7ldrrYS3FV9UnnXkQhqLN+qGEowe54ExfGUjgM1eiAH
 omSUXaEpukHQuLlQY6rHEX04B+nYlFND30QjR+M2AcUzP6JYptT7588A03qSaDV1S8z3
 BKNxZCFpdbEapR877CPAwDHmvVUPF/Noq53jbMzuXH2H6/s5LG4F7x3Igh422gOSPxFx
 U2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186858; x=1697791658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xOsZ7ZL5JHN7RjGpQtBamH1YbH9vqmibRGYngEIRT7E=;
 b=RRuNLVvivLc61bZb+MrnQuOj23D0220js8zKyClQj2eeP3PoUt4dxLf9L4j+CzIyd+
 cU2yAqOdOSr5Y4rOP2jWm/WeiqtR9CIZNHEXq6UmsPe+ac4B8Im91fqh4R7sWI9uIkWt
 lXVj5Uk9qJIyV6FXxVXBVBDdtxeopm3rgJVx24kgpMw3MUWHsDNIbeju6PslAIPOSOoL
 p0rb8uS9Y7cKWBoTL0f97qh3blkvBVJIT14NRO4RFzIVSRGezO1y1gcSX0Fi+J/5N+2W
 C8IjESCwaBOEJ5RJvndGaQzIKmljWvSqlBQnrz5D42BrFy9bXyH0Z73d2Dy0c57G1G8T
 zMdA==
X-Gm-Message-State: AOJu0YwMeJUBGTfNZ6SdKOfKN38cWf/lgboXjDLfSfb13k3e0NXgEV7L
 z5/KE6jMdHgpcbH5YDyq63L5IeKUWdK8QI5OwcE=
X-Google-Smtp-Source: AGHT+IFFL3NY4YZswvt/m5VRYI/aPvbqOUkl4serfp4Hhxg0imaCnB1cL0W3YBrnuaw0eWFXgWZyqw==
X-Received: by 2002:a05:6000:1b07:b0:321:6450:62ea with SMTP id
 f7-20020a0560001b0700b00321645062eamr22529243wrz.36.1697186858497; 
 Fri, 13 Oct 2023 01:47:38 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:37 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [RFC PATCH v3 14/78] util/error-report.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:42 +0300
Message-Id: <95c579123764d0825d692db97b3bcc7d09443322.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42d.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 util/error-report.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/error-report.c b/util/error-report.c
index 6e44a55732..acb66420de 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -369,7 +369,7 @@ static void qemu_log_func(const gchar *log_domain,
           (log_domain == NULL || !strstr(qemu_glog_domains, log_domain))) {
             break;
         }
-        /* Fall through */
+        fallthrough;
     case G_LOG_LEVEL_MESSAGE:
         info_report("%s%s%s",
                     log_domain ?: "", log_domain ? ": " : "", message);
-- 
2.39.2


