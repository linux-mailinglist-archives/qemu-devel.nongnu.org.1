Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5516495ED99
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Aug 2024 11:45:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siWGN-0002my-BV; Mon, 26 Aug 2024 05:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siWGF-0002le-BH
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 05:43:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siWGD-0006xc-6d
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 05:43:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724665417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2m8TDuYy1QRgT4VKtu8udgyzGBhNH8tr9NIu0CoNooc=;
 b=FMSF3NzoCcrODcsxfbygXyjy0nMdtm0cNS7LkNCHAUdfzwDOndcg3oW6ZeL0hahUxIuovN
 a3MDni70dEzIuKCzF8j9viTF0y1MTEMeJR88HsJBQd2bCNEU7xqriqMQFnwxqDH7OyoqHe
 mmo5NQLxwS0bf3j9zBaghanW5aETBc4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-620-nT9nGjRaME-MIkhlBY-HNg-1; Mon,
 26 Aug 2024 05:43:35 -0400
X-MC-Unique: nT9nGjRaME-MIkhlBY-HNg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82FCD195608A; Mon, 26 Aug 2024 09:43:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.178])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCE8619560AA; Mon, 26 Aug 2024 09:43:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 0/3] Optional fixes for 9.1.0-rc4
Date: Mon, 26 Aug 2024 11:43:27 +0200
Message-ID: <20240826094330.276592-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

 Hi Richard,

since it seems like we're going to have RC4, here are some minor
fixes that could still be included.

The following changes since commit f259e4cb8a8b4ef5463326fc214a7d8d7703d5de:

  Merge tag 'pull-trivial-patches' of https://gitlab.com/mjt0k/qemu into staging (2024-08-24 08:09:27 +1000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-08-26

for you to fetch changes up to aee07f2563d27167935ae3557a9f435937eb3f9f:

  tests/qtest: Delete previous boot file (2024-08-26 10:58:11 +0200)

----------------------------------------------------------------
* Disable the broken qtests in the MSYS2 CI job
* Replace deprecated keyword in the Cirrus-CI scripts
* Fix a simple leak in the migration-test qtest

----------------------------------------------------------------
Akihiko Odaki (1):
      tests/qtest: Delete previous boot file

Philippe Mathieu-Daudé (1):
      gitlab-ci: Replace build_script -> step_script in Cirrus jobs

Thomas Huth (1):
      .gitlab-ci.d/windows.yml: Disable the qtests in the MSYS2 job

 tests/qtest/migration-test.c  | 18 +++++++++++-------
 .gitlab-ci.d/cirrus/build.yml |  2 +-
 .gitlab-ci.d/windows.yml      | 26 ++------------------------
 3 files changed, 14 insertions(+), 32 deletions(-)


