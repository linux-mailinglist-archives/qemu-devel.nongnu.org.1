Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4797682B098
	for <lists+qemu-devel@lfdr.de>; Thu, 11 Jan 2024 15:25:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNvyi-0004NK-Lb; Thu, 11 Jan 2024 09:24:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyT-0004Lw-GZ
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:01 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rNvyR-0002V6-Bx
 for qemu-devel@nongnu.org; Thu, 11 Jan 2024 09:24:00 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3368abe1093so4265725f8f.2
 for <qemu-devel@nongnu.org>; Thu, 11 Jan 2024 06:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704983036; x=1705587836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ln64hRwHlJJ0pQEAuAxOaAua0Oss5Jze+kXnvVQ8J9Y=;
 b=qVCWhdnjMNRsk4KgqDKJDOleIlTIvsqnp1GHOKKcXIF7DengGwMBrBIGLMeCwfTX7w
 XMTuMTZg1fVn66R0WkW0j2sXALLHTbl9PIcffAuJa8VCh9u6XTBWbDse2RC2W3mPcA0B
 X0dQemz/ObxZkIca8udQKEJ0jhRXUmpht5xv2qKCwB+boC6NIHNj5dwJrxwIbEWSLrZn
 Ixh5eiO126xHcJV301zIkd2K9Ij0RJ9iThWBBM3GQ5SJZIr6NQZXexD2eiAgnOKHzUlH
 SF0s1qyOUSW51mf3JnGHcFsCUZ28g1eQXORzlOS2HEN/vpRlUKV8IIJdhIUaI0KE+WpV
 3FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704983036; x=1705587836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ln64hRwHlJJ0pQEAuAxOaAua0Oss5Jze+kXnvVQ8J9Y=;
 b=FgjFPW01w3Tqqp7x5KgDM9V1X+wkaRwmurJFfMTsKN4Hogr6oCy1CsgUvX3iZPk+Gp
 n7No1MdU2ACICYck5PxZOVwh7R+Xo2W2UmojX9rcX5VTuTR0tzkE6C/bFHqL9JZgEBma
 kXax0PLjcF3gzsG11awRRn+2M4YaXplRHeWisP6uXQCtVRse6GzwsGMf2o8wY4zOxH3c
 mqQStWtddbNvfSsmD78kyKS9baFkPNu9OWmua8+XrUcHF98anfQDLbG5CCNfNzT8tAWO
 hUfa8g+x4M/glXlO9IoQD+cPC+Q2vd1QRmBTMagE8FtTAYDcsz+MDqJNcpsX75+v4u6k
 8WPg==
X-Gm-Message-State: AOJu0Yw2ODJooSBOX5LsbBjyQVV6GO32ErC25XJ461QkV7M5D8YCMXZ8
 jEXh19Hvy7ZMWlR+TOlJqsWikAdcHSj1XHTPJyXB2BltwU+4gg==
X-Google-Smtp-Source: AGHT+IFXk2++/uRRI+OA+jtS1uUQ5ze4Rgn9uQlAGgOhgRm0Htpar0wYsO0bDy4XPnUnMOUhzLyrhA==
X-Received: by 2002:adf:eb01:0:b0:336:60ea:319d with SMTP id
 s1-20020adfeb01000000b0033660ea319dmr574008wrn.63.1704983036016; 
 Thu, 11 Jan 2024 06:23:56 -0800 (PST)
Received: from linaro.. ([102.35.208.160]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b0033677aae2e2sm1349000wrp.107.2024.01.11.06.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jan 2024 06:23:55 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 05/12] tests/plugin/mem: fix race condition with callbacks
Date: Thu, 11 Jan 2024 18:23:18 +0400
Message-ID: <20240111142326.1743444-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
References: <20240111142326.1743444-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x42f.google.com
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

Introduce a lock so global count is correct.
This was found by comparing with new inline per_vcpu inline op.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/plugin/mem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 44e91065ba7..beca8232342 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -22,6 +22,7 @@ static uint64_t io_count;
 static bool do_inline, do_callback;
 static bool do_haddr;
 static enum qemu_plugin_mem_rw rw = QEMU_PLUGIN_MEM_RW;
+static GMutex lock;
 
 static void plugin_exit(qemu_plugin_id_t id, void *p)
 {
@@ -42,6 +43,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
 static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
                      uint64_t vaddr, void *udata)
 {
+    g_mutex_lock(&lock);
     if (do_haddr) {
         struct qemu_plugin_hwaddr *hwaddr;
         hwaddr = qemu_plugin_get_hwaddr(meminfo, vaddr);
@@ -53,6 +55,7 @@ static void vcpu_mem(unsigned int cpu_index, qemu_plugin_meminfo_t meminfo,
     } else {
         cb_mem_count++;
     }
+    g_mutex_unlock(&lock);
 }
 
 static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
-- 
2.43.0


