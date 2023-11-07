Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD57E41D7
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 15:29:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0N0K-0004UI-Q8; Tue, 07 Nov 2023 09:24:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N06-0004JZ-BD
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:20 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0N02-0007cU-9M
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 09:24:17 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso7247902e87.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 06:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699367049; x=1699971849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ua8AI/feWes7WKGpR0iK2DJxyzyGPmZR7VA8v8f6v4Q=;
 b=tLjavIgl0ib5OfFRKtlxFyow3ClD7bWJjWbGE+wC9fZN7+p9dSfw8Mqa43rGjcKgUH
 E+/hYurQDkbo3P4c56t0Nb7F8WEOICvPG15/THcTTE6lA5G6DxAwiKvYOU84IxtxC/FJ
 +H/5fqQXXlOUZhU1FiC67F14AqY+LsYVAvojkMKMn3n1JZd6R3UAp33it/Aak9ucxLRw
 LnElX/8AjeCQFUyOnXJEb9C0DHG4rol7UGupq0Ec5yIBVkGcL7JViCopWmSvIEd9GBlD
 tGe30J7YPFSXgWmYL4vQdvVzEm0DCMZ96tHGNS/WUpojSre5s+Mejl70vzBClqLJYZdZ
 7MHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699367049; x=1699971849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ua8AI/feWes7WKGpR0iK2DJxyzyGPmZR7VA8v8f6v4Q=;
 b=lTbcD7V2ktU/FwAeSoi282VZUhU6cD949LWaQYZH9bpVWM8TG7NgXS2MhWdzIU7fO3
 ffaKYrB6XMUVwW2hdfLPPCcWi7jEC4QBnHtNjxveGtd/N9uQqPdKAmF1rQKVomTq0x6Q
 w5C8gcoE6Qj+M3Zdj/tqBy8wS0Ljm1yj4HggWjflzZFUWUfoKFmO6+j4tuuaPP7H+v+6
 y0PkPTNjVM2p1SjikyIoTdRuL3rcUVeJ9TZ7FSFGdeBRXxGYg7Nr96sjq70f24kwLIMJ
 19sdEodgCFPJPVYDDThcWvM57Y7udO5H+6ufRp63cWwPOHiwJBmAkX3TYfvPn3P5m1t9
 tHKA==
X-Gm-Message-State: AOJu0Yz7dHSqsD3KSXDIlS+Os2S4NlAEdosB6dMhU+fut8kJSip76JPv
 AypPuVwql5wQAnV2f7NMqY7MuQ==
X-Google-Smtp-Source: AGHT+IFTWCUKsjGiU5nLGQwVWWcw0pYzdFn8m4xUDQVh6UTDhW5zBWGsDQRs0z/K0TlkYVbvrYZI6A==
X-Received: by 2002:ac2:561a:0:b0:508:268b:b087 with SMTP id
 v26-20020ac2561a000000b00508268bb087mr22600335lfd.26.1699367049543; 
 Tue, 07 Nov 2023 06:24:09 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 k8-20020a05600c1c8800b004081a011c0esm15962291wms.12.2023.11.07.06.23.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:24:05 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BF8C565762;
 Tue,  7 Nov 2023 14:23:55 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Greg Manning <gmanning@rapitasystems.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/23] plugins: add dllexport and dllimport to api funcs
Date: Tue,  7 Nov 2023 14:23:44 +0000
Message-Id: <20231107142354.3151266-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231107142354.3151266-1-alex.bennee@linaro.org>
References: <20231107142354.3151266-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Greg Manning <gmanning@rapitasystems.com>

In qemu-plugin.h, mark all API functions as __declspec(dllexport) when
compiling the executables, and as __declspec(dllimport) when being used
to compile plugins against.

Signed-off-by: Greg Manning <gmanning@rapitasystems.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20231102172053.17692-2-gmanning@rapitasystems.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231106185112.2755262-14-alex.bennee@linaro.org>

diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index 50a9957279..4daab6efd2 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -22,15 +22,18 @@
  *   https://gcc.gnu.org/wiki/Visibility
  */
 #if defined _WIN32 || defined __CYGWIN__
