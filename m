Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2BE825706
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 16:48:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLmPw-000581-AG; Fri, 05 Jan 2024 10:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmOm-000204-QK
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:46:25 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLmOj-0003qM-D4
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 10:46:16 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d4f5d902dso16146425e9.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 07:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704469572; x=1705074372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaWEpr5f/U/wZNl7ClicoZnkchpUab2rsBaBsce3JqA=;
 b=ILKT0InOW9Wh0TE9nnBj+WiviH/WaLZ2lala2LTM3Aovv0TCxl0Pbwsc9kFU21n0b9
 1DerARmCTs0ZNtAjGFfFlADSzSrWqBtdT6c9OexpGORqpgTGKiQNneNccpIuTSkvuVZB
 KblNMxRPeXNDg8ICd5uQ0ErMktTa9w/pq+f3jAKVX9Lm6tqPTV8f5bFBW0wf9himunrL
 ykMetXUvmr1a3RXbLacRdY3kjsrVVVT3RWv61tAUS4HoEu+kGsd6HSiup7Df9XZOy+8D
 CBcAwY2UHg1DBoGyKfZi4IIGiL+7BQuOmcT36oKycCdiqNVOKEpVv4U2tglj2CqkVMAT
 ED9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704469572; x=1705074372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TaWEpr5f/U/wZNl7ClicoZnkchpUab2rsBaBsce3JqA=;
 b=bjk89RuKEXhwB+Asie2e5wH9KzpAd9ED+4PEC0w/osYf9lxtxdNTVxJpTrKp6KweNt
 F8ZtvE8yesQ6Pt+OY7vjPg7GP8hOiIjqrroPhYJwwxsgDctLCKL4taF2YkN9KvA9S7L3
 ApgbkSso9tynJuWEUn2sKgjxhpm2+fJ/OuqaWAzdSSy0ze4XRi2T0ayN/ATnhJDCyafV
 WNGnamsWRvzuIKsQrCjbl9cYGPP1RXjhhcuzyZYlMwjfxWFJrPWM92zv3Og4WU+cBfYZ
 rPc0wjyGDp9pyUleTuLcydHyxxpWzz+5YoKR8atPsoca6blgabjgHOI/pwjbcXP7QZaz
 dFmA==
X-Gm-Message-State: AOJu0YxfiFnYXOQBrpcEja0AWM3sDd+ic8AdyIUWlU3tOBoaUN6DQSGx
 zDVzR3SbgPi4XE7wtLwyJ3xFxuDh+2ZLXuU8m+KKg0O7mBw=
X-Google-Smtp-Source: AGHT+IHchGDzGZUXyaUKE7Ua7noUpkAg1Gg/cGtAMRVa5jV2c1mKHycg+NpR9CLOzU4msVwipqj0dQ==
X-Received: by 2002:a05:600c:138e:b0:40d:9485:cc89 with SMTP id
 u14-20020a05600c138e00b0040d9485cc89mr1204952wmf.74.1704469571776; 
 Fri, 05 Jan 2024 07:46:11 -0800 (PST)
Received: from m1x-phil.lan (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 k9-20020a05600c1c8900b0040e3a1f88f2sm1376690wms.15.2024.01.05.07.46.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jan 2024 07:46:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Gavin Shan <gshan@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 27/71] machine: Print CPU model name instead of CPU type
Date: Fri,  5 Jan 2024 16:42:20 +0100
Message-ID: <20240105154307.21385-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240105154307.21385-1-philmd@linaro.org>
References: <20240105154307.21385-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Gavin Shan <gshan@redhat.com>

The names of supported CPU models instead of CPU types should be
printed when the user specified CPU type isn't supported, to be
consistent with the output from '-cpu ?'.

Correct the error messages to print CPU model names instead of CPU
type names.

Signed-off-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231204004726.483558-5-gshan@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index c523ce32eb..fc239101f9 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1421,15 +1421,19 @@ static bool is_cpu_type_supported(const MachineState *machine, Error **errp)
 
         /* The user specified CPU type isn't valid */
         if (!mc->valid_cpu_types[i]) {
-            error_setg(errp, "Invalid CPU type: %s", machine->cpu_type);
+            g_autofree char *requested = cpu_model_from_type(machine->cpu_type);
+            error_setg(errp, "Invalid CPU model: %s", requested);
             if (!mc->valid_cpu_types[1]) {
-                error_append_hint(errp, "The only valid type is: %s\n",
-                                  mc->valid_cpu_types[0]);
+                g_autofree char *model = cpu_model_from_type(
+                                                 mc->valid_cpu_types[0]);
+                error_append_hint(errp, "The only valid type is: %s\n", model);
             } else {
-                error_append_hint(errp, "The valid types are: ");
+                error_append_hint(errp, "The valid models are: ");
                 for (i = 0; mc->valid_cpu_types[i]; i++) {
+                    g_autofree char *model = cpu_model_from_type(
+                                                 mc->valid_cpu_types[i]);
                     error_append_hint(errp, "%s%s",
-                                      mc->valid_cpu_types[i],
+                                      model,
                                       mc->valid_cpu_types[i + 1] ? ", " : "");
                 }
                 error_append_hint(errp, "\n");
-- 
2.41.0


