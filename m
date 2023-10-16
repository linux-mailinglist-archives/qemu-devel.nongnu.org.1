Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AE87C9F99
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 08:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsH8z-00040l-Lp; Mon, 16 Oct 2023 02:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8w-0003zJ-1Q
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qsH8t-0005T1-GG
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 02:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697437914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9QQ5Jv++5JWrJcQC65uokcTL2BMQ3kZau3NHc7ktyfI=;
 b=JdjL0SJTO/e5Lm7K3l5+2VF8pdj++lojTl4jrSGT4vH9pQF+YvTfcWqsoEPGgCvg4YfpdI
 AigZAw7DlIqVAZ4+ZrmoNgK8A8q94DTtUojVK/gXwVXSO9LK3TrGq7mSprKbHmpMt1hNht
 gcnIGSX5Q2uH/wxUy9+lrRwcdvcqwjw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-127-VC_bdEVqOkae6hQAGioAEw-1; Mon, 16 Oct 2023 02:31:42 -0400
X-MC-Unique: VC_bdEVqOkae6hQAGioAEw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-993eeb3a950so260252066b.2
 for <qemu-devel@nongnu.org>; Sun, 15 Oct 2023 23:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697437900; x=1698042700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9QQ5Jv++5JWrJcQC65uokcTL2BMQ3kZau3NHc7ktyfI=;
 b=BEraUrID7MKHSoHJjnQmiD2z4nVe9/2MopFRvOMnzguRTDiiHe8YWGA04qG/MecbaG
 1GPC0hezsFmy0Ar0kMLEmEYNkOS/WgliKq3rCV/o5DBXe4Ly7mpvuOIt2lE64CACb9ws
 yoDze+tz8xQ+WjETYe3Kcuhq6HmSRc0xIAZhul8+FVT8ULL4ZDjGLn6BLqUycHYlfcD0
 1Az9z8cOW0eh60HbI7ACFXVv7kq3bFp805ytaJ0Q+O79dqDs8+j16hJRFEVgBSYBrpP2
 pJGY8UQljS/JhRP4dEgGGQUFvzWYZrJczTtASQNR0Dk1yh4NBF9z/3ZTojGsAe33xewg
 Uomw==
X-Gm-Message-State: AOJu0Yz0JyeYve8P4tvzDu3VjhPIAgMkyhWCM4Ug6Mv0PbmAKoXGO/aN
 rIDFqPu7MeA8yHKS7HDm9ND0NKcbzma4i3mk/KUZsCVL0sDxVaiFMYo20nS+mljSzHXjLVIibf2
 qfLOe66lINaynfK/gX4ZtZaTBvEuorwkx/6ywXh14YZkZWsub/3bWl45SecCu1mCN2/fIwyKNsq
 c=
X-Received: by 2002:a17:906:cc0d:b0:9a2:86b:bb18 with SMTP id
 ml13-20020a170906cc0d00b009a2086bbb18mr27954287ejb.26.1697437900774; 
 Sun, 15 Oct 2023 23:31:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJZkDpMl2j4MMjNlYIGSeWRfUJyCUnuvgxQTwyd4LwUU2QsZIfAfvt1NEF41QG0ayrpMN7Og==
X-Received: by 2002:a17:906:cc0d:b0:9a2:86b:bb18 with SMTP id
 ml13-20020a170906cc0d00b009a2086bbb18mr27954282ejb.26.1697437900463; 
 Sun, 15 Oct 2023 23:31:40 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a170906738b00b00992e94bcfabsm3376851ejl.167.2023.10.15.23.31.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Oct 2023 23:31:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/17] hw/remote: move stub vfu_object_set_bus_irq out of
 stubs/
Date: Mon, 16 Oct 2023 08:31:16 +0200
Message-ID: <20231016063127.161204-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231016063127.161204-1-pbonzini@redhat.com>
References: <20231016063127.161204-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/remote/meson.build                                   | 4 +++-
 stubs/vfio-user-obj.c => hw/remote/vfio-user-obj-stub.c | 0
 stubs/meson.build                                       | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)
 rename stubs/vfio-user-obj.c => hw/remote/vfio-user-obj-stub.c (100%)

diff --git a/hw/remote/meson.build b/hw/remote/meson.build
index a1e8708c732..a3aa29aaf17 100644
--- a/hw/remote/meson.build
+++ b/hw/remote/meson.build
@@ -7,9 +7,11 @@ remote_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('remote-obj.c'))
 remote_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('proxy.c'))
 remote_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('iohub.c'))
 remote_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('iommu.c'))
-remote_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_true: files('vfio-user-obj.c'))
 
 remote_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_true: libvfio_user_dep)
+remote_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_true: files('vfio-user-obj.c'),
+              if_false: files('vfio-user-obj-stub.c'))
+remote_ss.add(when: 'CONFIG_ALL', if_true: files('vfio-user-obj-stub.c'))
 
 specific_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('memory.c'))
 specific_ss.add(when: 'CONFIG_MULTIPROCESS', if_true: files('proxy-memory-listener.c'))
diff --git a/stubs/vfio-user-obj.c b/hw/remote/vfio-user-obj-stub.c
similarity index 100%
rename from stubs/vfio-user-obj.c
rename to hw/remote/vfio-user-obj-stub.c
diff --git a/stubs/meson.build b/stubs/meson.build
index ef6e39a64d8..025e7d2851f 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -65,4 +65,3 @@ else
   stub_ss.add(files('qdev.c'))
 endif
 stub_ss.add(files('semihost-all.c'))
-stub_ss.add(when: 'CONFIG_VFIO_USER_SERVER', if_false: files('vfio-user-obj.c'))
-- 
2.41.0


