Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 176B17A5F74
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 12:25:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiXu0-0006KL-I7; Tue, 19 Sep 2023 06:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qiXti-0006IY-UQ; Tue, 19 Sep 2023 06:24:03 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qiXtg-0000Ct-2s; Tue, 19 Sep 2023 06:24:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7d8a:0:640:8fc3:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTP id 9FC5B5F8F6;
 Tue, 19 Sep 2023 13:23:53 +0300 (MSK)
Received: from d-tatianin-nix.yandex-team.ru (unknown
 [2a02:6b8:b081:b64e::1:27])
 by mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id lNiu865OdGk0-L18B0c2q; Tue, 19 Sep 2023 13:23:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1695119033;
 bh=5XboSyHgRD4tfs7rklk0U8lsyjTVCw2opXhn42H1+1M=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=R0cBExrz+WnzLIbUURCZZNrLyo6THooEyNUYBLI46YmmWM0R7JmbnIfTr6ZlDTuOY
 j9bgeVO0iGrIgtsufg3gixnM7vLaDuWRWixJODdgfH8M1hReOG9s0gvPlqIimLYqIA
 mMYbgmfl51x4US4M5TC/2sbm0YQdA2wr/uBb+/WQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-11.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Daniil Tatianin <d-tatianin@yandex-team.ru>
Subject: [PATCH v2 0/3] migration-qtest: zero the first byte of each page on
 start
Date: Tue, 19 Sep 2023 13:23:43 +0300
Message-Id: <20230919102346.2117963-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

This series fixes an issue where the outcome of the migration qtest
relies on the initial memory contents all being the same across the
first 100MiB of RAM, which is a very fragile invariant.
 
We fix this by making sure we zero the first byte of every testable page
in range beforehand.

Changes since v1:
- Add a fix for the s390x test binary as well as suggested by Peter Xu

Daniil Tatianin (3):
  i386/a-b-bootblock: factor test memory addresses out into constants
  i386/a-b-bootblock: zero the first byte of each page on start
  s390x/a-b-bios: zero the first byte of each page on start

 tests/migration/i386/a-b-bootblock.S |  18 +-
 tests/migration/i386/a-b-bootblock.h |  16 +-
 tests/migration/s390x/a-b-bios.c     |   8 +
 tests/migration/s390x/a-b-bios.h     | 380 ++++++++++++++-------------
 4 files changed, 234 insertions(+), 188 deletions(-)

-- 
2.34.1


