Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 55650BCF752
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Oct 2025 16:30:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7aDW-0003m0-Sv; Sat, 11 Oct 2025 10:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDP-0003bM-OJ
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:04:56 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v7aDI-0005OH-KO
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 10:04:54 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 5A95EC017A;
 Sat, 11 Oct 2025 17:04:44 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:a4b::1:3c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id h4NOTl1FrqM0-fRtBLqoK; Sat, 11 Oct 2025 17:04:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1760191483;
 bh=+y7XSy4SX2y1bLvavd/0RyzeiTZtL/eIynmuuHDZCAI=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=DKXWf+tt3+ZggYefWNhDvknTbIUnpfc1jYp0072MC59iA3cbVNvgTTU0C7kar3EXy
 V4fb75K4XTWfLwmKAVTsbObjyeaxy5n0JA6xwT1Obj6PRIj8hgRE/WeUffJYkMcB00
 SGbECWowy5CY3eUxmvAvFsd42TQOjzbCn+vLinHE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: armbru@redhat.com
Cc: qemu-devel@nongnu.org,
	vsementsov@yandex-team.ru,
	eblake@redhat.com
Subject: [PATCH v2 00/33] qapi: docs: width=70 and two spaces between sentences
Date: Sat, 11 Oct 2025 17:04:06 +0300
Message-ID: <20251011140441.297246-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Hi all!

Let's bring the documentation in line with the requirements. And
do check these requirements in QAPI parser.

v2: resend without duplicated patchs. Sorry for the noise.

Vladimir Sementsov-Ogievskiy (33):
  qapi: Add documentation format validation
  qapi/acpi.json: docs: width=70 and two spaces between sentences
  qapi/audio.json: docs: width=70 and two spaces between sentences
  qapi/block-core.json: docs: width=70 and two spaces between sentences
  qapi/block-export.json: docs: width=70 and two spaces between
    sentences
  qapi/block.json: docs: width=70 and two spaces between sentences
  qapi/char.json: docs: width=70 and two spaces between sentences
  qapi/crypto.json: docs: width=70 and two spaces between sentences
  qapi/dump.json: docs: width=70 and two spaces between sentences
  qapi/introspect.json: docs: width=70 and two spaces between sentences
  qapi/job.json: docs: width=70 and two spaces between sentences
  qapi/machine-s390x.json: docs: width=70 and two spaces between
    sentences
  qapi/machine.json: docs: width=70 and two spaces between sentences
  qapi/migration.json: docs: width=70 and two spaces between sentences
  qapi/misc-arm.json: docs: width=70 and two spaces between sentences
  qapi/misc-i386.json: docs: width=70 and two spaces between sentences
  qapi/misc.json: docs: width=70 and two spaces between sentences
  qapi/net.json: docs: width=70 and two spaces between sentences
  qapi/qdev.json: docs: width=70 and two spaces between sentences
  qapi/qom.json: docs: width=70 and two spaces between sentences
  qapi/replay.json: docs: width=70 and two spaces between sentences
  qapi/rocker.json: docs: width=70 and two spaces between sentences
  qapi/run-state.json: docs: width=70 and two spaces between sentences
  qapi/sockets.json: docs: width=70 and two spaces between sentences
  qapi/stats.json: docs: width=70 and two spaces between sentences
  qapi/tpm.json: docs: width=70 and two spaces between sentences
  qapi/trace.json: docs: width=70 and two spaces between sentences
  qapi/transaction.json: docs: width=70 and two spaces between sentences
  qapi/ui.json: docs: width=70 and two spaces between sentences
  qapi/vfio.json: docs: width=70 and two spaces between sentences
  qapi/virtio.json: docs: width=70 and two spaces between sentences
  qga/qapi-schema.json: docs: width=70 and two spaces between sentences
  qapi/acpi-hest.json: docs: width=70 and two spaces between sentences

 qapi/acpi-hest.json     |   2 +-
 qapi/acpi.json          |  20 ++-
 qapi/audio.json         |   4 +-
 qapi/block-core.json    | 191 +++++++++++++++-------------
 qapi/block-export.json  |  26 ++--
 qapi/block.json         |  18 +--
 qapi/char.json          |  34 +++--
 qapi/crypto.json        |   7 +-
 qapi/dump.json          |   9 +-
 qapi/introspect.json    |   8 +-
 qapi/job.json           |  26 ++--
 qapi/machine-s390x.json |   3 +-
 qapi/machine.json       |  59 +++++----
 qapi/migration.json     | 209 ++++++++++++++++++-------------
 qapi/misc-arm.json      |   6 +-
 qapi/misc-i386.json     |   9 +-
 qapi/misc.json          |  16 ++-
 qapi/net.json           |  61 +++++----
 qapi/qdev.json          |  13 +-
 qapi/qom.json           |  31 +++--
 qapi/replay.json        |   9 +-
 qapi/rocker.json        |  18 ++-
 qapi/run-state.json     |  60 +++++----
 qapi/sockets.json       |  34 ++---
 qapi/stats.json         |   3 +-
 qapi/tpm.json           |   3 +-
 qapi/trace.json         |   3 +-
 qapi/transaction.json   |  33 ++---
 qapi/ui.json            | 108 ++++++++++------
 qapi/vfio.json          |   3 +-
 qapi/virtio.json        | 269 +++-------------------------------------
 qga/qapi-schema.json    |  83 +++++++------
 scripts/qapi/parser.py  |  39 +++++-
 33 files changed, 713 insertions(+), 704 deletions(-)

-- 
2.48.1


