Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C90B724637
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:34:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XjV-00067g-1f; Tue, 06 Jun 2023 10:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xiz-0005b3-PJ
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6Xiw-0001KV-NO
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ge4jdihkScBNcEVqkgKh2RLw5xeyUC0ajU6o0YN3Ua0=;
 b=RnnSnnG8ktEHyhylkFeSdBgR+ZcmcNO/z8Xc+P3SGIa4kFeYvLjJC1/bEB7Ngm14UPzaGI
 q/hexOr1DBZqjrW+toYH0p1kPW5AcEGmiTOQoHMdddr0sir4zVt6iDktbxW3BiKfT6/Z1U
 nGrJo6CZ2RDAL/lZGa+dp9XIjbFreuw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-hw5ghIN4MMG-m7sjeWAuQQ-1; Tue, 06 Jun 2023 10:31:48 -0400
X-MC-Unique: hw5ghIN4MMG-m7sjeWAuQQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-977cb78acfcso232114666b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:31:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061907; x=1688653907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ge4jdihkScBNcEVqkgKh2RLw5xeyUC0ajU6o0YN3Ua0=;
 b=Pg683VBRqdIHF3qRhiBO5P6HWLq7Wd1Cyc8QXcUtPPFKIyQOCKeOiKpZ3GqOcvLIeX
 av/lmvSaW65Lg5xnKapQOw4o8rELBeJ5tSKM/pou/bLayzSz3Rz70XLH/wKbFln2i94M
 eAcuSjAnnbAtkaVBEm5casgyD0lDQT2+1VNPLqkX8jfzZ8qmw/lpG9f3N4t8RHqdNfB+
 d9oljXiU1rLviwBEujOgLvU2IkiUgslwtGBVfAB/uwo6rM+AAb8eWsvIe+qgLkQvuwhN
 9m3DLQBMgqigScE2UidGgVuKLQKmBKlZg08WHU3fWtbcoBaekOOGluxbKovL/r9PEhxZ
 0BUA==
X-Gm-Message-State: AC+VfDygOes7mJMwb67yFSoTnh+IekprRPA5Tn5LEaxxQTAaUBJ18YLX
 KS0RV5B9eYfWIQ0eVVFjD0rcBdv55BiPS6guDrmUErxRslrz2kIuVP3NXay/0sN2XCmY0cu/sR5
 G0XrWrvbcYNW+OE2Q1zkzN2shNJ9Se3269M6S8EJwQT+g4dq66i1bLnIENTuZoWFk/WHjgd5H34
 o=
X-Received: by 2002:a17:907:6d8c:b0:977:1dae:2500 with SMTP id
 sb12-20020a1709076d8c00b009771dae2500mr2359283ejc.1.1686061906955; 
 Tue, 06 Jun 2023 07:31:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7IQ6WOhR//ArdbucUTfm/9ibUkuKz0rCNDX8N2G7UedhVGGA4Du+LcxqPnVID6aKGAxA5Osw==
X-Received: by 2002:a17:907:6d8c:b0:977:1dae:2500 with SMTP id
 sb12-20020a1709076d8c00b009771dae2500mr2359271ejc.1.1686061906756; 
 Tue, 06 Jun 2023 07:31:46 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 ot12-20020a170906cccc00b0096f4c9ce526sm5638194ejb.225.2023.06.06.07.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 07:31:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 18/21] pc-bios/s390-ccw: always build network bootloader
Date: Tue,  6 Jun 2023 16:31:13 +0200
Message-Id: <20230606143116.685644-19-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
References: <20230606143116.685644-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

In the beginning, the network bootloader was considered experimental and
thus optional, but it is well established nowadays and configure always
checks for roms/SLOF before compiling pc-bios/s390-ccw.

Therefore, it makes sense to always build it together with the other
part of the s390-ccw bios.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


