Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B37881BA45
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 16:10:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGKf8-0008U9-DZ; Thu, 21 Dec 2023 10:08:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKep-0008Cl-Ag; Thu, 21 Dec 2023 10:08:19 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1rGKem-0004L1-EI; Thu, 21 Dec 2023 10:08:18 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5534abbc637so1083878a12.0; 
 Thu, 21 Dec 2023 07:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703171291; x=1703776091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jnJPE2oIDz97YP6esr/R8SX7Cf88AF/hpec8jnAAEHQ=;
 b=eZfM4HqD7L95UKMGOHomaoZ/DuASISzypNAmjzb7PQhcfLO7JygA9ckEOiv1ehaTSb
 FdAWyohR6Jk+VKd7rv0lury6DBmkeYAYIuROB10RV0a96LqJvpBuuNTjuosdvzSL2yQw
 MjNNZWSl0jjqhhAfYGIbFpfYt4mb8i5JTZ7gwkap0Un/qb6Y764wxQ6PigX1yv1gMX43
 DyAegexAl579IW8oQ7GrUGnIwjKmyN67Id6YNmUe8jiw0Mn1Iktc3PFDc2EDwVKB1VU8
 nKuVSRvO4sl+wdJjHrc4mWN7ZJ8POPEYhzbIrsUuNZMPM3PQcrgK/epk8NqcI9C2lIeO
 cjcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703171291; x=1703776091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jnJPE2oIDz97YP6esr/R8SX7Cf88AF/hpec8jnAAEHQ=;
 b=RaMREkSIpFpm4JnHXGyYQP3gDCIS4b8dxo402Fr/uHBGIISMyc/0RRGyriYqyiiaiy
 mFwbI2Zf91ymTldIQ6cGwAjjKe67yeZK6keUEghbw0DnHNvsIn1ZxCPXirTRjKmTnjh0
 Wx2KCjEZqcYoAaAuSD5/Mq/Dll8XSxJBN7XVbJX8pOtV6MuE3rTHcHGjeOb1SI3/kqkT
 1Fo3MOUWEBLxMApLlYGriPXweM1gWDwpxPFAcNT26RL9x6SRtAUlt5WmAT0yuETwJfkn
 2QeT7ujcw/irDyDudsHJT8pFsHeCVaTmXukG0yJNhNZ+g/74BcKn6Tt4fW86K6yLTCYy
 Rfcg==
X-Gm-Message-State: AOJu0YyBc0D+H97Twt/+wLiqyezBkSFqK9WM5hyS4nKCOhSQ1QnIXN0y
 cNRUUHxf4rOHPNcDUlnTDHDS1b3FroK5cg==
X-Google-Smtp-Source: AGHT+IEmIIJhrkZ2CesxRAAKb6pW/IuBPs2Oj/qoz1th0BOzqmdaMMnZS6KPvGvI1ef3wKjIrD/hyA==
X-Received: by 2002:a50:bb41:0:b0:552:f56d:eb81 with SMTP id
 y59-20020a50bb41000000b00552f56deb81mr5488736ede.66.1703171291036; 
 Thu, 21 Dec 2023 07:08:11 -0800 (PST)
Received: from archlinux.. (pd95ed842.dip0.t-ipconnect.de. [217.94.216.66])
 by smtp.gmail.com with ESMTPSA id
 t25-20020a056402241900b00553b6b5bb44sm1264264eda.67.2023.12.21.07.08.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 07:08:10 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Hanna Reitz <hreitz@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <huth@tuxfamily.org>,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-ppc@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Sergio Lopez <slp@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 David Hildenbrand <david@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Leonardo Bras <leobras@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 06/11] exec/ioport: Add portio_list_set_enabled()
Date: Thu, 21 Dec 2023 16:07:45 +0100
Message-ID: <20231221150750.5435-7-shentey@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231221150750.5435-1-shentey@gmail.com>
References: <20231221150750.5435-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52e.google.com
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
index dc35a17461..9317091d1a 100644
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


