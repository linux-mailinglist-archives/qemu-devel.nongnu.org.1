Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2620917F3A
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jun 2024 13:09:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQVT-0007vm-Os; Wed, 26 Jun 2024 07:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQVR-0007s4-2m
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:08:05 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQVL-0004xF-Ti
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:08:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fa55dbf2e7so22494505ad.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719400076; x=1720004876;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s88RDAKD9didfyWyFg4xAviSDDkSMw5Wc3QBYXQ76FI=;
 b=LUsbLGOPiS+R0WPDf5DIWcBlLG8Nv8yDKUOmPoZPyTPknIb+OWqqBPaY3VwwTL2hUa
 fz2gUe60l0d61yPEuZLy5xntqtSW5zebYreHyA3VYvycN9iFlHbvuLUfynN13Nf0UPHz
 x7nkaPdOC9hXQJ1ZbZe8V3I/c51mwgZn6BDJF1ifEwo08r5kHT2W/BwjPfhNJ0LXPaCr
 DWQ6NnKR5IO32xzHwwyluffTx3T9Z7KMU6i/xcWcYahhoPrng0AjCNROVb8S1En5P+6y
 63FuwU0zp0GO/m/Y2qu04k45ZR0YjXM/hKJQsoF9UtT41bi0Gw/LP7f0zhaJmWebnAQL
 6idg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719400076; x=1720004876;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s88RDAKD9didfyWyFg4xAviSDDkSMw5Wc3QBYXQ76FI=;
 b=bcmaR3txbL2xvRZ792OJi+3xahXpBECjt0wkBecm60fq0ggr6kBb8bxcTHIicG01qQ
 p0po/fkqCOVRDarXZ0xJ3tVWbJOJeRspk9t1Qcu+ySjOeIKUMuY6aEQZ1OwZlYo/nmCm
 ovtDuCOfdjSmdHPLnIzrc87HLUzGPAM0Qu2y78VihwgLU80M17oGtqTxDKi1/UdrLjN0
 35zgIYsJu/SJmPNpaGz695nGj8Cj/dD0jgJuifBPX6w6CD6HjuznjRekXFn+B15gPuqY
 UFhAoLAPZCpvVXtjuRM+R6bE5Toa9BUzQO1wnSqUu9tH2cwmT/tmHm3E3aMN0KjHy4rG
 3eXA==
X-Gm-Message-State: AOJu0YxeRyIqG8Rn37tAeNHev7UpSll/x30Qv/ckf5pmQW69qP1JsCIy
 12sF8WpFKSsoRSqyZkmQCU3Q5S0DR/eDwbSYKeQX8IwNWc+OliI40jMJt/1bSTk=
X-Google-Smtp-Source: AGHT+IHzTI+eaHCjNSlntryxBmmHmKVW9cUOvgNduBxD/9bFh8actwBSuXmkd8m5hlFYe6WlFS33CA==
X-Received: by 2002:a17:902:7849:b0:1fa:925b:5b6e with SMTP id
 d9443c01a7336-1fa925b5e03mr8855945ad.63.1719400076478; 
 Wed, 26 Jun 2024 04:07:56 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1f9eb3c5feesm97761515ad.161.2024.06.26.04.07.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:07:56 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Wed, 26 Jun 2024 20:06:36 +0900
Subject: [PATCH 13/14] tests/qtest: Free paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240626-san-v1-13-f3cc42302189@daynix.com>
References: <20240626-san-v1-0-f3cc42302189@daynix.com>
In-Reply-To: <20240626-san-v1-0-f3cc42302189@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

This suppresses LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 tests/qtest/qos-test.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/qos-test.c b/tests/qtest/qos-test.c
index 5da4091ec32b..114f6bef273a 100644
--- a/tests/qtest/qos-test.c
+++ b/tests/qtest/qos-test.c
@@ -33,7 +33,6 @@
 static char *old_path;
 
 
-
 /**
  * qos_set_machines_devices_available(): sets availability of qgraph
  * machines and devices.
@@ -191,6 +190,12 @@ static void subprocess_run_one_test(const void *arg)
     g_test_trap_assert_passed();
 }
 
+static void destroy_pathv(void *arg)
+{
+    g_free(((char **)arg)[0]);
+    g_free(arg);
+}
+
 /*
  * in this function, 2 path will be built:
  * path_str, a one-string path (ex "pc/i440FX-pcihost/...")
@@ -295,10 +300,13 @@ static void walk_path(QOSGraphNode *orig_path, int len)
     if (path->u.test.subprocess) {
         gchar *subprocess_path = g_strdup_printf("/%s/%s/subprocess",
                                                  qtest_get_arch(), path_str);
-        qtest_add_data_func(path_str, subprocess_path, subprocess_run_one_test);
-        g_test_add_data_func(subprocess_path, path_vec, run_one_test);
+        qtest_add_data_func_full(path_str, subprocess_path,
+                                 subprocess_run_one_test, g_free);
+        g_test_add_data_func_full(subprocess_path, path_vec,
+                                  run_one_test, destroy_pathv);
     } else {
-        qtest_add_data_func(path_str, path_vec, run_one_test);
+        qtest_add_data_func_full(path_str, path_vec,
+                                 run_one_test, destroy_pathv);
     }
 
     g_free(path_str);

-- 
2.45.2


