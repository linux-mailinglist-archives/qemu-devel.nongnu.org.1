Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D4BB05659
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Jul 2025 11:32:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubbzD-0007AZ-LL; Tue, 15 Jul 2025 05:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubbyp-00074R-6H
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubbym-0005Lh-6E
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 05:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752571778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CnyvCbC7aXeBpRcvgjcrSR64DJS2KpjPyoKC42YAVfk=;
 b=HXxucKNV+Vrm+cUxH7HKEhtDtbjYRKh7rdPetwGwxJB79iQBJoFvYpEHI42cp8yVwiiLv4
 Z/3VSZyxkJBVZcK1p2zj+P+//ax095A0upbeEnssCtL50PewJ+crdbPEUr9pHy+a9tin5V
 XeH2odpJbmFNfynzFgcVuk9GnDkOL7c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-dbtZR9USOIydpDyrZTe9QA-1; Tue,
 15 Jul 2025 05:29:36 -0400
X-MC-Unique: dbtZR9USOIydpDyrZTe9QA-1
X-Mimecast-MFC-AGG-ID: dbtZR9USOIydpDyrZTe9QA_1752571775
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A42061808993
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 09:29:35 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.173])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7FD4B1977000; Tue, 15 Jul 2025 09:29:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/7] crypto: misc fixes and improvements to cert handling
Date: Tue, 15 Jul 2025 10:29:25 +0100
Message-ID: <20250715092932.1395271-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series includes three patches that were posted a fairly
long time ago. They are borderline between a feature request
and a bug fix, but I'm classing them more bug fix, since they
addressing issues with cert acceptance that we really should
not have had.

The patches by Henry had outstanding comments from myself,
and I've chosen to simply fix them in two followup commits
of my own now to get this over the line.

The patch from "matoro" was not accepted because they were
contributed under a github alias. With our change to have
a more relaxed interpretation of the DCO allowing any
"known identity", we can now accept this patch. It had
some conflicts with Henry's patch which I've fixed up.

Then there is one other small bug fix and one improvement
to use a newer gnutls API.

Daniel P. Berrangé (4):
  crypto: stop requiring "key encipherment" usage in x509 certs
  crypto: switch to newer gnutls API for distinguished name
  crypto: remove extraneous pointer usage in gnutls certs
  crypto: fix error reporting in cert chain checks

Henry Kleynhans (2):
  crypto: load all certificates in X509 CA file
  crypto: only verify CA certs in chain of trust

matoro (1):
  crypto: allow client/server cert chains

 crypto/tlscredsx509.c                 | 236 +++++++++++++++-----------
 crypto/tlssession.c                   |  12 +-
 docs/system/tls.rst                   |  13 +-
 tests/unit/crypto-tls-x509-helpers.h  |   6 +-
 tests/unit/test-crypto-tlscredsx509.c | 138 ++++++++++++---
 tests/unit/test-crypto-tlssession.c   |  14 +-
 tests/unit/test-io-channel-tls.c      |   4 +-
 7 files changed, 270 insertions(+), 153 deletions(-)

-- 
2.49.0


