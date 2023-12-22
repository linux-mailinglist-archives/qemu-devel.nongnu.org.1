Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E016781C7AE
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:57:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGcHF-0004xe-5U; Fri, 22 Dec 2023 04:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGcHB-0004uJ-NC
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:57:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGcHA-0004IG-DN
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703239023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2otSKxDgyZYC+BcOoQEMSX2Js3HgdWqtaNo7UYSHbr0=;
 b=dXMbzMusfOAleNzwM/OCJHZ0l5YTCFN9r83B6ZwpOt3QDgspH1YxjB1JDflT49XeVjMA37
 Wzda12amuhHxGW2VNpasV7kIPCnZZW7cuWiIYB2Hpdi3vqsuAnL7o2E2cXmr1zM6e2+Kfm
 jGIS24Po4X/SbV56WckKsugUtLnUIfc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-omwNcNAoMyKzgSbF0vUOtw-1; Fri, 22 Dec 2023 04:57:01 -0500
X-MC-Unique: omwNcNAoMyKzgSbF0vUOtw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40c58a71b7cso12702405e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 01:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703239019; x=1703843819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2otSKxDgyZYC+BcOoQEMSX2Js3HgdWqtaNo7UYSHbr0=;
 b=aWMGLbdPGNrAaCSocfbd851UnECjy6EENFpI90KUm0m/gHAHT13hH/l0XQAfy8g3af
 RaoypBPffiWzDyW7aY1VCKOHAIdH8EbKaKcHhWYsHLXWlwmtrSLlOO7b7QfNeKWZFpY4
 XgaX3JVndQjZaSUpNpNv+MAcUaE7ithNjEyoieBfBblpacFx6a9fWLle4yTvvDcMwEPZ
 Rc8ltDvWKoFvv95iBZqCqbeqqIhukz/oaeC/CO9fjwEtuib/yVlXPvV0I8DeZk17D2X1
 w4U0u6UtVvnSj0IOiXhQPpCf1U0s9rihH6E+9jQrj2799tOOXsRxsR9BhMoajd++u3RY
 8mgg==
X-Gm-Message-State: AOJu0Yw52+bJIynH4fn/JGOv3QLE10cvLdQRYcoXgHvO0drT2MgslwY6
 W+vel4a7y13BV4JfydEixmm9iLq0q/6BJKwy9jd0Q7f42hEOtjdYbjVaxNWae5jiXYJsIPNa1a6
 WFsedAVAFOQd9Sjq/AfaI6yBJtCGHrcIUg4hEUyTSnYJmSlTSsUD7I2l4T4T4Ed11SnYdIZ6Gt/
 re+FusX34=
X-Received: by 2002:a05:600c:4e91:b0:40c:32da:7994 with SMTP id
 f17-20020a05600c4e9100b0040c32da7994mr704887wmq.63.1703239019676; 
 Fri, 22 Dec 2023 01:56:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAOKcGjMytc2s5V1pXkBjGNLp6E1ZhxqK2ggj9YNpWmczoTEjixA/WG5lqYKoG27Hmi0rNeA==
X-Received: by 2002:a05:600c:4e91:b0:40c:32da:7994 with SMTP id
 f17-20020a05600c4e9100b0040c32da7994mr704874wmq.63.1703239019162; 
 Fri, 22 Dec 2023 01:56:59 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a05600c354500b0040d2805d158sm6268043wmq.48.2023.12.22.01.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 01:56:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	qemu-stable@nongnu.org
Subject: [PATCH] configure: use a native non-cross compiler for linux-user
Date: Fri, 22 Dec 2023 10:56:57 +0100
Message-ID: <20231222095657.87118-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Commit c2118e9e1ab ("configure: don't try a "native" cross for linux-user",
2023-11-23) sought to avoid issues with using the native compiler with a
cross-endian or cross-bitness setup.  However, in doing so it ended up
requiring a cross compiler setup (and most likely a slow compiler setup)
even when building TCG tests that are native to the host architecture.
Always allow the host compiler in that case.

Cc: qemu-stable@nongnu.org
Fixes: c2118e9e1ab ("configure: don't try a "native" cross for linux-user", 2023-11-23)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 4fb2dd179c8..21ab9a64e98 100755
--- a/configure
+++ b/configure
@@ -1356,8 +1356,8 @@ probe_target_compiler() {
   done
 
   try=cross
-  # For softmmu/roms we might be able to use the host compiler
-  if [ "${1%softmmu}" != "$1" ]; then
+  # For softmmu/roms also look for a bi-endian or multilib-enabled host compiler
+  if [ "${1%softmmu}" != "$1" ] || test "$target_arch" = "$cpu"; then
       case "$target_arch:$cpu" in
         aarch64_be:aarch64 | \
         armeb:arm | \
-- 
2.43.0


