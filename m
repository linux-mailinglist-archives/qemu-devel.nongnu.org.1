Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C0A712473
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:20:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2UXy-0003Fp-Pb; Fri, 26 May 2023 06:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2UXw-0003Fd-J3
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q2UXv-0002TH-3E
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:19:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685096382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KnCmrMLMTq/TAwiFvjXEYF3V2dT06QkjhgZpHWvc8Yw=;
 b=FNX6NcRHBElZfqMm5ouqbkXosZY15fw45mb/iMYU3NJlb/y3u/D8DPB7ndCxRKe1zSdrfr
 NTa+Q16G+eQAr9Qbo9Xqirw/VgNKQl0iylRK8+2dbiTGqV2N6rb5BHox7QWHnMWuBBB8M0
 lR+Tbz7hU286WVJkQyO/qZYkd5hW3Bk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-631-swbWCBelNeigiNen8MJiVA-1; Fri, 26 May 2023 06:19:38 -0400
X-MC-Unique: swbWCBelNeigiNen8MJiVA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62EB51C05146;
 Fri, 26 May 2023 10:19:38 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5145940C1438;
 Fri, 26 May 2023 10:19:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 0/5] gitlab: improvements to handling of stable staging
 branches
Date: Fri, 26 May 2023 11:19:29 +0100
Message-Id: <20230526101934.935969-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

We just (re)discovered that our gitlab rules don't work nicely with
pipelines running from stable staging branches. Every pipeline gets
published with the 'latest' tag, whether its the main staging branch
or one of the stable staging branches. If pipelines for multiple
staging branches run concurrently they'll get very confused and end
up using the wrong container content. eg a 8.0 stable job will get
run with a container from the development branch, or vica-verca.

With this series we dynamically change the tag so that the 'staging'
branch still uses 'latest', but the stable 'staging-X.Y' branaches
use a 'staging-X-Y' container tag.

We also let the container tag be set explicitly via the new variable

  QEMU_CI_CONTAINER_TAG

to facilitate CI testing, the new variable

  QEMU_CI_UPSTREAM

can be set to the fork namespace, to allow contributors to run a
pipeline as if their fork were upstream.

Finally 'QEMU_CI=1' is also made to work in upstream, so that it is
possible to re-run selective jobs on staging branches.

Changed in v2:

 - Allow QEMU_CI=1 to work on all staging branches, not just stable
 - Rebased

Daniel P. Berrangé (5):
  gitlab: centralize the container tag name
  gitlab: allow overriding name of the upstream repository
  gitlab: stable staging branches publish containers in a separate tag
  gitlab: avoid extra pipelines for tags and stable branches
  gitlab: support disabling job auto-run in upstream

 .gitlab-ci.d/base.yml                | 63 ++++++++++++++++++++++++----
 .gitlab-ci.d/buildtest-template.yml  |  4 +-
 .gitlab-ci.d/buildtest.yml           |  4 +-
 .gitlab-ci.d/container-template.yml  |  3 +-
 .gitlab-ci.d/crossbuild-template.yml |  6 +--
 .gitlab-ci.d/static_checks.yml       |  4 +-
 docs/devel/ci-jobs.rst.inc           | 11 +++++
 7 files changed, 78 insertions(+), 17 deletions(-)

-- 
2.40.1


