Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7270576B56C
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 15:05:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQp3F-00077T-Sj; Tue, 01 Aug 2023 09:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQp2z-0006oc-QE
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:04:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qQp2w-0006q5-Sa
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 09:04:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690895050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wYx69p2m9Q22Ebd2Ip6Igi0A06sWeQAa/v6I/y++mg8=;
 b=aU3JsMR9gWpp3BGZ7/iT0o8T26VKR1dB73uvsq3NMKCh0vokbKVfN43zZHYtjCH85GYzSH
 7F5uqRKUA4EcE/6tf49irLXWYyzTh9owLJoSHoTTR9XJGlPIv1no58bj6X0/rw4+cBn2+9
 H43A2eok9pHl8VMrwBANjAB7vkUuOh4=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-487-6b7sVZNLMuKryosNPG2Q3Q-1; Tue, 01 Aug 2023 09:04:06 -0400
X-MC-Unique: 6b7sVZNLMuKryosNPG2Q3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 339B41C09040;
 Tue,  1 Aug 2023 13:04:06 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0BC45140E952;
 Tue,  1 Aug 2023 13:04:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/8] gitlab: speed up msys windows jobs with GCC
Date: Tue,  1 Aug 2023 14:03:55 +0100
Message-ID: <20230801130403.164060-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

This is an alternative and/or complementary to Thomas' proposal
to use CLang with msys:

  https://lists.gnu.org/archive/html/qemu-devel/2023-07/msg05402.html

First of all, the current msys installer we're using is over 12
months out of date. Thus after running the install, pacman then
replaces most of what we've just installed with new downloaded
content. Using the most update installer cuts 3+1/2 minutes off
the msys install time - 7 minutes becomes 3+1/2.

Secondly, QEMU defaults to compiling with -O2 and this is more
computationally expensive for GCC. Switching to -O0 drops the
build time from 60 minutes down to 45 minutes.

Thirdly, including debug symbols also has an overhead, and turning
that off reduces time still further down to 38 minutes.

IOW, between all three changes, we can cut approx 25-26 minutes
off the job execution time, bringing it nicely within the job
timeout.

The actually phase of installing the mingw deps still accounts
for about 10 minutes and has not been optimized.

Possibly the same trick of -O0 and skipping -g would also help
the clang alternative Thomas' proposed. If so, that could be
enough to let us enable more features / targets during the
msys build.

Daniel P. Berrangé (8):
  gitlab: remove duplication between msys jobs
  gitlab: print timestamps during windows msys jobs
  gitlab: always use updated msys installer
  gitlab: drop $CI_PROJECT_DIR from cache path
  gitlab: always populate cache for windows msys jobs
  configure: support passthrough of -Dxxx args to meson
  gitlab: disable optimization and debug symbols in msys build
  gitlab: disable FF_SCRIPT_SECTIONS on msys jobs

 .gitlab-ci.d/windows.yml | 174 +++++++++++++++++++--------------------
 configure                |   5 ++
 2 files changed, 92 insertions(+), 87 deletions(-)

-- 
2.41.0


