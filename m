Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5B17D94AC
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 12:06:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwJiW-0003FD-1Y; Fri, 27 Oct 2023 06:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJiT-0003EB-IB
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 06:05:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qwJiN-0002A4-Dt
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 06:05:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698401110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+4wdHh452Yb07ftKofW3Hg3LZ1DKjesz45mtc23MU0o=;
 b=WjavMdC2WUU1hEsZtaNhPhHVa8Pvjoz+UITznUUbSe6DpybC0Ss0XhiUtOnKJ9r1scFVXd
 bSdWagksR9mY2iCWt1HM7/JMlcZmHLP75RrUCkH4afD0eDNqJikQynkbiVsSHCebw21+gb
 uj1beD5HUnVCdUCf3NFOAGa3CRT7qtQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-QUYaHQjqNsGDVBh2mLn8rQ-1; Fri, 27 Oct 2023 06:05:05 -0400
X-MC-Unique: QUYaHQjqNsGDVBh2mLn8rQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B7E98966A3;
 Fri, 27 Oct 2023 10:05:05 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.196])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F34BF492BFC;
 Fri, 27 Oct 2023 10:05:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 Sebastian Mitterle <smitterl@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>
Subject: [risu PATCH 0/2] Add support for instructions with length > 32 bit
Date: Fri, 27 Oct 2023 12:04:39 +0200
Message-ID: <20231027100441.375223-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

RISU currently only supports instructions with a length of
16 bit or 32 bit, however classical CISC systems like s390x
also have instructions that are longer than 32 bit. The first
patch improves the generator to support instructions with
more than 32 bits, and the second patch adds some 48-bit
instructions to the s390x.risu file.

Thomas Huth (2):
  risugen: allow instructions with length > 32 bit
  s390x.risu: Add some instructions with a length of 48 bits

 risugen                | 48 +++++++++++++++++++++++++++++-------------
 risugen_arm.pm         |  6 +++---
 risugen_common.pm      |  2 +-
 risugen_loongarch64.pm |  4 ++--
 risugen_m68k.pm        |  6 +++---
 risugen_ppc64.pm       |  4 ++--
 risugen_s390x.pm       | 17 +++++++++++----
 s390x.risu             | 20 ++++++++++++++++++
 8 files changed, 77 insertions(+), 30 deletions(-)

-- 
2.41.0


