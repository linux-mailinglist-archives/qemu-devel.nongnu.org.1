Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A9B79D04E
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 13:46:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg1ll-0004EJ-7C; Tue, 12 Sep 2023 07:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg1lj-0004DJ-00
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qg1lg-00034B-Ob
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 07:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694518880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sslEPt2l/B+52i7MHt49StiyA6tp17JZtLHfUQqi7ac=;
 b=ItwqxGDpzH14eYa0LPyQ6JxcKigChnoJayPVeHQjZ7hgJKFS09Bk2W7uU6qNHbGwgVgcFx
 BGPQAi4LQXjOPAZX575NYxUelRvz0B0/BarkrLjIljsntfkbL65XmyH8QSZ/lK0+gkD0F8
 nrZbHcsmRIY0dMhOQitjacegbNByy74=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-FEEI5Q5-PdSbz_w6lJYLlQ-1; Tue, 12 Sep 2023 07:41:17 -0400
X-MC-Unique: FEEI5Q5-PdSbz_w6lJYLlQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9931B101FAA3;
 Tue, 12 Sep 2023 11:41:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.161])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86FCD1054FC0;
 Tue, 12 Sep 2023 11:41:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Viktor Mihajlovski <mihajlov@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PULL 2/7] s390x: do a subsystem reset before the unprotect on reboot
Date: Tue, 12 Sep 2023 13:41:07 +0200
Message-ID: <20230912114112.296428-3-thuth@redhat.com>
In-Reply-To: <20230912114112.296428-1-thuth@redhat.com>
References: <20230912114112.296428-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

From: Janosch Frank <frankja@linux.ibm.com>

Bound APQNs have to be reset before tearing down the secure config via
s390_machine_unprotect(). Otherwise the Ultravisor will return a error
code.

So let's do a subsystem_reset() which includes a AP reset before the
unprotect call. We'll do a full device_reset() afterwards which will
reset some devices twice. That's ok since we can't move the
device_reset() before the unprotect as it includes a CPU clear reset
which the Ultravisor does not expect at that point in time.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <20230901114851.154357-1-frankja@linux.ibm.com>
Tested-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 3dd0b2372d..2d75f2131f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -438,10 +438,20 @@ static void s390_machine_reset(MachineState *machine, ShutdownCause reason)
     switch (reset_type) {
     case S390_RESET_EXTERNAL:
     case S390_RESET_REIPL:
+        /*
+         * Reset the subsystem which includes a AP reset. If a PV
+         * guest had APQNs attached the AP reset is a prerequisite to
+         * unprotecting since the UV checks if all APQNs are reset.
+         */
+        subsystem_reset();
         if (s390_is_pv()) {
             s390_machine_unprotect(ms);
         }
 
+        /*
+         * Device reset includes CPU clear resets so this has to be
+         * done AFTER the unprotect call above.
+         */
         qemu_devices_reset(reason);
         s390_crypto_reset();
 
-- 
2.41.0


