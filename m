Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A35A82D095
	for <lists+qemu-devel@lfdr.de>; Sun, 14 Jan 2024 13:42:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOzmD-0003Ma-6V; Sun, 14 Jan 2024 07:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzmA-0003LL-TL; Sun, 14 Jan 2024 07:39:42 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rOzm9-0001ho-Bj; Sun, 14 Jan 2024 07:39:42 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a28cc85e6b5so934738566b.1; 
 Sun, 14 Jan 2024 04:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705235978; x=1705840778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLhGyFxoalYrWwXJ5TMnYbhPZmyPAPZBcWGnzyg4yTg=;
 b=iuFWxMdOTLrQjcinmgEIqnbwR9d1oG91G9hFt4TYuMSpU2xQvjiU1omhhQOF0NZL48
 P1KNbiBXq80Wd+UIJynLOHx+dKlmxIWC5lyAXRMhM+L2Wbqe9l6Z70J7IVO0BwYCxoyw
 4Fk5no4M5ciUSltH82T7CqulUhZG62Umr1WS4Fd8mPpQQZkJ1THsqzzveKidq42BoSu5
 lps7oHOsvzq6FMNVp9ePOuln7ndUyAOu4ViWnD3uU4OkirsiYTSr+5S7feIynwsPr4tA
 jtrnVyiOxtmT2krgsXBLFKtaElbXe5dF4pzAe5WAblFybFI8mQQBz3/wJc84mAbUDC3O
 Up8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705235978; x=1705840778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLhGyFxoalYrWwXJ5TMnYbhPZmyPAPZBcWGnzyg4yTg=;
 b=AmrU2h0nlxEIa159Dg7mU1Youc057G7eUpaOOhuq5F3tpXkoStkpyvwzHK2++qxOlz
 N0wYONMa1dUE6crY/XRLGyEVzf2O4ahFZwISJIGirxhBMrFt0eJCj5cJ8k2nHNGWASai
 v6v9ESQASslCGfhAgCVmpNHjsuuO7saSEnr2tJm07qtDiQOzSBwrHAZdd4nTiXN86Z9W
 RgDOtpVP3ElUt6OXGzHNiz/vEp9Wa6ZyGqQPIjMWmU6nqRS1q+dUKESsQfMxY6gFWj+m
 du51lk35oDkjlOhVur2MxEw9jt+IR91DXmt1EJDkUrSyani7F36B4zz3Jr/MINjUnaqC
 +htg==
X-Gm-Message-State: AOJu0Ywn3WS1GdgNmeNXgTpp/haAXFEnJN2Y2NgyE/inw71Hs9EXqglt
 aDFSWolfAOWoFb5NkTCfIPAJMxhrR9Q=
X-Google-Smtp-Source: AGHT+IGwrazloDR1nYvPODY8e1lcZ2nn0lj58EZTJpfqhV7VnhKysJIu+HqpMi/ROE4AUO+2VpR78w==
X-Received: by 2002:a17:907:9504:b0:a2c:b993:d0b7 with SMTP id
 ew4-20020a170907950400b00a2cb993d0b7mr1028420ejc.233.1705235978425; 
 Sun, 14 Jan 2024 04:39:38 -0800 (PST)
Received: from archlinux.. (dynamic-077-183-249-018.77.183.pool.telefonica.de.
 [77.183.249.18]) by smtp.gmail.com with ESMTPSA id
 s2-20020a170906354200b00a293c6cc184sm4023734eja.24.2024.01.14.04.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 04:39:37 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Kevin Wolf <kwolf@redhat.com>, David Hildenbrand <david@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 06/11] exec/ioport: Add portio_list_set_enabled()
Date: Sun, 14 Jan 2024 13:39:06 +0100
Message-ID: <20240114123911.4877-7-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114123911.4877-1-shentey@gmail.com>
References: <20240114123911.4877-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x634.google.com
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
index 30b05f0f74..1683fc6026 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -465,6 +465,7 @@ Examples of such API functions are:
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


