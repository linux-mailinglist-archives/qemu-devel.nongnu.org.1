Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4767DCB84
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:12:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmeN-00043F-Jb; Tue, 31 Oct 2023 07:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmeL-0003y2-2L
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:11:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmeI-0006xG-Kd
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:11:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698750665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l0kKGu2EdIziwE7j4F+R0m/lX6hoBDvdHMCj+CK347g=;
 b=BQNfv8Z4bY7ZMmYJEOuWkWLI7uJUNSWXHy9KOTt3fmZtbm5k6nHhxQzLv05YAfD9ubHjI1
 ffozsPdv+eamX6HNZJurE4gw00kP55qEk0d6Em5hNX381nKkp35HoYG7iciH+McnF3GcZh
 HWN4WDhS/Nd5kSMqaFkGP0h1dL2jyVQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269--2F3hnTEMCmoTEIiQIdlig-1; Tue,
 31 Oct 2023 07:11:02 -0400
X-MC-Unique: -2F3hnTEMCmoTEIiQIdlig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AB233826D2D;
 Tue, 31 Oct 2023 11:11:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9E891121306;
 Tue, 31 Oct 2023 11:11:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE82421E6A1F; Tue, 31 Oct 2023 12:10:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 mst@redhat.com, david@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
Subject: [PATCH 0/7] Miscellaneous error message improvements
Date: Tue, 31 Oct 2023 12:10:52 +0100
Message-ID: <20231031111059.3407803-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


