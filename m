Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5FD717D02
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 12:17:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4IsG-0001ms-Bw; Wed, 31 May 2023 06:16:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1q4IsE-0001mU-W0
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:16:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eskultet@redhat.com>)
 id 1q4Is5-0000Uk-JI
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685528160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PefyTQFm2Sy9milcl6Rb5XF9YxmkSjCTiLrUifa7u30=;
 b=AQ0ZZlEhUpIIvIvnbb76/iK/7hN67RVUMjv4gmG+ZrUrS66Gr7DtHNun6iUt7HN8BfMUn3
 up8Es53Oz26DLiowYKReWhLnwAiw0FtN3MTfNb/pizdxGNAINcoGxwNIQKeaHgykVpwtRf
 SNAi4aVNDlz7A2QMp1qQCXbb7pTjdCw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-nnDL1J1IOh2d7rmMzbpM8Q-1; Wed, 31 May 2023 06:14:50 -0400
X-MC-Unique: nnDL1J1IOh2d7rmMzbpM8Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3BF01800888;
 Wed, 31 May 2023 10:14:50 +0000 (UTC)
Received: from ridgehead.redhat.com (unknown [10.45.224.152])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BCB840CFD08;
 Wed, 31 May 2023 10:14:48 +0000 (UTC)
From: Erik Skultety <eskultet@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Erik Skultety <eskultet@redhat.com>
Subject: [PATCH 0/2] tests: lcitool: Refresh to latest lcitool changes
Date: Wed, 31 May 2023 12:14:46 +0200
Message-Id: <cover.1685528076.git.eskultet@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eskultet@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
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

- add Alpine 3.17 & 3.18 targets
- bump gitlab CI Alpine/Fedora container versions accordingly

Erik Skultety (2):
  tests: lcitool: Refresh to latest master
  tests: lcitool: refresh: Bump container versions

 tests/docker/dockerfiles/alpine.docker             | 4 ++--
 tests/docker/dockerfiles/fedora-win32-cross.docker | 4 ++--
 tests/docker/dockerfiles/fedora-win64-cross.docker | 4 ++--
 tests/docker/dockerfiles/fedora.docker             | 4 ++--
 tests/lcitool/libvirt-ci                           | 2 +-
 tests/lcitool/refresh                              | 8 ++++----
 6 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.40.1


