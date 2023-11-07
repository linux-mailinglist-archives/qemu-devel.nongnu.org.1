Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DC67E48FE
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 20:09:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0RRK-0004Yl-VP; Tue, 07 Nov 2023 14:08:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0RRB-0004XI-Bo
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:08:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1r0RR0-0005oa-8Q
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 14:08:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699384100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yGgul8LztNHwPBEWwyIpnM0O5a1gRFv2NEPTEfdr5PQ=;
 b=DJpfG+M0iTEnxoWyl3mob4eLK/ZEqjtF2U4SLIiKQ+cnoqtfmoAAiVv5+xlPMATois4MX9
 EesOfRoavxRxpnZvjtgYlJpMqhiH3UX+8HGINtGshLUfhjmUz7oq0va02Q+AsA72JKVYBA
 +cpEhEFtsyXKSCP0qBcGs7rdhur5VDI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-583-gtRdoLtrMoyTK1Frd_GTmQ-1; Tue,
 07 Nov 2023 14:08:19 -0500
X-MC-Unique: gtRdoLtrMoyTK1Frd_GTmQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEC33383DC68
 for <qemu-devel@nongnu.org>; Tue,  7 Nov 2023 19:08:18 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF75125C0;
 Tue,  7 Nov 2023 19:08:17 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 0/5] Misc fixes patches
Date: Tue,  7 Nov 2023 19:08:12 +0000
Message-ID: <20231107190817.1607710-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 462ad017ed76889d46696a3581e1b52343f9b683:

  Merge tag 'pixman-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2023-11-07 19:00:03 +0800)

are available in the Git repository at:

  https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request

for you to fetch changes up to 3e7ebf58e808afb422e5000bbf77dc4aa88dd6e6:

  scripts/cpu-x86-uarch-abi.py: Fix parameter error of cmd (2023-11-07 16:45:18 +0000)

----------------------------------------------------------------
 * Print error with f32 audio format in wav backend instead of abort
 * Drop redundant listener name suffix
 * Update libvirt mailing list address
 * Cleanup RSA key error paths
 * Fix CPU uarch ABI script QMP command calling

----------------------------------------------------------------

Daniel P. Berrangé (2):
  audio: don't abort on f32 audio format in wav backend
  MAINTAINERS: update libvirt devel mailing list address

Fabiano Rosas (1):
  io: Stop appending -listen to net listeners

Markus Armbruster (1):
  crypto/rsakey-builtin.c.inc: Clean up two error paths

Zhao Liu (1):
  scripts/cpu-x86-uarch-abi.py: Fix parameter error of cmd

 MAINTAINERS                  | 2 +-
 audio/wavaudio.c             | 4 ++++
 crypto/rsakey-builtin.c.inc  | 8 ++------
 io/net-listener.c            | 4 +---
 scripts/cpu-x86-uarch-abi.py | 4 ++--
 5 files changed, 10 insertions(+), 12 deletions(-)

-- 
2.41.0


