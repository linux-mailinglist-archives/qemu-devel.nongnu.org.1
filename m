Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E77A7C3E1
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Apr 2025 21:34:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0mmI-0003R6-Va; Fri, 04 Apr 2025 15:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u0mmE-0003Qf-8Q; Fri, 04 Apr 2025 15:32:30 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u0mmB-0001Pr-5f; Fri, 04 Apr 2025 15:32:29 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:600c:0:640:a431:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 832F061A09;
 Fri,  4 Apr 2025 22:32:21 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:1220::1:20])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id uVf6w50Fh0U0-y91ckRtH; Fri, 04 Apr 2025 22:32:19 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1743795139;
 bh=B2cfCxjzzPps6C5BFr8gAJMPzn+TUrRE6pJ+Yw6keMM=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=T0aBPHbFfTcvThb1S0pTeTk8ONKR+XmqLUwOZ1ibChr4jxAR9hE67VvAhz1fwfu70
 NKZSzY8GiehXwimoUoIIIbEDRgv+wR6tcIN6/OT2aL+UAXJbrL3cuDUFSdTiCWEO/L
 XRUdiCpcek82Yrr4s3t94aYNH165R1KQciDxap/g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 devel@lists.libvirt.org, pkrempa@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, vsementsov@yandex-team.ru
Subject: [PATCH v2 0/2] derpecate some block-job- APIs
Date: Fri,  4 Apr 2025 22:31:52 +0300
Message-ID: <20250404193154.707145-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

v2:
Update documentation: add patch 01

v1 was:
[PATCH] [for-10.1] qapi/block-core: derpecate some block-job- APIs
Supersedes: <20250401155730.103718-1-vsementsov@yandex-team.ru>

Vladimir Sementsov-Ogievskiy (2):
  qapi: synchronize jobs and block-jobs documentation
  qapi/block-core: derpecate some block-job- APIs

 docs/about/deprecated.rst | 31 ++++++++++++++
 qapi/block-core.json      | 89 ++++++++++++++++++++++++++++-----------
 qapi/job.json             | 29 ++++++++++++-
 3 files changed, 122 insertions(+), 27 deletions(-)

-- 
2.48.1


