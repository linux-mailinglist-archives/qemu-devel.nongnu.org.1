Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F017BB623
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:16:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoimx-00082M-SH; Fri, 06 Oct 2023 07:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimv-00081X-Hj
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoimu-0000HX-3I
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696590871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrLgVIQkAHjAMRqFWa/jP4n4ukjcbGYSSbVn59AYU2E=;
 b=N3JzYM7nwPktA30C04ZEWuV34xlE4mkKjZnwSepsiulZ6a2Y+cf3p3F6jgW+ovZOu6zixe
 3FCvfG6tRbUpNaypvCU0O7xf/GgkNeqNUDwlRQ/F1xRsjikgo2nd9z8SIkoBG1pvyjrt0v
 U/YEA06RqXSeVQQY+b5Cp12yeVXampw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-ywIFhpXPP0Gri7xJ6nAT6w-1; Fri, 06 Oct 2023 07:14:30 -0400
X-MC-Unique: ywIFhpXPP0Gri7xJ6nAT6w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9ba0616b761so7908566b.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:14:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696590868; x=1697195668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mrLgVIQkAHjAMRqFWa/jP4n4ukjcbGYSSbVn59AYU2E=;
 b=v2LX1YsF7Hs5YKrqix+makXKolkiQKBF1wg5t6dL5qW9Q1Dz0LGZ19RLdOpRHUOzl5
 iCFtpfC/p7LeWerNGLW6XMhv0DqCkrRYf878WM84OooPAebZPgpfKaFSjjgYXPO+n4vc
 gUmLaqRrLdreETL2HA13tXzv91OMVSSTZJYekrwwqw7Q97t9zUdY0CmYJnhEg9+jLOpp
 y5ymUre+eo2v5Og/SvWVngMR9LeKgavSocVQONcvor54wjSMq/zRbcQ/X4a4e98tv1PD
 iniaDNOzU9t4Ih4Rik9WjsQ+By1dseoP5gH8qTKLTK7lNiItcGBzpvNtISfWykBwA5MW
 K90Q==
X-Gm-Message-State: AOJu0Yy36+NIG+STs/P0Y+jRl8icpCjzm8W7C+SKsoF3bit5qtkGd5V7
 E4amNAukzHj+eElhvFV7RKMnnbnUlVUXWb6hnxB5xdYqK7RFWcXriwAsaic7XlXmpm4Zz38bFRl
 84l8dH974ztU/BIkAvhWsTUjIiFbEw9hTUq7F5+te+H3FlX0UmgionDQ877179nKhw8nZdErDls
 8=
X-Received: by 2002:a17:907:7804:b0:9b0:552c:b36c with SMTP id
 la4-20020a170907780400b009b0552cb36cmr7255388ejc.21.1696590868509; 
 Fri, 06 Oct 2023 04:14:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMfktU/1G4q5CMzKiK1jlGF1aaOzeT9IiVi3frrnGrGeC9Ut2S32aSh26sLYEzWL0SGrGqFg==
X-Received: by 2002:a17:907:7804:b0:9b0:552c:b36c with SMTP id
 la4-20020a170907780400b009b0552cb36cmr7255371ejc.21.1696590868171; 
 Fri, 06 Oct 2023 04:14:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 z11-20020a170906074b00b00988f168811bsm2742861ejb.135.2023.10.06.04.14.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 04:14:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Bulekov <alxndr@bu.edu>
Subject: [PULL 08/26] fuzz: Correct invalid mentions of 'softmmu' by 'system'
Date: Fri,  6 Oct 2023 13:13:54 +0200
Message-ID: <20231006111412.13130-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006111412.13130-1-pbonzini@redhat.com>
References: <20231006111412.13130-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Alexander Bulekov <alxndr@bu.edu>
Message-ID: <20231004090629.37473-5-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/memory.c        | 2 +-
 tests/qtest/fuzz/fuzz.c | 2 +-
 tests/qtest/fuzz/fuzz.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/softmmu/memory.c b/softmmu/memory.c
index 234bd7b1161..fa1c99f9bad 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -3638,7 +3638,7 @@ void memory_region_init_rom_device(MemoryRegion *mr,
 }
 
 /*
- * Support softmmu builds with CONFIG_FUZZ using a weak symbol and a stub for
+ * Support system builds with CONFIG_FUZZ using a weak symbol and a stub for
  * the fuzz_dma_read_cb callback
  */
 #ifdef CONFIG_FUZZ
diff --git a/tests/qtest/fuzz/fuzz.c b/tests/qtest/fuzz/fuzz.c
index 3bedb81b32b..9b9c9f9c36e 100644
--- a/tests/qtest/fuzz/fuzz.c
+++ b/tests/qtest/fuzz/fuzz.c
@@ -207,7 +207,7 @@ int LLVMFuzzerInitialize(int *argc, char ***argv, char ***envp)
         fuzz_target->pre_vm_init();
     }
 
-    /* Run QEMU's softmmu main with the fuzz-target dependent arguments */
+    /* Run QEMU's system main with the fuzz-target dependent arguments */
     cmd_line = fuzz_target->get_init_cmdline(fuzz_target);
     g_string_append_printf(cmd_line, " %s -qtest /dev/null ",
                            getenv("QTEST_LOG") ? "" : "-qtest-log none");
diff --git a/tests/qtest/fuzz/fuzz.h b/tests/qtest/fuzz/fuzz.h
index 21d1362d655..7da0bc3d7eb 100644
--- a/tests/qtest/fuzz/fuzz.h
+++ b/tests/qtest/fuzz/fuzz.h
@@ -49,13 +49,13 @@ typedef struct FuzzTarget {
 
 
     /*
-     * Returns the arguments that are passed to qemu/softmmu init(). Freed by
+     * Returns the arguments that are passed to qemu/system init(). Freed by
      * the caller.
      */
     GString *(*get_init_cmdline)(struct FuzzTarget *);
 
     /*
-     * will run once, prior to running qemu/softmmu init.
+     * will run once, prior to running qemu/system init.
      * eg: set up shared-memory for communication with the child-process
      * Can be NULL
      */
-- 
2.41.0