-  #ifdef BUILDING_DLL
-    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
-  #else
+  #ifdef CONFIG_PLUGIN
     #define QEMU_PLUGIN_EXPORT __declspec(dllimport)
+    #define QEMU_PLUGIN_API __declspec(dllexport)
+  #else
+    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
+    #define QEMU_PLUGIN_API __declspec(dllimport)
   #endif
   #define QEMU_PLUGIN_LOCAL
 #else
   #define QEMU_PLUGIN_EXPORT __attribute__((visibility("default")))
   #define QEMU_PLUGIN_LOCAL  __attribute__((visibility("hidden")))
+  #define QEMU_PLUGIN_API
 #endif
 
 /**
@@ -147,6 +150,7 @@ typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
  *
  * Note: Calling this function from qemu_plugin_install() is a bug.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
 
 /**
@@ -160,6 +164,7 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  * Plugins are reset asynchronously, and therefore the given plugin receives
  * callbacks until @cb is called.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
 
 /**
@@ -171,6 +176,7 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  *
  * See also: qemu_plugin_register_vcpu_exit_cb()
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
@@ -183,6 +189,7 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
  *
  * See also: qemu_plugin_register_vcpu_init_cb()
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
@@ -193,6 +200,7 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a vCPU idles.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
@@ -203,6 +211,7 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a vCPU resumes execution.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb);
 
@@ -253,6 +262,7 @@ typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
  * callbacks to be triggered when the block or individual instruction
  * executes.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb);
 
@@ -265,6 +275,7 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a translated unit executes.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           qemu_plugin_vcpu_udata_cb_t cb,
                                           enum qemu_plugin_cb_flags flags,
@@ -296,6 +307,7 @@ enum qemu_plugin_op {
  * Note: ops are not atomic so in multi-threaded/multi-smp situations
  * you will get inexact results.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm);
@@ -309,6 +321,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
  *
  * The @cb function is called every time an instruction is executed
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             qemu_plugin_vcpu_udata_cb_t cb,
                                             enum qemu_plugin_cb_flags flags,
@@ -324,6 +337,7 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
  * Insert an inline op to every time an instruction executes. Useful
  * if you just want to increment a single counter somewhere in memory.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm);
@@ -334,6 +348,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
  *
  * Returns: number of instructions in this block
  */
+QEMU_PLUGIN_API
 size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
 
 /**
@@ -342,6 +357,7 @@ size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
  *
  * Returns: virtual address of block start
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);
 
 /**
@@ -355,6 +371,7 @@ uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);
  *
  * Returns: opaque handle to instruction
  */
+QEMU_PLUGIN_API
 struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
 
@@ -368,6 +385,7 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
  * Returns: pointer to a stream of bytes containing the value of this
  * instructions opcode.
  */
+QEMU_PLUGIN_API
 const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
 
 /**
@@ -376,6 +394,7 @@ const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
  *
  * Returns: size of instruction in bytes
  */
+QEMU_PLUGIN_API
 size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn);
 
 /**
@@ -384,6 +403,7 @@ size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn);
  *
  * Returns: virtual address of instruction
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
 
 /**
@@ -392,6 +412,7 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
  *
  * Returns: hardware (physical) target address of instruction
  */
+QEMU_PLUGIN_API
 void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
 
 /**
@@ -410,6 +431,7 @@ struct qemu_plugin_hwaddr;
  *
  * Returns: size of access in ^2 (0=byte, 1=16bit, 2=32bit etc...)
  */
+QEMU_PLUGIN_API
 unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
 /**
  * qemu_plugin_mem_is_sign_extended() - was the access sign extended
@@ -417,6 +439,7 @@ unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
  *
  * Returns: true if it was, otherwise false
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info);
 /**
  * qemu_plugin_mem_is_big_endian() - was the access big endian
@@ -424,6 +447,7 @@ bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info);
  *
  * Returns: true if it was, otherwise false
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
 /**
  * qemu_plugin_mem_is_store() - was the access a store
@@ -431,6 +455,7 @@ bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
  *
  * Returns: true if it was, otherwise false
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
 
 /**
@@ -446,6 +471,7 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
  * information about the handle should be recovered before the
  * callback returns.
  */
+QEMU_PLUGIN_API
 struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr);
 
