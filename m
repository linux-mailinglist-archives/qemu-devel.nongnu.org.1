Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B09791B85
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 18:26:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdCOj-0007Os-Qh; Mon, 04 Sep 2023 12:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdCOf-0007Me-Ul
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:25:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qdCOd-0001rv-KA
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 12:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693844751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xi7CuMM1c7mkFaycy94LHIW/D/9DZWG4uAQGSJybtGY=;
 b=TR5k4YYwo8rjZnLbfLufLtEsg/+PIhkm1xJI3REKwXNdmWavmV4R4JHOuM0RVG0tC8sg4B
 mrgUS6c2OeVX5nwLRy9wi1I/9N00xoZIf3abqpFz205AIhpZohBzDeyKvGTVYBcwEXxIX+
 0sbEj9WQgPG4hA99gIn3obvNPU2SK+o=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-464-dcwu184cPXutJcZxlgkgBQ-1; Mon, 04 Sep 2023 12:25:47 -0400
X-MC-Unique: dcwu184cPXutJcZxlgkgBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 35B771817903;
 Mon,  4 Sep 2023 16:25:47 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.42.28.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2962D493110;
 Mon,  4 Sep 2023 16:25:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 William Tsai <williamtsai1111@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 0/1] qom: fix setting of qdev array properties
Date: Mon,  4 Sep 2023 17:25:43 +0100
Message-ID: <20230904162544.2388037-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

By the time of the 8.2.0 release, it will have been 2 years and 6
releases since we accidentally broke setting of array properties
for user creatable devices:

  https://gitlab.com/qemu-project/qemu/-/issues/1090

Some context:

* Initial identification / report on the mailing list

   https://lists.gnu.org/archive/html/qemu-devel/2022-07/msg00111.html

* Sub-thread of that exploring the background on need/use of array
  properties:

   https://lists.gnu.org/archive/html/qemu-devel/2022-07/msg01531.html

* Markus' initial PoC for an order preserving QDict impl

   https://lists.gnu.org/archive/html/qemu-devel/2022-07/msg00758.html

* A later (unrelated?) patch for order preserving QDict impl

   https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03229.html

* A re-posting of the new patch

   https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg00292.html

Personally I'm not a fan of the introducing the order preserving QDict
impl, because I feel that the need to preserve QDict ordering is a
design bug. Not that I think the current ordering when iterating over
QDict is in any way special. I just rather see the ordering left as
"undefined" and any callers that need a specific ordering should apply
what they need.

Since setting device array properties requires that 'len-XXX' be
processed first, so the following patch does exactly that. We iterate
over the properties twice, first setting the 'len-XXX' properties,
then setting everything else.

I still think for user creatable devices we'd be better off just
mandating the use of JSON syntax for -device and thus leveraging
the native JSON array type. This patch was the quick fix for the
existing array property syntax though.

Daniel P. Berrangé (1):
  qom: fix setting of array properties

 qom/object_interfaces.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

-- 
2.41.0


