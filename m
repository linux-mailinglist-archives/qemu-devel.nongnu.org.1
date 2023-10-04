Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 095827B7EBB
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:07:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo0c8-0004PW-7d; Wed, 04 Oct 2023 08:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Zi-0000ZJ-I1
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:02:03 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qo0Zg-0001Dk-At
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:01:58 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31f71b25a99so2000258f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696420914; x=1697025714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JFR7669aVf4KyLNHSFRJbfPNWIK7DIVGhVdjQEp6ZNY=;
 b=c410cBrinHdXKPh/0GXFNIujJc8p4HC82P2XH8G4B3vdYLUvxsIUdRnhmrvAD/dkeX
 cuPjaKXmXo23PPNdFeV8KdzLJMk9XNArzbfyVT6ygFFdq+mo838RliNJ3YjWdT/rUNCz
 doDJqYQIIhuXp5WaseOgHjy3Y9LK9ZA/4lPy2mGeHTiwIjcfzs9KETQRggujMmPozxF+
 R6P3uxxLgGR4d7JgI2N7pALGnRhlwHX1Vt/JiV3qldwsHgERQEbI0AVEMtf3bZoMI48w
 pHay0DIcmyCZN8mcS1MtyM7fAkpK6aYAnGd1lMxTvhY7yEZ+jGE4IBpltUDtFlTz1avG
 Pyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696420914; x=1697025714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JFR7669aVf4KyLNHSFRJbfPNWIK7DIVGhVdjQEp6ZNY=;
 b=ZztG/2bvfdhRKqFyE1+mQlMx6VvlztduCB2ZPql8w1NQlOeH/Xa2CoPxLjxOlLuxpg
 OGzR+udvZRYHsM0RFqOOGsdgHd3inny2K6JkoK0ZVtpw2OUwGT4+t4b9YOaw4fwlblbm
 y+F1T0dGGmteRzuEN/1DK2jaaLFsnKCKuz2LOpQV2ZeuN+xmhQNKo0Gd1dwQsTELE6dP
 GxQxsFZanfJoaTsCUQPmXmhM/l0iWGoIfOqldjuPGvNXX4Jh2KE1Cd3lSAzCjaGLPovP
 Q60RJ2ixWaPEVEj7OyQlGSOZJ6DBctASz11MY1CRoEu7Lx++GtvKOlzyu5QIxmrGtK7I
 lpwA==
X-Gm-Message-State: AOJu0YyY22Yjq0JLlgKzSacPM+mfbyLAWOZVoJZhn9V2c39CDfk78le1
 qGoxpD1aFVn+Kg18GvuJIrHWh4ZMQ7ecFOaxOYs=
X-Google-Smtp-Source: AGHT+IHZ41iGInbPZOVU8UhgLtndX8zP3LDRDVfJV5h821e+xsqPNMXYAvE4PA2cB5n8T97TgZh+Xw==
X-Received: by 2002:a5d:4586:0:b0:321:5e2f:37e1 with SMTP id
 p6-20020a5d4586000000b003215e2f37e1mr1904926wrq.19.1696420912872; 
 Wed, 04 Oct 2023 05:01:52 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 q4-20020a5d5744000000b003231a0ca5ebsm3819548wrw.49.2023.10.04.05.01.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 05:01:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: [PATCH v3 15/16] sysemu/tpm: Clean up global variable shadowing
Date: Wed,  4 Oct 2023 14:00:18 +0200
Message-ID: <20231004120019.93101-16-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004120019.93101-1-philmd@linaro.org>
References: <20231004120019.93101-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

  softmmu/tpm.c:178:59: error: declaration shadows a variable in the global scope [-Werror,-Wshadow]
  int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
                                                            ^
  /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/include/getopt.h:77:14: note: previous declaration is here
  extern char *optarg;                    /* getopt(3) external variables */
               ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/sysemu/tpm.h | 2 +-
 softmmu/tpm.c        | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 66e3b45f30..1ee568b3b6 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -17,7 +17,7 @@
 
 #ifdef CONFIG_TPM
 
-int tpm_config_parse(QemuOptsList *opts_list, const char *optarg);
+int tpm_config_parse(QemuOptsList *opts_list, const char *optstr);
 int tpm_init(void);
 void tpm_cleanup(void);
 
diff --git a/softmmu/tpm.c b/softmmu/tpm.c
index 578563f05a..7164ea7ff1 100644
--- a/softmmu/tpm.c
+++ b/softmmu/tpm.c
@@ -175,15 +175,15 @@ int tpm_init(void)
  * Parse the TPM configuration options.
  * To display all available TPM backends the user may use '-tpmdev help'
  */
-int tpm_config_parse(QemuOptsList *opts_list, const char *optarg)
+int tpm_config_parse(QemuOptsList *opts_list, const char *optstr)
 {
     QemuOpts *opts;
 
-    if (!strcmp(optarg, "help")) {
+    if (!strcmp(optstr, "help")) {
         tpm_display_backend_drivers();
         return -1;
     }
-    opts = qemu_opts_parse_noisily(opts_list, optarg, true);
+    opts = qemu_opts_parse_noisily(opts_list, optstr, true);
     if (!opts) {
         return -1;
     }
-- 
2.41.0


