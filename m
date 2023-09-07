Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 254407972BB
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:14:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEdH-000350-BF; Thu, 07 Sep 2023 09:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEcr-0002mj-B7
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEco-0007GF-0b
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bSigBqSUZKr66KwDywctiPhcrHXhPWqZwNq20QZJZus=;
 b=Az111191J5oG4W8hQyFnkiK18AFy03RQ7DXpPsMykFVvhLUOqk1jeJPxLiA1ZD3TUMMb/w
 egww/dMb0/R3rQbNEMkJgabVAFAsAr1IKUDoPIKFKRfsYtH1opia7FRhO2qIOSihlAlBMF
 ybvc+2B2w+NO3GAwoY4kKZ2ORA2eBCE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Ln_UjslVODiEEULfI2WAyQ-1; Thu, 07 Sep 2023 09:00:42 -0400
X-MC-Unique: Ln_UjslVODiEEULfI2WAyQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-31dc8f0733dso575102f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091635; x=1694696435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bSigBqSUZKr66KwDywctiPhcrHXhPWqZwNq20QZJZus=;
 b=SPXlz/tkTiKxsx93SYMekxURFhj3GLnvduevwJXCwr9kHM+DMsRXHlDl0UObY7i/PR
 25yChc2+41jlPVSHb7g6ccbTML049IrG1zUyAg1pBkf6AlmXu7bw7gnR4J2CqnV2Zc6Q
 JDephEomoDv4jnLI0yyzYhvABOeQIREtDLvJywQ5PhG/dhRbOEE+d4gJr0ZnBU03Ksjs
 Kc0/cmG4Va0cyKIUeSBXfab8hLCspdoBEf6r7yAdGGIcwNJMGiWyWA85rlTR+Jmc04rB
 /95och4UqMiJ0k/6BuQckDZJ2+McNLiL20FpqyrN5ok4aLHTF4tXkixvYX6M87aajApj
 42Pw==
X-Gm-Message-State: AOJu0YxN3//Rt6Vz8KFoGeh0bpJXcfWuZdbiIfTiyP07RQGkQ2Epvw08
 Oa5jJK6/JZoMG25VGbBrG2eQHU2Nvsm/haIac4bT2wv1211dE9QCx7Qq9092aEC+UnNoRw32CpS
 pjUiXQcJSTbDBRNx6yYVTVRlOYes5kHYd89kubJexG8k/hwIFeW5ya4TD9YE7UnSyZh/vbRBqtR
 E=
X-Received: by 2002:a5d:63cb:0:b0:317:6e62:b124 with SMTP id
 c11-20020a5d63cb000000b003176e62b124mr4924878wrw.18.1694091635361; 
 Thu, 07 Sep 2023 06:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdkoqSw/pENJqQKOCcfvpRD8kqP1NZYQV3K5cc2Cz+jiZJzu3PRjx6102Op20iDDybqF0NCA==
X-Received: by 2002:a5d:63cb:0:b0:317:6e62:b124 with SMTP id
 c11-20020a5d63cb000000b003176e62b124mr4924854wrw.18.1694091635001; 
 Thu, 07 Sep 2023 06:00:35 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 j14-20020adfe50e000000b0031c52e81490sm23264417wrm.72.2023.09.07.06.00.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:00:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 13/51] util/async-teardown.c: move to softmmu/,
 only build it when system build is requested
Date: Thu,  7 Sep 2023 14:59:22 +0200
Message-ID: <20230907130004.500601-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
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

From: Michael Tokarev <mjt@tls.msk.ru>

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-ID: <20230901101302.3618955-9-mjt@tls.msk.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 {util => softmmu}/async-teardown.c | 0
 softmmu/meson.build                | 1 +
 util/meson.build                   | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {util => softmmu}/async-teardown.c (100%)

diff --git a/util/async-teardown.c b/softmmu/async-teardown.c
similarity index 100%
rename from util/async-teardown.c
rename to softmmu/async-teardown.c
diff --git a/softmmu/meson.build b/softmmu/meson.build
index ea5603f0218..c18b7ad7382 100644
--- a/softmmu/meson.build
+++ b/softmmu/meson.build
@@ -37,3 +37,4 @@ endif
 
 system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
 system_ss.add(when: fdt, if_true: files('device_tree.c'))
+system_ss.add(when: 'CONFIG_LINUX', if_true: files('async-teardown.c'))
diff --git a/util/meson.build b/util/meson.build
index a3751602869..c4827fd70aa 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -3,7 +3,6 @@ util_ss.add(files('thread-context.c'), numa)
 if not config_host_data.get('CONFIG_ATOMIC64')
   util_ss.add(files('atomic64.c'))
 endif
-util_ss.add(when: 'CONFIG_LINUX', if_true: files('async-teardown.c'))
 util_ss.add(when: 'CONFIG_POSIX', if_true: files('aio-posix.c'))
 util_ss.add(when: 'CONFIG_POSIX', if_true: files('fdmon-poll.c'))
 if config_host_data.get('CONFIG_EPOLL_CREATE1')
-- 
2.41.0


