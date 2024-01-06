Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D173282619A
	for <lists+qemu-devel@lfdr.de>; Sat,  6 Jan 2024 22:08:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMDrn-0005ei-Mt; Sat, 06 Jan 2024 16:06:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDrl-0005eI-77; Sat, 06 Jan 2024 16:06:01 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rMDri-0001AI-BD; Sat, 06 Jan 2024 16:06:00 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-554fe147ddeso699716a12.3; 
 Sat, 06 Jan 2024 13:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704575155; x=1705179955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yLhGyFxoalYrWwXJ5TMnYbhPZmyPAPZBcWGnzyg4yTg=;
 b=VAvM5leyQE6vhP4jRn0s/a/Z7ewPozeTUBWESN6j5dqp02wtXqDpAT5GEqM6bNoGiG
 d99wWchDxu13Tcq7mNE89D9zMyZ5gtw5FfOe/n22iwzSs22+iQ0mtX2LQa9f4waz3YF0
 JiC4C7ku0LOFZeO1eeVR1yHwu3ifgAT0kocKzAjGQVzVaCS1Nfa0UqjUjqZDhuyv3cAW
 EOsNVosG/rcS9xAX2qKyYMKUBGwMl4Rv6EZLnnxFvMtXQBeRzfRguBc93MEaNvVSAogU
 8ErWW4tE/1YZLbogntgG55dHEdAWHpdynk/l5+69CmwaQ2+kZrskDO14z9OSxQyDdSFr
 wDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704575155; x=1705179955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yLhGyFxoalYrWwXJ5TMnYbhPZmyPAPZBcWGnzyg4yTg=;
 b=LG+lChS91Hjym7D/sZaKVAOLmwyxe+4qOSWH18aYh7WHT9x3ccJmbHXS9Doz0B5KYH
 er6tv14XIVaehrZKJZUY/7fVVPGM19CWj1On8L9tBZBdXgeMpWLrjDMLSpFMZRgubEqO
 3RQVKyBD9jFeiL417IAXarvx+KcLBoD3DAH+Hh6LZly1jc8hPT7ay4qeKp8lsBTAgOiE
 UxY4k3xa1EVfyKBWZFVfZvzx6EABo+qk3+4Tgm2TeJGlJUUxCa9umz0dvAQrPZI47V8r
 4/zZGgqNc9m2MtN1F7U9+Fl8DZxTp9k/4J21QJ4hYvdEAssVFp4QRcZqWu7WIQv88ecW
 /86g==
X-Gm-Message-State: AOJu0YwmSziBswQekAFL6Gr+eRyMiQ5yzPy4w+VgRmNMHKmSmeY/ZM5v
 FZtR8V7502E/kLeGe9t6iy6PAG6SYIo=
X-Google-Smtp-Source: AGHT+IG0QVo0nfdw4Hc/7KoEBaE/DajehiPo/GEWgPzwVaGDHw6ipDxYRpPwKdt83hwXu7V76vbYDQ==
X-Received: by 2002:a50:955a:0:b0:557:2c3e:206a with SMTP id
 v26-20020a50955a000000b005572c3e206amr619482eda.0.1704575155608; 
 Sat, 06 Jan 2024 13:05:55 -0800 (PST)
Received: from archlinux.. (dynamic-077-011-174-094.77.11.pool.telefonica.de.
 [77.11.174.94]) by smtp.gmail.com with ESMTPSA id
 f20-20020a056402195400b005576f4471besm624922edz.42.2024.01.06.13.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jan 2024 13:05:55 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Peter Xu <peterx@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Leonardo Bras <leobras@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v4 06/11] exec/ioport: Add portio_list_set_enabled()
Date: Sat,  6 Jan 2024 22:05:26 +0100
Message-ID: <20240106210531.140542-7-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240106210531.140542-1-shentey@gmail.com>
References: <20240106210531.140542-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
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


