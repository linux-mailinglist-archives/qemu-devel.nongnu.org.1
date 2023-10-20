Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1217D14A9
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 19:16:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtt5z-00016s-KT; Fri, 20 Oct 2023 13:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtt5w-00016F-UH
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:15:32 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qtt5v-0004YW-BT
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 13:15:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-32ddfb38c02so770131f8f.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697822129; x=1698426929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86FXsRfIWc3qxKloJ/dq3J9FNZepHuMpnW+a6InquQ8=;
 b=VHnFdgn6lROJNcOiLuCyNbyoLZ/73pu7GmxS/uzXZynNg+2bmDY0dtePQMT1V8b48F
 dSLRfMdFkGczI2gSQvjVuu3mls2yLSEhkRhpE4K4xJNS6LX5eRE/e9YD86USZgBJQzM3
 WxlQhhEdEekfX7AG5BaiIBC8xc4K9zAP7w8z/2PNiX4xB1Re6rCJCMvSw10seuxZydpE
 pRmfLmcbUPtsBKbJFA8UFCao5/ML5/hC1u2f1++JZJ8bdnLJtIHm1yazP0Kce1pad/vK
 3Pc3YovQiOTxlYBKATpzZI40vosfP5ggCtZiaX0w6dSiLSf6z6cThjG9ik3NvVZ1t2YN
 CrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697822129; x=1698426929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86FXsRfIWc3qxKloJ/dq3J9FNZepHuMpnW+a6InquQ8=;
 b=JnELNKwRvzhzKLRRyFR+H1NUxZVAQMbeIyfBUlN2j+Ab2vpjP1fJUxL+UUUgGSd4wF
 PZu8UoHoa/07j9hRN+PJ6mBLcIM2pJH++dOJpdAaPUBYvNO21AGDkdWTRNE/fYI95AlF
 KNYkTxJYJubLpRDhwTSGqWKUdRBQ/z7Zo7xmFIgrt9zXeAap4XvQsz1fj9vG1SsbT31a
 z64yOgpAV3piR+PI7M9FgPKqXWEb3eMvVYm2KSS1MFwskRuFFQTPpjnbSkRVxt/JPE2+
 bPWP1AeYt+aihI2xyRsgTPgKFf0NBTAdxIkSHiZptLyYW0OGageWOJdeODV7SobGJcWI
 BvZw==
X-Gm-Message-State: AOJu0YzdP8Bcge7CWvmGrOVKg2RnrmY6/3AmNPXiWOEnSa140Aj9cwPW
 e7o4E76acjSW7P8jlNUT7ADCXn7PZkMDiNc+bDg=
X-Google-Smtp-Source: AGHT+IGaSc1mZr6D4n2ute7W1OeRkEzPdNyNQjTEXTQnQaSL9Z0FDc5G6QkC5rEfa4xOhZJnJQPh3g==
X-Received: by 2002:a05:6000:1244:b0:32d:a409:84c8 with SMTP id
 j4-20020a056000124400b0032da40984c8mr1842604wrx.67.1697822129434; 
 Fri, 20 Oct 2023 10:15:29 -0700 (PDT)
Received: from m1x-phil.lan (tbo33-h01-176-171-212-97.dsl.sta.abo.bbox.fr.
 [176.171.212.97]) by smtp.gmail.com with ESMTPSA id
 x18-20020a5d60d2000000b003248a490e3asm2076532wrt.39.2023.10.20.10.15.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Oct 2023 10:15:29 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 3/4] hw/i386/pc: Propagate error if PC_SPEAKER device
 creation failed
Date: Fri, 20 Oct 2023 19:15:07 +0200
Message-ID: <20231020171509.87839-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020171509.87839-1-philmd@linaro.org>
References: <20231020171509.87839-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

In commit 40f8214fcd ("hw/audio/pcspk: Inline pcspk_init()")
we neglected to give a change to the caller to handle failed
device creation cleanly. Here this can not happen because
pc_basic_device_init() uses &error_fatal. Anyhow, do the
proper error reporting to avoid bad code example spreading.

Reported-by: Bernhard Beschow <shentey@gmail.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 6750ed427a..3937d88355 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1288,7 +1288,9 @@ bool pc_basic_device_init(struct PCMachineState *pcms,
         }
         object_property_set_link(OBJECT(pcms->pcspk), "pit",
                                  OBJECT(pit), &error_fatal);
-        isa_realize_and_unref(pcms->pcspk, isa_bus, &error_fatal);
+        if (!isa_realize_and_unref(pcms->pcspk, isa_bus, errp)) {
+            return false;
+        }
     }
 
     /* Super I/O */
-- 
2.41.0


