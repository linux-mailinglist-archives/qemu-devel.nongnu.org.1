Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F78B817A1A
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 19:52:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFIid-0006Fe-5D; Mon, 18 Dec 2023 13:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiV-00069s-4s; Mon, 18 Dec 2023 13:51:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rFIiP-0008Pz-00; Mon, 18 Dec 2023 13:51:47 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40c6e2a47f6so35948535e9.0; 
 Mon, 18 Dec 2023 10:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702925498; x=1703530298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y238zjYlrP82jW+c2G5tr4kwW6UUjfsDc9YiHIQkqX4=;
 b=LiSNDQI8quzkubhgsunbWL02iF+r/Kd7ioCsxCNY2OFsggeTbjVeejBZQZx8VGyGpJ
 3SI1vnN40eaD83+sQORVplmvz/SV0GZNhjAIVnZ6OQXa3soDS1NB2GtMNaqy2Nze7hwz
 AK9F1QysTaSZVEgU0czVMAeLD5d/agSe1SObISgF5eWGjD18hWPeGRLJ7Drg+a5F2vQw
 TNDU4dh+fF9tjZVGJEWKkA7Lf/92OHvGrn6p1MzXEQkjChMPqPhfrhEHk5Bg+zChbsBe
 pbNXZAsV4XvNF7vH2IjAwTWUuSGeNrQJj3JEo4nQb2fkJj1wSfzNHriLAN8SHnEfMJQ/
 O9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702925498; x=1703530298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y238zjYlrP82jW+c2G5tr4kwW6UUjfsDc9YiHIQkqX4=;
 b=au2FuXUE4pgiBi7qVwYuWu+SALiRes82dOxi9lAdIDYvWpC67kN0OXiTHu1T6kq8DW
 H0Ik0dnm8Srcz6XELpKkvsFz5jSGZx/GQowTz6U2KE1KejGu+DQFgJ6cvUyRLfLQQNSd
 5WXr8ECK/H2hOhd80YElAhuSuZyvV8gle9c5MROxYCDQQ7bgxneLYXjN8TeUrSwCDVX6
 8H4KU3Kjv3iMW/PLEUk5vjH4uXhIrKKeuVpDaTcvVCWFyCNOKphkpz8xMDryeaJiKa4D
 DdhAtAIrKfsboAlQXs4SAfIPh2Pr0wiPUlla2QIqftwAHqzYwkH3NKDSD3ITHJUkTIq3
 uiRw==
X-Gm-Message-State: AOJu0Ywei7oHio8Q+dKjcUE/GDJez91VUU8pMdyeHicv9nvwDZGUf4eV
 R/WycmOX/OV4EEJN9dx6bxA6lYPHYbI=
X-Google-Smtp-Source: AGHT+IFwyt7ufTs/Oo+4mIFjJPSvAw1QBKAWdd5T5Z3PvLnegr+XbXuZdvZxnBc6i/NvZhW3Wos5Bw==
X-Received: by 2002:a05:600c:444e:b0:40c:3d90:4a00 with SMTP id
 v14-20020a05600c444e00b0040c3d904a00mr4378865wmn.57.1702925498640; 
 Mon, 18 Dec 2023 10:51:38 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-092-224-039-156.92.224.pool.telefonica.de. [92.224.39.156])
 by smtp.gmail.com with ESMTPSA id
 s7-20020a05600c45c700b0040c45071c18sm35134091wmo.39.2023.12.18.10.51.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 10:51:37 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v2 07/12] exec/ioport: Add portio_list_set_enabled()
Date: Mon, 18 Dec 2023 19:51:09 +0100
Message-ID: <20231218185114.119736-8-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218185114.119736-1-shentey@gmail.com>
References: <20231218185114.119736-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Some SuperI/O devices such as the VIA south bridges or the PC87312 controller
allow to enable or disable their SuperI/O functions. Add a convenience function
for implementing this in the VIA south bridges.

The naming of the functions is inspired by its memory_region_set_enabled()
pendant.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 docs/devel/migration.rst | 1 +
 include/exec/ioport.h    | 1 +
 system/ioport.c          | 9 +++++++++
 3 files changed, 11 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 389fa24bde..466be609a2 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -465,6 +465,7 @@ Examples of such memory API functions are:
   - memory_region_set_address()
   - memory_region_set_alias_offset()
   - portio_list_set_address()
+  - portio_list_set_enabled()
 
 Iterative device migration
 --------------------------
diff --git a/include/exec/ioport.h b/include/exec/ioport.h
index 96858e5ac3..4397f12f93 100644
--- a/include/exec/ioport.h
+++ b/include/exec/ioport.h
@@ -71,6 +71,7 @@ void portio_list_add(PortioList *piolist,
                      struct MemoryRegion *address_space,
                      uint32_t addr);
 void portio_list_del(PortioList *piolist);
+void portio_list_set_enabled(PortioList *piolist, bool enabled);
 void portio_list_set_address(PortioList *piolist, uint32_t addr);
 
 #endif /* IOPORT_H */
diff --git a/system/ioport.c b/system/ioport.c
index 000e0ee1af..fd551d0375 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -324,6 +324,15 @@ void portio_list_del(PortioList *piolist)
     }
 }
 
+void portio_list_set_enabled(PortioList *piolist, bool enabled)
+{
+    unsigned i;
+
+    for (i = 0; i < piolist->nr; ++i) {
+        memory_region_set_enabled(piolist->regions[i], enabled);
+    }
+}
+
 void portio_list_set_address(PortioList *piolist, uint32_t addr)
 {
     MemoryRegionPortioList *mrpio;
-- 
2.43.0


