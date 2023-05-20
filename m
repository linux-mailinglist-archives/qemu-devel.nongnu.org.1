Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 566D470AA9E
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 21:08:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0Rui-0007GC-L3; Sat, 20 May 2023 15:06:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Rug-0007FC-1Y
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0Rue-00007i-JB
 for qemu-devel@nongnu.org; Sat, 20 May 2023 15:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684609603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QM2DMiqNlRp+JmlFPMLefbiTWEx8q3yu7MLoR53X3fw=;
 b=Pv5dF6DJkj+hznQeLA1NzBiMhJ3ZVYd+SeVAjh28qtmjjySTe+AFUtNDBhkpafZMDdu1HN
 CZkzA6qpYK55wI1FhyRUO6Rkb9Jrqgn1jmZpUI5CmItlgHVRcUn8mmPDLZql3rCFrfM6FB
 /pbfPAtOSkGjhaL0pTJz/JFrpr+LB68=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-Av3kj5nHN5KOATsuPzLDbA-1; Sat, 20 May 2023 15:06:42 -0400
X-MC-Unique: Av3kj5nHN5KOATsuPzLDbA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-96f46e5897eso338825966b.3
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 12:06:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684609600; x=1687201600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QM2DMiqNlRp+JmlFPMLefbiTWEx8q3yu7MLoR53X3fw=;
 b=fhCy6xmiGsauSaedPNHFKIyncgc3irddSfY2rwFKEbAOyHUfG+GCfzPHdZIDB9Izwu
 qmIOYfmRj7saPRM+jsiy7w9kRyhAEzIXll/lf3jZ2StTi43KfKgzcIUXBOezzYLvuHpg
 twwIeyuJh3FShBAulB/Y/5sKvB/yFRV4TvV9qwJtf8f0GrnTw5ZpudPAjsgmB7sc9Klq
 +gkc5Nl7HYuHebTJYHGdWH5RzSLzJaIV9NJLyLU6AfeoyChnKPiyiuT1CJm0RUD/KDqD
 IgDulv1XkL4Ym8a/r8x1uNrmWz7hHKdxgVj0f87XyuzHZUYYx0VOdD8Cqqyj7Xzw+kAf
 M2ZQ==
X-Gm-Message-State: AC+VfDxCNDYsRNi///Ziqs/VvD3NzBEgVfIpzf283hovXfjzGZvH9Bs/
 Y9WOLZx4wM/eIYw8bYutz7O5BaJH6Uq37LFCtoLHngJfP6PDqlkZufRKEdChzqHGok+WTKVunKe
 t2RwdVkmez4Uo2G5tGk4BUWQSbHnkT4kYFsyVbzQK0nitDP5AtKqmhRN+xHVQlGY0W1r0a5LB9/
 0=
X-Received: by 2002:a17:906:58d4:b0:961:8fcd:53bc with SMTP id
 e20-20020a17090658d400b009618fcd53bcmr6484112ejs.21.1684609600800; 
 Sat, 20 May 2023 12:06:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4LJLRCSohYgH18hVCmprNd74we2Q42J32O3yLqagZ8yCij43ZJuYKKIWYiys7IhTJUd8NzVA==
X-Received: by 2002:a17:906:58d4:b0:961:8fcd:53bc with SMTP id
 e20-20020a17090658d400b009618fcd53bcmr6484104ejs.21.1684609600587; 
 Sat, 20 May 2023 12:06:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 dc8-20020a170906c7c800b009531d9efcc4sm1067409ejb.133.2023.05.20.12.06.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 12:06:40 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 4/7] configure: fix backwards-compatibility for meson
 sphinx_build option
Date: Sat, 20 May 2023 21:06:29 +0200
Message-Id: <20230520190632.7491-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230520190632.7491-1-pbonzini@redhat.com>
References: <20230520190632.7491-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

Reintroduce the cmd_line.txt mangling to remove the sphinx_build option
when rerunning meson.  The mechanism was removed in commit 75cc28648574
("configure: remove backwards-compatibility code", 2023-01-11) because
the fixups were obsolete at the time; however, the Meson deprecation
mechanism doesn't quite work when options are finally removed, so we
need to bring it back.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/configure b/configure
index bcab685cfd97..f7cd376e525f 100755
--- a/configure
+++ b/configure
@@ -1987,6 +1987,14 @@ if test "$skip_meson" = no; then
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


