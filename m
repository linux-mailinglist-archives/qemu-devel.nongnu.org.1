Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F28BF7AF17B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:01:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPi-0002AF-I5; Tue, 26 Sep 2023 12:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPV-000256-HY
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPT-0006fV-VB
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+X4ZFF3Oy6UcO2Mgndzs8r8IIomXYpZkaTF6XIulRg0=;
 b=HMPwW646TmxXOH3/xsj4gcWogDA/i0/r+rDUfn9uQgIH/lreyGHweYfgTAXRGao70znPqd
 3Qd3AY4FbmCDf9DW/6l93Tz7xJeP6PbNIjJ2P1G1Nuc7hgOqfds+6JOupeNiyHx/qvLwj/
 ctEhm/LwbGXJDLhe1yndf2s+JzXvc0c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-Tr5n89RlO9y5TpPlcgqXFQ-1; Tue, 26 Sep 2023 12:59:41 -0400
X-MC-Unique: Tr5n89RlO9y5TpPlcgqXFQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32001e60fb3so5324768f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747580; x=1696352380;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+X4ZFF3Oy6UcO2Mgndzs8r8IIomXYpZkaTF6XIulRg0=;
 b=uB9X3f0Xu9axlde1hUQuV/XHFlxLZ1fHNcRyALKqlWtEHwPn2FcrRjaifyOgQZ1RGL
 /rhzlfuCUgrhVsFpbFZB3qQLtIKg4U2758eoMXnBZut5g26g17OcLZiZpva4pzVV3KRV
 f1sV2AnrN8Uso6atngP/Nux3Q6QBNal14BVpsoi9koGFX7LRI0kGnWYtnUqUO3QoVi1q
 hf/PIDnIWLK6hpMFR8bbFlsdu01/pwFkUcoBQ/RifDYC86ltwtZAUC14/QZ3WQkkFYHa
 4TlBnyFKY+ADNm3NFb/k/WAPQN/WV4w3H5uAHIcOC0FSmrlBwPsh6q2rBvD2CTZT0BXk
 N6qQ==
X-Gm-Message-State: AOJu0YykZ6y0TA2xGAS3u1L7FfSMNiBMv1gQybO4lfoICTFWDeGtSPJp
 Lp1Jwg9ni2VcIjhUa9fvGYgZbhxHGdev0FU06FFkK+C54MtorPHiJp1I8XJgYsWNS9jSyyI4etk
 AYE0FV/pL7r1easgPYQpOFnevduWC1pDNqhVRJk3pcpGIQkVf0hWke8Adj17Uuld+EzyGYp8Ees
 Q=
X-Received: by 2002:adf:ea46:0:b0:323:3062:ef5d with SMTP id
 j6-20020adfea46000000b003233062ef5dmr2333477wrn.33.1695747580164; 
 Tue, 26 Sep 2023 09:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFg1yJZhlfMrde9piwA7TpxgAnLdGsU11RXoUXmmaiF79AJ1qY1CJxtJ2geHqq7xgC+wm7xIA==
X-Received: by 2002:adf:ea46:0:b0:323:3062:ef5d with SMTP id
 j6-20020adfea46000000b003233062ef5dmr2333470wrn.33.1695747579872; 
 Tue, 26 Sep 2023 09:59:39 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a5d608c000000b003179d5aee67sm15214144wrt.94.2023.09.26.09.59.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/19] target/i386/cpu: avoid shadowed local variables
Date: Tue, 26 Sep 2023 18:59:08 +0200
Message-ID: <20230926165915.738719-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

Reuse the pointer variable used for the unversioned model.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7836aa6692f..ed72883bf33 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5976,9 +5976,10 @@ static void x86_register_cpudef_types(const X86CPUDefinition *def)
     /* Versioned models: */
 
     for (vdef = x86_cpu_def_get_versions(def); vdef->version; vdef++) {
-        X86CPUModel *m = g_new0(X86CPUModel, 1);
         g_autofree char *name =
             x86_cpu_versioned_model_name(def, vdef->version);
+
+        m = g_new0(X86CPUModel, 1);
         m->cpudef = def;
         m->version = vdef->version;
         m->note = vdef->note;
-- 
2.41.0


