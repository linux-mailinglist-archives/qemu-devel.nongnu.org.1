Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC937634F7
	for <lists+qemu-devel@lfdr.de>; Wed, 26 Jul 2023 13:30:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOchw-0003B1-Ta; Wed, 26 Jul 2023 07:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOchY-00038C-0B
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 07:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qOchT-0003zD-RA
 for qemu-devel@nongnu.org; Wed, 26 Jul 2023 07:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690370938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=si3IFuh6sRInmnlsPnbbMEByBVAD1LjpJZVXzShKVs0=;
 b=FUZNIbaULnXfwVf2Xfu7Cfe6j9fdh/2qm6x3qvXwqHhR10NzoGNHncrNR3Wsbym5N4jRZw
 B48XDeWQLUSdgVWeh4L4XU6a6XOi6ZpVgxT54BtFccVXSCL8BTeOfYor8eVQPlQ1CvQ8gK
 JnyxRcN+Mob391MqgTKjQOlTS5Sw9ck=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-272-c5qL4aUxNy6VsAzCRRXKhA-1; Wed, 26 Jul 2023 07:28:56 -0400
X-MC-Unique: c5qL4aUxNy6VsAzCRRXKhA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C0E11C07549;
 Wed, 26 Jul 2023 11:28:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 54F50F7835;
 Wed, 26 Jul 2023 11:28:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C12E21E6833; Wed, 26 Jul 2023 13:28:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 0/5] QAPI patches patches for 2023-07-26
Date: Wed, 26 Jul 2023 13:28:50 +0200
Message-ID: <20230726112855.155795-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The following changes since commit 6cb2011fedf8c4e7b66b4a3abd6b42c1bae99ce6:

  Update version for v8.1.0-rc1 release (2023-07-25 20:09:05 +0100)

are available in the Git repository at:

  https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2023-07-26

for you to fetch changes up to 1799bdcb47d8368c92cfc69c3b4f305ec8414977:

  qapi: Reformat recent doc comments to conform to current conventions (2023-07-26 13:26:53 +0200)

----------------------------------------------------------------
QAPI patches patches for 2023-07-26

----------------------------------------------------------------
The patches affect only documentation.  Generated code does not change.

Markus Armbruster (5):
      qapi/block-core: Tidy up BlockLatencyHistogramInfo documentation
      qapi/block: Tidy up block-latency-histogram-set documentation
      qapi/qdev: Tidy up device_add documentation
      qapi/trace: Tidy up trace-event-get-state, -set-state documentation
      qapi: Reformat recent doc comments to conform to current conventions

 qapi/block-core.json     | 85 +++++++++++++++++++++++-------------------------
 qapi/block.json          | 12 +++----
 qapi/cxl.json            |  4 +--
 qapi/machine-target.json |  2 +-
 qapi/migration.json      | 10 +++---
 qapi/net.json            |  1 -
 qapi/qdev.json           |  6 ++--
 qapi/qom.json            |  9 ++---
 qapi/trace.json          |  9 ++---
 qapi/ui.json             |  2 +-
 10 files changed, 66 insertions(+), 74 deletions(-)

-- 
2.41.0


