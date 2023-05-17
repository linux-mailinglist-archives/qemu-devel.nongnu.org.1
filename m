Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9E6707025
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLH4-00058y-SG; Wed, 17 May 2023 13:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEg-0001d9-BP
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEe-0004Ps-Ij
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mG9RV/wEzHBntPeSF5MlucOTxAQIk0J7mP2S/5XHYJY=;
 b=TwXO5fZfZOCf5HtxhTYtmk3K7F5TRaHDWtHU66AixDrgLeRlB9AEYjVOFkA0Wr4t+mFk2q
 K+qCoT8E3aR+z7vZdY1SgIk/4YUyfxpZq7mD5cS1h1COjoG9qgJ5Axu5xGnCR3DePu9jp/
 dGR+fAOD52C3+G46qJHdMeVTJcZpo30=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-32UQ6sgCNP-TFDYWwV0BgQ-1; Wed, 17 May 2023 13:46:46 -0400
X-MC-Unique: 32UQ6sgCNP-TFDYWwV0BgQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f426514683so4396355e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345605; x=1686937605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mG9RV/wEzHBntPeSF5MlucOTxAQIk0J7mP2S/5XHYJY=;
 b=UsIJm9DnlHkpIb3173/QYBtpOs28wiWWpEjhVgBDqa8IQzLgO8RTV5OEV/cCDO6M7Y
 Lyv3LVH29hGAk+yX2n/9tu0myK7gWH2k6HRgUFlaBeQO6eYWyBBubW6DJkIOv7OnrFhb
 0XU+pHP1r806KWpKL6UTOU9BysJ/mPvAJVQFqSz1Gbl5N/Csfv2fhnbQVdpPsRmt2o/N
 5Ph+e0L3zfkOWyvGG17si6vftwnxEJGN8Fciaix3vStsMGbhSh6n9E4BzoXiLsw62kDx
 C7L9buiFBgOTtmY/Fj49vYs7etNwvbBBPEkl6bJhYTHOCtN2+2Ig4onQ0u3Rcdp0Fkso
 LSgg==
X-Gm-Message-State: AC+VfDx6aZ8iVJefo5hUK9V0/swZfPUVVkCDRCEgBOyoaJXp5vb6z2kx
 BO4TEbvkq7KnWcRysoqYNNcTBP/qbkEOh7eGCGG69auGN3ONnGwtta4oK+NbGaAupRIeeTLAbrA
 +UGS/OvNnzbRjRvZRwSdy0sSdikrjJphtcciV9YrwKYC56NfCDdPGU/vILPhOcuF9pSR7C7rTad
 s=
X-Received: by 2002:a05:600c:2305:b0:3f5:d3c6:737d with SMTP id
 5-20020a05600c230500b003f5d3c6737dmr837810wmo.39.1684345604792; 
 Wed, 17 May 2023 10:46:44 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6c55JgDR6IXneH1h0+ccVOIRHjDFr8ZIzCvs5LNfVJXZak9kb/JxXnY+GCfOKABZGwxHUlAQ==
X-Received: by 2002:a05:600c:2305:b0:3f5:d3c6:737d with SMTP id
 5-20020a05600c230500b003f5d3c6737dmr837800wmo.39.1684345604386; 
 Wed, 17 May 2023 10:46:44 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 f6-20020a1c6a06000000b003f427cba193sm2812575wmc.41.2023.05.17.10.46.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 50/68] meson: drop unnecessary declare_dependency()
Date: Wed, 17 May 2023 19:45:02 +0200
Message-Id: <20230517174520.887405-51-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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

The libvfio_user_dep variable of subprojects/libvfio-user/lib/meson.build
is already a dependency, so there is no need to wrap it with another
declare_dependency().

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/meson.build b/meson.build
index 464890d99ac0..88fba57cca81 100644
--- a/meson.build
+++ b/meson.build
@@ -2720,9 +2720,7 @@ if have_system and vfio_user_server_allowed
 
   libvfio_user_proj = subproject('libvfio-user')
 
-  libvfio_user_lib = libvfio_user_proj.get_variable('libvfio_user_dep')
-
-  libvfio_user_dep = declare_dependency(dependencies: [libvfio_user_lib])
+  libvfio_user_dep = libvfio_user_proj.get_variable('libvfio_user_dep')
 endif
 
 fdt = not_found
-- 
2.40.1


