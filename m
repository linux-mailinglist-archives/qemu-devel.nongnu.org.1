Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF19BD8335
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Oct 2025 10:35:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aUS-0006i8-CA; Tue, 14 Oct 2025 04:34:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8aUN-0006hj-CI
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:34:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8aUK-00054M-J5
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:34:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760430870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ipA/NfBK8orPbOPeoSn4uhL6GpeWEv3wXIVhCRvmAyE=;
 b=aDki83i9b0jOIy7sBpflgoEG47esWAZDeZtPGKHJoQiix4p5vj5iDgK9Bt9Rb65wZ26fHa
 XLYNcyo7rztVJ6EudivBMa7WzPLtzAOfzfpUNe8DEqI5zAVOFyO3PN8eJnVJ5Hiy/FRmug
 kqENsbvv5gTalrXJQM018z+0Y5Wrhbg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-obf_2qHYMnCVf_BWOUOpwg-1; Tue,
 14 Oct 2025 04:34:28 -0400
X-MC-Unique: obf_2qHYMnCVf_BWOUOpwg-1
X-Mimecast-MFC-AGG-ID: obf_2qHYMnCVf_BWOUOpwg_1760430868
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D54101954102; Tue, 14 Oct 2025 08:34:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 083FA19560A2; Tue, 14 Oct 2025 08:34:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/2] Clean up the functional download cache after some
 months
Date: Tue, 14 Oct 2025 10:34:22 +0200
Message-ID: <20251014083424.103202-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

The download cache of the functional tests is currently only growing.
But sometimes tests get removed or changed to use different assets,
thus we should clean up the stale old assets after a while when they
are not in use anymore.

This little patch series now introduces time stamps for the assets in
the cache (first patch) that we update during each test run, so we can
check these time stamps regularly and evict stale assets after half
of a year not being used anymore (that should be enough time to still
keep the assets around for a while in case you want to diagnose a
problem that is still some months old).

v3:
- Simplify the code in _save_time_stamp() (thanks, Daniel!)

v2:
- Add some wordings to the 1st patch why we cannot use mtime/atime here
- Use functions from Path object instead from "os" (thanks to Daniel!)

Thomas Huth (2):
  tests/functional: Set current time stamp of assets when using them
  tests: Evict stale files in the functional download cache after a
    while

 MAINTAINERS                         |  1 +
 scripts/clean_functional_cache.py   | 45 +++++++++++++++++++++++++++++
 tests/Makefile.include              |  1 +
 tests/functional/qemu_test/asset.py | 13 +++++++++
 4 files changed, 60 insertions(+)
 create mode 100755 scripts/clean_functional_cache.py

-- 
2.51.0


