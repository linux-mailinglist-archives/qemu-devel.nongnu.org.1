Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC613788CE8
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 18:01:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZZDk-0001SX-Fq; Fri, 25 Aug 2023 11:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qZZDi-0001Re-HT
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qZZDd-0004i9-Cp
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:59:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692979167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=oUbIr22MSsNuH1ZvogXQ24d9gyPr3Ubo6tttNYFFXGk=;
 b=ITRvE1+opKMs4LNEoOJ6xnoWuDWIxT/UXS+ofe1kNcJfURCNv5b+QopiXpiiO1X6A8lT+8
 LxRD7ZOCvrFbzqjgO7x/iH9ThWJT5ZBcw+kTgSZ2iWee10ov09PmD1yrQhTNrNKg6zKnSv
 ufvW4JNiS1lMTTpbS2ygU64vBzpP2fk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-yIQdng-WNrWS0tvepXQqJw-1; Fri, 25 Aug 2023 11:59:25 -0400
X-MC-Unique: yIQdng-WNrWS0tvepXQqJw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4599108BF61;
 Fri, 25 Aug 2023 15:59:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.86])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A4BAC40D283A;
 Fri, 25 Aug 2023 15:59:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9AC6D21E690D; Fri, 25 Aug 2023 17:59:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, dave@treblig.org, thuth@redhat.com,
 qemu-block@nongnu.org, berrange@redhat.com, dgilbert@redhat.com,
 qemu-trivial@nongnu.org
Subject: [PATCH 0/2] docs tests: Fix use of migrate_set_parameter
Date: Fri, 25 Aug 2023 17:59:21 +0200
Message-ID: <20230825155923.1983141-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

I spotted a bad use of migrate_set_parameter in test-hmp.c, and looked
for more.

I also looked for more failing HMP commands in test-hmp.c.  I found
some, but they fail only on some machines, which feels okay.  They
are:

* device_add usb-mouse,id=mouse1
  device_del mouse1

  Fail when the device is not compiled in, and when the machine
  doesn't provide USB.

* memsave 0 4096 "/dev/null"

  Fails when the machine doesn't have memory there.

* screendump /dev/null

  Fails when there is no console.

* dump-guest-memory /dev/null 0 4096

  Fails for targets that don't support dumping, and when the machine
  doesn't have memory there.

* nmi

  Fails when the machine doesn't provide NMIs.

Markus Armbruster (2):
  docs tests: Fix use of migrate_set_parameter
  tests/qtest/test-hmp: Fix migrate_set_parameter xbzrle-cache-size test

 docs/multi-thread-compression.txt | 12 ++++++------
 docs/rdma.txt                     |  2 +-
 tests/qtest/test-hmp.c            |  6 +++---
 tests/qemu-iotests/181            |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

-- 
2.41.0


