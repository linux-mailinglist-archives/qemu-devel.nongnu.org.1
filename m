Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B495072E1D2
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 13:40:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90UC-00059V-Ff; Tue, 13 Jun 2023 05:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90UA-00057F-MM
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:46 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90U0-0005VC-Nj
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:38:46 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-97454836448so755280966b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649113; x=1689241113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=coCYRAX/D0a1lARgSgpQz1zwILEZC/GYBuzI7kzZU2k=;
 b=fvYNJGElWOZz1CVYoJHpvlpNEdZJHYJgVoa3xXhSVBqQoAE6+fe57f1ahMXjFN/Cjl
 zSmTpPCklpHaSZtxD3geMnY7qUOgZzixJWsp98MDJYA2sErZg78PuwjPxTdyYX+EiiwD
 t5yokU+RWa0v7UVqzdCsgUDV8VwuNRQsEqHbv1JlUF+CblMnSAdFunig8UYkxSsRG0hN
 ShdE+2+jHegDisA8I8hPgcoK9ucbVoBShcnoIiWKDpJMMtGE358fnv/RmCP3K6hQGzH7
 eFT/JpvF8lY9ZXMQMKXsYYJj9RnhU578SD8ujcYd/+DD4zDay6oBgqPp4Jw9DABlOkoJ
 7EMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649113; x=1689241113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=coCYRAX/D0a1lARgSgpQz1zwILEZC/GYBuzI7kzZU2k=;
 b=AdbYeR5ZKl1e6joq2+jE/T236X2hOAI8y/eIE1aRinYW6Hz6eFeYJbYNurmG/l34O2
 cj0buW7mf6iTmLhjoZERrj61mS0nGUxNR1mQt8uRturf4gJFSTAD9jN28HQKrLDBLNwm
 0Xdmf7ObFZHv1/R8d9zPZvyGukl9sLm0/L4yQ0Z/J2wkgoLQ4zDI3IbISGG9OxgwnM6k
 JqEuzb5rx6oWB+DNPuxeOHKUIELoGz/07niDThWHJHgutpggS7pN6bfkdIjPSKxwb8kJ
 f+TTCPRV59i0zMlh7Mo96fzS8WN9h82F+lOjYjlFMkhknahvPvhDgZE5okTaV/MzO+6u
 lnvg==
X-Gm-Message-State: AC+VfDwITanNPc2z9GWe1q6Y52Yt/ng2oL25uvDPktBtIO18wsmcBphg
 WZ8RwfHen0i+4yjKpFIRBjjxC8nDeXSp/ABZpAebUg==
X-Google-Smtp-Source: ACHHUZ59jlwoYPU3KBNv+8oIOiZK4KA4cFoXT5yC1limHVxBEmjQlUFDEX3tcNUOakTQUqgGqklAPA==
X-Received: by 2002:a17:907:6daa:b0:973:cc48:f19c with SMTP id
 sb42-20020a1709076daa00b00973cc48f19cmr11331108ejc.56.1686649113701; 
 Tue, 13 Jun 2023 02:38:33 -0700 (PDT)
Received: from localhost.localdomain ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 g12-20020a1709064e4c00b00965e1be3002sm4801468ejw.166.2023.06.13.02.38.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Jun 2023 02:38:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PULL 02/17] cocoa: Fix warnings about invalid prototype declarations
Date: Tue, 13 Jun 2023 11:38:07 +0200
Message-Id: <20230613093822.63750-3-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613093822.63750-1-philmd@linaro.org>
References: <20230613093822.63750-1-philmd@linaro.org>
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

Fix the following Cocoa trivial warnings:

  C compiler for the host machine: cc (clang 14.0.0 "Apple clang version 14.0.0 (clang-1400.0.29.202)")
  Objective-C compiler for the host machine: clang (clang 14.0.0)

  [100/334] Compiling Objective-C object libcommon.fa.p/net_vmnet-bridged.m.o
  net/vmnet-bridged.m:40:31: warning: a function declaration without a prototype is deprecated in all versions of C [-Wstrict-prototypes]
  static char* get_valid_ifnames()
                                ^
                                 void
  [742/1436] Compiling Objective-C object libcommon.fa.p/ui_cocoa.m.o
  ui/cocoa.m:1937:22: warning: a function declaration without a prototype is deprecated in all versions of C [-Wstrict-prototypes]
  static int cocoa_main()
                       ^
                        void

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20230425192820.34063-1-philmd@linaro.org>
---
 net/vmnet-bridged.m | 2 +-
 ui/cocoa.m          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/vmnet-bridged.m b/net/vmnet-bridged.m
index 46d2282863..76a28abe79 100644
--- a/net/vmnet-bridged.m
+++ b/net/vmnet-bridged.m
@@ -37,7 +37,7 @@ static bool validate_ifname(const char *ifname)
 }
 
 
-static char* get_valid_ifnames()
+static char* get_valid_ifnames(void)
 {
     xpc_object_t shared_if_list = vmnet_copy_shared_interface_list();
     __block char *if_list = NULL;
diff --git a/ui/cocoa.m b/ui/cocoa.m
index 168170a8a6..0c2153d17c 100644
--- a/ui/cocoa.m
+++ b/ui/cocoa.m
@@ -1934,7 +1934,7 @@ static void cocoa_clipboard_request(QemuClipboardInfo *info,
     exit(status);
 }
 
-static int cocoa_main()
+static int cocoa_main(void)
 {
     QemuThread thread;
 
-- 
2.38.1


