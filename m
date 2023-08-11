Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482077910D
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 15:53:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUSY2-0000dj-9K; Fri, 11 Aug 2023 09:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qUSY0-0000dO-5V
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 09:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <twiederh@redhat.com>)
 id 1qUSXy-00032q-F2
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 09:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691761881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JqIHIUjbjQpm5YZMZ4TDKtlypcxYvEzkhdx9HxYSUzg=;
 b=hpzX+uQwKvJhiM9nFwd/uQlpA/G8UyAbrTYqMuZIaUajm2jLVpW5HALBYB4job3hR99Wn6
 MuJ8dBXsSJxPQxDiVIf5w3lNcSFoGzcLapwFaF0BrTCBz6llVT0ynFIC+u6JmwUPb9zr1B
 5Kh8Xs2yaOjHep7y4nErUnN4/6Dv0uo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-DKU31BBUOGqQbHMJTjTA7w-1; Fri, 11 Aug 2023 09:50:13 -0400
X-MC-Unique: DKU31BBUOGqQbHMJTjTA7w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DD3E28004A7
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 13:50:13 +0000 (UTC)
Received: from work.redhat.com (unknown [10.39.193.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5E55140E96D;
 Fri, 11 Aug 2023 13:50:12 +0000 (UTC)
From: Tim Wiederhake <twiederh@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tim Wiederhake <twiederh@redhat.com>
Subject: [PATCH 0/4] Generate x86 cpu features
Date: Fri, 11 Aug 2023 15:50:07 +0200
Message-Id: <20230811135011.23343-1-twiederh@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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
target/i386/cpu.c (`feature_word_info`) into an xml file and adds a
script to generate the c code from this xml.

A patch set to convert the cpu model data (`builtin_x86_defs`) in the
same way will follow.

Tim Wiederhake (4):
  target/i386: Split out feature_word_info
  target/i386: Translate feature_word_info to xml
  target/i386: Format feature_word_info.c.inc
  target/i386: Autogenerate feature_word_info.c.inc

 target/i386/cpu.c                   |  677 +----------
 target/i386/feature_word_info.c.inc |  704 ++++++++++++
 target/i386/feature_word_info.py    |  110 ++
 target/i386/feature_word_info.xml   | 1610 +++++++++++++++++++++++++++
 4 files changed, 2425 insertions(+), 676 deletions(-)
 create mode 100644 target/i386/feature_word_info.c.inc
 create mode 100755 target/i386/feature_word_info.py
 create mode 100644 target/i386/feature_word_info.xml

-- 
2.39.2


