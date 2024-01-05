Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7593825717
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:50:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmPc-0004Ie-Qe; Fri, 05 Jan 2024 10:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmOa-0001iK-Op
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:46:06 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmOU-0003n6-VQ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:46:02 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3367601a301so1315070f8f.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469555; x=1705074355; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbnewdzJw2WIotOB6UCheBhSeiFExHVz6pISXRX/KZs=;
 b=wWWcE4ZMz7jSyR8BERdVhQ5fdM5Uw0UJqJBGbybWADWqeHA/6Zm+NazIwCBvMKycrW
 jncj9/hpBZXlwyUFGSMy6Riz8Jlr+8I4QRNcBVY/fl1ayHL7O3BJwICGD/nMI7a5pOTV
 TKZUKgXS+nQOLv/KJYSeartncYUbmHpGjR2XXh3B8szDogVIK9k331Kbnpnm/Cya54HM
 D1tt9Lj8FKpEot1W9qouSfpYd3sKQ8oczIo2gxP42tjRz3qGiSsUXgAyFzRDJ8rd5zIW
 c32mAF3NyJGvxzgGXul4gxoMf3RT0LACVzMYeqWbD66cAiMttpncleQDzstsCyXOazHe
 4cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469555; x=1705074355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RbnewdzJw2WIotOB6UCheBhSeiFExHVz6pISXRX/KZs=;
 b=xD0zJoG20bH/U8tA1sI84aCvCkIc4UIFvToW7lcItR1QigqHodkiZ1fXxlkCdBWSE5
 cjs3hsTlVJivElOw+/A1+IdLjDIHSCT3QLoUzgA7z9WxqpM4zuVklY+b4CXdXj5oGZg1
 wMWEY6b3bo6ti88vjS6yXRw5MbFRzW31tzpd0Gtfk5Z4PkxQDKniQtyJXgl/o55jaWKM
 XeLshw3hXUvGEWnylr3B2+mYyAqJZnaRut1S7UwaO7iM54eegR/nHPMh+zLaPlKTm1KY
 HmwAmV/Xi486V4g5LH3Ng01VYfmBVZpTGbPBR+Hic11fHqFNCat7rBL26KXAj4yD8qPl
 FHUg==
X-Gm-Message-State: AOJu0YxHvUxoDbnGg8JtbPfO5ZEFu91UE3u1F57nSXgo3fe0RF9hsV35
 uJIrL7K9v645q1zyWtOyk01LK4it3e+VYLebaOIu0kYzxrw=
X-Google-Smtp-Source: AGHT+IHg+0OT3KRSSE5x1DHXNTZTW9W0UuTexnJBd7wkFGmaURJNKZhXNVpCc2y41EKLDdnS3IPcDg==
X-Received: by 2002:a5d:650c:0:b0:337:5280:a14 with SMTP id
 x12-20020a5d650c000000b0033752800a14mr856805wru.170.1704469555497; 
 Fri, 05 Jan 2024 07:45:55 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 x17-20020a5d6511000000b0033743c2d17dsm1609158wru.28.2024.01.05.07.45.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:45:55 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 24/71] machine: Use error handling when CPU type is checked
Date: Fri,  5 Jan 2024 16:42:17 +0100
Message-ID: <20240105154307.21385-25-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

From: Gavin Shan <gshan@redhat.com>

Functions that use an Error **errp parameter to return errors should
not also report them to the user, because reporting is the caller's
job. The principle is violated by machine_run_board_init() because
it calls error_report(), error_printf(), and exit(1) when the machine
doesn't support the requested CPU type.

Clean this up by using error_setg() and error_append_hint() instead.
No functional change, as the only caller passes &error_fatal.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20231204004726.483558-2-gshan@redhat.com>
[PMD: Correct error_append_hint() argument]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0198b54b39..1898d1d1d7 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1477,15 +1477,16 @@ void machine_run_board_init(MachineState *machine, const char *mem_path, Error *
 
         if (!machine_class->valid_cpu_types[i]) {
             /* The user specified CPU is not valid */
-            error_report("Invalid CPU type: %s", machine->cpu_type);
-            error_printf("The valid types are: %s",
-                         machine_class->valid_cpu_types[0]);
+            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
+            error_append_hint(errp, "The valid types are: %s",
+                              machine_class->valid_cpu_types[0]);
             for (i = 1; machine_class->valid_cpu_types[i]; i++) {
-                error_printf(", %s", machine_class->valid_cpu_types[i]);
+                error_append_hint(errp, ", %s",
+                                  machine_class->valid_cpu_types[i]);
             }
-            error_printf("\n");
 
-            exit(1);
+            error_append_hint(errp, "\n");
+            return;
         }
     }
 
-- 
2.41.0


