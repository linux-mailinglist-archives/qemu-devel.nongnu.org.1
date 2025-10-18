Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F4C6BED872
	for <lists+qemu-devel@lfdr.de>; Sat, 18 Oct 2025 21:11:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vACH7-0006SU-Uw; Sat, 18 Oct 2025 15:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACGk-0006NB-7R; Sat, 18 Oct 2025 15:07:10 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vACGi-0000z8-1o; Sat, 18 Oct 2025 15:07:09 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 82AE215F799;
 Sat, 18 Oct 2025 22:06:58 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3FC492F0602;
 Sat, 18 Oct 2025 22:07:02 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Chenxi Mao <maochenxi@bosc.ac.cn>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.2 12/23] block/curl.c: Use explicit long constants in
 curl_easy_setopt calls
Date: Sat, 18 Oct 2025 22:06:47 +0300
Message-ID: <20251018190702.1178893-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.2-20251018220623@cover.tls.msk.ru>
References: <qemu-stable-10.1.2-20251018220623@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: "Richard W.M. Jones" <rjones@redhat.com>

curl_easy_setopt takes a variable argument that depends on what
CURLOPT you are setting.  Some require a long constant.  Passing a
plain int constant is potentially wrong on some platforms.

With warnings enabled, multiple warnings like this were printed:

../block/curl.c: In function ‘curl_init_state’:
../block/curl.c:474:13: warning: call to ‘_curl_easy_setopt_err_long’ declared with attribute warning: curl_easy_setopt expects a long argument [-Wattribute-warning]
  474 |             curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
      |             ^

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Chenxi Mao <maochenxi@bosc.ac.cn>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009141026.4042021-2-rjones@redhat.com>
(cherry picked from commit ed26056d90ddff21351f3efd2cb47fea4f0e1d45)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/curl.c b/block/curl.c
index 00b949ea45..1102a3aa2f 100644
--- a/block/curl.c
+++ b/block/curl.c
@@ -471,11 +471,11 @@ static int curl_init_state(BDRVCURLState *s, CURLState *state)
                              (void *)curl_read_cb) ||
             curl_easy_setopt(state->curl, CURLOPT_WRITEDATA, (void *)state) ||
             curl_easy_setopt(state->curl, CURLOPT_PRIVATE, (void *)state) ||
-            curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1) ||
-            curl_easy_setopt(state->curl, CURLOPT_FOLLOWLOCATION, 1) ||
-            curl_easy_setopt(state->curl, CURLOPT_NOSIGNAL, 1) ||
+            curl_easy_setopt(state->curl, CURLOPT_AUTOREFERER, 1L) ||
+            curl_easy_setopt(state->curl, CURLOPT_FOLLOWLOCATION, 1L) ||
+            curl_easy_setopt(state->curl, CURLOPT_NOSIGNAL, 1L) ||
             curl_easy_setopt(state->curl, CURLOPT_ERRORBUFFER, state->errmsg) ||
-            curl_easy_setopt(state->curl, CURLOPT_FAILONERROR, 1)) {
+            curl_easy_setopt(state->curl, CURLOPT_FAILONERROR, 1L)) {
             goto err;
         }
         if (s->username) {
@@ -800,7 +800,7 @@ static int curl_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     s->accept_range = false;
-    if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1) ||
+    if (curl_easy_setopt(state->curl, CURLOPT_NOBODY, 1L) ||
         curl_easy_setopt(state->curl, CURLOPT_HEADERFUNCTION, curl_header_cb) ||
         curl_easy_setopt(state->curl, CURLOPT_HEADERDATA, s)) {
         pstrcpy(state->errmsg, CURL_ERROR_SIZE,
diff --git a/contrib/elf2dmp/download.c b/contrib/elf2dmp/download.c
index 21306b3fd4..fa8da0f9a2 100644
--- a/contrib/elf2dmp/download.c
+++ b/contrib/elf2dmp/download.c
@@ -27,8 +27,8 @@ bool download_url(const char *name, const char *url)
     if (curl_easy_setopt(curl, CURLOPT_URL, url) != CURLE_OK
             || curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, NULL) != CURLE_OK
             || curl_easy_setopt(curl, CURLOPT_WRITEDATA, file) != CURLE_OK
-            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1) != CURLE_OK
-            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0) != CURLE_OK
+            || curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L) != CURLE_OK
+            || curl_easy_setopt(curl, CURLOPT_NOPROGRESS, 0L) != CURLE_OK
             || curl_easy_perform(curl) != CURLE_OK) {
         unlink(name);
         fclose(file);
-- 
2.47.3


