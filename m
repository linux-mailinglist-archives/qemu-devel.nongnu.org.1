Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E87A21E19
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Jan 2025 14:46:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td8NR-0007g3-D5; Wed, 29 Jan 2025 08:45:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NN-0007cY-6H
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:45:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1td8NJ-0008Aj-Lf
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 08:45:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738158300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VO91E1FlAM+qaGkzqg2uqgrKeXOgETMx8CjvOfgixsc=;
 b=L1G4YsyxI5SLEGmZ1bu7EtUZVXQfd5Z/Uzk1lP3/ad6LDNwmNgbfAyCmU7MhlSppxGGjG9
 TLsKfSbziF1Y1hwUBSaaJP9kSiHjXExo5EIBFRgSvWkCPrI4+nP24IYcO8sJp30pD1vOCG
 d1Vbgg+MuI3g4rhJICx82PzWMHpu588=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-Y8bpypsLPCK7t24Ue7PIag-1; Wed,
 29 Jan 2025 08:44:55 -0500
X-MC-Unique: Y8bpypsLPCK7t24Ue7PIag-1
X-Mimecast-MFC-AGG-ID: Y8bpypsLPCK7t24Ue7PIag
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 474E51800361; Wed, 29 Jan 2025 13:44:53 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E5ADC1800352; Wed, 29 Jan 2025 13:44:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 imp@bsdimp.com, kevans@freebsd.org, gaosong@loongson.cn, laurent@vivier.eu
Subject: [PATCH 3/6] m68k: reset vcpu after it's created
Date: Wed, 29 Jan 2025 14:44:33 +0100
Message-ID: <20250129134436.1240740-4-imammedo@redhat.com>
In-Reply-To: <20250129134436.1240740-1-imammedo@redhat.com>
References: <20250129134436.1240740-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Reseting vcpu before its thread is created, caused various issues in the past
for other targets. It doesn't cause issues for m68k at the moment but
to be consistent with the rest of targets, move reset during realize time
after qemu_init_vcpu().

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 target/m68k/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 41dfdf5804..3fd2663fb0 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -334,8 +334,8 @@ static void m68k_cpu_realizefn(DeviceState *dev, Error **errp)
 
     m68k_cpu_init_gdb(cpu);
 
-    cpu_reset(cs);
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
 
     mcc->parent_realize(dev, errp);
 }
-- 
2.43.0


