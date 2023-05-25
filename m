Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 53884710E16
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 16:17:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Bl9-0004f3-O2; Thu, 25 May 2023 10:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bks-0004WZ-N3
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q2Bkr-0007ZX-79
 for qemu-devel@nongnu.org; Thu, 25 May 2023 10:15:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685024148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbaiOJ+X9dPem4hTQLiSjkY45220lj4bM9vCCks40hU=;
 b=hTAbNcFdQAyy8W5VIzeQEx80cDFPtl8y6kkxX9d8j4F4g3BWa+cmsT4ZB4Rq54pbU4pdRG
 pbQa5Pft4VsCgwSCDRq1VX/eAf59og0X4kiwflp4ZOHWHD7GlbqJ5n2s/2vhutE2tdyxFp
 uayDU4AXYgbAfwvIwZq718Bb4Tw4wb0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-K5Pt6cZgNuicshNX-XV2bQ-1; Thu, 25 May 2023 10:15:39 -0400
X-MC-Unique: K5Pt6cZgNuicshNX-XV2bQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-513f4c301e8so2758181a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 07:15:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685024138; x=1687616138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CbaiOJ+X9dPem4hTQLiSjkY45220lj4bM9vCCks40hU=;
 b=WYwtC9oBjbQZ/sXtVnc2DYvtBY7SVCXxESdaSa8cAY72Pz1FDjvULgmLa5BGeyJ8M4
 n07JeNjRX/Kk6cnG9qM8D3+TG6RZRBqwcS2M3Xj38dDgiKyQywbPBmN7p5S0LmOxWD1b
 bqBAnbXK0fuFqGYB27tJwM8CZtOadDvG6PGI7DNJLPwR52rNzgGYyTRlDYZH5CYVSB8N
 mlDQlFaAC8fIHZY513a9iHTSJ31PuedTL1wrOhKQezGvb0MLSB+MUwMyB2Sg0c7ZIIpk
 y4RWETOqljdrKjjOwiGUv8E2aPdtxg8FdmdXDBdQX5meB8q+toyFS9wf7AAA1RN+XxQi
 qfvw==
X-Gm-Message-State: AC+VfDyD4OzxPQZywVLLVKdi0GhDBSpTEYz70KPtE6wElIAFfR67z+lb
 8PUUOoSwm9ipY43X79byM7gWrgG4fRAJI/EMqXidG1Dh1/RBNfsnEcuXHATzOo0HdOa398uU7x6
 LW1bA3SPnAfiAckAfXwC3mU2wcyKotkPBd97zGfij6z3lzb4dRc1ct9ZnC/8bIcmEAgTohI9qp5
 4=
X-Received: by 2002:aa7:d448:0:b0:509:d7d0:d71a with SMTP id
 q8-20020aa7d448000000b00509d7d0d71amr5074986edr.26.1685024138006; 
 Thu, 25 May 2023 07:15:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ohVSuPlRq9hKLYVvwpQu99Byyl4T1ent/ynfk2oV/YRPbwfvYgtrZpWbMrILwhJsh6tTyNw==
X-Received: by 2002:aa7:d448:0:b0:509:d7d0:d71a with SMTP id
 q8-20020aa7d448000000b00509d7d0d71amr5074973edr.26.1685024137774; 
 Thu, 25 May 2023 07:15:37 -0700 (PDT)
Received: from [192.168.10.117] ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.gmail.com with ESMTPSA id
 d8-20020a50fb08000000b00502689a06b2sm583730edq.91.2023.05.25.07.15.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 07:15:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/20] meson: fix rule for qemu-ga installer
Date: Thu, 25 May 2023 16:15:15 +0200
Message-Id: <20230525141532.295817-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525141532.295817-1-pbonzini@redhat.com>
References: <20230525141532.295817-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The bindir variable is not available in the "glib" variable, which is an internal
dependency (created with "declare_dependency").  Use glib_pc instead, which contains
the variable as it is instantiated from glib-2.0.pc.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/meson.build b/qga/meson.build
index 622b5f94a232..d3291b4376cb 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -154,7 +154,7 @@ if targetos == 'windows'
                               qemu_ga_msi_arch[cpu],
                               qemu_ga_msi_vss,
                               '-D', 'BUILD_DIR=' + meson.project_build_root(),
-                              '-D', 'BIN_DIR=' + glib.get_variable('bindir'),
+                              '-D', 'BIN_DIR=' + glib_pc.get_variable('bindir'),
                               '-D', 'QEMU_GA_VERSION=' + config_host['QEMU_GA_VERSION'],
                               '-D', 'QEMU_GA_MANUFACTURER=' + config_host['QEMU_GA_MANUFACTURER'],
                               '-D', 'QEMU_GA_DISTRO=' + config_host['QEMU_GA_DISTRO'],
-- 
2.40.1


