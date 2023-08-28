Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6E778AC77
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:40:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZeI-0003IY-F6; Mon, 28 Aug 2023 06:39:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeF-0003I9-La
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeD-00053E-65
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkBVuS+6agitdw186DJC/AMPSh4wQnuDJvm2qT0ChKk=;
 b=CCKpUo/aXNHIAr4YaLlvIG3rN3AmJFrrML41/53qy8Npp4zrheUNLwMMs2ERuOtHbAs/79
 +EaM4dftatkR2bSFsvhiMW6Z+rEzrgEhBgCdmQyNpfYKM0XoQ7pmCOt2AT83rbzKgj4fvO
 rJ0nGpUCGPNozyeEzVMySInGFuacBBs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-PJnpglpBM_OLpYglAuVluQ-1; Mon, 28 Aug 2023 06:39:02 -0400
X-MC-Unique: PJnpglpBM_OLpYglAuVluQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-317a84a3ebeso2132937f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219140; x=1693823940;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RkBVuS+6agitdw186DJC/AMPSh4wQnuDJvm2qT0ChKk=;
 b=fEO4r5quwapTBHEavpxgKOG/KHr8vaXYkHnvGb8ChQSbdOGyAvA+EoLOPxHH3CmV9O
 GIwrHR0QGfmhnTyY/95oB/WtZH/O5+LtNKgOP/pFu+wLmjpcB2I3VYvKS8RyufDYgUD6
 46lMSDeLg9jHUGsfIaP2OQvl3WWdgjNdrLq/4IaZJ1C+1r8NO1//NUyYq+G7NaQn6au5
 4q5nD+JcbrHapsatrLgprCEcCqtPqjeaSxYb57Atykl9mThcnWxFnERnp1wwrpCiID0K
 +BnbRJuenleirakykaFRC2Nt+zAG+i3yPAamAsHKSRIZpOnof+3llY6RaThYPEzRKpu5
 X+NA==
X-Gm-Message-State: AOJu0YwHyPRqfYtTpoHtj2wahkIN+bY6D1OENWjIJJlbIT49O5ILx1SS
 duXp9DHXes9yo7Q73yovpN70HaPJ6D5vSx4iWi29h05I6AoOZJwOoFCDe1pHo/+EYjzo18quHBy
 1JMPLJl/yOM2KkIIB7D1ZUKtEWkRc/Lg3XAn+xILbWEPHHuLBNRQGUQdRVHgf6lC7Cb9uts59Jg
 k=
X-Received: by 2002:adf:e9ce:0:b0:319:789f:fcda with SMTP id
 l14-20020adfe9ce000000b00319789ffcdamr21583742wrn.9.1693219140666; 
 Mon, 28 Aug 2023 03:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjJYhwo1uoZ2rEJeSoxJsT9WV0nON43GlVvX7gA7lr9dAJUypRfiWI9kcMQ95kyfe72lYTLw==
X-Received: by 2002:adf:e9ce:0:b0:319:789f:fcda with SMTP id
 l14-20020adfe9ce000000b00319789ffcdamr21583725wrn.9.1693219140265; 
 Mon, 28 Aug 2023 03:39:00 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h8-20020adffd48000000b00318147fd2d3sm10139706wrs.41.2023.08.28.03.38.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:38:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/14] configure: fix and complete detection of tricore tools
Date: Mon, 28 Aug 2023 12:38:40 +0200
Message-ID: <20230828103856.46031-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

The tricore tools are not detected when they are installed in
the host system, only if they are taken from an external
container.  For this reason the build-tricore-softmmu job
was not running the TCG tests.

In addition the container provides all tools, not just as/ld/gcc,
so there is no need to special case tricore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/configure b/configure
index 133f4e32351..f2bd8858d6c 100755
--- a/configure
+++ b/configure
@@ -1271,6 +1271,7 @@ fi
 : ${cross_prefix_sh4="sh4-linux-gnu-"}
 : ${cross_prefix_sparc64="sparc64-linux-gnu-"}
 : ${cross_prefix_sparc="$cross_prefix_sparc64"}
+: ${cross_prefix_tricore="tricore-"}
 : ${cross_prefix_x86_64="x86_64-linux-gnu-"}
 
 : ${cross_cc_aarch64_be="$cross_cc_aarch64"}
@@ -1458,10 +1459,6 @@ probe_target_compiler() {
       tricore)
         container_image=debian-tricore-cross
         container_cross_prefix=tricore-
-        container_cross_as=tricore-as
-        container_cross_ld=tricore-ld
-        container_cross_cc=tricore-gcc
-        break
         ;;
       x86_64)
         container_image=debian-amd64-cross
-- 
2.41.0


