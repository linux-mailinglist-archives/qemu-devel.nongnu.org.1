Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EA64B14D4B
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Jul 2025 13:59:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugiy8-0003Lj-Mr; Tue, 29 Jul 2025 07:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugiy6-0003Cl-ET
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:06 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugixy-0006Dw-GN
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:58:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-455b002833bso20952195e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790275; x=1754395075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BpijfTk5ey8lbtSr1qjZ36lDbCV/5lAhHeBTCJwFvjc=;
 b=INPen6fkuRDtVXBE/VyR6IbzzNyb4E3uui/a4euhSqo3SDrhX76O9RmCLbGrtgfThG
 N+g1zcDGA5DvouDCOPDcmTViZ+ISTj70tgDbPcgivFxOnCMf12cYfgG6pUmW9uVlr/4b
 zJIVXvz6RunV2pPT0PPjzgZ6CPKV/wpPIu4RWm0XjUQUI0o2CalOnGpSMhhL8zkQyuCD
 PBVCvs7vDTv5zARbx5yP2doVIn+2ULtnx5IAsAX5m+xCCfKZHwKAosIcFfqQppt2rINM
 sPaylKyqtCvkkz1OAZ3UKJ9lFkmci1Bfz9IinuEwI5ePBXORGtemG83I0mmM/V2qnjnT
 DnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790275; x=1754395075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BpijfTk5ey8lbtSr1qjZ36lDbCV/5lAhHeBTCJwFvjc=;
 b=vUptEXroCRqNC33HWS4+vdCtOi93ghUuOmCi7LvIO+q803AbRLGcwO685mF/obTtSy
 xsdFnIQ6GLsjWNsVzKzRsShpI1YFs8B0AgrR9+3gf3WeuFjQyXHrAm7pEvgmDcPV0XA9
 R82aqdLeOm/vc4a/zYe7RH8FVEG/lcgu3BGnHwlbg5Z9O4GcjcVeW+iu+Jy6YY0XyB7q
 YvZO67xitCE2SxLEqA8s89UWgrn1pbyDCc0t0u0GIRJwsN5YG9s8/PYmZ02030a9fnf5
 +BH+eobI7lsESr3fYYIEcN+Y61urjyXi+HDr7y/RQpMqw0IX/mYLn2X51JS8KnYGdVwl
 5kGg==
X-Gm-Message-State: AOJu0YyeEKuQ19gFdDjMO7ZsuS9WsV4SrMTZBsmf3NaUpc0g8dr4W4Vz
 bjo3WcUELGUsXjOjeoAC+FTvizoY//WSnVf3WALe+h6O1R7+3cf/SujpWYVkWnKEcgj+fCyWqta
 xlVz6
X-Gm-Gg: ASbGnctTb/QhO4q+fMVatsqaMOCftT92tvG4BRstlJblVosJqlURjAdPdyOWG5BIoaM
 8obTsJqf8M4JTUw/MbVeBHWKU0CUY1VyyA4kmH/PT0arPix7QcJtrrkyi4FvtZB1+wAqiYrWdlq
 d4RbKD5rOP5RGj96+pU8s6rkHetzDYzIk7UyyiOajmEoiQ7GoZuBubkJ+krAsHTlCrt6ZIqbsLl
 ZCMGaOj4rDMOe+VK8T51hvgES2YveQBz08YLG2hE/0v5rvDtFElz0mGrGH0bzPM4bgUMgcsThRC
 ivVzRkIYfCVZmAT3Ao4Eh22yqVY70vIzn5arzCgj7EdQGHfWsi+TQEdGPVL4V/J6+Q+Jpo+ti7i
 LVuYoBy1xjK64FG0pkF/Mrvrh9NBuw2synGUh33izxvoKR0gsK3bGOhmsP5ArbpPZP3s2NAzU
X-Google-Smtp-Source: AGHT+IGo2b9BijLrwmPTeoGevbU0PgrlM/bbdRCieWVnBQ0qoZSk74t97htyig6evKPznenY30TpXQ==
X-Received: by 2002:a05:600c:3f0b:b0:442:e9eb:cba2 with SMTP id
 5b1f17b1804b1-4588b7d28f2mr50826645e9.0.1753790275530; 
 Tue, 29 Jul 2025 04:57:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054f686sm191217305e9.14.2025.07.29.04.57.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Jul 2025 04:57:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/9] migration: rename target.c to vfio.c
Date: Tue, 29 Jul 2025 13:57:29 +0200
Message-ID: <20250729115735.33619-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729115735.33619-1-philmd@linaro.org>
References: <20250729115735.33619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-ID: <20250725201729.17100-3-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 migration/{target.c => vfio.c} | 2 +-
 migration/meson.build          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename migration/{target.c => vfio.c} (90%)

diff --git a/migration/target.c b/migration/vfio.c
similarity index 90%
rename from migration/target.c
rename to migration/vfio.c
index 12fd399f0c5..0b64e49ef06 100644
--- a/migration/target.c
+++ b/migration/vfio.c
@@ -1,5 +1,5 @@
 /*
- * QEMU live migration - functions that need to be compiled target-specific
+ * QEMU live migration - VFIO
  *
  * This work is licensed under the terms of the GNU GPL, version 2
  * or (at your option) any later version.
diff --git a/migration/meson.build b/migration/meson.build
index 9aa48b290e2..276da3be5a3 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -51,4 +51,4 @@ system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
                 if_true: files('ram.c',
-                               'target.c'))
+                               'vfio.c'))
-- 
2.49.0


