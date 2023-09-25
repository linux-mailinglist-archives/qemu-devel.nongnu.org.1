Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 648147ADFAE
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 21:42:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrSJ-0002hd-So; Mon, 25 Sep 2023 15:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSH-0002fo-IB
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:17 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qkrSE-0004mx-1n
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 15:41:17 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id A246C6373E;
 Mon, 25 Sep 2023 22:41:11 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:6422::1:2a])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id geUBjG0OhCg0-6y8RApFp; Mon, 25 Sep 2023 22:41:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695670871;
 bh=3MG107ct8Ug6ljNO236hrBkDgC4FelsYjZS2SdUxMYM=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=wqVpT8lbJncgL1EtXeJNFufIxjNy0HuwBM9KyBc2xw3Opa3e/y/rusX4r/nvUhzvb
 sHgLNiZjJLPOEw6Yu+VdJGoe2WLZBJt9IjFAFo85594ZUMDQN0uLM3YD5qayXTvj0h
 9Ob57AoldyPR7LFm6A73qy2QW7I5KeK5aPZpJOtQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 06/12] mc146818rtc: rtc_set_time(): initialize tm to zeroes
Date: Mon, 25 Sep 2023 22:40:34 +0300
Message-Id: <20230925194040.68592-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925194040.68592-1-vsementsov@yandex-team.ru>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

set_time() function doesn't set all the fields, so it's better to
initialize tm structure. And Coverity will be happier about it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/rtc/mc146818rtc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index c27c362db9..b63e1aeaea 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -599,7 +599,7 @@ static void rtc_get_time(MC146818RtcState *s, struct tm *tm)
 
 static void rtc_set_time(MC146818RtcState *s)
 {
-    struct tm tm;
+    struct tm tm = {0};
     g_autofree const char *qom_path = object_get_canonical_path(OBJECT(s));
 
     rtc_get_time(s, &tm);
-- 
2.34.1


