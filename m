Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E597AF4DE
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:17:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlETi-0000Zf-GA; Tue, 26 Sep 2023 16:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETZ-0000Y4-NT
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:09 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETU-0002jI-VX
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id 7D9F96071F;
 Tue, 26 Sep 2023 23:16:02 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZFWwvr0Oc0U0-y1u5B3CV; Tue, 26 Sep 2023 23:16:01 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695759361;
 bh=ou8GZudm1QVqrgm1YLFWVUTc0Kur2k7RwKAHeFH0CfY=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mZM5/tXe7cjK24YfsmPSl0eoQ+fJXBWeooqSuTBntaZeseLzWaLyIw/1JpMuuPqPv
 Ko18HD7wMSIy37ebpf4jxS4/3w89kZAph3dMYITZIrzrVDqZxZi6DsQZ4PSYF+TtHr
 qi0zGetElc/TqXwFOXSz+0YtAnLBDfQHZ7yrSoPY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru, peter.maydell@linaro.org,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 8/8] io/channel-socket: qio_channel_socket_flush(): improve
 msg validation
Date: Tue, 26 Sep 2023 23:15:32 +0300
Message-Id: <20230926201532.221152-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926201532.221152-1-vsementsov@yandex-team.ru>
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
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

For SO_EE_ORIGIN_ZEROCOPY the 32-bit notification range is encoded
as [ee_info, ee_data] inclusively, so ee_info should be less or
equal to ee_data.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 io/channel-socket.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/io/channel-socket.c b/io/channel-socket.c
index 02ffb51e99..3a899b0608 100644
--- a/io/channel-socket.c
+++ b/io/channel-socket.c
@@ -782,6 +782,11 @@ static int qio_channel_socket_flush(QIOChannel *ioc,
                              "Error not from zero copy");
             return -1;
         }
+        if (serr->ee_data < serr->ee_info) {
+            error_setg_errno(errp, serr->ee_origin,
+                             "Wrong notification bounds");
+            return -1;
+        }
 
         /* No errors, count successfully finished sendmsg()*/
         sioc->zero_copy_sent += serr->ee_data - serr->ee_info + 1;
-- 
2.34.1


