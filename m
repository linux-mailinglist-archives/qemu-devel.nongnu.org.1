Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C3CA788DB2
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 19:16:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZaPo-0004Qh-9Y; Fri, 25 Aug 2023 13:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZaPB-0003tR-CW
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:15:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZaP7-0001kC-GR
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692983723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s55xbyvjny6vYK5A+0zE5rtp2j1gDzbOB58lNn06NN8=;
 b=PUyKlE63hiHjMLXGHLefG5RbfARCNaXxIvgdo2ifoBBzZVXCz2f8fT99EA9gw6yK9pHdAx
 cAOwoWclwL3YxZo2mbjdis5bYEVIP5RRSA53yfGcHL5dowhr28k+lK9CcYAClggHb1cpYa
 BSoZ3nlGOPmCxD4ac1GtwSYjYTJ48TU=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-gEz00SMNN-uz49qKvGSQYQ-1; Fri, 25 Aug 2023 13:15:22 -0400
X-MC-Unique: gEz00SMNN-uz49qKvGSQYQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1c55535c088so310776fac.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 10:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692983721; x=1693588521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s55xbyvjny6vYK5A+0zE5rtp2j1gDzbOB58lNn06NN8=;
 b=kmFk+Nr+AyIfZLfLbtdFz70H2ge9CeNwXGjoFlXm6E27LL33i9P4MmqFZcy2eITYMG
 yKY8ajZo/boHnA2bGZY0H50Z/VWw+LjbzdM0p/s8CFvwO2WEDV5+BcgUdbug3E0WPK4L
 Kvf3G+uNJbm5Q8bLPRUoY3MLpw0dVyHHd2iKSdoZmOiDTsTOUW3RPyqBAmqOQRpGlun0
 9F5MNPTK19FVYHmtg35jgLLo7iQZuQQ7W7305q4986Ed0Esc7uxjzcV/nQwU3pTXBs19
 RAtLVBCcEZvkNRpIqMc0MHrmmq23rMJVj5r5oJfWd7Aj7c+dl99peYFsTvj+sVbyhtOZ
 Zvow==
X-Gm-Message-State: AOJu0YyhfAv+QLolPOyn5gS8gnnLzAnU5Y+QjW00ZWNGpA2O+6CFaqRd
 jgmTmIpQce4o4T/Myd3yMXMlpY/DcFfVpAZ4YeZyfSVMarufL2MrKrWeaPDvPPT9w3SoNhKOvkX
 XlWP+KsO0hy1WENXgHyuoG7xT8z4JGofQx0EEf5jPFhTmlwqcpmjDPjU+HZ0vG8b0nGUg+dd3
X-Received: by 2002:a05:6871:520b:b0:1c0:d0e8:8ff5 with SMTP id
 ht11-20020a056871520b00b001c0d0e88ff5mr23521419oac.1.1692983721416; 
 Fri, 25 Aug 2023 10:15:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFR0ic2fo4keP6jb+AQDAv+Y9jqjAqdMshV8/3UMPh34vmlxHdUdnhuaFY241W7ffH4dgUixg==
X-Received: by 2002:a05:6871:520b:b0:1c0:d0e8:8ff5 with SMTP id
 ht11-20020a056871520b00b001c0d0e88ff5mr23521386oac.1.1692983721049; 
 Fri, 25 Aug 2023 10:15:21 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a0cf184000000b0063cfb3fbb7esm679191qvl.16.2023.08.25.10.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 10:15:20 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 2/4] tests/migration-test: Add a test for null parameter
 setups
Date: Fri, 25 Aug 2023 13:15:15 -0400
Message-ID: <20230825171517.1215317-3-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825171517.1215317-1-peterx@redhat.com>
References: <20230825171517.1215317-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a test for StrOrNull parameters (tls-*).

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tests/qtest/migration-test.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 62d3f37021..64efee8b04 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -1471,6 +1471,26 @@ static void test_postcopy_preempt_all(void)
 
 #endif
 
+/*
+ * We have a few parameters that allows null as input, test them to make
+ * sure they won't crash (where some used to).
+ */
+static void test_null_parameters(void)
+{
+    const char *allow_null_params[] = {
+        "tls-authz", "tls-hostname", "tls-creds"};
+    QTestState *vm = qtest_init("");
+    int i;
+
+    for (i = 0; i < sizeof(allow_null_params) / sizeof(const char *); i++) {
+        qtest_qmp_assert_success(vm, "{ 'execute': 'migrate-set-parameters',"
+                                 "'arguments': { %s: null } }",
+                                 allow_null_params[i]);
+    }
+
+    qtest_quit(vm);
+}
+
 static void test_baddest(void)
 {
     MigrateStart args = {
@@ -2827,6 +2847,7 @@ int main(int argc, char **argv)
         }
     }
 
+    qtest_add_func("/migration/null_parameters", test_null_parameters);
     qtest_add_func("/migration/bad_dest", test_baddest);
     qtest_add_func("/migration/precopy/unix/plain", test_precopy_unix_plain);
     qtest_add_func("/migration/precopy/unix/xbzrle", test_precopy_unix_xbzrle);
-- 
2.41.0


