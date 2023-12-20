Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC775819B9E
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Dec 2023 10:44:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFt5L-0002cw-3P; Wed, 20 Dec 2023 04:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5H-0002bu-J2
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rFt5E-0005mG-1C
 for qemu-devel@nongnu.org; Wed, 20 Dec 2023 04:41:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703065303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EUdSw9i/DzOMtmTDE3qXLAOOmPNMBRzeMyzZekMOjZ8=;
 b=g0E1YNjLypWXxL0EpeVTUWfKiLts1hdp48QH+3wamzbqN/69cXT0icOC632i2MvnksRZvB
 8Fwr9spZOx0IyvehodxRJRx94MskBG3N3rrHa/QJeZ1QXfZBd3k8lE2GE1mfw8WpMYxa32
 N5WEditef6vdYUurrs7zaHCZjW92f0E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-iXBIiGg2M8e2s3FwcSNf-g-1; Wed, 20 Dec 2023 04:41:39 -0500
X-MC-Unique: iXBIiGg2M8e2s3FwcSNf-g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F9E9803916;
 Wed, 20 Dec 2023 09:41:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.167])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 17B382166B31;
 Wed, 20 Dec 2023 09:41:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 16/19] tests/qtest/npcm7xx_pwm-test: Only do full testing in
 slow mode
Date: Wed, 20 Dec 2023 10:41:02 +0100
Message-ID: <20231220094105.6588-17-thuth@redhat.com>
In-Reply-To: <20231220094105.6588-1-thuth@redhat.com>
References: <20231220094105.6588-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The npcm7xx_pwm-test can take quite a while when running with
--enable-debug on a loaded system. The tests here are quite
repetitive - by default it should be fine if we only execute
some of them and only execute all when running in slow testing mode.

Message-ID: <20231215143524.49241-1-thuth@redhat.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/npcm7xx_pwm-test.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/npcm7xx_pwm-test.c b/tests/qtest/npcm7xx_pwm-test.c
index ea4ca1d106..b53a43c417 100644
--- a/tests/qtest/npcm7xx_pwm-test.c
+++ b/tests/qtest/npcm7xx_pwm-test.c
@@ -606,6 +606,7 @@ static void test_toggle(gconstpointer test_data)
     uint32_t ppr, csr, pcr, cnr, cmr;
     int i, j, k, l;
     uint64_t expected_freq, expected_duty;
+    int cnr_step = g_test_quick() ? 2 : 1;
 
     mft_init(qts, td);
 
@@ -618,7 +619,7 @@ static void test_toggle(gconstpointer test_data)
             csr = csr_list[j];
             pwm_write_csr(qts, td, csr);
 
-            for (k = 0; k < ARRAY_SIZE(cnr_list); ++k) {
+            for (k = 0; k < ARRAY_SIZE(cnr_list); k += cnr_step) {
                 cnr = cnr_list[k];
                 pwm_write_cnr(qts, td, cnr);
 
@@ -678,6 +679,7 @@ static void pwm_add_test(const char *name, const TestData* td,
 int main(int argc, char **argv)
 {
     TestData test_data_list[ARRAY_SIZE(pwm_module_list) * ARRAY_SIZE(pwm_list)];
+    int pwm_module_list_cnt = 1, pwm_list_cnt = 1;
 
     char *v_env = getenv("V");
 
@@ -687,8 +689,13 @@ int main(int argc, char **argv)
 
     g_test_init(&argc, &argv, NULL);
 
-    for (int i = 0; i < ARRAY_SIZE(pwm_module_list); ++i) {
-        for (int j = 0; j < ARRAY_SIZE(pwm_list); ++j) {
+    if (!g_test_quick()) {
+        pwm_module_list_cnt = ARRAY_SIZE(pwm_module_list);
+        pwm_list_cnt = ARRAY_SIZE(pwm_list);
+    }
+
+    for (int i = 0; i < pwm_module_list_cnt; ++i) {
+        for (int j = 0; j < pwm_list_cnt; ++j) {
             TestData *td = &test_data_list[i * ARRAY_SIZE(pwm_list) + j];
 
             td->module = &pwm_module_list[i];
-- 
2.43.0


