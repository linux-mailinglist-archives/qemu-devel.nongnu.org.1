Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD507A0F1F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:44:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgtAo-0003HB-DH; Thu, 14 Sep 2023 16:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAe-0003Bs-Kk
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:40 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgtAd-0006KN-4l
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:42:40 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40413ccdd4cso7535585e9.0
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694724156; x=1695328956; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tWanWC67jhmn9FXRwvcRc23eY0xLvKm6663P3+ePW3g=;
 b=FNqw5/ZtT4aFN3BMvqUh9PbSD7pzpq/sy0oyQ/1loh3uSBI0WY6XS26nhgGABG4BUn
 lXzcZNI/TYootDyvsVq48ktJbryJemzzwjjbsIf/6xH+S60yzX4JEQeH526dcqqvzr/P
 ucYKywwIAOjmAZQj/fgHyYKs1sx6MaUske5CwKonHCequgTpqdPKG47OQIV/ldfovkzn
 Zg03Y/ovMZ2BZ/vis17c7/5PpNSS5+enADHTe5woVYWHlz4HGx6ZmhOwsFPr0IToMwbZ
 Kt7niGPKqblN5mns4uhyyDFFEQyjm7YbZRNjBez6sYxUjsw4z6/v6cNSmJB2u77/ZM1g
 oX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694724156; x=1695328956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tWanWC67jhmn9FXRwvcRc23eY0xLvKm6663P3+ePW3g=;
 b=cxZXI+N53J3qhmWhjEayBKLQK6m/xTCNU1O355KIn1YQYo+zTIgaYAPI0lUBCqsYae
 nRI6t6fCU2MP17MrInqb5SXZLQ+/JJxKVCbsEG5Ub9oyjOfyBYOh4rHGg/18xnt0DTUE
 9Fu2RgIyWyvfQgRQf8olFpMlUK3qAXJ8ImGBN9eaGIELsrlhZ9eFHrsJU2oCs2m+9pR+
 ZRbczFPps+5NvVb0iV+WIdkS5zZKsBTcloZulevbKtKAVgQ7pXl0UScabCNKYYL8DIsz
 TLgZ2OmRZlueeJU4Jq82YcnKK5EJEoodk6s0DqeyUczDvvtk5Zcxy5R1XQIX8h2/yLcn
 7llw==
X-Gm-Message-State: AOJu0YxGxGKdcnCtEMCdM4KGcgubV0ZA0FkDCq3K4P8g1ykUI3MQAte0
 wsC6b6DeLqCSqr6wpO0gRr0jypt3DOE=
X-Google-Smtp-Source: AGHT+IGT+WdJtUHy1xxf3raWiXrULDlhBZQQ2fwAkBnMDQDgRYNZ2HgcnQ61XwEH7DVfRhwS9jyEcg==
X-Received: by 2002:a5d:4d48:0:b0:317:59a6:6f68 with SMTP id
 a8-20020a5d4d48000000b0031759a66f68mr2424982wru.0.1694724156662; 
 Thu, 14 Sep 2023 13:42:36 -0700 (PDT)
Received: from karim.my.domain ([197.39.44.105])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a056000124300b0031f34a395e7sm2661880wrx.45.2023.09.14.13.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 13:42:36 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, imp@bsdimp.com,
 Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH v5 07/23] bsd-user: Add bsd-mem.c to meson.build
Date: Thu, 14 Sep 2023 23:40:51 +0300
Message-ID: <20230914204107.23778-8-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.c   | 0
 bsd-user/meson.build | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 bsd-user/bsd-mem.c

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index 5243122fc5..6ee68fdfe7 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-mem.c',
   'bsdload.c',
   'elfload.c',
   'main.c',
-- 
2.42.0


