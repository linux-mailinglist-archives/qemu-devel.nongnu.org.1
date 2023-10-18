Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C01AC7CDA58
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 13:29:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt4jL-0003ji-Uo; Wed, 18 Oct 2023 07:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt4jG-0003hN-V8
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:28:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt4jF-0005dO-0R
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 07:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697628524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zlBi0uAz8yyAaofDaFbNNRcxIrbd/HojO8+WyRCrkSA=;
 b=PWEe/ph7Tsj5gzRjQyU4kQYrwPR4/pTXepM67FTHibcBfftIPiiip1O1I/V8DkQQNsiU00
 dphD01HJSO5nOtHzeid+ua5UPaZXT2/ccLMY26IuAjIZirWPrGXgjosGoAcZ+PC7suDed5
 s+nIyQr3DQnDRcjNXsDN1PrX/XdPJ1A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-76-bzJ_PMkMNoOYeAsZahFiHQ-1; Wed, 18 Oct 2023 07:28:33 -0400
X-MC-Unique: bzJ_PMkMNoOYeAsZahFiHQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBB851C05AF5;
 Wed, 18 Oct 2023 11:28:32 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 00D62492BEE;
 Wed, 18 Oct 2023 11:28:31 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 3/4] migration/doc: How to migrate when hosts have
 different features
Date: Wed, 18 Oct 2023 13:28:26 +0200
Message-ID: <20231018112827.1325-4-quintela@redhat.com>
In-Reply-To: <20231018112827.1325-1-quintela@redhat.com>
References: <20231018112827.1325-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Sometimes devices have different features depending of things outside
of qemu.  For instance the kernel.  Document how to handle that cases.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>

---

If you have some example to put here, I am all ears.  I guess that
virtio-* with some features that are on qemu but not on all kernel
would do the trick, but I am not a virtio guru myself.  Patches
welcome.
---
 docs/devel/migration.rst | 97 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/docs/devel/migration.rst b/docs/devel/migration.rst
index 6fe275b1ec..974505e4a7 100644
--- a/docs/devel/migration.rst
+++ b/docs/devel/migration.rst
@@ -1138,3 +1138,100 @@ machine types to have the right value::
     +    { "virtio-blk-device", "num-queues", "1"},
          ...
      };
+
+A device with diferent features on both sides
+---------------------------------------------
+
+Let's assume that we are using the same QEMU binary on both sides,
+just to make the things easier.  But we have a device that has
+different features on both sides of the migration.  That can be
+because the devices are different, because the kernel driver of both
+devices have different features, whatever.
+
+How can we get this to work with migration.  The way to do that is
+"theoretically" easy.  You have to get the features that the device
+has in the source of the migration.  The features that the device has
+on the target of the migration, you get the intersection of the
+features of both sides, and that is the way that you should launch
+QEMU.
+
+Notice that this is not completely related to QEMU.  The most
+important thing here is that this should be handled by the managing
+application that launches QEMU.  If QEMU is configured correctly, the
+migration will succeed.
+
+That said, actually doing it is complicated.  Almost all devices are
+bad at being able to be launched with only some features enabled.
+With one big exception: cpus.
+
+You can read the documentation for QEMU x86 cpu models here:
+
+https://qemu-project.gitlab.io/qemu/system/qemu-cpu-models.html
+
+See when they talk about migration they recommend that one chooses the
+newest cpu model that is supported for all cpus.
+
+Let's say that we have:
+
+Host A:
+
+Device X has the feature Y
+
+Host B:
+
+Device X has not the feature Y
+
+If we try to migrate without any care from host A to host B, it will
+fail because when migration tries to load the feature Y on
+destination, it will find that the hardware is not there.
+
+Doing this would be the equivalent of doing with cpus:
+
+Host A:
+
+$ qemu-system-x86_64 -cpu host
+
+Host B:
+
+$ qemu-system-x86_64 -cpu host
+
+When both hosts have different cpu features this is guaranteed to
+fail.  Especially if Host B has less features than host A.  If host A
+has less features than host B, sometimes it works.  Important word of
+last sentence is "sometimes".
+
+So, forgetting about cpu models and continuing with the -cpu host
+example, let's see that the differences of the cpus is that Host A and
+B have the following features:
+
+Features:   'pcid'  'stibp' 'taa-no'
+Host A:        X       X
+Host B:                        X
+
+And we want to migrate between them, the way configure both QEMU cpu
+will be:
+
+Host A:
+
+$ qemu-system-x86_64 -cpu host,pcid=off,stibp=off
+
+Host B:
+
+$ qemu-system-x86_64 -cpu host,taa-no=off
+
+And you would be able to migrate between them.  It is responsability
+of the management application or of the user to make sure that the
+configuration is correct.  QEMU doesn't know how to look at this kind
+of features in general.
+
+Notice that we don't recomend to use -cpu host for migration.  It is
+used in this example because it makes the example simpler.
+
+Other devices have worse control about individual features.  If they
+want to be able to migrate between hosts that show different features,
+the device needs a way to configure which ones it is going to use.
+
+In this section we have considered that we are using the same QEMU
+binary in both sides of the migration.  If we use different QEMU
+versions process, then we need to have into account all other
+differences and the examples become even more complicated.
-- 
2.41.0


