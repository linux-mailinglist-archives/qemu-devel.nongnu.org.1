Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A82F7B7EA3
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:05:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0c7-0004Jh-8p; Wed, 04 Oct 2023 08:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Zy-0000iQ-14
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:02:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Zm-0001H2-2r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:02:09 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4064867903cso20899025e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420920; x=1697025720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bBGVE0DoG3fp73QBVo0q6OJfPVhOCAa/aXxiQ7+SOqM=;
 b=TE5CK8a90U5D2mlq/2X2jrpsmiQUwjjXA9laJk8hU817U+l+11qJY10K4lIBmprLry
 KqJ97qNrifVn40AAId2BxJ8o5btJP9uxzHJqlR+a6uK6i3Z3aOR62xedab7oQDpHFp3K
 7kak/o9wcyV8B6PclALOz/PtUlRyuM/JRHSiU41ERffu3C3Q6YeAmThSVyPdhEEvmPbi
 6KXBKv1fL/c0yK0xyYXG5BVQ4glqQCLQ25+bIE2Rm4nIx+tDHBl/dQrHzT1Hnb50ICBP
 1/9K4uTRO9+It/SfNQDKBgcSMNtplzqNz1stmkPo7acO0fYmjjYimrochHTZVbh4VTiw
 ej5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420920; x=1697025720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bBGVE0DoG3fp73QBVo0q6OJfPVhOCAa/aXxiQ7+SOqM=;
 b=WzEQCBsKzCYoYSOh+mda13gC09Fk64CseFE4cspMkyL7fLnB1B0k6fg/htQBa+wY90
 pla5rS5vyxAM4bbtKqjMgyG/lxCkzP8IRtqPSOakZQfN4qiL/TOjswbNGsJvLGq7yZsd
 prgOwLRwOCZqb3DJoe32c5Ni+Jyaj9rpAbdewndpfTo/A3HDyJDw8V/oKtACTHa21Ggk
 kHaSBQ66KM6QZna287k316Il49C6a8G1j1dWAEQtzTUCLenkwBI3WRe1kjaLHCngFb8y
 qSWW/Wm7L0NmKHXzCKDUowpV3+Gonqy7Mmn1RNEdvTr9eXSd2TknanhwCU0exmLweQs8
 aCTQ==
X-Gm-Message-State: AOJu0Yy8LD1JUfoOvfIqQqLqWoQ1aYi1Y0X15OAkyMz/tBJRXaJScmRq
 5o1M3SwEVLXziftknFtQRCV/QzBh/+NQ4BK7s38=
X-Google-Smtp-Source: AGHT+IFKBiCh3mm7umXWjhYGHybFCd7VpPslSYNol+gjEruY4r/GKaSlgvsZ8tS/yjSxFEIR6zFveg==
X-Received: by 2002:a1c:ed17:0:b0:406:7d74:a29e with SMTP id
 l23-20020a1ced17000000b004067d74a29emr2149020wmh.19.1696420919371; 
 Wed, 04 Oct 2023 05:01:59 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 q23-20020a7bce97000000b003feea62440bsm1351186wmj.43.2023.10.04.05.01.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:01:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v3 16/16] trace/control: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:19 +0200
Message-ID: <20231004120019.93101-17-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

  trace/control.c:288:34: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  void trace_opt_parse(const char *optarg)
                                   ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 trace/control.h | 4 ++--
 trace/control.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/trace/control.h b/trace/control.h
index dfd209edd8..6754bfe052 100644
--- a/trace/control.h
+++ b/trace/control.h
@@ -197,11 +197,11 @@ extern QemuOptsList qemu_trace_opts;
 
 /**
  * trace_opt_parse:
- * @optarg: A string argument of --trace command line argument
+ * @optstr: A string argument of --trace command line argument
  *
  * Initialize tracing subsystem.
  */
-void trace_opt_parse(const char *optarg);
+void trace_opt_parse(const char *optstr);
 
 /**
  * trace_get_vcpu_event_count:
diff --git a/trace/control.c b/trace/control.c
index 1a48a7e266..ef107829ac 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -285,10 +285,10 @@ bool trace_init_backends(void)
     return true;
 }
 
-void trace_opt_parse(const char *optarg)
+void trace_opt_parse(const char *optstr)
 {
     QemuOpts *opts = qemu_opts_parse_noisily(qemu_find_opts("trace"),
-                                             optarg, true);
+                                             optstr, true);
     if (!opts) {
         exit(1);
     }
-- 
2.41.0


