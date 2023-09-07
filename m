Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BC3797CB7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 21:30:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeKhp-0000Qu-1J; Thu, 07 Sep 2023 15:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qeKhg-0000QO-7P
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 15:30:13 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1qeKhc-0000R8-OY
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 15:30:11 -0400
Received: from mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:9412:0:640:7d12:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTP id CD79C60326;
 Thu,  7 Sep 2023 22:29:59 +0300 (MSK)
Received: from d-tatianin-nix.yandex-team.ru (unknown
 [2a02:6b8:b081:b5a6::1:1f])
 by mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mTfKjH0OdCg0-ahaNg5wv; Thu, 07 Sep 2023 22:29:58 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1694114998;
 bh=AuZ4QjCXeAsApz7GuMckX2lnDWAQNWy5f5nZSeeTNTY=;
 h=Message-Id:Date:Cc:Subject:To:From;
 b=mdn7nywsyBEYumioQk99vD4Ei8eh466dwSg+OP9i1+BAdqbJ6DgD0foCyyKHK0/ne
 13o8eTrW7TB+WQMZAoxV/hDYQ0ME1f2T3Q38jL4N61wgj7HLaBqaesrDci/tRSbUmE
 AmIxQoWOzYx3Rme8u96AkwW+/jetyqOAhQ09d8dA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-44.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
To: Juan Quintela <quintela@redhat.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru
Subject: [PATCH 0/2] i386/a-b-bootblock: zero the first byte of each page on
 start
Date: Thu,  7 Sep 2023 22:29:42 +0300
Message-Id: <20230907192944.1609099-1-d-tatianin@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

This series fixes an issue where the outcome of the migration qtest
relies on the initial memory contents all being the same across the
first 100MiB of RAM, which is a very fragile invariant.

We fix this by making sure we zero the first byte of every testable page
in range beforehand.

Daniil Tatianin (2):
  i386/a-b-bootblock: factor test memory addresses out into constants
  i386/a-b-bootblock: zero the first byte of each page on start

 tests/migration/i386/a-b-bootblock.S | 18 +++++++++++++++---
 tests/migration/i386/a-b-bootblock.h | 16 ++++++++--------
 2 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.34.1


