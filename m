Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1612379875B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:48:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeasN-0003oc-VH; Fri, 08 Sep 2023 08:46:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qeasA-0003ge-BJ
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qeas5-0006Kc-Tl
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694177138;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tLdis8F/tO1lHdl8oWYMZgMFP1tSRinX0svjpV5sJh8=;
 b=d3zJqv5nRu6RtXL50c+0i7SXfBaY+4Xhyz//D5Dd6dyepSz6avqKWyUgTqaglWVFJ+KV56
 U/qPIHzNH7yfEyGwjaNkUChqNdG9A1iM1BHcjrf8ir26+k06Oz6MANcH6KxyyGfbp3I3xd
 SjpOeC7dG4kuFfRf6AFSCQaV9gnLbn4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-nnXNWgveO8WwJGdx_2O47Q-1; Fri, 08 Sep 2023 08:45:37 -0400
X-MC-Unique: nnXNWgveO8WwJGdx_2O47Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 371219468A3;
 Fri,  8 Sep 2023 12:45:36 +0000 (UTC)
Received: from work.redhat.com (unknown [10.39.194.211])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EB19200BFEA;
 Fri,  8 Sep 2023 12:45:35 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH v2 00/10] Generate x86 cpu features
Date: Fri,  8 Sep 2023 14:45:24 +0200
Message-Id: <20230908124534.25027-1-twiederh@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=twiederh@redhat.com;
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

Synchronizing the list of cpu features and models with qemu is a recurring
task in libvirt. For x86, this is done by reading qom-list-properties for
max-x86_64-cpu and manually filtering out everthing that does not look like
a feature name, as well as parsing target/i386/cpu.c for cpu models.

This is a flawed, tedious and error-prone procedure. Ideally, qemu
and libvirt would query a common source for cpu feature and model
related information. Meanwhile, converting this information into an easier
to parse format would help libvirt a lot.

This patch series converts the cpu feature information present in
target/i386/cpu.c (`feature_word_info`) into a yaml file and adds a
script to generate the c code from this data.

A patch set to convert the cpu model data (`builtin_x86_defs`) in the
same way will follow.

v1: https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg02005.html

Changes since v1:
* Incorporated changes from
  https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg04241.html.
* Changed data format from xml to yaml, as proposed in
  https://lists.nongnu.org/archive/html/qemu-devel/2023-09/msg01033.html.
  Using json has some drawbacks, see
  https://lists.nongnu.org/archive/html/qemu-devel/2023-08/msg03384.html.
* Rebased on top of current master. Features added in the meantime:
  amx-complex and vmx-enable-user-wait-pause
* Split up the reformatting of feature_word_info.c.inc to make it easier
  to review. These patches could be squashed together before merging.

Tim Wiederhake (10):
  target/i386: Add missing feature names in FEAT_VMX_EPT_VPID_CAPS
  target/i386: Fix feature names in FEAT_VMX_EPT_VPID_CAPS
  target/i386: Fix duplicated feature name in FEAT_KVM
  target/i386: Split out feature_word_info
  target/i386: Translate feature_word_info to yaml
  target/i386: Format feature_word_info.c.inc: Remove comments
  target/i386: Format feature_word_info.c.inc: feat_names
  target/i386: Format feature_word_info.c.inc: Unfold cpuid member
  target/i386: Format feature_word_info.c.inc: Whitespaces and trailing
    commas
  target/i386: Autogenerate feature_word_info.c.inc

 target/i386/cpu.c                   |  677 +-----------------
 target/i386/feature_word_info.c.inc | 1030 +++++++++++++++++++++++++++
 target/i386/feature_word_info.py    |   62 ++
 target/i386/feature_word_info.yaml  |  697 ++++++++++++++++++
 4 files changed, 1790 insertions(+), 676 deletions(-)
 create mode 100644 target/i386/feature_word_info.c.inc
 create mode 100755 target/i386/feature_word_info.py
 create mode 100644 target/i386/feature_word_info.yaml

-- 
2.39.2


