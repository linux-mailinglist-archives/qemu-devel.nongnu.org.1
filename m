Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACB2744D10
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 11:48:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFtfK-0003lZ-CD; Sun, 02 Jul 2023 05:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtfI-0003jm-1z
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:46:44 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFtfG-0007gf-Lb
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 05:46:43 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-54f75f85a17so1796273a12.0
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 02:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688291201; x=1690883201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IJPRtuvbHAsqaGR1Ln6VUbGyabvHfWSFqdv+KVApqEU=;
 b=SZ6DxrzDPRFD6yltfqE+fWhle8GDnGDeHxTH06+MZgfXVuMfzPKwXiHSXRlnFX7qvY
 BzxQ0Cm+MHM/+jUyDi6sP7JPB+h/QKt1Cjkmpoaivgnlr0aWq4pgseYcDJvHx7gfxT6U
 aL+T1+Lmjt7J8j/ox9PzYmYd2LoXW2uGiZ7U2qajumMYPolvUIqltOufvPVDkUkX5WBc
 U+uMFL3DJs9qrNjFlnDcLrIuL3aNGSUVjn/6I64nu9Z/5R9E2dEruq36GSmnpuxTzsE/
 uycU4iwMaSV3XLnI0pCAXdDv+wVI7lyOU0lnsM4YSSOPUqo3tcKJJ7sU5ISYG5RvdIJU
 eRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688291201; x=1690883201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IJPRtuvbHAsqaGR1Ln6VUbGyabvHfWSFqdv+KVApqEU=;
 b=ESNCa0FcmvMrhJaWhm69l/dDSFw4TIvnNl+IzFBWTO8ss282lsdx2dSEU/gYVxpN2i
 pFF3R17psAbg+gfEnp6HUoEaKoVqD2wW85P8ohNObC2c4lpxhAY8+avY9DTbBvTpkbey
 7pPJ7RiR0e2GoMw3ijJLqeDsUezcBEcmzgkY0XZ8UOA6ppTOwonG1t4T2SD8AbNBm8bY
 Qy1PkEUCg5EnQ7ARwGMjxfCOkb+dy6RqL2eMufAyEikHQXx//RcrvrEiFe4IrXYiMY3D
 P4FMk31JzO4jEg01uHSlgrySgYmTDe8jCox6Wp42kr8QE+Ttng539hUuadk2vQEjrxGY
 HrdA==
X-Gm-Message-State: ABy/qLY/wFAwmL9Dtc68QiV74F6d6HMD1gaDWqT8gDONAW7/+GVNYkrv
 GpHelZvUd+eRDFw2SBR2Rna7UWqV27VyuSdaFsw=
X-Google-Smtp-Source: APBJJlH2QbdS0xQp+mMf2VxJ2dmwE7z9oMUZnMKiQb4iG3LEkvCAG80X3eufyeNNWP07NPyYX+e5gQ==
X-Received: by 2002:a05:6a20:8e0b:b0:12e:7d41:b2f with SMTP id
 y11-20020a056a208e0b00b0012e7d410b2fmr417256pzj.46.1688291201074; 
 Sun, 02 Jul 2023 02:46:41 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 i1-20020a635841000000b005348af1b84csm12934067pgm.74.2023.07.02.02.46.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 02:46:40 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v2 1/4] docs: Fix next function numbers in SR/IOV documentation
Date: Sun,  2 Jul 2023 18:46:25 +0900
Message-ID: <20230702094631.39111-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230702094631.39111-1-akihiko.odaki@daynix.com>
References: <20230702094631.39111-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::531;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The ARI next function number field is undefined for VF so the PF should
end the linked list formed with the field by specifying 0.

This also changes the value of the field for VF; it seems to imply the
value has some meaning if it differs from one of the PF, but it doesn't.

Fixes: 2503461691 ("pcie: Add some SR/IOV API documentation in docs/pcie_sriov.txt")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/pcie_sriov.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/pcie_sriov.txt b/docs/pcie_sriov.txt
index 7eff7f2703..2b7094dc47 100644
--- a/docs/pcie_sriov.txt
+++ b/docs/pcie_sriov.txt
@@ -48,7 +48,7 @@ setting up a BAR for a VF.
       ...
       int ret = pcie_endpoint_cap_init(d, 0x70);
       ...
-      pcie_ari_init(d, 0x100, 1);
+      pcie_ari_init(d, 0x100, 0);
       ...
 
       /* Add and initialize the SR/IOV capability */
@@ -78,7 +78,7 @@ setting up a BAR for a VF.
       ...
       int ret = pcie_endpoint_cap_init(d, 0x60);
       ...
-      pcie_ari_init(d, 0x100, 1);
+      pcie_ari_init(d, 0x100, 0);
       ...
       memory_region_init(mr, ... )
       pcie_sriov_vf_register_bar(d, bar_nr, mr);
-- 
2.41.0


