Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F657CC4A2
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:20:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjg9-0005oj-TH; Tue, 17 Oct 2023 09:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsjg2-0005mq-HG
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:00:03 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsjg0-0003Y1-H2
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:00:01 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id BF5DF616E4;
 Tue, 17 Oct 2023 15:59:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gxjRqEIOdGk0-28ARftey; Tue, 17 Oct 2023 15:59:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697547598;
 bh=K2NSR9gc5d8TtCzYn8PXvc/opLX6Fela1pBElbq7QwU=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=pVEXEB3bUVwRPUrJdadUfR2ybt6LkcWM6oLVF2xwmux0LGiP0xulvgokhQSNyL4gf
 WLYfzBZbs+jTxY9M+RMOs2qJ0kELFyoTggg9495DfsWsfGSSL2osyF/ZDWMrNKZiv/
 PPOWHUymMvf/q1+G0SHV15unhEq0XQM76MiFHaB0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 6/6] io/channel-socket: qio_channel_socket_flush(): improve
 msg validation
Date: Tue, 17 Oct 2023 15:59:41 +0300
Message-Id: <20231017125941.810461-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017125941.810461-1-vsementsov@yandex-team.ru>
References: <20231017125941.810461-1-vsementsov@yandex-team.ru>
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
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
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


