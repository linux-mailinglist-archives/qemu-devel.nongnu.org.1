Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 87046707058
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 20:01:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLGi-00043V-Vj; Wed, 17 May 2023 13:49:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEW-00009Z-Vj
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLER-0004Lk-1Q
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYwBoQfoPq8gzyxMAjFuE9dhgscDIFH9kaTNoAGSNNY=;
 b=V1FHgvdtU/ngN64inz5RE6YXcACvro7pnC9NHWExS5uSEzxjM49v3w+QmBGTbD75AMnVzb
 ulIBXTSvab62yKsYwCy3U8a5LdoUHnUj78augoyU6dY9/hL25ww7JK6EFVSblUYvz0FUMi
 m4HPjkvFDycHYDi7klnyEnKRYuHlM+g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-72vcZyboO_6QyNr0qwUkng-1; Wed, 17 May 2023 13:46:20 -0400
X-MC-Unique: 72vcZyboO_6QyNr0qwUkng-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30629b36d9bso471568f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345575; x=1686937575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYwBoQfoPq8gzyxMAjFuE9dhgscDIFH9kaTNoAGSNNY=;
 b=IgtyPw3OYJDRjkz8gp7tjfjSo9JK1PWxZf2CyJhZ60PAsDMqTux/qAgsgkYAFkeiyX
 rxxG+ynEcKcSY/Yf7JTvUGTPJ13CYQdS6h+mXRNG7Cg8JwPx8sGASaPQP2JwnlePCZnl
 6IyuCoC7N60vHUrjbu1hdn+VNNUSRhnbu+aLduJA3O3/SfRxZxk7/cFptZnptkAR+VKC
 e2+RZ2w6qyPF62MA0Li6EFHehWpbD0YsGZor2Y0eBrpUjyloX5CK2dLFb31IM7PMyIzb
 z+o/rzMQKzTE+bkifgTEJx1ORnU6pcR765xUvrcCG/ipTweleHwzaAHgZNXQTYwfdZ2x
 45KQ==
X-Gm-Message-State: AC+VfDyfiThSw+NBDXySDzNhTKKqAADAlqURrEGowgdvwzKOvWxgOOY5
 GKO2PXXRi6G6hmnIjY26TY3mjLTv8gqqNum6iAK7IpOf/kSJxxXm7Iep0uMME189sCpLW7Esn6A
 IWJvHR9kusqY2TQAaRq3m88zPEYQWU7g6nrRmb1emc5+TxqwaIthtSN5PosPQZMmbyPcYGBg20B
 Y=
X-Received: by 2002:a5d:5409:0:b0:309:3b8d:16a8 with SMTP id
 g9-20020a5d5409000000b003093b8d16a8mr1106139wrv.50.1684345574869; 
 Wed, 17 May 2023 10:46:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ43oBVghnPH+heaC9c21i6x4e9GytlK3+gmTauN/1EMHrl/hADM3ALyJSmJVsk5wOnsZE93ew==
X-Received: by 2002:a5d:5409:0:b0:309:3b8d:16a8 with SMTP id
 g9-20020a5d5409000000b003093b8d16a8mr1106130wrv.50.1684345574553; 
 Wed, 17 May 2023 10:46:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 h14-20020adffd4e000000b00304aba2cfcbsm3478111wrs.7.2023.05.17.10.46.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:14 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 31/68] tests/vm: add py310-expat to NetBSD
Date: Wed, 17 May 2023 19:44:43 +0200
Message-Id: <20230517174520.887405-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517174520.887405-1-pbonzini@redhat.com>
References: <20230517174520.887405-1-pbonzini@redhat.com>
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

From: John Snow <jsnow@redhat.com>

NetBSD cannot successfully run "ensurepip" without access to the pyexpat
module, which NetBSD debundles. Like the Debian patch, it would be
strictly faster long term to install pip/setuptools, and I recommend
developers at their workstations take that approach instead.

For the purposes of a throwaway VM, there's not really a speed
difference for who is responsible for installing pip; us (needs
py310-pip) or Python (needs py310-expat).

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20230511035435.734312-14-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vm/netbsd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index 13eae109c042..c7e3f1e7357f 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -31,6 +31,7 @@ class NetBSDVM(basevm.BaseVM):
         "pkgconf",
         "xz",
         "python310",
+        "py310-expat",
         "ninja-build",
 
         # gnu tools
-- 
2.40.1


