Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7307CCAFB
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 20:46:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsp4B-0005vG-EY; Tue, 17 Oct 2023 14:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsp42-0005oI-G1; Tue, 17 Oct 2023 14:45:11 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qsp3u-0004s6-6u; Tue, 17 Oct 2023 14:45:09 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:750a:0:640:e46:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id CFF3B62074;
 Tue, 17 Oct 2023 21:44:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:8006::1:24])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jipbAUIOliE0-IqKhOBGu; Tue, 17 Oct 2023 21:44:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1697568296;
 bh=6xICqA92J5ff5XtYzIjy3J2hFySxHxivhOeN5jejcHQ=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=LW60jhi/t18S2q0WdzxVuAyRZ6uD/OMpVFuSYWpOZraQQhg7RgRSwDNDZp5ISM1lp
 RqEkIzHkMBUZtV1sjm3ljXRvFwnvv+RFJ3b8PmDV7GPslBbrl9GiHMhue3dA4Ld4DQ
 L3+zxqYinTAfWjAT0Jqm47VU2qnqgYCu8Ktaa/iM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com, den@openvz.org,
 alexander.ivanov@virtuozzo.com, vsementsov@yandex-team.ru
Subject: [PATCH v8 1/7] block-backend: blk_root(): drop const specifier on
 return type
Date: Tue, 17 Oct 2023 21:44:38 +0300
Message-Id: <20231017184444.932733-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017184444.932733-1-vsementsov@yandex-team.ru>
References: <20231017184444.932733-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We'll need get non-const child pointer for graph modifications in
further commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/block-backend.c                       | 2 +-
 include/sysemu/block-backend-global-state.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 39aac1bbce..fdf7597277 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -2897,7 +2897,7 @@ int coroutine_fn blk_co_copy_range(BlockBackend *blk_in, int64_t off_in,
                               bytes, read_flags, write_flags);
 }
 
-const BdrvChild *blk_root(BlockBackend *blk)
+BdrvChild *blk_root(BlockBackend *blk)
 {
     GLOBAL_STATE_CODE();
     return blk->root;
diff --git a/include/sysemu/block-backend-global-state.h b/include/sysemu/block-backend-global-state.h
index 49c12b0fa9..ccb35546a1 100644
--- a/include/sysemu/block-backend-global-state.h
+++ b/include/sysemu/block-backend-global-state.h
@@ -126,7 +126,7 @@ void blk_set_force_allow_inactivate(BlockBackend *blk);
 bool blk_register_buf(BlockBackend *blk, void *host, size_t size, Error **errp);
 void blk_unregister_buf(BlockBackend *blk, void *host, size_t size);
 
-const BdrvChild *blk_root(BlockBackend *blk);
+BdrvChild *blk_root(BlockBackend *blk);
 
 int blk_make_empty(BlockBackend *blk, Error **errp);
 
-- 
2.34.1


