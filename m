Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0041F832A55
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:26:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQorp-0005E1-0Z; Fri, 19 Jan 2024 08:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQorl-000572-DT
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:25:01 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rQorj-0006mM-Bo
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:25:01 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5578485fc0eso777727a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 05:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705670697; x=1706275497; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KXo1YLt845Pt2zK9FJiS5jPZDy9N656n9fSj/iWqSqs=;
 b=x7KAk5wRHLS/4Kwtz+h2VkfxHhjDR9beEknXEumTX5zHsHGjTCW4I1Estd4pF+cTmr
 JUogamv6tnCx1SIldXTkSa6OJKmZzUvSlB5geuoBOFB/xC7Cwe3qvJE99g//EPGAKdGS
 KLLfQn2aNI655r41GA55dBF/+gQHfso+SY+1A1saho25tdbUxrA/XbFoR2sOJlnqz1Rh
 lRI80Lt7gQb4uZWUdA2ZxxkbFop5l34vGyxsVpNcGJwZwscsxdQ4KWGBv/Zhi2qNlxXR
 D/idluyC1rFJQgjxc/pCWnbyX/HmmRoND5MQ3atcNhleVp4tEhb0+B0dzEisDmyBpOMU
 LDxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705670697; x=1706275497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KXo1YLt845Pt2zK9FJiS5jPZDy9N656n9fSj/iWqSqs=;
 b=Ps+9dtFAB/0aIqePbduyYR6W1ZfoI1NIYt9pGzC+0Akk90Wq5CNlwf+sXs/6cyctV/
 Z5K9ITe/nbeo1CrEkbjTRSOwo2AfT9UWlWYAU12vYu6AKapijOWYCBj738W1YvIbxCyW
 WMSA4PIGal2Ieapr/YXCkr7uUdl+3UuGIQejbXtjCfaWuyGPHrglwjVih3mp6/QNER1K
 YlGEMrQUexb35u3rYNfzFusfDqBQ/kJtreEq5gOkAyc2xzsLHv0maOKdu9Npnsa9X/sp
 2xWX7smNLhPxr2mffawZbV3ubL4GPnQN2KmeVIC4VeIRS8fx0Ylw8FH5Pw5A/9/f72+W
 /2kQ==
X-Gm-Message-State: AOJu0Yxmv8GIwwIQiextrsi5KBh3C0X+AUmxs/OOdYFs6uTwY4avCTs8
 NOrBHziUGQNsZlmzgabViwhoM49Iu5XScah+HR8HAKFY3yQJA3ylG9rI1tUU3uHQ/C1ZgsZar6s
 5vps=
X-Google-Smtp-Source: AGHT+IFTVbdPtqN7cjbpfHaxqzZHMxlRVkhGFF5UfzIzuqlBikjo68VvlfFRSXx9twRMCr+ktIJFhw==
X-Received: by 2002:a50:a41a:0:b0:559:2e6:bb18 with SMTP id
 u26-20020a50a41a000000b0055902e6bb18mr1729994edb.62.1705670697158; 
 Fri, 19 Jan 2024 05:24:57 -0800 (PST)
Received: from localhost.localdomain (adsl-138.37.6.1.tellas.gr. [37.6.1.138])
 by smtp.gmail.com with ESMTPSA id
 b11-20020aa7dc0b000000b00558fc426affsm8568310edu.88.2024.01.19.05.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 05:24:56 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 4/5] hw/xen/xen-hvm-common.c: convert DPRINTF to tracepoints
Date: Fri, 19 Jan 2024 15:24:46 +0200
Message-Id: <651ad62da159524e33edb5741fff4030797c864d.1705670342.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
References: <cover.1705670342.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Tracing DPRINTFs to stderr might not be desired. A developer that relies
on tracepoints should be able to opt-in to each tracepoint and rely on
QEMU's log redirection, instead of stderr by default.

This commit converts DPRINTFs in this file that are used for tracing
into tracepoints.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/xen/trace-events     | 10 +++++++++-
 hw/xen/xen-hvm-common.c | 35 ++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/hw/xen/trace-events b/hw/xen/trace-events
index 1b748dba09..dd5b5a7f35 100644
--- a/hw/xen/trace-events
+++ b/hw/xen/trace-events
@@ -42,7 +42,7 @@ xs_node_vscanf(char *path, char *value) "%s %s"
 xs_node_watch(char *path) "%s"
 xs_node_unwatch(char *path) "%s"
 
