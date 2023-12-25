Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB1081E1A1
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 17:43:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHo2N-0006Fp-CP; Mon, 25 Dec 2023 11:42:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rHo2J-0006FS-JO
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 11:42:39 -0500
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minhquangbui99@gmail.com>)
 id 1rHo2I-0001jU-7H
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 11:42:39 -0500
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-593faaa1afbso2488529eaf.0
 for <qemu-devel@nongnu.org>; Mon, 25 Dec 2023 08:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703522556; x=1704127356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xX0pOm2vruiJrlVAX8MbAu8t5DYYdB4AcErZuPkHXbg=;
 b=NeU1CusuhzB8QO6/GgCXiHm2zflf8CQ+3IgCEF/0/KSXunjJ+rL1bJkTasGJaMnwTp
 jJyVHXhqbGOo1gzHXL3qbReoanEIUpYAd8GW937R46GIBvhlbA6zbH6GBlxVFFoi+uGH
 rWS7uAiuhG4chpqLFGL35WcGUO0xQu+/8NvHW5JUP6piDMDkpujZxFvS+5QVnt4QVzBm
 ggbMI2k2inbpeQKtqojBRtUWr/1VfxcOTgHH+fm0SWbxxQcjwOU4+mnipDe7ybOEAyRS
 AD2AZaOr4IHQg15LpvmIVF6JdXl5eNHaDeSi0LuutG23xGLB26U+lmAPurU/YGfCOP1R
 P1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703522556; x=1704127356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xX0pOm2vruiJrlVAX8MbAu8t5DYYdB4AcErZuPkHXbg=;
 b=YHraP4/KBnONp91FFD7VduAfCzPzMNt63yxDy90ka2zI7uaRRhaI8gixJnjL2rXJ6i
 82pjNBA5pqwKdxyePDm2Bxp84T7AaQog8YAfdSo06Dgra9oWd+XgWi5VvSp50nvHzKTA
 DixF/o7Itnl36CgLDNsqQJxSWfpMHissseIWB3YlLIqL9BLzQ+ittv+icWpSZmrKQhf9
 kjLtpYX2maYWyydbTey7UVFAr5rMSpjR6frsPrgwfIs64dR3nsth4La0dYP4SLvqB/Rh
 S3nRK4GQOvXXd7daavAdj6bRw04zPVJ/TUWElESICd+iYmxd88EhRussGE9mYLlEkTX0
 XzGA==
X-Gm-Message-State: AOJu0YwxBjz3yfgQgb82Cfi8omOGi33wpTkUoXp0jNYt4WNIByChu90w
 yYXKUz4SBORlrHR88TmPkn3E3zNmG1t7mg==
X-Google-Smtp-Source: AGHT+IHX3DOhhYABblS7wsfxexSan9Y2DNQFv6ed0eKiqRz+o09951R4A8Io20pyaKn2t5S9fOe7CQ==
X-Received: by 2002:a05:6808:d47:b0:3bb:8197:502 with SMTP id
 w7-20020a0568080d4700b003bb81970502mr7027993oik.49.1703522556560; 
 Mon, 25 Dec 2023 08:42:36 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:50f4:9050:d7ef:8aab:5b58:14b2])
 by smtp.googlemail.com with ESMTPSA id
 x22-20020a63fe56000000b005b92e60cf57sm8092928pgj.56.2023.12.25.08.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Dec 2023 08:42:36 -0800 (PST)
From: Bui Quang Minh <minhquangbui99@gmail.com>
To: qemu-devel@nongnu.org
Cc: David Woodhouse <dwmw2@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Joao Martins <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <lists@philjordan.eu>,
 Santosh Shukla <santosh.shukla@amd.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Subject: [PATCH v11 5/7] test: bios-tables-test: prepare IVRS change in ACPI
 table
Date: Mon, 25 Dec 2023 23:40:59 +0700
Message-Id: <20231225164101.105958-6-minhquangbui99@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231225164101.105958-1-minhquangbui99@gmail.com>
References: <20231225164101.105958-1-minhquangbui99@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=minhquangbui99@gmail.com; helo=mail-oo1-xc29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Following the instructions in bios-tables-test, this lists that IVRS.ivrs
in ACPI table will be changed to add new IVHD type 0x11.

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..ac420db6b7 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/q35/IVRS.ivrs",
-- 
2.25.1


