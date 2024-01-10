Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 721BD82A347
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 22:28:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNg6I-0001iT-AE; Wed, 10 Jan 2024 16:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3lwufZQcKCl4GKIHK9ECKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--komlodi.bounces.google.com>)
 id 1rNg68-0001iA-45
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:26:52 -0500
Received: from mail-pj1-x104a.google.com ([2607:f8b0:4864:20::104a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3lwufZQcKCl4GKIHK9ECKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--komlodi.bounces.google.com>)
 id 1rNg66-00010d-Mg
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 16:26:51 -0500
Received: by mail-pj1-x104a.google.com with SMTP id
 98e67ed59e1d1-28d29d2dd7dso2143020a91.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 13:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704922008; x=1705526808; darn=nongnu.org;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=UujjEtCL3f3hHEN5AYDAZysO92z8l1BhG6bS0cwEohQ=;
 b=BVvXvWfCiOgzOL6A8FywwyWBf4d3JVZioaMiMTN5ktt1RYbmdz2rU4obIAsdvLZDdU
 jOu4HagX7pUeOT/kRQqz1+KOL5Gk5RcJNJvx3wjsoZS+OjLviu4IMfSh2lFgB7HdC3mG
 91zaRVEQNdj98zadzUx43Y0JN9DblsxzzmxImnv4WsDPARYDNqrccFIt5BiNaZ9gGE+L
 ZIbrPzaqHDniMYdXzFfFStSS74pV25kT2J66wGPd5IDqKrAXCk4lh6E2H8YvbYKwe9Vj
 aoIn1aeQYP+nK3UFUsVr/QBrOu1RzXxJtudc5+Fe8bGWAT5uOeZOP2MFvRgnCBtjTGUC
 5qRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704922008; x=1705526808;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UujjEtCL3f3hHEN5AYDAZysO92z8l1BhG6bS0cwEohQ=;
 b=OQsHzIjiy6TqY7Z1QGh88imk+2ICedoRIkkynZtNfvfIesZQO2U3Zq7smtlyskhpx7
 k4uG0suJ287z+/uhuGOF61xQChm3DDWvLzz7xex+2KFS0PMkztKGSpt6Sr2DUJ7CVFFX
 c4TdWCiKNwqYYWqnoKcF7bnXWcUnQwFdsZ4bNTjLrXAkRa2W/6fP6/yaayO8IrIImjx1
 qmGS2Z4P3hQgBmX9H/8QPuFm8RYSX85eJoJjatcL4oe+pGpch5TY2QORs/VOZl3Nf3+a
 x3PH1QsZTdeL/uZKl6y9FCwEoJ/59BHdVW0EVBNXN/Cz7Q0BnL8sTkVTJfLDe2wnYO5t
 zkLg==
X-Gm-Message-State: AOJu0YzCDa916OKqVaEn+QW7nva29sizY54PjcUypNB80nE3YB9ZMhYd
 J99ZtVBPPzxnyZhnLfG/7vhJLx8zfrpEH9iP9LzfSSsqpIxC/QfLqFwlaMf5dSWAjLCbLYsVOIu
 duKhm8BkemrHndy5M8UbQ5YmZBAExY1kk6PVBDgTp+FDnbumNPX2uqK3mnq8JRsiP8IKQAg==
X-Google-Smtp-Source: AGHT+IE5kcic6ArKbCMUC9GZQUx/LxgJzY4NPM7k6bA8jhG4XO+hHj9txx/6bLwAhndpgXxoXJ/j09qt7Vfa
X-Received: from komlodi.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:35ee])
 (user=komlodi job=sendgmr) by 2002:a17:90b:3d4e:b0:28d:c240:4253 with SMTP id
 qn14-20020a17090b3d4e00b0028dc2404253mr679pjb.1.1704922007746; Wed, 10 Jan
 2024 13:26:47 -0800 (PST)
Date: Wed, 10 Jan 2024 21:26:39 +0000
In-Reply-To: <20240110212641.1916202-1-komlodi@google.com>
Mime-Version: 1.0
References: <20240110212641.1916202-1-komlodi@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240110212641.1916202-3-komlodi@google.com>
Subject: [PATCH 2/4] hw/i2c/smbus_slave: Add object path on error prints
From: Joe Komlodi <komlodi@google.com>
To: qemu-devel@nongnu.org
Cc: venture@google.com, komlodi@google.com, cminyard@google.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::104a;
 envelope-from=3lwufZQcKCl4GKIHK9ECKKCHA.8KIMAIQ-9ARAHJKJCJQ.KNC@flex--komlodi.bounces.google.com;
 helo=mail-pj1-x104a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

The current logging doesn't tell us which specific smbus device is an
error state.

Signed-off-by: Joe Komlodi <komlodi@google.com>
---
 hw/i2c/smbus_slave.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/i2c/smbus_slave.c b/hw/i2c/smbus_slave.c
index 1300c9ec72..e24a1ef472 100644
--- a/hw/i2c/smbus_slave.c
+++ b/hw/i2c/smbus_slave.c
@@ -25,11 +25,15 @@
 #define DPRINTF(fmt, ...) \
 do { printf("smbus(%02x): " fmt , dev->i2c.address, ## __VA_ARGS__); } while (0)
 #define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__); exit(1);} while (0)
+do { fprintf(stderr, "%s: smbus: error: " fmt , \
+             object_get_canonical_path(OBJECT(dev)), ## __VA_ARGS__); \
+             exit(1); } while (0)
 #else
 #define DPRINTF(fmt, ...) do {} while(0)
 #define BADF(fmt, ...) \
-do { fprintf(stderr, "smbus: error: " fmt , ## __VA_ARGS__);} while (0)
+do { fprintf(stderr, "%s: smbus: error: " fmt , \
+             object_get_canonical_path(OBJECT(dev)), ## __VA_ARGS__); \
+             } while (0)
 #endif
 
 enum {
-- 
2.43.0.472.g3155946c3a-goog


