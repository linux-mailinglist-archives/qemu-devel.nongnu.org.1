Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F7BDDE22
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Oct 2025 11:56:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8yE0-0003N9-M1; Wed, 15 Oct 2025 05:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8yDu-0003Lb-N3
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:55:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8yDq-0004R1-R5
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 05:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760522100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=pqmVXubB2bu2LOTSEec6wExMpRcXMYB7fS6WxxzSbnk=;
 b=SoLNLGFeZLTX1a/PlGdaJyAuRwQPOqg6D+3I+Hu5Vy7Fpqn7roJoAr3SPC+jCmTerYWmlA
 V+xby1gjUKWekTJhl7UwLhAB3zxXdW0GAhT0+zkGgAi0hZJWzxVvmdY6sydPn83WWmRPXI
 Sds4I9oAQlr8Ggcpaa61ACIkXpMIfXs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-O-CG0rtgPUqzwJ9CXpyNYQ-1; Wed,
 15 Oct 2025 05:54:58 -0400
X-MC-Unique: O-CG0rtgPUqzwJ9CXpyNYQ-1
X-Mimecast-MFC-AGG-ID: O-CG0rtgPUqzwJ9CXpyNYQ_1760522097
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83964180066C; Wed, 15 Oct 2025 09:54:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0D81A1800577; Wed, 15 Oct 2025 09:54:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 0/6] tests/functional: Fix various problems reported by pylint
Date: Wed, 15 Oct 2025 11:54:48 +0200
Message-ID: <20251015095454.1575318-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Using pylint to improve the code quality in the tests/functional/qemu_test
a little bit, for example:

- put the doc strings in the right locations (after the "def" line, not
  in front of it)
- use the right indentation everywhere (4 spaces)
- use isinstance() instead of checking via type()
- use lazy logging strings

Thomas Huth (6):
  tests/functional: Fix problems in asset.py reported by pylint
  tests/functional: Fix problems in decorators.py reported by pylint
  tests/functional: Fix problems in linuxkerenl.py reported by pylint
  tests/functional: Fix problems in testcase.py reported by pylint
  tests/functional: Fix problems in uncompress.py reported by pylint
  tests/functional: Fix problems in utils.py reported by pylint

 tests/functional/qemu_test/asset.py       |  24 ++-
 tests/functional/qemu_test/decorators.py  | 176 ++++++++-------
 tests/functional/qemu_test/linuxkernel.py |  10 +-
 tests/functional/qemu_test/testcase.py    | 251 +++++++++++-----------
 tests/functional/qemu_test/uncompress.py  |  40 ++--
 tests/functional/qemu_test/utils.py       |  22 +-
 6 files changed, 262 insertions(+), 261 deletions(-)

-- 
2.51.0


