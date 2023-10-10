Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B135A7BFA57
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 13:52:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqBGY-0007gs-Nn; Tue, 10 Oct 2023 07:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGW-0007eF-1n
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:51:08 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqBGU-000712-AQ
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 07:51:07 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9a6190af24aso964704166b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696938664; x=1697543464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fiFld9bySWpL5X2cOy1s/AgFftSvZ7+zCb8U4NbScok=;
 b=Pc8dWaRYE5E76Jadq9wA5Nh0HD+6NaWNNU+5xhi284baMb3cpdrxC52qkfhETXQJ7A
 ecYhwwCoW4bA+mHmdmC0m8eBNblRaDyuvoaCSF9R20tY/S9qIQ3hlkX5eW/qhNkjdhsH
 3p2anLIaElkZAlpETUrnsR6PkKCvFnSwKxHXuAwJX5cFv+YX+ya0IJl270Jd8DqumAe4
 ZjE3HvseTb1RK/pNxisHz5rjEDXwUH48yLBLGQo5oxuiaRxgOFKxTyrg7bQXhwWBXaVY
 auE7XxON7daTk8ynRob5YlSWHFJCNHnakDn3pDk3yTpOJrza0bLGXuw/GoUausPmNgu+
 iBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696938664; x=1697543464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fiFld9bySWpL5X2cOy1s/AgFftSvZ7+zCb8U4NbScok=;
 b=HU/3W6u/nOm37jMTSHvDExHNjJ/FCHVeOHLh6VwQhk/5L+b9u6xv7AOUNa0W/AJN+7
 yyxPLT1d3ymodFWg6mc5Md+L8EMysiOTsr4kydZCmgyj85EEyDuCBb4Yx4p/b7psu4iM
 xmPN+IicREN74hIzpnocTqA7syhDQrl4WAuUQlmr1Z0wkKqDLoym3bMNCSiFfe6SPMkQ
 +s1GzS7D/W+4j5/GNanuA/gvDJxXh9CuGuE1tlgqeJ9uT1Cz1/tTD/7Tb6idqXXHaxX9
 P3/7/NacdQwCHBf+iTy6mBvQc21lS6w5S+jjI9/zHH9fG5bjvPoTHYNfCgho3SljQXRm
 xVbw==
X-Gm-Message-State: AOJu0Yz5WQdBW8iYt52JEW5emRjdnym7agPC4sfQ7XexoAPrRompKZiI
 WZ+85HYRmW80HIO5ZAZfIkYm8grjhqOGfLEg/9Op+g==
X-Google-Smtp-Source: AGHT+IGMXQXAxQ07TKmnCaINJe8MWpcSaNwQsAcsxlqcVIo/r67ElsdbMH3MdCSUc6GJ7r1vB8P2ug==
X-Received: by 2002:a17:907:7850:b0:9ae:75dc:4589 with SMTP id
 lb16-20020a170907785000b009ae75dc4589mr17988299ejc.64.1696938664748; 
 Tue, 10 Oct 2023 04:51:04 -0700 (PDT)
Received: from m1x-phil.lan (aif79-h01-176-172-113-148.dsl.sta.abo.bbox.fr.
 [176.172.113.148]) by smtp.gmail.com with ESMTPSA id
 u13-20020a1709060b0d00b009ad87d1be17sm8323271ejg.22.2023.10.10.04.51.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Oct 2023 04:51:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 2/6] hw/loader: Clean up global variable shadowing in
 rom_add_file()
Date: Tue, 10 Oct 2023 13:50:44 +0200
Message-ID: <20231010115048.11856-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010115048.11856-1-philmd@linaro.org>
References: <20231010115048.11856-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Invert 'option_rom' logic and rename it as 'option_rom_has_mr' to fix:

  hw/core/loader.c:1073:27: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
                       bool option_rom, MemoryRegion *mr,
                            ^
  include/sysemu/sysemu.h:57:22: note: previous declaration is here
  extern QEMUOptionRom option_rom[MAX_OPTION_ROMS];
                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loader.h | 11 ++++++-----
 hw/core/loader.c    | 10 +++++-----
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index c4c14170ea..9dbb9f7fdb 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -272,7 +272,8 @@ void pstrcpy_targphys(const char *name,
 
 ssize_t rom_add_file(const char *file, const char *fw_dir,
                      hwaddr addr, int32_t bootindex,
-                     bool option_rom, MemoryRegion *mr, AddressSpace *as);
+                     bool option_rom_has_mr,
+                     MemoryRegion *mr, AddressSpace *as);
 MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
                            size_t max_len, hwaddr addr,
                            const char *fw_file_name,
@@ -341,15 +342,15 @@ void *rom_ptr_for_as(AddressSpace *as, hwaddr addr, size_t size);
 void hmp_info_roms(Monitor *mon, const QDict *qdict);
 
 #define rom_add_file_fixed(_f, _a, _i)          \
-    rom_add_file(_f, NULL, _a, _i, false, NULL, NULL)
+    rom_add_file(_f, NULL, _a, _i, true, NULL, NULL)
 #define rom_add_blob_fixed(_f, _b, _l, _a)      \
     rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, NULL, true)
 #define rom_add_file_mr(_f, _mr, _i)            \
-    rom_add_file(_f, NULL, 0, _i, false, _mr, NULL)
+    rom_add_file(_f, NULL, 0, _i, true, _mr, NULL)
 #define rom_add_file_as(_f, _as, _i)            \
-    rom_add_file(_f, NULL, 0, _i, false, NULL, _as)
+    rom_add_file(_f, NULL, 0, _i, true, NULL, _as)
 #define rom_add_file_fixed_as(_f, _a, _i, _as)          \
-    rom_add_file(_f, NULL, _a, _i, false, NULL, _as)
+    rom_add_file(_f, NULL, _a, _i, true, NULL, _as)
 #define rom_add_blob_fixed_as(_f, _b, _l, _a, _as)      \
     rom_add_blob(_f, _b, _l, _l, _a, NULL, NULL, NULL, _as, true)
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4dd5a71fb7..f0d20fd776 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1070,8 +1070,8 @@ static void *rom_set_mr(Rom *rom, Object *owner, const char *name, bool ro)
 
 ssize_t rom_add_file(const char *file, const char *fw_dir,
                      hwaddr addr, int32_t bootindex,
-                     bool option_rom, MemoryRegion *mr,
-                     AddressSpace *as)
+                     bool option_rom_has_mr,
+                     MemoryRegion *mr, AddressSpace *as)
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     Rom *rom;
@@ -1139,7 +1139,7 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
                  basename);
         snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
 
-        if ((!option_rom || mc->option_rom_has_mr) && mc->rom_file_has_mr) {
+        if ((option_rom_has_mr || mc->option_rom_has_mr) && mc->rom_file_has_mr) {
             data = rom_set_mr(rom, OBJECT(fw_cfg), devpath, true);
         } else {
             data = rom->data;
@@ -1239,12 +1239,12 @@ int rom_add_elf_program(const char *name, GMappedFile *mapped_file, void *data,
 
 ssize_t rom_add_vga(const char *file)
 {
-    return rom_add_file(file, "vgaroms", 0, -1, true, NULL, NULL);
+    return rom_add_file(file, "vgaroms", 0, -1, false, NULL, NULL);
 }
 
 ssize_t rom_add_option(const char *file, int32_t bootindex)
 {
-    return rom_add_file(file, "genroms", 0, bootindex, true, NULL, NULL);
+    return rom_add_file(file, "genroms", 0, bootindex, false, NULL, NULL);
 }
 
 static void rom_reset(void *unused)
-- 
2.41.0


