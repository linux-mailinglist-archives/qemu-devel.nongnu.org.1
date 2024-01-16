Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E52782EA81
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 08:59:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPeKZ-0002jv-93; Tue, 16 Jan 2024 02:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPeKW-0002jE-Hq
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:57:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rPeKU-00082e-DU
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 02:57:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705391868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=G/ut5WYwkPB8VJ0pwT8BD+q/Z9S1uruhTRK0FPBqRH0=;
 b=EYMFt8wVKzFvbG2rhRPJjA9HhExzVzVgpORb726tYtoxAAmbPw7cFk2r3xZsVVrlHklT43
 eEhwIg80LeNjM8If9YnvZ4s6Du1eapONZ1+WhCiact3TTcQX++PGdIbtqc+g4hb8+5cv8J
 PZXbitaty5WaQJRK/EfCBPHW7KL5uhs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-WFMTwsgYNMe3EADud_wq-w-1; Tue, 16 Jan 2024 02:57:46 -0500
X-MC-Unique: WFMTwsgYNMe3EADud_wq-w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2CE10185A781;
 Tue, 16 Jan 2024 07:57:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 472E43C25;
 Tue, 16 Jan 2024 07:57:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/5] qtest timeouts and ROP mitigation
Date: Tue, 16 Jan 2024 08:57:39 +0100
Message-ID: <20240116075744.219169-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 Hi Peter!

The following changes since commit 977542ded7e6b28d2bc077bcda24568c716e393c:

  Merge tag 'pull-testing-updates-120124-2' of https://gitlab.com/stsquad/qemu into staging (2024-01-12 14:02:53 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-01-16

for you to fetch changes up to 7ff9ff039380008952c6fd32011dd2a4d5666906:

  meson: mitigate against use of uninitialize stack for exploits (2024-01-16 07:25:27 +0100)

----------------------------------------------------------------
* Improve the timeouts for some problematic qtests
* Enable some ROP mitigation compiler switches

----------------------------------------------------------------
Daniel P. Berrangé (2):
      meson: mitigate against ROP exploits with -fzero-call-used-regs
      meson: mitigate against use of uninitialize stack for exploits

Thomas Huth (3):
      tests/qtest/meson.build: Bump the boot-serial-test timeout to 4 minutes
      tests/qtest/npcm7xx_watchdog_timer: Only test the corner cases by default
      qtest: Bump npcm7xx_watchdog_timer-test timeout to 2 minutes

 meson.build                               | 16 ++++++++++++++++
 tests/qtest/npcm7xx_watchdog_timer-test.c |  5 +++--
 tests/qtest/meson.build                   |  3 ++-
 3 files changed, 21 insertions(+), 3 deletions(-)


