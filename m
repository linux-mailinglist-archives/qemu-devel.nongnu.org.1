Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF067B2E7E
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 10:54:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9ET-0006VB-Qo; Fri, 29 Sep 2023 04:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qm9EI-0006Fv-8e
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:10 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1qm9EB-0005oC-8L
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 04:52:09 -0400
Received: from pasha-ThinkPad-X280.intra.ispras.ru (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 8DCA74076749;
 Fri, 29 Sep 2023 08:51:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 8DCA74076749
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1695977505;
 bh=baCpMjxJgDmEAn3Ne00ctKK+RUYSBlKNzGAMXkeLkGo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qBxehL3/uYlvH03CS4EWyb/nivbsPKOhxao1pm7JaWSl7uFczoxAC2ZzRPjOoQHPO
 5HD2QOIt5h8BYtIpdjiKunhqGxkHu+/1W+4aa2KUMeVx7kndVJ5tJRgbXLd/J71rxu
 Qxqitwrpg484g0gzNvNMpHZ2qP/oxB8wEwJsuDPI=
From: pavel.dovgalyuk@ispras.ru
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, crosa@redhat.com, wainersm@redhat.com, bleal@redhat.com,
 alex.bennee@linaro.org, mst@redhat.com, rafael.pizarrosolar@epfl.ch,
 jasowang@redhat.com, Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: [PATCH 3/3] replay: fix for loading non-replay snapshots
Date: Fri, 29 Sep 2023 11:51:21 +0300
Message-Id: <20230929085121.848482-4-pavel.dovgalyuk@ispras.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929085121.848482-1-pavel.dovgalyuk@ispras.ru>
References: <20230929085121.848482-1-pavel.dovgalyuk@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>

Snapshots created in regular icount execution mode can't be loaded
in recording mode, because icount value advances only by 32-bit value.
This patch initializes replay icount initial value after loading
the snapshot.

Cc: Pizarro Solar Rafael Ulises Luzius <rafael.pizarrosolar@epfl.ch>
Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
---
 replay/replay-snapshot.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 10a7cf7992..1e32ada1f6 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -75,6 +75,7 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
+            replay_state.current_icount = replay_get_current_icount();
             if (!save_snapshot(replay_snapshot,
                                true, NULL, false, NULL, &err)) {
                 error_report_err(err);
-- 
2.34.1


