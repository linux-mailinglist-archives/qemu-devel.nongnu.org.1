Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76416815FEC
	for <lists+qemu-devel@lfdr.de>; Sun, 17 Dec 2023 15:43:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEsLn-0005eu-Oh; Sun, 17 Dec 2023 09:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLf-0005a2-9V; Sun, 17 Dec 2023 09:42:31 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rEsLc-0003Om-PI; Sun, 17 Dec 2023 09:42:30 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a1db99cd1b2so259350066b.2; 
 Sun, 17 Dec 2023 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702824146; x=1703428946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y238zjYlrP82jW+c2G5tr4kwW6UUjfsDc9YiHIQkqX4=;
 b=QrRomk+XSeTGzL5YopC6V50hGnT5VoKJylO2EcfMl4JH6t3t9qpKQsmbEyzJrAXay2
 8/qYo7oOONxpyE6l11wTES3oZsgyLqeAi4tZQXTL7eTpbZOdYFywxYym6iqISYr163I3
 bQdMlO/+vPF9UJOjvVnmFOfM3AmU1Su7i1kog7D9O1NdcWbSA0cyE6+XuA8MHeDROSxR
 kPdJJA26TaBQ/UiiIzRRY7m0DnFRfCQKdbNhLQ74LX/WP1UkV3AXUvjpeM9t3MfrAP2K
 q6meegWXntDIXNoglfC9NmCOJa83HRaoqS18oa7Iknt3qAEkdvu2y8XF6QVljmSYgNul
 9D2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702824146; x=1703428946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y238zjYlrP82jW+c2G5tr4kwW6UUjfsDc9YiHIQkqX4=;
 b=ivZIaiKQKS5AOcAtKdcZRJb55EspJL4AipY9Y8CFieuk6botyHL8N03oCBwTKzOkJh
 TjgLtTHPW/sQjQKiGhMJBauEF+kiozBnzU/X6XwhSAgCIVmL/T5LDofxFeafgQdqEw9B
 BaXL4UCdX9EcDzbY5f6ymJFGFtTjEAOb6STiFB7T4F294JMbAUfuX2xEa/w6iOMrEZmA
 R4nHqA/eCljetxo2Kt6TvtJkwPQ2Z4VbiRw1n16g/uTLYcoDpb7l2GnLMX15KXlnFfz3
 5e9xYs4p+4lZOGvj+fyuLlBvuGjKkz0ckue0QXhFDlak9ss1AfVOod7+VxaWgFNxYrFr
 PS0A==
X-Gm-Message-State: AOJu0Yx1zVpf6r08HokoDNX/s/2sQXQHIu0VGkZnI2u0KyELEZuQj0Ma
 OgnWFf2WBFaMcgFldOncyFoB0KJvJiY=
X-Google-Smtp-Source: AGHT+IGS8NfRztj1XiNyVyITkWCmYD7E15gy070cTHxTV80KwjnY7tuXD40O9VXYUaXX6oARZJVcaA==
X-Received: by 2002:a17:906:7108:b0:a23:3ba6:f1ee with SMTP id
 x8-20020a170906710800b00a233ba6f1eemr357419ejj.139.1702824146314; 
 Sun, 17 Dec 2023 06:42:26 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-162-117.77.11.pool.telefonica.de.
 [77.11.162.117]) by smtp.gmail.com with ESMTPSA id
 vv6-20020a170907a68600b00a1dff479037sm12996632ejc.127.2023.12.17.06.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 06:42:25 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Thomas Huth <huth@tuxfamily.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 qemu-ppc@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 11/12] exec/ioport: Add portio_list_set_enabled()
Date: Sun, 17 Dec 2023 15:41:47 +0100
Message-ID: <20231217144148.15511-12-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217144148.15511-1-shentey@gmail.com>
References: <20231217144148.15511-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
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


