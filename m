Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B37A57B7EAC
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0bc-0003pA-TK; Wed, 04 Oct 2023 08:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZS-0000R0-3s
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:45 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0ZN-00018I-Si
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:40 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-32167a4adaaso1961090f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420895; x=1697025695; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8JtBXMzpsFb0+ye9vGJHcom9MCYcPPJwy9i7R/QePcg=;
 b=ZAJIIhDLyaN90sKwwdR94n4Fl46z0zReNcEbd+Ml/rh/lASraSRMUNXgDS1puqsvN+
 Hp3qqiwscoxMsVOaCiei1IS9QPIF2N7Zd33DRMVTdjiLpUGIzspid5q1+pCkWbgU0Hxz
 GX5DBgqN0kQYFtHGusMAIeNTwd3/m1iqcdzWRPHWbyBbE5wbCpVLUTgTCs3HgG3CBYAp
 T4f6c8C3lLqXG9dY5nV3YLmDa33XjFu12cdAhB9sOn+4x4a7NNWNqJaCTdlGCts1coRp
 AVFM2Gp/lJch0bqdbvcJdFWiqfK7RtzyVoglSiVOU8+49WgLUxCFbWfCz0YUtOr+PQ4E
 rLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420895; x=1697025695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8JtBXMzpsFb0+ye9vGJHcom9MCYcPPJwy9i7R/QePcg=;
 b=hs1ShJ/8fUy53YwUeto2usWnHscewqaVj25HSP8GVXfZ6kQhmc1kDk47rt7A5N4OP+
 h72kfCH9S9aoXM7vy1B1RI0MIM2nCPivwZoXGxj92LLVvG+7jR/bVred01t/faAnqUVL
 wWEMJ4Z2Dnyx9+QuMSK048yf+W/5u/AqV7sh/P2OmGGk0n1BeCdEDSYch5IhDB/STNry
 4CI/vizu2ZB5E9iqmgZmRgmkJwzUwXp2mVDAFYIYQivCQCKTc9h9Xt63UA1/2UGxJq3K
 QdFfoCTEWQ9lcJX3EmSyfFz17XhCFJ6D+Gcejk8kxbYaHc+eXN/nJ1v9byhJ1Uex3K3q
 UGtA==
X-Gm-Message-State: AOJu0Yyi6eV0boeQiqaKQTZ/HwSVmPCEDTgOyJXCf0aVBuxqF7YB7wMg
 +p2BFMtwa233+jlttWAEXEzL3bvbiJOsKNSBbbI=
X-Google-Smtp-Source: AGHT+IHqMtwgwiEgtBRQ+8KlhWpc5r5Vy0rjEsgW/c1jEnfpdOjs0WNaZOyTv9eQsoC41k00n9t3vw==
X-Received: by 2002:adf:f00e:0:b0:323:30bb:f19c with SMTP id
 j14-20020adff00e000000b0032330bbf19cmr1961403wro.10.1696420895001; 
 Wed, 04 Oct 2023 05:01:35 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 o13-20020a5d408d000000b003232380ffd7sm3833760wrp.102.2023.10.04.05.01.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:01:34 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/16] util/guest-random: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:15 +0200
Message-ID: <20231004120019.93101-13-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

  util/guest-random.c:90:45: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  int qemu_guest_random_seed_main(const char *optarg, Error **errp)
                                              ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/guest-random.h | 8 ++++----
 util/guest-random.c         | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/qemu/guest-random.h b/include/qemu/guest-random.h
index 09ff9c2236..5060d49d60 100644
--- a/include/qemu/guest-random.h
+++ b/include/qemu/guest-random.h
@@ -13,16 +13,16 @@
 #define QEMU_GUEST_RANDOM_H
 
 /**
- * qemu_guest_random_seed_main(const char *optarg, Error **errp)
- * @optarg: a non-NULL pointer to a C string
+ * qemu_guest_random_seed_main(const char *seedstr, Error **errp)
+ * @seedstr: a non-NULL pointer to a C string
  * @errp: an error indicator
  *
- * The @optarg value is that which accompanies the -seed argument.
+ * The @seedstr value is that which accompanies the -seed argument.
  * This forces qemu_guest_getrandom into deterministic mode.
  *
  * Returns 0 on success, < 0 on failure while setting *errp.
  */
-int qemu_guest_random_seed_main(const char *optarg, Error **errp);
+int qemu_guest_random_seed_main(const char *seedstr, Error **errp);
 
 /**
  * qemu_guest_random_seed_thread_part1(void)
diff --git a/util/guest-random.c b/util/guest-random.c
index 9465dda085..33607d5ff2 100644
--- a/util/guest-random.c
+++ b/util/guest-random.c
@@ -87,11 +87,11 @@ void qemu_guest_random_seed_thread_part2(uint64_t seed)
     }
 }
 
-int qemu_guest_random_seed_main(const char *optarg, Error **errp)
+int qemu_guest_random_seed_main(const char *seedstr, Error **errp)
 {
     uint64_t seed;
-    if (parse_uint_full(optarg, 0, &seed)) {
-        error_setg(errp, "Invalid seed number: %s", optarg);
+    if (parse_uint_full(seedstr, 0, &seed)) {
+        error_setg(errp, "Invalid seed number: %s", seedstr);
         return -1;
     } else {
         deterministic = true;
-- 
2.41.0


