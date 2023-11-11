Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CD87E8B60
	for <lists+qemu-devel@lfdr.de>; Sat, 11 Nov 2023 16:30:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1pvc-0003yJ-RY; Sat, 11 Nov 2023 10:29:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pva-0003u3-VH
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1pvZ-0008K8-29
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 10:29:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699716580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hl4FPp2TiWf73lYkGpagrM0g80ds/eBjfxzWE9bvrYM=;
 b=HpV9XTRMICeHtPm6QQLjK6NYOx3mM8Lojh8jmhXHWNN6rIUyNlLdGBbqYYz3ggXjggnghk
 1f1jxccEoObgXg4MIcjJL/cRSwtX61M+3LJ3AMYv+2vgHeVEOLGFINFq2siyVllukm1r1D
 EtXk3jhoBZTO+6vZhlvfvIFNtBKMgA4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-TXfbByv-Py6agoEX0wp_2w-1; Sat, 11 Nov 2023 10:29:38 -0500
X-MC-Unique: TXfbByv-Py6agoEX0wp_2w-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9dd489c98e7so218416866b.2
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 07:29:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699716577; x=1700321377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hl4FPp2TiWf73lYkGpagrM0g80ds/eBjfxzWE9bvrYM=;
 b=aZi+aP3f+4TgWxbcSZO/bAHEUvg4IEU8ev4sF4vizAG0zmy6fCGxPefbxwItaoQvaz
 K2oYDgZwHE/RUl1s8eQZEP6i6l1eUl8S0519CloN8bXKxY6kqopgdR/6tOgmDpF9Lcre
 A7cOH6Rwq7s2U8xf7rWcqug6yDG5GvhJ9GKZzKgZGBr2sjQLJxPOfT8muIdF+eFCt8Qx
 mNh+po7jtG7902TVRCDovN6GDNQn5Cwb83NzouUlrVu9VPtpAAdDAoXf+2C7Cdw/6DxB
 9rBcnU/2tXhJANjxIWAmEJjQkOQZIm20ZfjfWyJM8b4k6sC/njgtPc12VfyxVXcZqtku
 LoxQ==
X-Gm-Message-State: AOJu0YyQhpBhEeG/gC2NhvOZwhLX90zymvJIGXr/bn6/dK7iVoQLspLz
 UyaRD/qgwrtvhTxYRU3D4SWw58wtbINjis8FwqTgt5tdOPg/BlK9CdtJ7THWjzrkkVQhhw+WSOI
 jEgXtBbxwKmjqdXwliRposfL/7OwyGN6ThpJiE5zC3FO4gWihZS1m1sENI23nC9s32aQOJjnl5M
 w=
X-Received: by 2002:a17:906:140d:b0:9bf:2f84:5de7 with SMTP id
 p13-20020a170906140d00b009bf2f845de7mr1599696ejc.4.1699716576954; 
 Sat, 11 Nov 2023 07:29:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHULk/GgzAg73MXZUOEzUZdTC7mZFIt7x+PHlkS0+w4Wl0eB+FwgjYPxLO3juinijMxDvaAMw==
X-Received: by 2002:a17:906:140d:b0:9bf:2f84:5de7 with SMTP id
 p13-20020a170906140d00b009bf2f845de7mr1599684ejc.4.1699716576701; 
 Sat, 11 Nov 2023 07:29:36 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 lg7-20020a170906f88700b00977eec7b7e8sm1209901ejb.68.2023.11.11.07.29.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Nov 2023 07:29:35 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 5/6] .gitlab-ci.d/cirrus: Upgrade macOS to 13 (Ventura)
Date: Sat, 11 Nov 2023 16:29:22 +0100
Message-ID: <20231111152923.966998-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231111152923.966998-1-pbonzini@redhat.com>
References: <20231111152923.966998-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

macOS 14 "Sonoma" was released on September 2023 [1].

According to QEMU's support policy, we stop supporting the
previous major release two years after the the new major
release has been published. Replace the macOS 12 (Monterey)
testing by macOS 13 (Ventura, released on October 2022, [2]).

Refresh the generated files by running:

  $ make lcitool-refresh

[1] https://www.apple.com/newsroom/2023/09/macos-sonoma-is-available-today/
[2] https://www.apple.com/newsroom/2022/10/macos-ventura-is-now-available/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20231108162022.76189-1-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/cirrus.yml                              | 6 +++---
 .gitlab-ci.d/cirrus/{macos-12.vars => macos-13.vars} | 2 +-
 tests/lcitool/refresh                                | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename .gitlab-ci.d/cirrus/{macos-12.vars => macos-13.vars} (95%)

diff --git a/.gitlab-ci.d/cirrus.yml b/.gitlab-ci.d/cirrus.yml
index e7f1f83c2c4..07dc6edae1c 100644
--- a/.gitlab-ci.d/cirrus.yml
+++ b/.gitlab-ci.d/cirrus.yml
@@ -59,13 +59,13 @@ x64-freebsd-13-build:
     INSTALL_COMMAND: pkg install -y
     TEST_TARGETS: check
 
-aarch64-macos-12-base-build:
+aarch64-macos-13-base-build:
   extends: .cirrus_build_job
   variables:
-    NAME: macos-12
+    NAME: macos-13
     CIRRUS_VM_INSTANCE_TYPE: macos_instance
     CIRRUS_VM_IMAGE_SELECTOR: image
-    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-monterey-base:latest
+    CIRRUS_VM_IMAGE_NAME: ghcr.io/cirruslabs/macos-ventura-base:latest
     CIRRUS_VM_CPUS: 12
     CIRRUS_VM_RAM: 24G
     UPDATE_COMMAND: brew update
diff --git a/.gitlab-ci.d/cirrus/macos-12.vars b/.gitlab-ci.d/cirrus/macos-13.vars
similarity index 95%
rename from .gitlab-ci.d/cirrus/macos-12.vars
rename to .gitlab-ci.d/cirrus/macos-13.vars
index 5f3fb346d1d..534f0299560 100644
--- a/.gitlab-ci.d/cirrus/macos-12.vars
+++ b/.gitlab-ci.d/cirrus/macos-13.vars
@@ -1,6 +1,6 @@
 # THIS FILE WAS AUTO-GENERATED
 #
-#  $ lcitool variables macos-12 qemu
+#  $ lcitool variables macos-13 qemu
 #
 # https://gitlab.com/libvirt/libvirt-ci
 
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 92e7d30982e..2259f131b48 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -196,7 +196,7 @@ try:
     # Cirrus packages lists for GitLab
     #
     generate_cirrus("freebsd-13")
-    generate_cirrus("macos-12")
+    generate_cirrus("macos-13")
 
     #
     # VM packages lists
-- 
2.41.0