-# xen-hvm.c
+# xen-hvm-common.c
 xen_ram_alloc(unsigned long ram_addr, unsigned long size) "requested: 0x%lx, size 0x%lx"
 xen_client_set_memory(uint64_t start_addr, unsigned long size, bool log_dirty) "0x%"PRIx64" size 0x%lx, log_dirty %i"
 handle_ioreq(void *req, uint32_t type, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O=%p type=%d dir=%d df=%d ptr=%d port=0x%"PRIx64" data=0x%"PRIx64" count=%d size=%d"
@@ -55,6 +55,14 @@ cpu_ioreq_move(void *req, uint32_t dir, uint32_t df, uint32_t data_is_ptr, uint6
 xen_map_resource_ioreq(uint32_t id, void *addr) "id: %u addr: %p"
 cpu_ioreq_config_read(void *req, uint32_t sbdf, uint32_t reg, uint32_t size, uint32_t data) "I/O=%p sbdf=0x%x reg=%u size=%u data=0x%x"
 cpu_ioreq_config_write(void *req, uint32_t sbdf, uint32_t reg, uint32_t size, uint32_t data) "I/O=%p sbdf=0x%x reg=%u size=%u data=0x%x"
+cpu_get_ioreq_from_shared_memory_req_not_ready(int state, int data_is_ptr, uint64_t addr, uint64_t data, uint32_t count, uint32_t size) "I/O request not ready: 0x%x, ptr: 0x%x, port: 0x%"PRIx64", data: 0x%"PRIx64", count: %u, size: %u"
+xen_main_loop_prepare_init_cpu(int id, void *cpu) "cpu_by_vcpu_id[%d]=%p"
+xen_map_ioreq_server_shared_page(long unsigned int ioreq_pfn) "shared page at pfn 0x%lx"
+xen_map_ioreq_server_buffered_io_page(long unsigned int ioreq_pfn) "buffered io page at pfn 0x%lx"
+xen_map_ioreq_server_buffered_io_evtchn(int bufioreq_evtchn) "buffered io evtchn is 0x%x"
+destroy_hvm_domain_cannot_acquire_handle(void) "Cannot acquire xenctrl handle"
+destroy_hvm_domain_failed_action(const char *action, int sts, char *errno_s) "xc_domain_shutdown failed to issue %s, sts %d, %s"
+destroy_hvm_domain_action(int xen_domid, const char *action) "Issued domain %d %s"
 
 # xen-mapcache.c
 xen_map_cache(uint64_t phys_addr) "want 0x%"PRIx64
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 47e6cb1db3..05a29c6f11 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -169,11 +169,12 @@ static ioreq_t *cpu_get_ioreq_from_shared_memory(XenIOState *state, int vcpu)
     ioreq_t *req = xen_vcpu_ioreq(state->shared_page, vcpu);
 
     if (req->state != STATE_IOREQ_READY) {
-        DPRINTF("I/O request not ready: "
-                "%x, ptr: %x, port: %"PRIx64", "
-                "data: %"PRIx64", count: %u, size: %u\n",
-                req->state, req->data_is_ptr, req->addr,
-                req->data, req->count, req->size);
+        trace_cpu_get_ioreq_from_shared_memory_req_not_ready(req->state,
+                                                             req->data_is_ptr,
+                                                             req->addr,
+                                                             req->data,
+                                                             req->count,
+                                                             req->size);
         return NULL;
     }
 
@@ -601,10 +602,9 @@ static void xen_main_loop_prepare(XenIOState *state)
     if (evtchn_fd != -1) {
         CPUState *cpu_state;
 
-        DPRINTF("%s: Init cpu_by_vcpu_id\n", __func__);
         CPU_FOREACH(cpu_state) {
-            DPRINTF("%s: cpu_by_vcpu_id[%d]=%p\n",
-                    __func__, cpu_state->cpu_index, cpu_state);
+            trace_xen_main_loop_prepare_init_cpu(cpu_state->cpu_index,
+                                                 cpu_state);
             state->cpu_by_vcpu_id[cpu_state->cpu_index] = cpu_state;
         }
         qemu_set_fd_handler(evtchn_fd, cpu_handle_ioreq, NULL, state);
@@ -681,7 +681,7 @@ static int xen_map_ioreq_server(XenIOState *state)
     }
 
     if (state->shared_page == NULL) {
-        DPRINTF("shared page at pfn %lx\n", ioreq_pfn);
+        trace_xen_map_ioreq_server_shared_page(ioreq_pfn);
 
         state->shared_page = xenforeignmemory_map(xen_fmem, xen_domid,
                                                   PROT_READ | PROT_WRITE,
@@ -693,7 +693,7 @@ static int xen_map_ioreq_server(XenIOState *state)
     }
 
     if (state->buffered_io_page == NULL) {
-        DPRINTF("buffered io page at pfn %lx\n", bufioreq_pfn);
+        trace_xen_map_ioreq_server_buffered_io_page(bufioreq_pfn);
 
         state->buffered_io_page = xenforeignmemory_map(xen_fmem, xen_domid,
                                                        PROT_READ | PROT_WRITE,
@@ -709,7 +709,7 @@ static int xen_map_ioreq_server(XenIOState *state)
         return -1;
     }
 
-    DPRINTF("buffered io evtchn is %x\n", bufioreq_evtchn);
+    trace_xen_map_ioreq_server_buffered_io_evtchn(bufioreq_evtchn);
 
     state->bufioreq_remote_port = bufioreq_evtchn;
 
@@ -737,16 +737,17 @@ void destroy_hvm_domain(bool reboot)
 
     xc_handle = xc_interface_open(0, 0, 0);
     if (xc_handle == NULL) {
-        fprintf(stderr, "Cannot acquire xenctrl handle\n");
+        trace_destroy_hvm_domain_cannot_acquire_handle();
     } else {
         sts = xc_domain_shutdown(xc_handle, xen_domid, reason);
         if (sts != 0) {
-            fprintf(stderr, "xc_domain_shutdown failed to issue %s, "
-                    "sts %d, %s\n", reboot ? "reboot" : "poweroff",
-                    sts, strerror(errno));
+            trace_destroy_hvm_domain_failed_action(
+                reboot ? "reboot" : "poweroff", sts, strerror(errno)
+            );
         } else {
-            fprintf(stderr, "Issued domain %d %s\n", xen_domid,
-                    reboot ? "reboot" : "poweroff");
+            trace_destroy_hvm_domain_action(
+                xen_domid, reboot ? "reboot" : "poweroff"
+            );
         }
         xc_interface_close(xc_handle);
     }
-- 
γαῖα πυρί μιχθήτω


