Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBC37BD7A4
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 11:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpmtF-0003Ht-Pk; Mon, 09 Oct 2023 05:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpms3-0001sk-1X
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:17 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpmrw-0005xX-8K
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 05:48:14 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-533f193fc8dso7490490a12.2
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 02:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696844883; x=1697449683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjIFUd9EeYCQO/H7VS1vP3CjmTEJO6hAfPQ2q7h2ewE=;
 b=Sw4h7STNnHObyngFRp7jim4pUrqYPwGpm4PG3VMD8WRDKYpT0aFXYd60ZBtY/tJTdQ
 9MossDNHTCposqOs1ieDtMSxlly/g7XE4av5EeTYILDUrTkHCoS9rFHCvcUDgwKKCyOr
 4Elk7+JyK8IiXFwPYhASSF2hv10tapsc5N10eVETFwZGwRw1HtgP3R8MGnnwe8RLZVVy
 4Yr9RLMsvz3I3Gkwy7bPG6uQxBNeQyJGL7mt3+vRIFkTJBVKI1WAIN/grdko8FosZOhy
 I+kVDyvBlY6LBbwCiZTADK3xjAbImMe1mQgo9Ga6HjsAWOrr51j8SocqWUKvqD1n7pQ+
 BzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696844883; x=1697449683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QjIFUd9EeYCQO/H7VS1vP3CjmTEJO6hAfPQ2q7h2ewE=;
 b=fGxKh8jUuob07m+Zn5kX31jIaWkDKJEEncLDD5wAFSe0oUF0X/41i0ynhQqzlq/aly
 0M6cZpZjTjdtIYOAwsnC+dAftABc9MHjAIMN6NK4HXvS2pW16yQaQReAjlfpGkjmehqZ
 5dJf21GuR/qUUG6wfTGu7mTFZ8mrn8M6S0kQT/ndHQt6eawYHp2XPRycTOu4OasGyA+k
 Liz52BbrzOW6a+E+7XiVkIZ77lAPiabKRoSGWB30ZFf9EAWV/MEcfM9UeHA1fQNOP2nD
 951YmJgr7l+GrnyWAd2f2MgvgXVVh/+pp5bh3xswtnH9Q2+usvTz5kTi+8hDxbhhILId
 J8Gw==
X-Gm-Message-State: AOJu0YxSwq0he/UOev94Roz6EbVLv3sUFDqfbB0flMDpcWAozC8Wf20g
 nXFxneKXf3S+7/kPiANxCQgPziyhpWGDjTfgRlg=
X-Google-Smtp-Source: AGHT+IEm2DRPRDfWQHvmrSSWZMmgFL7UgZ9trMFcE9MEG9SakFoNT4n+VXWcl8OBMCCEpNomcP0qpA==
X-Received: by 2002:a05:6402:355:b0:523:d51:bb2 with SMTP id
 r21-20020a056402035500b005230d510bb2mr11341808edw.15.1696844883379; 
 Mon, 09 Oct 2023 02:48:03 -0700 (PDT)
Received: from m1x-phil.lan (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr.
 [176.170.217.185]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa7d619000000b0053622a35665sm5802067edr.66.2023.10.09.02.48.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Oct 2023 02:48:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, David Hildenbrand <david@redhat.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 2/6] hw/loader: Clean up global variable shadowing in
 rom_add_file()
Date: Mon,  9 Oct 2023 11:47:42 +0200
Message-ID: <20231009094747.54240-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009094747.54240-1-philmd@linaro.org>
References: <20231009094747.54240-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Fix:

  hw/core/loader.c:1073:27: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
                       bool option_rom, MemoryRegion *mr,
                            ^
  include/sysemu/sysemu.h:57:22: note: previous declaration is here
  extern QEMUOptionRom option_rom[MAX_OPTION_ROMS];
                       ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/loader.h | 2 +-
 hw/core/loader.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/loader.h b/include/hw/loader.h
index c4c14170ea..8685e27334 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -272,7 +272,7 @@ void pstrcpy_targphys(const char *name,
 
 ssize_t rom_add_file(const char *file, const char *fw_dir,
                      hwaddr addr, int32_t bootindex,
-                     bool option_rom, MemoryRegion *mr, AddressSpace *as);
+                     bool has_option_rom, MemoryRegion *mr, AddressSpace *as);
 MemoryRegion *rom_add_blob(const char *name, const void *blob, size_t len,
                            size_t max_len, hwaddr addr,
                            const char *fw_file_name,
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 4dd5a71fb7..7f0cbfb214 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -1070,7 +1070,7 @@ static void *rom_set_mr(Rom *rom, Object *owner, const char *name, bool ro)
 
 ssize_t rom_add_file(const char *file, const char *fw_dir,
                      hwaddr addr, int32_t bootindex,
-                     bool option_rom, MemoryRegion *mr,
+                     bool has_option_rom, MemoryRegion *mr,
                      AddressSpace *as)
 {
     MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
@@ -1139,7 +1139,7 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
                  basename);
         snprintf(devpath, sizeof(devpath), "/rom@%s", fw_file_name);
 
-        if ((!option_rom || mc->option_rom_has_mr) && mc->rom_file_has_mr) {
+        if ((!has_option_rom || mc->option_rom_has_mr) && mc->rom_file_has_mr) {
             data = rom_set_mr(rom, OBJECT(fw_cfg), devpath, true);
         } else {
             data = rom->data;
-- 
2.41.0


