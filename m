Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 276067700DF
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 15:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRuav-0004Ba-Qv; Fri, 04 Aug 2023 09:11:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qRuat-0004B4-Md
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qRuas-0002Tc-4g
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 09:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691154708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w5u/Y6q9uq62OMZmB6SY6hfv7zYB1pMT+2HH66zNd/8=;
 b=iisWSyJK32A9S4fCEEKXvr9P+JA07NnfF0G7ALLMuOe0QBk1LmPoX1lZ7SNvsUpFPVkI3g
 BVblLLeh7gGcMcBJUtl5qSq6dA6B7pCsP/p851+9F/wvC1B7EhU37LKt2eLLchEYSOU6mP
 Dzv80Zwg/Opwgp1YdSvZ48Z792YzIaY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-mjPuw6WVP3a8AjXe9wAD1A-1; Fri, 04 Aug 2023 09:11:47 -0400
X-MC-Unique: mjPuw6WVP3a8AjXe9wAD1A-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993d5006993so148372366b.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 06:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691154705; x=1691759505;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w5u/Y6q9uq62OMZmB6SY6hfv7zYB1pMT+2HH66zNd/8=;
 b=IBS1CZkKGl2YaYu4CgUi/qDf5hwKy6Bji7bMgm7gZsZo/IzBbNoVv8ZQq3sUIX6aCp
 cgIhReUfzl8DbhH0ddPRlCbF2Yt9gkyR4c7brjm3C0iwo6VL2Oo40+GHZ/EfZhDTme0b
 xAMslGQwtIxXIwbS04SN10RZ4JDSpfHJe1zbmPRbLRSg834+SYJQpcpcKrrg8RCV/quJ
 XCzALFF3YX3YyM2j/v1EiZ4qO1k4qPJC0FsIG20+mwFPgYcLpAp7tYCAsuYexrSymDdh
 kBJ3XuzvGzl2mx8EaW35nxOy6WHT69xzUrdvpUveYNDBQTY8COjPfny7sJUxcyqVhNV5
 yauw==
X-Gm-Message-State: AOJu0YzpDDQaMXj/f5B0Mo9d1aVdo2XAD65elcxgXWSZJLEaqrdVh7wI
 ddGW5UTXx/0LCiL+IB3jvRQMJ3ZlIdzSqeufArVpDtRWm9SAVZxSbR2kMYN6zJ3eP/yFi1lc4Jv
 D/PBawMl7VnIYUvLNsYmnjzzBjMTbw5rWyJmhLmtCInoZBWZAw2z38Mqs6Wj8VsdovThOjCQiYV
 Y=
X-Received: by 2002:a17:907:78c5:b0:99c:22e3:3eed with SMTP id
 kv5-20020a17090778c500b0099c22e33eedmr1533412ejc.73.1691154705567; 
 Fri, 04 Aug 2023 06:11:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0aRgDGo/nJocHXLMCPrm/ykNXnGKs0EEpGy6wxWtnUOcImfhx9tuoO5QSXFqYJwxKmnlW8w==
X-Received: by 2002:a17:907:78c5:b0:99c:22e3:3eed with SMTP id
 kv5-20020a17090778c500b0099c22e33eedmr1533393ejc.73.1691154705217; 
 Fri, 04 Aug 2023 06:11:45 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a1709060e1100b009944e955e19sm1295612eji.30.2023.08.04.06.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 06:11:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] ci: install meson in CirrusCI KVM build environment
Date: Fri,  4 Aug 2023 15:11:43 +0200
Message-ID: <20230804131143.394134-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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


