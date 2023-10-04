Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBEC7B7B7B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:13:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxsV-0004by-K1; Wed, 04 Oct 2023 05:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxqi-0001nx-0Z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnxqe-0007UW-7l
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:07:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40572aeb6d0so18170935e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696410434; x=1697015234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vrY11rg/jZ5eShwKyE6eTnfciSU2dmuT97v3/Q0zg28=;
 b=ZUOv+bmrOk9+1ONiJAw3k5FIIbTBd8B0cBMutAvz+2DWuXRUaA1h7EbThWqDlUb/Ji
 FxxnoMhgQ2GU4ZoMfpY3fSihRWlLOAgwZX2VUFCumOb7KFfL8OxvT3nPxIwedp6jWTTK
 slIgY0dKYJTl0u4fbAo1rmpe0fGyIMAmwYkqMb9zvnOCknTl51gobNaL+mN60A/MkA9/
 /dzOTtOMFfT5nKE8IhJYjQ5j4FhElcHmiNXzEPlRi/G0OzUJbIlJSrW/xCML7chk/3vF
 AIWfZb6cZHjjapzkz5BDPrtNken/H91Y4fCnnPLlIc6SkHBj9sM1fq3DBtjXX2ovrF3i
 tUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696410434; x=1697015234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vrY11rg/jZ5eShwKyE6eTnfciSU2dmuT97v3/Q0zg28=;
 b=RU8lWOfldgtTf5dnXzz+qDAB+K2aIzbIhU1Zph+lFXm8M7QP3e3EXUVrVuKhiINL9d
 wdTL6qWBNXEwf7NZaIQePrlxxvcmIygYa4W04x2ipaww8Q5K8TnK10jnLbeDnqMAAtar
 9V6eXq3wMUdSDwunkJb7PGHcV33tqISlJZ6o7QOr1nivoW7h3gQnVVMz8MLPl+xto888
 FCf1h/J1mmpOk6TKaqG2JfyqlgAfuFShkBDoe2Iy04nZXKngjvE7nrzvJ/m7qwo79Iat
 XjUEanlMu6/0YbhdIrhi7BNOjikHTIUppuAvpD1ox95WexGalkGWtz9SAUfLKyzY5WWu
 TbwA==
X-Gm-Message-State: AOJu0YyO/1/idoEOJLKCE+/9JJZ9WEL84xReFwnJLui4QOhkMPz6oo/4
 n1bjQS1JVoTkqWPQTRAmrJkRVR1Qnpk+aVgGEJY=
X-Google-Smtp-Source: AGHT+IEo3i5t3ywTnsAD3IqdOPk4VbswRvct7A7kOK1jLTs7AhjTgC3fKHQKkeIpskcrxVRI13CX+Q==
X-Received: by 2002:a7b:c41a:0:b0:401:b2c7:349b with SMTP id
 k26-20020a7bc41a000000b00401b2c7349bmr1848081wmi.7.1696410434343; 
 Wed, 04 Oct 2023 02:07:14 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 f16-20020a5d4dd0000000b00323384e04e8sm3475947wru.111.2023.10.04.02.07.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 02:07:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 07/13] gdbstub: Rename 'softmmu' -> 'system'
Date: Wed,  4 Oct 2023 11:06:22 +0200
Message-ID: <20231004090629.37473-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004090629.37473-1-philmd@linaro.org>
References: <20231004090629.37473-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

We have gdbstub/user.c for user emulation code,
use gdbstub/system.c for system emulation part.

Rename s/softmmu/system/ in meson and few comments.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 gdbstub/internals.h             |  4 ++--
 gdbstub/{softmmu.c => system.c} |  2 +-
 gdbstub/meson.build             | 10 +++++-----
 gdbstub/trace-events            |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)
 rename gdbstub/{softmmu.c => system.c} (99%)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index fee243081f..f7fd1bede5 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -103,7 +103,7 @@ static inline int tohex(int v)
 }
 
 /*
- * Connection helpers for both softmmu and user backends
+ * Connection helpers for both system and user backends
  */
 
 void gdb_put_strbuf(void);