@@ -462,6 +488,7 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
  * Returns true if the handle's memory operation is to memory-mapped IO, or
  * false if it is to RAM
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
 
 /**
@@ -473,12 +500,14 @@ bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
  * Note that the returned physical address may not be unique if you are dealing
  * with multiple address spaces.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_hwaddr_phys_addr(const struct qemu_plugin_hwaddr *haddr);
 
 /*
  * Returns a string representing the device. The string is valid for
  * the lifetime of the plugin.
  */
+QEMU_PLUGIN_API
 const char *qemu_plugin_hwaddr_device_name(const struct qemu_plugin_hwaddr *h);
 
 /**
@@ -513,6 +542,7 @@ typedef void (*qemu_plugin_vcpu_mem_cb_t) (unsigned int vcpu_index,
  * callback so the plugin is responsible for ensuring it doesn't get
  * confused by making appropriate use of locking if required.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       qemu_plugin_vcpu_mem_cb_t cb,
                                       enum qemu_plugin_cb_flags flags,
@@ -531,6 +561,7 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
  * instruction. This provides for a lightweight but not thread-safe
  * way of counting the number of operations done.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_mem_rw rw,
                                           enum qemu_plugin_op op, void *ptr,
@@ -544,6 +575,7 @@ typedef void
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);
 
+QEMU_PLUGIN_API
 void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb);
 
@@ -551,6 +583,7 @@ typedef void
 (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_idx,
                                      int64_t num, int64_t ret);
 
+QEMU_PLUGIN_API
 void
 qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb);
@@ -563,6 +596,7 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
  * Returns an allocated string containing the disassembly
  */
 
+QEMU_PLUGIN_API
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
 
 /**
@@ -572,6 +606,7 @@ char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
  * Return a static string referring to the symbol. This is dependent
  * on the binary QEMU is running having provided a symbol table.
  */
+QEMU_PLUGIN_API
 const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
 
 /**
@@ -583,9 +618,11 @@ const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn);
  *
  * See also: qemu_plugin_register_vcpu_init_cb()
  */
+QEMU_PLUGIN_API
 void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
                                qemu_plugin_vcpu_simple_cb_t cb);
 
+QEMU_PLUGIN_API
 void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb);
 
@@ -602,6 +639,7 @@ void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
  * In user-mode it is possible a few un-instrumented instructions from
  * child threads may run before the host kernel reaps the threads.
  */
+QEMU_PLUGIN_API
 void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
@@ -615,6 +653,7 @@ int qemu_plugin_n_max_vcpus(void);
  * qemu_plugin_outs() - output string via QEMU's logging system
  * @string: a string
  */
+QEMU_PLUGIN_API
 void qemu_plugin_outs(const char *string);
 
 /**
@@ -628,6 +667,7 @@ void qemu_plugin_outs(const char *string);
  * returns true if the combination @name=@val parses correctly to a boolean
  * argument, and false otherwise
  */
+QEMU_PLUGIN_API
 bool qemu_plugin_bool_parse(const char *name, const char *val, bool *ret);
 
 /**
@@ -638,6 +678,7 @@ bool qemu_plugin_bool_parse(const char *name, const char *val, bool *ret);
  * return NULL. The user should g_free() the string once no longer
  * needed.
  */
+QEMU_PLUGIN_API
 const char *qemu_plugin_path_to_binary(void);
 
 /**
@@ -646,6 +687,7 @@ const char *qemu_plugin_path_to_binary(void);
  * Returns the nominal start address of the main text segment in
  * user-mode. Currently returns 0 for system emulation.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_start_code(void);
 
 /**
@@ -654,6 +696,7 @@ uint64_t qemu_plugin_start_code(void);
  * Returns the nominal end address of the main text segment in
  * user-mode. Currently returns 0 for system emulation.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_end_code(void);
 
 /**
@@ -662,6 +705,7 @@ uint64_t qemu_plugin_end_code(void);
  * Returns the nominal entry address of the main text segment in
  * user-mode. Currently returns 0 for system emulation.
  */
+QEMU_PLUGIN_API
 uint64_t qemu_plugin_entry_code(void);
 
 #endif /* QEMU_QEMU_PLUGIN_H */
-- 
2.39.2


