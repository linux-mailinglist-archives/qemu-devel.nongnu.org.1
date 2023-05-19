Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E92F6709EC3
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 20:08:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q04Wd-000205-43; Fri, 19 May 2023 14:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q04WZ-0001zw-HR
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:08:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q04WY-0008Aq-2Y
 for qemu-devel@nongnu.org; Fri, 19 May 2023 14:08:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684519697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=O6c6iJq7SwxbvPuO15ACuAdh44PCN+9D6axKC+7mOSI=;
 b=WqgHpPOtJfiXIuzbKRAJBNicPgRTOhlC0PjTQC7IzHb/NcOcp6jLoLLmOjsxXT79Y15r6u
 qhSlxcSF8GDlwDt19tivsGUa6EVYSRC9KwX/sY/Fk+2+tKUEFfTvZXWFunTX2xkHBjlQNy
 LRDmoDwQVN9H+D7/qQots4aeHshroL0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-hKR435ihMeytvRIMH1a_EA-1; Fri, 19 May 2023 14:08:15 -0400
X-MC-Unique: hKR435ihMeytvRIMH1a_EA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-95847b4b4e7so461689666b.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 11:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684519694; x=1687111694;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O6c6iJq7SwxbvPuO15ACuAdh44PCN+9D6axKC+7mOSI=;
 b=UnBKYGwfK1Dzx+Xl7ffz3UhkpwPhvUY60wPxsSaGkOPA/37WSWJ3R692szqODftljE
 gKhBn5VIyR/b9TYxy10gHbzbuipJ0AQA/irkS20C9bGS6+CN8W5SDEHKYrX2RzEB00EO
 9ZNTmzIjJt0ZwBTyF7EAxB+/3hBSeInYlaq66qIfiTckDO7s9HxWwvwKaRWUH1t6Iusa
 DstXBN6AqDMfhHmSWTfgQnpM6pMr8lqTEb13Ruxxx6rCjklEVQ4my3lXPzxuPOjOnuJA
 HAYHhr9cnu6z1W9suglaFbnpG+ADG0GewHmwvkW0LFCgxIE+FXwCRR+sks8VihjpB60v
 gR0w==
X-Gm-Message-State: AC+VfDzwMG4+T6V9oL7gkns668ytBnhCE0NP4qLeK4YxmugrYjLVp3ai
 KgA9J6ja5yZCSO0++avFS347QF9nOcPN25m56ls6jlcogeOhqtR2ju/seMvWEnzH/9xjelQHKzh
 op8Ulw/DuqsAabQGam9p6eC91QeEpYDVFizani2hkbNZRtTORlY52UTs7gKiKWPVuVi2EKVc2Xa
 A=
X-Received: by 2002:a17:906:f90a:b0:962:9ffa:be02 with SMTP id
 lc10-20020a170906f90a00b009629ffabe02mr1953828ejb.36.1684519694265; 
 Fri, 19 May 2023 11:08:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74C7bwiYe0wIY/BWcn4nMJb+wcqAi7qIG7UKQgNgECP+9el01k7eznqrWRNQqxwZ3riNSvDw==
X-Received: by 2002:a17:906:f90a:b0:962:9ffa:be02 with SMTP id
 lc10-20020a170906f90a00b009629ffabe02mr1953815ejb.36.1684519693932; 
 Fri, 19 May 2023 11:08:13 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 t24-20020a170906269800b00966392de4easm2592889ejc.14.2023.05.19.11.08.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 11:08:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] configure: fix backwards-compatibility for meson sphinx_build
 option
Date: Fri, 19 May 2023 20:08:12 +0200
Message-Id: <20230519180812.1181871-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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

Reintroduce the cmd_line.txt mangling to remove the sphinx_build
option when rerunning meson.  The mechanism was removed in
commit 75cc28648574 ("configure: remove backwards-compatibility code", 2023-01-11)
because it was obsolete at the time, but the Meson deprecation
mechanism doesn't quite work when options are finally removed.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configure b/configure
index 43620b80c8df..b61475a4cb5d 100755
--- a/configure
+++ b/configure
@@ -1984,6 +1984,14 @@ if test "$skip_meson" = no; then
   if test "$?" -ne 0 ; then
       error_exit "meson setup failed"
   fi
+else
+  if test -f meson-private/cmd_line.txt; then
+    # Adjust old command line options that were removed
+    # sed -i is not portable
+    perl -i -ne '
+      /^sphinx_build/ && next;
+      print;' meson-private/cmd_line.txt
+  fi
 fi
 
 # Save the configure command line for later reuse.
-- 
2.40.1


