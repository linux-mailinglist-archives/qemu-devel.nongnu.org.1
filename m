Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7923D7222A4
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 11:53:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q66tJ-0002nf-RE; Mon, 05 Jun 2023 05:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tF-0002mn-OE
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q66tE-0006lg-3J
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 05:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685958759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BNrpPzqOcJXXm/37Nr/jLdT14Il3H1CTilJU+kXrBCQ=;
 b=aGLuhlquUrPsVkphn7k1fOpkPuEv3C5K3efRJjDVEBtP3mMxNegxlE5yTqnk9T3Jy67W5W
 7FBI64rK7065biqxq4OCHWkuved6D3JLAT0l9K4IUKrcofiZOrL6R8RUVaFQ/pUyP0fZ4g
 GmXRe9rkFyNA8CrxOlhEMSCiU8Y+eek=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-2UYCg79-Mo2y-95IIAxcDQ-1; Mon, 05 Jun 2023 05:52:38 -0400
X-MC-Unique: 2UYCg79-Mo2y-95IIAxcDQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a34e35f57so316050066b.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 02:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685958756; x=1688550756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BNrpPzqOcJXXm/37Nr/jLdT14Il3H1CTilJU+kXrBCQ=;
 b=JReysX5fKslrIX5N6zllbQRjB0H20uLh49gDfgq8mbkYK+GUNezEC8X9zYZ43U0UC6
 CC1L5JO6PzTbZXCjRy8iPMOXGgIM/KvdREl8h7z/2hk9IwSkWF/49Hkfh78y0eioUaDb
 Wq1fPMdxr7gSs2siSP4Bg++RvZiq01RLb9ezdh/Rpvf6YDB/uEOH05NCpHIF4nfsqtaj
 psDripy7plL9i+woVbw6TgdRrRz1z/QDYLpF5fKfDxp/syR2vLikhT/oMpgafPyJAydY
 m+AEbGc6bRGWIjmEw92kBxooDJb8wTBOSayMvlsIesdMJ7HSkF/k0ACHHIdBossmtRLu
 ZWqg==
X-Gm-Message-State: AC+VfDxcc4Bh1pkPXNeN8Gt4W0yDKxObHtsgzsuEtgbNYV/x5W2h55Hb
 /027zNZR7VMz2IEw8BiL+ofSEPbm46R6MCyKS3t0ob0zPywP5pQEgfvuWio8SEDnOL/lNpma2FG
 M4iI3WQ0eVzI5e/RpLHVAssCGDHTtDJzCekDnD+SoWmRGDbZsv2+eP8lSheVSTK73I8vsBYw04C
 Y=
X-Received: by 2002:a17:907:a41f:b0:973:daaa:f3e1 with SMTP id
 sg31-20020a170907a41f00b00973daaaf3e1mr6346361ejc.39.1685958756688; 
 Mon, 05 Jun 2023 02:52:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7m1BzqnWgd54Au8gmT4udBILsXcG5AEOBY3A9jrwh/JNuU9zpuIs3+tDBqkczbcMLzW6Frrg==
X-Received: by 2002:a17:907:a41f:b0:973:daaa:f3e1 with SMTP id
 sg31-20020a170907a41f00b00973daaaf3e1mr6346348ejc.39.1685958756471; 
 Mon, 05 Jun 2023 02:52:36 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a170906970f00b00965b5540ad7sm4171046ejx.17.2023.06.05.02.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jun 2023 02:52:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com,
	berrange@redhat.com
Subject: [PATCH 07/10] pc-bios/s390-ccw: always build network bootloader
Date: Mon,  5 Jun 2023 11:52:20 +0200
Message-Id: <20230605095223.107653-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605095223.107653-1-pbonzini@redhat.com>
References: <20230605095223.107653-1-pbonzini@redhat.com>
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

In the beginning, the network bootloader was considered experimental and
thus optional, but it is well established nowadays and configure always
checks for roms/SLOF before compiling pc-bios/s390-ccw.

Therefore, it makes sense to always build it together with the other
part of the s390-ccw bios.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 pc-bios/s390-ccw/Makefile | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 9c5276f8ade..2e8cc015aa0 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -67,12 +67,7 @@ s390-ccw.img: s390-ccw.elf
 
 $(OBJECTS): Makefile
 
-ifneq ($(wildcard $(SRC_PATH)/../../roms/SLOF/lib/libnet),)
 include $(SRC_PATH)/netboot.mak
-else
-s390-netboot.img:
-	@echo "s390-netboot.img not built since roms/SLOF/ is not available."
-endif
 
 ALL_OBJS = $(sort $(OBJECTS) $(NETOBJS) $(LIBCOBJS) $(LIBNETOBJS))
 -include $(ALL_OBJS:%.o=%.d)
-- 
2.40.1


