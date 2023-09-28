Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 090497B1ED8
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 15:45:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlrJR-0000r7-UH; Thu, 28 Sep 2023 09:44:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJP-0000qy-Pw
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1qlrJM-0005Da-VK
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 09:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695908651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9fZ3AUZkMhQ+QsLzxsdBVQmbivX8uFvkPfZ5Ne/Q1/w=;
 b=OI5P6fT4IYWIMvoQ6LGnKNfbn0Zm0BmZkcDRDHMr8FhoDAN6mm+6JUXv4ilrGJbhhILLoq
 +ct/s5KBNBu1WMiOeWuhPmYNkLuGzG+BbBR6jRvUosNT7LK8ZRTTmSx+enulTauvRgaTMW
 1fCdoUtfgl/iFEShopWloabPRvfy1U4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-642-s3kzKoEMPkS9FsbdcG7sRg-1; Thu, 28 Sep 2023 09:44:09 -0400
X-MC-Unique: s3kzKoEMPkS9FsbdcG7sRg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B182811E93;
 Thu, 28 Sep 2023 13:44:09 +0000 (UTC)
Received: from localhost (unknown [10.39.195.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A948F492C37;
 Thu, 28 Sep 2023 13:44:08 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/14] Tracing patches
Date: Thu, 28 Sep 2023 09:43:53 -0400
Message-ID: <20230928134407.568453-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 494a6a2cf7f775d2c20fd6df9601e30606cc2014:

  Merge tag 'pull-request-2023-09-25' of https://gitlab.com/thuth/qemu into staging (2023-09-25 10:10:30 -0400)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request

for you to fetch changes up to ff014701ab0f09fdbf37b4c39334790f9b298253:

  scripts/analyse-locks-simpletrace.py: changed iteritems() to items() (2023-09-26 12:28:51 -0400)

----------------------------------------------------------------
Pull request

- Mads Ynddal's improvements to simpletrace.py

----------------------------------------------------------------

Mads Ynddal (14):
  simpletrace: add __all__ to define public interface
  simpletrace: annotate magic constants from QEMU code
  simpletrace: improve parsing of sys.argv; fix files never closed.
  simpletrace: changed naming of edict and idtoname to improve
    readability
  simpletrace: update code for Python 3.11
  simpletrace: improved error handling on struct unpack
  simpletrace: define exception and add handling
  simpletrace: made Analyzer into context-manager
  simpletrace: refactor to separate responsibilities
  simpletrace: move logic of process into internal function
  simpletrace: move event processing to Analyzer class
  simpletrace: added simplified Analyzer2 class
  MAINTAINERS: add maintainer of simpletrace.py
  scripts/analyse-locks-simpletrace.py: changed iteritems() to items()

 MAINTAINERS                          |   6 +
 scripts/analyse-locks-simpletrace.py |   2 +-
 scripts/simpletrace.py               | 372 +++++++++++++++++----------
 3 files changed, 241 insertions(+), 139 deletions(-)

-- 
2.41.0


