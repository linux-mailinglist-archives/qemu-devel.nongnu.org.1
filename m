Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB1D707048
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:59:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLF3-0001qI-0d; Wed, 17 May 2023 13:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEJ-0008UH-Hc
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEI-0004KB-1P
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345585;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rw+P8uHeSMURxVOwYqGlxgsOL1z8Zr5ZjIA/UkRecQ4=;
 b=OIpDZMpa7shV8i6/NamLoQfzipnK9rtrmMOeWehkPLtKYZc04btiYkFnGJHjhT6cY3AHIQ
 IBdOZ18yJYHfRtTAB5DpspMvYGrStMaGPNiHKt2Q5bb0KtieJI1JJHAFX2v0ALK/+wd71S
 FsBYoLxsLT+1zuCcbbepUELbS5FoFVs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-n9GfwjuAMPi_fde_fTZQBQ-1; Wed, 17 May 2023 13:46:24 -0400
X-MC-Unique: n9GfwjuAMPi_fde_fTZQBQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f42b226871so4969505e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345583; x=1686937583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rw+P8uHeSMURxVOwYqGlxgsOL1z8Zr5ZjIA/UkRecQ4=;
 b=IkVNTl0lmoSAcT8NxePAXUROAYLuX+TN5PDUaQTMrLJEZaUPotf+aMacNISBXlUL1C
 DRrKsfPM04viNzGXl9AOkSNOJBYyTKfZbuPiRHS8+A8uysuTJULZeP52sICJ6nHai2Jr
 qNB43Z3W9hdqDcRwn/S19TabFbGKaU/lrA38V6WLAGiJmgMPoUiKGYxcGWVHLkC/wXX/
 wadw0PzFaRZaDe1gPF2MhSYWFmrR7b4rYdTqyfizsFsOlj3sS706lljkhzKRPs/KeLgT
 dHAphSdz+OSTpm7FZaMNXwx4MzV91Jbz5WSjZc75iTAGzoWieyjEFZivrckELnxJLrK1
 xWwg==
X-Gm-Message-State: AC+VfDzBxi1WVLQkcqlOfI0TQiiMPoqNDHh3lH6HqOzTE+Fb1P1M4kx1
 vu+xLWc+sCFTUGYgI4uV5o93e+XoOpPAh+gaU8iiktuwpUHPC4X9E3gkHH0TGofM8C39Bo3asng
 Z6WrOdvfqsOQJPbP6oDeZ2NlU/JZZVEEwLOWRYYhplGr3S7yADVTPZWtTqu7pzXOPP9ablP1wMy
 8=
X-Received: by 2002:a1c:7315:0:b0:3f1:bb10:c865 with SMTP id
 d21-20020a1c7315000000b003f1bb10c865mr27856168wmb.38.1684345582738; 
 Wed, 17 May 2023 10:46:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7N+gHhTxbPUS3UGeXA67m1bJXsTrjlV2gpUeH/qZCzmP/r9077Wqqf83jYoqiHp438TVvlUg==
X-Received: by 2002:a1c:7315:0:b0:3f1:bb10:c865 with SMTP id
 d21-20020a1c7315000000b003f1bb10c865mr27856157wmb.38.1684345582392; 
 Wed, 17 May 2023 10:46:22 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 w19-20020a1cf613000000b003f42461ac75sm2903100wmc.12.2023.05.17.10.46.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 36/68] qemu.git: drop meson git submodule
Date: Wed, 17 May 2023 19:44:48 +0200
Message-Id: <20230517174520.887405-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Now that meson is installed from a vendored wheel, we don't need the git
submodule anymore. Drop it.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-19-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitmodules | 3 ---
 meson       | 1 -
 2 files changed, 4 deletions(-)
 delete mode 160000 meson

diff --git a/.gitmodules b/.gitmodules
index 6ce5bf49c588..2a3a12033c4b 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -49,9 +49,6 @@
 [submodule "roms/qboot"]
 	path = roms/qboot
 	url = https://gitlab.com/qemu-project/qboot.git
-[submodule "meson"]
-	path = meson
-	url = https://gitlab.com/qemu-project/meson.git
 [submodule "roms/vbootrom"]
 	path = roms/vbootrom
 	url = https://gitlab.com/qemu-project/vbootrom.git
diff --git a/meson b/meson
deleted file mode 160000
index 3a9b285a55b9..000000000000
--- a/meson
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit 3a9b285a55b91b53b2acda987192274352ecb5be
-- 
2.40.1


