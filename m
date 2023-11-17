Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5417EEF55
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 10:54:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3vXw-00080G-DW; Fri, 17 Nov 2023 04:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3vXu-0007zl-Ij
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 04:53:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3vXf-0006fH-6r
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 04:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700214818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=re1se415BeqVnajk1ds+JOLz3jdeQca9MKjy9PHTKfM=;
 b=RGr811gUBPT5XOLTKmsZ+7WiY8JJwOFxGSXBEfcculH9Y0NK0zEc+Vq/FPAVzCckkl0CSF
 Wc4/h8sHJy7eK+ErRU2TLfYchOvyyAlhMP5DODxgv8MLh8+RUXlJfkjSOl6i79kuK0hHh/
 Zwhsl5mOg9rgC1T2N6KYAxeVgTfo1RM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-iVYy86T_O6aGumaTtetnyA-1; Fri,
 17 Nov 2023 04:53:36 -0500
X-MC-Unique: iVYy86T_O6aGumaTtetnyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E20D63C0C108
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 09:53:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C187F5028
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 09:53:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D507121E6A1F; Fri, 17 Nov 2023 10:53:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 0/7] Error reporting patches for 2023-11-17
Date: Fri, 17 Nov 2023 10:53:27 +0100
Message-ID: <20231117095334.1819613-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The following changes since commit 34a5cb6d8434303c170230644b2a7c1d5781d197:

  Merge tag 'pull-tcg-20231114' of https://gitlab.com/rth7680/qemu into staging (2023-11-15 08:05:25 -0500)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-error-2023-11-17

for you to fetch changes up to 298d8b122056052951bda487392d8aabbfd0f3e5:

  target/i386/cpu: Improve error message for property "vendor" (2023-11-17 10:07:52 +0100)

----------------------------------------------------------------
Error reporting patches for 2023-11-17

----------------------------------------------------------------
Markus Armbruster (7):
      spapr/pci: Correct "does not support hotplugging error messages
      hmp: Improve sync-profile error message
      qga: Improve guest-exec-status error message
      ui/qmp-cmds: Improve two error messages
      net: Fix a misleading error message
      balloon: Fix a misleading error message
      target/i386/cpu: Improve error message for property "vendor"

 hw/ppc/spapr_pci.c |  4 ++--
 monitor/hmp-cmds.c |  4 ++--
 net/net.c          |  6 +++---
 qga/commands.c     |  2 +-
 system/balloon.c   | 10 +++++-----
 target/i386/cpu.c  |  3 ++-
 ui/ui-qmp-cmds.c   |  5 +++--
 7 files changed, 18 insertions(+), 16 deletions(-)

-- 
2.41.0


