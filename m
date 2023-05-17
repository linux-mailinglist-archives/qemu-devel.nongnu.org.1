Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F382D707022
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:56:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzLEa-0000LQ-IA; Wed, 17 May 2023 13:46:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLER-00004z-8P
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzLEN-0004Kz-Ns
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:46:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684345588;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPbo2+VzDqysnyV4UzfBcKr3OVEdwOudnHphko4hQ4w=;
 b=iYlHgV2wlrQHGUbbiZI6sES6NgQV+PRUVzNmiKNkrjIYjExiqMzOZUlCeFAg6rkRR6CHdU
 xYpBG/II0tczQpKmL3X8NH375luCHe5/d8coA3n/nhzrWT7ML8pr6iDJ+JCmYE/yOEhhzH
 spjmFbqF5OfAxfMSrBnQHZXdRcesbj4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-mE2KU8lZOkSqmoTvV8gV6g-1; Wed, 17 May 2023 13:46:27 -0400
X-MC-Unique: mE2KU8lZOkSqmoTvV8gV6g-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3079d15b51dso165825f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684345586; x=1686937586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UPbo2+VzDqysnyV4UzfBcKr3OVEdwOudnHphko4hQ4w=;
 b=TJfaTXckWYaH/Tq0JX/le7o8BGkh19VCRldsTcrSH3tbLKFWZr9n+MJNilzbxQTuNw
 t/TJeKeZoSMUY1z1+cchR0FPlfTzAJU7nHzEEFUKlgnoytNWCP3Gx3wmi5EC4iPkyXtW
 wPp1s0XUdGVqE3gv7bnpi0RvFIJQRnj6zvnunjq1b9EhO2gcFQ62+Ha1z++5d+qvTg8y
 HjixNssdBRE/whzTLmf6Y3tUaFZikBYh2CHKfuowGKbg4IyHy+PB9fW4RzLZ1qTjWDZc
 x11ad9vioAAjm3jw3Js1otmxnwxp/uZS30JwzK1PM/u1zescJx4MRt7LJjji4E9rxnRQ
 KByA==
X-Gm-Message-State: AC+VfDzVrFn4bLuSH847WzH3q5MJc1FNiihDqQHH740njhbq/y4nbILB
 Tu/X0PJ/3xCojMVIFnHeGZY/7GaOz5rZmA0YMqD6gBFGXdDJYg+wxGR5L+AUmftyhSSnLQjjvFQ
 6MGyd4lMjT8WvTwmanpRsT/QduUx9fqkshvs+Bj2LAa9B4ISc16rTQ3w6fpxM05w7HKHm0tRFh8
 c=
X-Received: by 2002:adf:eb4b:0:b0:307:9693:efe1 with SMTP id
 u11-20020adfeb4b000000b003079693efe1mr1243636wrn.18.1684345586123; 
 Wed, 17 May 2023 10:46:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Lx2V6JfmAjUsaLFTEGYM6pqqi9FcmhChwEelud65zaDcrxzrpxnhnyMQtMgxFubFCig3JQw==
X-Received: by 2002:adf:eb4b:0:b0:307:9693:efe1 with SMTP id
 u11-20020adfeb4b000000b003079693efe1mr1243618wrn.18.1684345585712; 
 Wed, 17 May 2023 10:46:25 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a5d55c4000000b002ca864b807csm3737423wrw.0.2023.05.17.10.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 10:46:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>
Subject: [PULL 38/68] configure: move --enable-docs and --disable-docs back to
 configure
Date: Wed, 17 May 2023 19:44:50 +0200
Message-Id: <20230517174520.887405-39-pbonzini@redhat.com>
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

Move this option back from meson into configure for the purposes of
using the configuration value to bootstrap Sphinx in different ways
based on this value.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-Id: <20230511035435.734312-21-jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure b/configure
index 4519c4d412f8..f8308926bbc6 100755
--- a/configure
+++ b/configure
@@ -279,6 +279,7 @@ debug_tcg="no"
 sanitizers="no"
 tsan="no"
 fortify_source="yes"
+docs="auto"
 EXESUF=""
 modules="no"
 prefix="/usr/local"
@@ -750,6 +751,10 @@ for opt do
   ;;
   --disable-debug-info) meson_option_add -Ddebug=false
   ;;
+  --enable-docs) docs=enabled
+  ;;
+  --disable-docs) docs=disabled
+  ;;
   --enable-modules)
       modules="yes"
   ;;
@@ -2615,6 +2620,7 @@ if test "$skip_meson" = no; then
 
   # QEMU options
   test "$cfi" != false && meson_option_add "-Dcfi=$cfi"
+  test "$docs" != auto && meson_option_add "-Ddocs=$docs"
   test "$fdt" != auto && meson_option_add "-Dfdt=$fdt"
   test -n "${LIB_FUZZING_ENGINE+xxx}" && meson_option_add "-Dfuzzing_engine=$LIB_FUZZING_ENGINE"
   test "$qemu_suffix" != qemu && meson_option_add "-Dqemu_suffix=$qemu_suffix"
-- 
2.40.1