@@ -229,7 +229,7 @@ void gdb_breakpoint_remove_all(CPUState *cs);
  * @is_write: is it a write operation
  *
  * This function is specialised depending on the mode we are running
- * in. For softmmu guests we can switch the interpretation of the
+ * in. For system guests we can switch the interpretation of the
  * address to a physical address.
  */
 int gdb_target_memory_rw_debug(CPUState *cs, hwaddr addr,
diff --git a/gdbstub/softmmu.c b/gdbstub/system.c
similarity index 99%
rename from gdbstub/softmmu.c
rename to gdbstub/system.c
index 9f0b8b5497..189975b1d6 100644
--- a/gdbstub/softmmu.c
+++ b/gdbstub/system.c
@@ -104,7 +104,7 @@ static void gdb_chr_event(void *opaque, QEMUChrEvent event)
 }
 
 /*
- * In softmmu mode we stop the VM and wait to send the syscall packet
+ * In system-mode we stop the VM and wait to send the syscall packet
  * until notification that the CPU has stopped. This must be done
  * because if the packet is sent now the reply from the syscall
  * request could be received while the CPU is still in the running
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index a5a1f4e433..e5bccba34e 100644
--- a/gdbstub/meson.build
+++ b/gdbstub/meson.build
@@ -1,6 +1,6 @@
 #
 # The main gdbstub still relies on per-build definitions of various
-# types. The bits pushed to softmmu/user.c try to use guest agnostic
+# types. The bits pushed to system/user.c try to use guest agnostic
 # types such as hwaddr.
 #
 
@@ -12,7 +12,7 @@ gdb_system_ss = ss.source_set()
 
 # We build two versions of gdbstub, one for each mode
 gdb_user_ss.add(files('gdbstub.c', 'user.c'))
-gdb_system_ss.add(files('gdbstub.c', 'softmmu.c'))
+gdb_system_ss.add(files('gdbstub.c', 'system.c'))
 
 gdb_user_ss = gdb_user_ss.apply(config_targetos, strict: false)
 gdb_system_ss = gdb_system_ss.apply(config_targetos, strict: false)
@@ -23,15 +23,15 @@ libgdb_user = static_library('gdb_user',
                              c_args: '-DCONFIG_USER_ONLY',
                              build_by_default: false)
 
-libgdb_softmmu = static_library('gdb_softmmu',
+libgdb_system = static_library('gdb_system',
                                 gdb_system_ss.sources() + genh,
                                 name_suffix: 'fa',
                                 build_by_default: false)
 
 gdb_user = declare_dependency(link_whole: libgdb_user)
 user_ss.add(gdb_user)
-gdb_softmmu = declare_dependency(link_whole: libgdb_softmmu)
-system_ss.add(gdb_softmmu)
+gdb_system = declare_dependency(link_whole: libgdb_system)
+system_ss.add(gdb_system)
 
 common_ss.add(files('syscalls.c'))
 
diff --git a/gdbstub/trace-events b/gdbstub/trace-events
index 7bc79a73c4..4fd126a38c 100644
--- a/gdbstub/trace-events
+++ b/gdbstub/trace-events
@@ -28,5 +28,5 @@ gdbstub_err_checksum_invalid(uint8_t ch) "got invalid command checksum digit: 0x
 gdbstub_err_checksum_incorrect(uint8_t expected, uint8_t got) "got command packet with incorrect checksum, expected=0x%02x, received=0x%02x"
 gdbstub_err_unexpected_runpkt(uint8_t ch) "unexpected packet (0x%02x) while target running"
 
-# softmmu.c
+# system.c
 gdbstub_hit_watchpoint(const char *type, int cpu_gdb_index, uint64_t vaddr) "Watchpoint hit, type=\"%s\" cpu=%d, vaddr=0x%" PRIx64 ""
-- 
2.41.0


