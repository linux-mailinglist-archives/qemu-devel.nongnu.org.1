Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5778F70685A
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 14:40:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzGQW-0006dk-JT; Wed, 17 May 2023 08:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzGQU-0006cy-PN
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:38:42 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1pzGQR-00019S-To
 for qemu-devel@nongnu.org; Wed, 17 May 2023 08:38:42 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c14:151e:0:640:1960:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id BC78C60E5F;
 Wed, 17 May 2023 15:38:31 +0300 (MSK)
Received: from vsementsov-nix.yandex.net (unknown
 [2a02:6b8:8f:4:7a31:c1ff:fef2:bf07])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id KcbvG13OqeA0-ix5w5sjD; Wed, 17 May 2023 15:38:31 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1684327111; bh=4ofp0LGBMXQq8f2S2l8U54eU5HUxYP5RGJtYg4t+i0A=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=o+8BSruU/XVs5zNsAVRL8TOoIJy1uFvk/+8eAuif5c5bzJu0x2A3UUVD0jErdYJ2/
 GlPWZ9WaarHpTQnkYuGTX5v3QYyzSiogw5KZ3OA9A2e5T22SQVL84USDX2dpvKBeeH
 bzp8alDi6bM0BMXqlnplhxBRh79sfOIJAbkLgMGE=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, leobras@redhat.com, peterx@redhat.com,
 quintela@redhat.com, vsementsov@yandex-team.ru, yc-core@yandex-team.ru
Subject: [PATCH 0/5] Restore vmstate on cancelled/failed migration
Date: Wed, 17 May 2023 15:37:47 +0300
Message-Id: <20230517123752.21615-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi all.

The problem I want to solve is that guest-panicked state may be lost
when migration is failed (or cancelled) after source stop.

Still, I try to go further and restore all possible paused states in the
same way. The key patch is the last one and others are refactoring and
preparation.

Vladimir Sementsov-Ogievskiy (5):
  runstate: add runstate_get()
  migration: never fail in global_state_store()
  runstate: drop unused runstate_store()
  migration: switch from .vm_was_running to .vm_old_state
  migration: restore vmstate on migration failure

 include/migration/global_state.h |  2 +-
 include/sysemu/runstate.h        |  2 +-
 migration/global_state.c         | 23 +++++++------
 migration/migration.c            | 56 +++++++++++++++-----------------
 migration/migration.h            |  9 +++--
 migration/savevm.c               |  6 +---
 softmmu/runstate.c               | 25 +++++++-------
 7 files changed, 59 insertions(+), 64 deletions(-)

-- 
2.34.1


