Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B1D79D8D6
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 20:42:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg8KZ-0004TE-FG; Tue, 12 Sep 2023 14:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg8KT-0004Sp-5Q
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qg8KQ-0001QM-Qy
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 14:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694544097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bo9Uiv1EmC7M8BwF7hgw+6ty93Fh7YrMdKE9xud24qo=;
 b=PwgCdjlEARrTtcrfCBsgu8GBQhpEXWhwstsaem05RrIBR/2vBs6K6S2VtIJEsGMGmNKi3Z
 yHspsjqSIEG059e2aGaxMJG0aAuyR2/srpRr7/SHwH/x6Ow83AFsQvh8T+P+etPgRQY4m1
 CFDSM3iyB5WmiWBTuZq0qSyI7KT6o8U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-Y2vsYIVyNMaCZomFngDC0g-1; Tue, 12 Sep 2023 14:41:34 -0400
X-MC-Unique: Y2vsYIVyNMaCZomFngDC0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73DE0805F6B;
 Tue, 12 Sep 2023 18:41:33 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C00D563F9D;
 Tue, 12 Sep 2023 18:41:31 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/4] ci: fix hang of FreeBSD CI jobs
Date: Tue, 12 Sep 2023 19:41:26 +0100
Message-ID: <20230912184130.3056054-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This addresses

  https://gitlab.com/qemu-project/qemu/-/issues/1882

Which turned out to be a genuine flaw which we missed during merge
as the patch hitting master co-incided with the FreeBSD CI job
having an temporary outage due to changed release image version.

Daniel P. Berrangé (4):
  microbit: add missing qtest_quit() call
  qtest: kill orphaned qtest QEMU processes on FreeBSD
  gitlab: make Cirrus CI timeout explicit
  gitlab: make Cirrus CI jobs gating

 .gitlab-ci.d/cirrus.yml       | 4 +++-
 .gitlab-ci.d/cirrus/build.yml | 2 ++
 tests/qtest/libqtest.c        | 7 +++++++
 tests/qtest/microbit-test.c   | 2 ++
 4 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.41.0


