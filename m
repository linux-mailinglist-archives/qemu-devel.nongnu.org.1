Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38D96EB32
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Sep 2024 08:59:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSst-0000M8-K5; Fri, 06 Sep 2024 02:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSsn-0008FM-Hn; Fri, 06 Sep 2024 02:55:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSsl-0003Hk-1D; Fri, 06 Sep 2024 02:55:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8E57F8C244;
 Fri,  6 Sep 2024 09:53:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 569901333FC;
 Fri,  6 Sep 2024 09:54:30 +0300 (MSK)
Received: (nullmailer pid 43414 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 15/53] util/async.c: Forbid negative min/max in
 aio_context_set_thread_pool_params()
Date: Fri,  6 Sep 2024 09:53:45 +0300
Message-Id: <20240906065429.42415-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Peter Maydell <peter.maydell@linaro.org>

aio_context_set_thread_pool_params() takes two int64_t arguments to
set the minimum and maximum number of threads in the pool.  We do
some bounds checking on these, but we don't catch the case where the
inputs are negative.  This means that later in the function when we
assign these inputs to the AioContext::thread_pool_min and
::thread_pool_max fields, which are of type int, the values might
overflow the smaller type.

A negative number of threads is meaningless, so make
aio_context_set_thread_pool_params() return an error if either min or
max are negative.

Resolves: Coverity CID 1547605
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240723150927.1396456-1-peter.maydell@linaro.org
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
(cherry picked from commit 851495571d14fe2226c52b9d423f88a4f5460836)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/async.c b/util/async.c
index 8f90ddc304..86d2910481 100644
--- a/util/async.c
+++ b/util/async.c
@@ -758,7 +758,7 @@ void aio_context_set_thread_pool_params(AioContext *ctx, int64_t min,
                                         int64_t max, Error **errp)
 {
 
-    if (min > max || !max || min > INT_MAX || max > INT_MAX) {
+    if (min > max || max <= 0 || min < 0 || min > INT_MAX || max > INT_MAX) {
         error_setg(errp, "bad thread-pool-min/thread-pool-max values");
         return;
     }
-- 
2.39.2


