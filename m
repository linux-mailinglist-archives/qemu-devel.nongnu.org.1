Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6526879A75A
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 12:41:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfeLH-0001c0-Qt; Mon, 11 Sep 2023 06:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qfeLC-0001bC-8A
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:40:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <victortoso@redhat.com>)
 id 1qfeL9-0006Iv-D5
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 06:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694428821;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ZXlFo3Fi7lxMVdNJnzqrxKU/wi2h/ZGAbfNN62QF8b8=;
 b=YGYPX3RhuUXCpDLtuG1Ck0hzTXsriMRzHakEHbu6JFaVw/FmQH00Kxc0tJ/blR8MWM2oz1
 zQzMDBINlHLmznzObdWlZZRjoM9t9NMNZTJmJRxa60Lk35iokGO1fgKAU4j7WvgT6aczAA
 g3KFiQmUSRCAQdlB6P10YRZU7TEwmRk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-Sx4JS1OqMvqHDJrQVCgCng-1; Mon, 11 Sep 2023 06:40:20 -0400
X-MC-Unique: Sx4JS1OqMvqHDJrQVCgCng-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE1A129ABA1C
 for <qemu-devel@nongnu.org>; Mon, 11 Sep 2023 10:40:19 +0000 (UTC)
Received: from tapioca.lan (unknown [10.45.225.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DD6D10F1BE8;
 Mon, 11 Sep 2023 10:40:18 +0000 (UTC)
From: Victor Toso <victortoso@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 00/11] Validate and test qapi examples
Date: Mon, 11 Sep 2023 12:40:08 +0200
Message-ID: <20230911104017.65397-1-victortoso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=victortoso@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

v1: https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg00853.html

Changes:
- Fixed running the generator with tests (Daniel). Added a flag for the
  generator, set in tests/meson.build (Philippe).
- Moved the script to the end of the series, to avoid git bisect issues
  (Daniel)
- Added a proper assert() to the generator, making it fail if any
  documentation error was found instead of just printing to the stderr
  and carry on. (Daniel)
- Fixed the 3 other warnings the generator was showing, we are 100% free
  of warnings (in my machine)

Cheers,
Victor

Victor Toso (11):
  qapi: fix example of get-win32-socket command
  qapi: fix example of dumpdtb command
  qapi: fix example of cancel-vcpu-dirty-limit command
  qapi: fix example of set-vcpu-dirty-limit command
  qapi: fix example of calc-dirty-rate command
  qapi: fix example of NETDEV_STREAM_CONNECTED event
  qapi: fix example of query-rocker-of-dpa-flows command
  qapi: fix example of query-spice command
  qapi: fix example of query-blockstats command
  qapi: meson: add test flag to allow skip generators
  qapi: scripts: add a generator for qapi's examples

 qapi/block-core.json         |  32 +++---
 qapi/machine.json            |   2 +-
 qapi/migration.json          |   6 +-
 qapi/misc.json               |   2 +-
 qapi/net.json                |   6 +-
 qapi/rocker.json             |   3 +-
 qapi/ui.json                 |   3 +-
 scripts/qapi/dumpexamples.py | 204 +++++++++++++++++++++++++++++++++++
 scripts/qapi/main.py         |   9 +-
 tests/meson.build            |   2 +-
 10 files changed, 239 insertions(+), 30 deletions(-)
 create mode 100644 scripts/qapi/dumpexamples.py

-- 
2.41.0


