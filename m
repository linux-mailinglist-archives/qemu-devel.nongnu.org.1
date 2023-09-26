Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE17AF4DF
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlETk-0000aq-HZ; Tue, 26 Sep 2023 16:16:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETc-0000ZZ-Jh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:13 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qlETR-0002hE-Pc
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:16:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:550b:0:640:d49b:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 66C7060B72;
 Tue, 26 Sep 2023 23:15:57 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b41d::1:39])
 by mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZFWwvr0Oc0U0-NKbQtG43; Tue, 26 Sep 2023 23:15:56 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695759356;
 bh=APD63jVjpKGyXrrj8bpH2G86emsF9emrRj2IUL6CpiU=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=oo3C88nKCjN3Ji0lvH0+9qdAPAtc/i8ltal3/vMacyKT+5nqSKEP0RYTIPiLbj+vK
 BLyFVchnCDDnawg8blMqmHLRrTvq51YDBJDc8BLzvtdedK7g+r479tf7JXIuhyOxsL
 tSusOeWrYbad6qhuFGxJDCtwDgPvIZXXLLOpTP48=
Authentication-Results: mail-nwsmtp-smtp-corp-main-62.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, vsementsov@yandex-team.ru, peter.maydell@linaro.org,
 yc-core@yandex-team.ru, davydov-max@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 3/8] libvhost-user.c: add assertion to
 vu_message_read_default
Date: Tue, 26 Sep 2023 23:15:27 +0300
Message-Id: <20230926201532.221152-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230926201532.221152-1-vsementsov@yandex-team.ru>
References: <20230926201532.221152-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Explain Coverity that we are not going to overflow vmsg->fds.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 subprojects/libvhost-user/libvhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index 0469a50101..49b57c7ef4 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -322,6 +322,7 @@ vu_message_read_default(VuDev *dev, int conn_fd, VhostUserMsg *vmsg)
         if (cmsg->cmsg_level == SOL_SOCKET && cmsg->cmsg_type == SCM_RIGHTS) {
             fd_size = cmsg->cmsg_len - CMSG_LEN(0);
             vmsg->fd_num = fd_size / sizeof(int);
+            assert(fd_size < VHOST_MEMORY_BASELINE_NREGIONS);
             memcpy(vmsg->fds, CMSG_DATA(cmsg), fd_size);
             break;
         }
-- 
2.34.1


