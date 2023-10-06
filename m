Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B469E7BB640
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:18:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoinM-0008Kp-Bm; Fri, 06 Oct 2023 07:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoinF-0008FW-Hx
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoin5-0000Ji-20
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0xB3F5N3hazXwUg7/Q8GgLwNzUPETqU4qEAMwqj5k+M=;
 b=SuBu9ttU5dq0Ph+wjGABb2cLZVYwwSyob7Cd27MyRKFhjf/rdewQq9XMpzJHumm9qYnI2t
 U7sz9ZYx0hZCe+IE6pjUJUGZPiotljaClxlrs5YKL2Jv2dV3yxwG172V4Y7nw/5nV5v+A2
 LZ+xjgeF6/VBurJ7Zxb0HZ3XUMg/p8Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-2Crj_WJ2PxyuoYHUr1mevQ-1; Fri, 06 Oct 2023 07:14:36 -0400
X-MC-Unique: 2Crj_WJ2PxyuoYHUr1mevQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-533d8a785a5so1817734a12.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590874; x=1697195674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0xB3F5N3hazXwUg7/Q8GgLwNzUPETqU4qEAMwqj5k+M=;
 b=GKST/O/S436lMvepHjvLKEaAD1Wd2ZkfPgF/Nklqy+mQzzSp0IcLNTwz4w4061bJJS
 p0y6t9WySjZl8c6wUH5bs5pan1wEmNJmylWR+0oNzCMte/QcYgxgillk2bMaatfOs8wk
 mtL2Q7cF+nOal3+CQ2ks2mR+UlLMm6qE4PAXVC7FT4a+NAB7LJ2PnO7RgS+gRf+O8Lzi
 jDZOR6IbbCOZ8p6UiW09zjD5pH7uYAHA1tG2yMj5dIj7xPjzGagWXzpCEEHL9hSxqwRj
 kj6wIaxsz5aTMYhQlt04M91U+VG5TDgPPb4fAH91st4wWvh4uf5/RbqxZLt/4MoCsJZh
 J8CA==
X-Gm-Message-State: AOJu0Yx849KLBMS/no8XZ31AD7za6DUbXqKhz5RuFSaRjpNmuIB73jlz
 /2PiubMX7KVrY0g274Am1wjjRKgn7sLNQbMb51U/q3TMdGdt8dT/p3UC0svQ0Cz4EkeAQMO/+/f
 5mtQVitKTDp5BdfYcKlWUmeVEp895B95CaIzTA5H3cu9UKXt2atR4wPaLDOCrSRgn5XOGZM8ptL
 Q=
X-Received: by 2002:a05:6402:751:b0:532:c41d:1dcd with SMTP id
 p17-20020a056402075100b00532c41d1dcdmr6173050edy.25.1696590874082; 
 Fri, 06 Oct 2023 04:14:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQl3cpBuyR+tDJqXaffrd8UHliP01AR8i3bOSKryURqFer18J+DBij4rJEkx8lMRHRLRLS9g==
X-Received: by 2002:a05:6402:751:b0:532:c41d:1dcd with SMTP id
 p17-20020a056402075100b00532c41d1dcdmr6173035edy.25.1696590873645; 
 Fri, 06 Oct 2023 04:14:33 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 g26-20020aa7c59a000000b00530ccd180a3sm2381412edq.97.2023.10.06.04.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/26] gdbstub: Rename 'softmmu' -> 'system'
Date: Fri,  6 Oct 2023 13:13:57 +0200
Message-ID: <20231006111412.13130-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We have gdbstub/user.c for user emulation code,
use gdbstub/system.c for system emulation part.

Rename s/softmmu/system/ in meson and few comments.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20231004090629.37473-8-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 gdbstub/internals.h             |  4 ++--
 gdbstub/meson.build             | 10 +++++-----
 gdbstub/{softmmu.c => system.c} |  2 +-
 gdbstub/trace-events            |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)
 rename gdbstub/{softmmu.c => system.c} (99%)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index fee243081ff..f7fd1bede50 100644
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
diff --git a/gdbstub/meson.build b/gdbstub/meson.build
index a5a1f4e433f..e5bccba34e5 100644
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
 
diff --git a/gdbstub/softmmu.c b/gdbstub/system.c
similarity index 99%
rename from gdbstub/softmmu.c
rename to gdbstub/system.c
index 9f0b8b54977..189975b1d62 100644
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
diff --git a/gdbstub/trace-events b/gdbstub/trace-events
index 7bc79a73c42..4fd126a38c1 100644
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


