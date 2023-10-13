Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FFC7C8F49
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 23:36:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrPiI-0006AN-Oq; Fri, 13 Oct 2023 17:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiH-00069q-FL
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:53 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qrPiG-0000P6-0V
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 17:28:53 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6b87c1edfd5so275969b3a.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 14:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697232530; x=1697837330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jct63rFb48sV+5hvOO6V2h6GbxQHLHhpSIfreHhtJXo=;
 b=P6GG0pbWPP3nstMPsdHdwF/FuFySmk5EbWayGZ4SYcJvwkII6ruxSKGKDAFcADIt/O
 bREzFoZNYcYX76wOgn4k++TGetZel0yyQH2yLje8GW9HW/aBk6oEO7ukT2odCqBXntO3
 XU20oayqefPx7VssqSTI3nX98irPbf1C5Z/oVNLhXQrJhmfTAbO4a2Cx0KkToJuzdE/8
 oy313sdUgc0XP0qU4kCxMktLfrgvPO61MoijFHx6SLhnhIaE7Hyf/1EX6ycwM/p1isnI
 Qy29vHm+luQvuPrF8KPul5cRld8QT9IZbDYQncb6WSc0YrJQf4NPocCND/tDwwVEIzn+
 nIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697232530; x=1697837330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jct63rFb48sV+5hvOO6V2h6GbxQHLHhpSIfreHhtJXo=;
 b=VopbPqAMd/wbAUESRK2U6dXg4Hm4GhFzUM3p95/HDncDJ52rKc6rzQWHdtYjzx5cZw
 bFkYDM9ig4bWT7wxAoJeeL9DnLAYbqq8JYJ0e1oBkxrkq3SMq32PpaSzs8PImftR0q29
 1Ft3krWsss07ycOXJbTL2t1rMKRstGsJSO+14GNiUjxYOq71CcrOEkc2rzrc5s+8egEE
 SsVsZlsSFLjnsgt1ILSjKGO5EQgyIchJ8b4WttVijBbWHRz8UgMOk6yJyQacwAaPREMW
 ewSMIsJqJQu0mWIkBsJVOVWuId2ISToVo6trXddIvGW8ic+k4sQq107PCETOXBfaztt5
 3flg==
X-Gm-Message-State: AOJu0YzOXQnuGUh78D6T11wNkmnvSbV6aVcreSAQWxgCs4S+D6Bl75FF
 Af0FMBseTaKRhaHl+dDqLkoZBpaQYdoWei69ykI=
X-Google-Smtp-Source: AGHT+IHh3NvU2pbGy2wTAk+g9Ks/cBZ+8cP52QWgqTrLAH8LWdrHTM4ZnT/wA+JRLtMEuXrmaLcE/A==
X-Received: by 2002:a05:6a00:855:b0:6b4:c21c:8b56 with SMTP id
 q21-20020a056a00085500b006b4c21c8b56mr2194216pfk.23.1697232530076; 
 Fri, 13 Oct 2023 14:28:50 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 b185-20020a6334c2000000b0058988954686sm70753pga.90.2023.10.13.14.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 14:28:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	atar4qemu@gmail.com
Subject: [PATCH 02/85] configs: Enable MTTCG for sparc, sparc64
Date: Fri, 13 Oct 2023 14:27:23 -0700
Message-Id: <20231013212846.165724-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013212846.165724-1-richard.henderson@linaro.org>
References: <20231013212846.165724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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


