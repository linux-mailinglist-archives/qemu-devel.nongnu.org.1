Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 443747CBB08
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:23:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdK3-0008PA-Az; Tue, 17 Oct 2023 02:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK1-0008Ng-81
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdJz-0003pT-O4
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:52 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c9b1e3a809so33952235ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523170; x=1698127970; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jct63rFb48sV+5hvOO6V2h6GbxQHLHhpSIfreHhtJXo=;
 b=sYxnQ3Swtie9lwFepnhRwSJapnKVcN1tM/GtQFMVuxxt7Cvb/x4/8+TBtzMCMUvDGV
 Omr6EAeAQsu1VV8NMD+b+J9eI2Z0M9pqou/wvbnbsA1nRArd8D7wLcT19FMyUjBgnpm8
 QD6fUeBDeqyEU15qH7eNsIX1Gzbia1yekZyKG9RGYIyrBX8buvdyQNPzTjRm8DRFCjRX
 XrQSX58yXv8k9/JPojHIht6F/F7ycCokUyHrR3bqaseq5e6g1bXrSfMNyzcRu92zHg/o
 FO8qh+oItG9CRy4g8ucTIptUfmXKHhOh0RLNrJVk5D49hOsN1iseNBO0ZwfTsCLKyCa4
 Xbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523170; x=1698127970;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jct63rFb48sV+5hvOO6V2h6GbxQHLHhpSIfreHhtJXo=;
 b=vwEwet4774Hd6Xyn1XTTUNJbOOaU5mjGs+CfTHQmdlrAx1uZK0VVHK/mkZHkl3aF2D
 v1NIaYYHqKb7jSVI4jB9vxXfxyP84/AYe/YuppTlXTEHWKmSnIzXfqwnkmK1lGtaW+nK
 CCCTqSd2fSeabqxEUlDoF6jeYhsk1wEDx8ucwv9coLH5ZmuHJIOy5CXvR6c6hvpDSb2/
 ZphxwIvvHojWRUR5qkayBxbi9MMAVKicDS3UzxWNmRoLucvZPMIP7DzOX5JDWBMlvHIJ
 Bzkzdk5Rd31nV3ZfuEJxVwrzOLtjbUAz7uhI4xZHlgF/Tvk2Dw5LXqKuN0udCTslXSY+
 g3fg==
X-Gm-Message-State: AOJu0YxwHlAfqCapxc1MzlYf59YuVGxO0MZy9CKwO6eEpU/ykEMDbTKj
 LuvR7tCOTHqXBlWa87q6woSIJv6sSUindrH/UNk=
X-Google-Smtp-Source: AGHT+IFrvrjyK9QZSSwmRb2HFfR9AsWzPvrpfcdG6ZO6JbyDBecZRKDDkHgyiHJG3nQ67s9Aex2q5A==
X-Received: by 2002:a17:903:138f:b0:1ca:18b3:3599 with SMTP id
 jx15-20020a170903138f00b001ca18b33599mr1124305plb.68.1697523169971; 
 Mon, 16 Oct 2023 23:12:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2 05/90] configs: Enable MTTCG for sparc, sparc64
Date: Mon, 16 Oct 2023 23:11:19 -0700
Message-Id: <20231017061244.681584-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

This will be of small comfort to sparc64, because both
sun4u and sun4v board models force max_cpus = 1.
But it does enable actual smp for sparc32 sun4m.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 configs/targets/sparc-softmmu.mak   | 1 +
 configs/targets/sparc64-softmmu.mak | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/sparc-softmmu.mak b/configs/targets/sparc-softmmu.mak
index 454eb35499..a5d9200382 100644
--- a/configs/targets/sparc-softmmu.mak
+++ b/configs/targets/sparc-softmmu.mak
@@ -1,2 +1,3 @@
 TARGET_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
diff --git a/configs/targets/sparc64-softmmu.mak b/configs/targets/sparc64-softmmu.mak
index d3f8a3b710..36ca64ec41 100644
--- a/configs/targets/sparc64-softmmu.mak
+++ b/configs/targets/sparc64-softmmu.mak
@@ -1,3 +1,4 @@
 TARGET_ARCH=sparc64
 TARGET_BASE_ARCH=sparc
 TARGET_BIG_ENDIAN=y
+TARGET_SUPPORTS_MTTCG=y
-- 
2.34.1


