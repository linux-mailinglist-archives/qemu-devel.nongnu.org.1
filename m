Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B70770961
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 22:08:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS156-0005DS-4y; Fri, 04 Aug 2023 16:07:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qS154-0005Cb-0W
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 16:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qS152-0005hD-KI
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 16:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691179643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5u/Y6q9uq62OMZmB6SY6hfv7zYB1pMT+2HH66zNd/8=;
 b=IYfvtDRj9f8cKyK7GWujB1YZsJTn+u+rO3RsW9V2rbL2PAc8Og9F45QguHWY2bGVyhSgmv
 eBzRNTc0+NPK34Y1v0+/eMfPsj4W0f5bF46V1xx5L2msGIb4jjdcTNaZfVCAqmH6oXT5jl
 J4m/gFEPrb0K+VjsN/K2SAaq0jUqIvI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-qEJbuHwrNcON1BvvMpT5kw-1; Fri, 04 Aug 2023 16:07:22 -0400
X-MC-Unique: qEJbuHwrNcON1BvvMpT5kw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bfe3dd009so494845266b.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691179641; x=1691784441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w5u/Y6q9uq62OMZmB6SY6hfv7zYB1pMT+2HH66zNd/8=;
 b=bO7d8QvV+LeFfG+7PEMOu0Chc3kGYlL2wJyH6sXMwN0TjO1h42dCKf4rEE7e79ojeb
 qp64X2WOrKikGaS5xE3rYajdwoyEb091hnL6OTN+v9oQXCzycNgjIz745g+NKFiyqDV0
 u5u0OMjeEGe5r3zTxPhTxZxrJSLxuRWoBzz/yIIsq1vyyURl/6FPGW39cCf6WMcVgUN0
 T+CU3uBO8RbQg1pHKW8BqWxABz9+88+s/rOBQ18Ru+jrhV+Mu7COuv++BxRsx2c2kHek
 whqiF5v5jKCzySETNfpmQY1lsTAkGMtENNDdL8ewBThT25TA5MVmEibMFaKt7s0z0R7X
 hslg==
X-Gm-Message-State: AOJu0YzdIfIBfTyNL5tK7s26Ddkgz1exuAF6JaLWOgJSZyZgDJw9KPeS
 wFlvfW1rEbtmZ+e5U3qCRdpPlkgDwB+O0MAqvlcFoelhasTJ+u220S6IhvYZhb/gtbo6LBO2ZJA
 K0ho1rWmajMRAXu6EBLINLy0FnkrA1VMG6hMSyg9jZ6TcyFq3ATRcr2xAnPJj3y1oUhROJcSyY2
 k=
X-Received: by 2002:a17:907:1c8b:b0:992:103c:43fa with SMTP id
 nb11-20020a1709071c8b00b00992103c43famr778910ejc.30.1691179640962; 
 Fri, 04 Aug 2023 13:07:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHateb6eqla0R8eXIfrg/kIyprVtwjOMksmLad6+vqy4gDEk79Sl2smPD/FI8qi3lf6JUVeuA==
X-Received: by 2002:a17:907:1c8b:b0:992:103c:43fa with SMTP id
 nb11-20020a1709071c8b00b00992103c43famr778895ejc.30.1691179640641; 
 Fri, 04 Aug 2023 13:07:20 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a170906c20b00b00992d70f8078sm1745094ejz.106.2023.08.04.13.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 13:07:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 2/2] ci: install meson in CirrusCI KVM build environment
Date: Fri,  4 Aug 2023 22:07:15 +0200
Message-ID: <20230804200715.430592-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230804200715.430592-1-pbonzini@redhat.com>
References: <20230804200715.430592-1-pbonzini@redhat.com>
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

scripts/archive-source.sh needs meson in order to download the subprojects,
therefore meson needs to be part of the host environment in which VM-based
build jobs run.

Fixes: 2019cabfee0 ("meson: subprojects: replace submodules with wrap files", 2023-06-06)
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/cirrus/kvm-build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/cirrus/kvm-build.yml b/.gitlab-ci.d/cirrus/kvm-build.yml
index 4334fabf39e..a93881aa8b5 100644
--- a/.gitlab-ci.d/cirrus/kvm-build.yml
+++ b/.gitlab-ci.d/cirrus/kvm-build.yml
@@ -15,7 +15,7 @@ env:
     folder: $HOME/.cache/qemu-vm
   install_script:
     - dnf update -y
-    - dnf install -y git make openssh-clients qemu-img qemu-system-x86 wget
+    - dnf install -y git make openssh-clients qemu-img qemu-system-x86 wget meson
   clone_script:
     - git clone --depth 100 "$CI_REPOSITORY_URL" .
     - git fetch origin "$CI_COMMIT_REF_NAME"
-- 
2.41.0


