Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD727CD66F
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:29:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uk-0001L6-T9; Wed, 18 Oct 2023 04:28:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uj-0001Iz-7b
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1ug-0003dC-0I
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=USJ4B+GKahp2xXnvyxaH3LRoPVFr+Gu6HO/V82MTTnw=;
 b=DL/ExfJE80dptW68RTqS56Ih/yEzL3+42aLcJge+xqRH0VcCt1h4JKZvu6hzp6WVVg4elq
 ZFpYcOqhfziC2ktO61NxguoiGwAdC5XQpit0bFX5Ee3OBEv9II0Fro/aaJ0q0E0ogewDw5
 G1Z1eMnX1PgMEVZRB33DggKdWQbcH5w=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-PGm-ylYKOLeo7E9E_w4Dvw-1; Wed, 18 Oct 2023 04:28:19 -0400
X-MC-Unique: PGm-ylYKOLeo7E9E_w4Dvw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae0601d689so435237866b.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617698; x=1698222498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USJ4B+GKahp2xXnvyxaH3LRoPVFr+Gu6HO/V82MTTnw=;
 b=HE6XQLKhoPLEr6I3eOEIyX7fdsVXSomyQ4vJQovL3GC9+RfckQg3ZtTimk4y0zwT8W
 XAQfVzgKZX/XczNVMI4o/9s56zB2HFZqCl2K60GdGzD6SNUKNWkoeZx4Q+aHJcMo1s+F
 a+13Mpperx5osg68Up/2pVV3EQ9jnSCLCUPYOYqSocx9zWrpUjhnh8W8FMC43Mue9POX
 29y1CCG40yz3ciR/49fWnbnLPIXmunFW1S25LLdDpyBliZ/yS+swBfeyArTIhWal9Lr6
 cBFJMdb/a2k8emypsLKrgGtLjiH1tC5UD5WuJjTxhySM7dLD5jMYZqkaK4swGJrmkHG8
 sLIw==
X-Gm-Message-State: AOJu0YwLT95JONUseKf48BOW3WOt9+sC2Qj20mvk9/SFIEUTbXk8YaOQ
 lT7cc/BaiQOG+Q246LhHkul5EFufNGuFFbM7nH54tK5C7RQqRciVWyWlqwoqXSFEDnoMzcjW2IG
 FRtw9MN6GbvkD4ZqeG+LlRlswWTgtjTnSbdV5CA0PH69mbUPRTPye8dkCiVx3A6c/VE1p/OiMYJ
 4=
X-Received: by 2002:a17:907:7f13:b0:9c2:2d0a:3211 with SMTP id
 qf19-20020a1709077f1300b009c22d0a3211mr3136392ejc.38.1697617698209; 
 Wed, 18 Oct 2023 01:28:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/0ABVsM5dmPVQGYK1IHj1tX8EnJNyyUaiHmQc8hOrScecVq0lO4xG7DEbJArMbiC2FfkKeg==
X-Received: by 2002:a17:907:7f13:b0:9c2:2d0a:3211 with SMTP id
 qf19-20020a1709077f1300b009c22d0a3211mr3136381ejc.38.1697617697916; 
 Wed, 18 Oct 2023 01:28:17 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 bh12-20020a170906a0cc00b0099bd7b26639sm1205444ejb.6.2023.10.18.01.28.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Subject: [PULL 12/32] tests/avocado: avoid invalid escape in Python string
Date: Wed, 18 Oct 2023 10:27:32 +0200
Message-ID: <20231018082752.322306-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018082752.322306-1-pbonzini@redhat.com>
References: <20231018082752.322306-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is an error in Python 3.12; fix it by using a raw string literal.

Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/avocado/virtio_check_params.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/avocado/virtio_check_params.py b/tests/avocado/virtio_check_params.py
index f4314ef824f..5fe370a1793 100644
--- a/tests/avocado/virtio_check_params.py
+++ b/tests/avocado/virtio_check_params.py
@@ -43,7 +43,7 @@
 class VirtioMaxSegSettingsCheck(QemuSystemTest):
     @staticmethod
     def make_pattern(props):
-        pattern_items = ['{0} = \w+'.format(prop) for prop in props]
+        pattern_items = [r'{0} = \w+'.format(prop) for prop in props]
         return '|'.join(pattern_items)
 
     def query_virtqueue(self, vm, dev_type_name):
-- 
2.41.0


