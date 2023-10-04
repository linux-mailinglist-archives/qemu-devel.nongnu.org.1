Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DEE7B7EAB
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:07:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0b7-0002nh-5m; Wed, 04 Oct 2023 08:03:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Yv-000092-0u
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Yq-00011W-BD
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:08 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-40651a726acso19299245e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420859; x=1697025659; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZOn2Cyb3kswX+CAOC8A0GBq7vdEIRLvrDWoI8N+PSM=;
 b=t3mZf4PtJVLMY4/kl0HRxnfPOoBa9YnDkkb9yvlyyduFx6EFr6I727reDsUeEsuo6h
 y/2Wg/mx+ccf3R0ayfVo1lrJf9cxtChYQ+iOPvBPNYNDAah9dvaQ8xdk58Z3qc0SG6PE
 z9lAMtQjPfGTz56HEGV4AE9CtMtllbNnP2xKvLhIIU+3mOIpK/o7mDSuJ5sllcVXyBPb
 1+IIEHsm3OFbUvHUz4Bay98PexVcRbC4d3bKNF3NDgGl4NVxAyxhvSnv4AfpKpS6WXf9
 6PPGYA3upfHf9m/0sAXGgyd+r8/pOujs49YwKflOyLA9b3YGwBaqz4RU+ACmjoDfJ7E8
 cI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420859; x=1697025659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DZOn2Cyb3kswX+CAOC8A0GBq7vdEIRLvrDWoI8N+PSM=;
 b=aPss3uRHuCduajEXU/t0Dd7SrVZjfK3WKN1bGGVVAYV9KXfWpe9d9tcZ+pRTbnyhgd
 HPNKM9Ab3k4Gmztw6T2RwO85g9ULAh0cN20pIRonmWI6Qp+gh+nhrm8jGOR9iVKAECJC
 JbYxe8p11lN/DCYMrkM6O5uLr5UBmtqc4j3o+gH0odTrRoTE/fULqh5tUF59/CI+ex4Y
 vPmqyw4wQNfmHO6GXcUko2wzO8sLG13zDFbeQdRZ7oqaUkViHBBeYvGDnlNQnSEBGuHg
 YwAS+1n34pBSrz33390pZ1BbQpRxSLSTpMo4yll8ISu16KYqg3WY7/PU/gVGU19hinb/
 3iWg==
X-Gm-Message-State: AOJu0YxeYrKZA9H7hDaiycPtw3kEMurm/xqmhc+Kfwu9CFpdxrDSlY7s
 RWPxYMFHQaEFazJev3/x6yGkT8cKO8Mpfa5sLf4=
X-Google-Smtp-Source: AGHT+IEeZMe+THQCTIWqRpKf2iDMGPxGxlm3EB5Lukifxoa7+fPWeRy/68FE34HyipEy5zM8UcrGQg==
X-Received: by 2002:a1c:7710:0:b0:405:3ee3:c69c with SMTP id
 t16-20020a1c7710000000b004053ee3c69cmr2222087wmi.15.1696420858586; 
 Wed, 04 Oct 2023 05:00:58 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 y11-20020a05600c364b00b004063977eccesm1346353wmq.42.2023.10.04.05.00.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:00:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v3 06/16] qemu-img: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:09 +0200
Message-ID: <20231004120019.93101-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

  qemu-img.c:247:46: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static bool is_valid_option_list(const char *optarg)
                                               ^
  qemu-img.c:265:53: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  static int accumulate_options(char **options, char *optarg)
                                                      ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qemu-img.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index a48edb7101..6068ab0d27 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -235,25 +235,25 @@ void help(void)
 }
 
 /*
- * Is @optarg safe for accumulate_options()?
+ * Is @list safe for accumulate_options()?
  * It is when multiple of them can be joined together separated by ','.
- * To make that work, @optarg must not start with ',' (or else a
+ * To make that work, @list must not start with ',' (or else a
  * separating ',' preceding it gets escaped), and it must not end with
  * an odd number of ',' (or else a separating ',' following it gets
  * escaped), or be empty (or else a separating ',' preceding it can
  * escape a separating ',' following it).
  * 
  */
-static bool is_valid_option_list(const char *optarg)
+static bool is_valid_option_list(const char *list)
 {
-    size_t len = strlen(optarg);
+    size_t len = strlen(list);
     size_t i;
 
-    if (!optarg[0] || optarg[0] == ',') {
+    if (!list[0] || list[0] == ',') {
         return false;
     }
 
-    for (i = len; i > 0 && optarg[i - 1] == ','; i--) {
+    for (i = len; i > 0 && list[i - 1] == ','; i--) {
     }
     if ((len - i) % 2) {
         return false;
@@ -262,19 +262,19 @@ static bool is_valid_option_list(const char *optarg)
     return true;
 }
 
-static int accumulate_options(char **options, char *optarg)
+static int accumulate_options(char **options, char *list)
 {
     char *new_options;
 
-    if (!is_valid_option_list(optarg)) {
-        error_report("Invalid option list: %s", optarg);
+    if (!is_valid_option_list(list)) {
+        error_report("Invalid option list: %s", list);
         return -1;
     }
 
     if (!*options) {
-        *options = g_strdup(optarg);
+        *options = g_strdup(list);
     } else {
-        new_options = g_strdup_printf("%s,%s", *options, optarg);
+        new_options = g_strdup_printf("%s,%s", *options, list);
         g_free(*options);
         *options = new_options;
     }
-- 
2.41.0


