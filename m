Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B40A78D4F4
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 11:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbHte-0003V4-AX; Wed, 30 Aug 2023 05:53:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qbHtc-0003Ub-9v
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:53:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qbHta-0004E6-3a
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 05:53:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693389233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ecl6eg83uzTrMrcNWOohG6N6NZqrFTc0lcAKquB7EHM=;
 b=Wmoqpvjrhn3zqPYkwc6JJaFRqppQ/+w70sL/r/MsTbd+O5m8NcXzWZhs7uYRGLMETd6RCC
 dyXTQC5ATWQblVV4abFfXezyQDW3NoNXLKGebbvliiDnl2lVzS5zXtnyQZVUcGKyPuqEnj
 f59/cShXEJXuFczUpRtAghf+c9S5afc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-G40r33obP_i5eO6nALCZqA-1; Wed, 30 Aug 2023 05:53:51 -0400
X-MC-Unique: G40r33obP_i5eO6nALCZqA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe661c0323so36144925e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 02:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693389230; x=1693994030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ecl6eg83uzTrMrcNWOohG6N6NZqrFTc0lcAKquB7EHM=;
 b=AkWo28FHUZJQ6pWc0oCsSv1bAncZEXUQ+imcIOqwloWXDBLJPD26n2phhtK9v+ZH1I
 JSDPgt2+p4KG/7EnqDeyr2QgmsYde4J1SfbEEuOLFT/UjbVC09PE3D8/g0UKC+FIqzVl
 CY+vhWO9HYtBYUjw/8/IPEyu5nqoRzdZOJOvMqaZ07/PwJY7mYizFv8KD9aktV9o9n3i
 dI78zEwlI1f0i4D/fhd8YF6dkqMUzGYCbRJ/4Kf0gDCU+dhlsC6ZYvQ9Gl3lGsYpesZy
 wxVyDaXs11870EOSIzIjQknSj9Z1JSV4a1S3Dq66j3/erp0Z5mDvHF6o1y0581BqzDyY
 wHDg==
X-Gm-Message-State: AOJu0Yw/KLl2ByE22cm0tN6vxR/VTD5NhDt7mo6jfes9N/J40c+Ymr4g
 iQZw/X66EILN/a3BWb0QNjWEVkloJNkLeJ+k9Ds4zhxzwxYLUqeOl578l8snUE9pvNj6qcmbUhk
 vy5JNA79bAdcl7Z+lEoN7vw3Lw0PvS0gwRfEC/EJSK9oHjS7N1KCtAk6dh0vq0pr/9zA50ifsE2
 Y=
X-Received: by 2002:a7b:c38e:0:b0:401:c338:ab94 with SMTP id
 s14-20020a7bc38e000000b00401c338ab94mr1324493wmj.29.1693389229946; 
 Wed, 30 Aug 2023 02:53:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwGChKC9Zc00N/2WxgGT8Qx3HLsWh42rQRR1IhlWfv4WJNbGU7jEAXS+3W6dxqKWHZrzz/EA==
X-Received: by 2002:a7b:c38e:0:b0:401:c338:ab94 with SMTP id
 s14-20020a7bc38e000000b00401c338ab94mr1324484wmj.29.1693389229447; 
 Wed, 30 Aug 2023 02:53:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c204100b003fe1630a8f0sm1722230wmg.24.2023.08.30.02.53.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 02:53:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] meson: test for CONFIG_TCG in config_all
Date: Wed, 30 Aug 2023 11:53:47 +0200
Message-ID: <20230830095347.132485-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

CONFIG_TCG is not included in *-config-devices.h, so the test is
always failing.

Fixes: 74884cb1a6d ("qtest/meson.build: check CONFIG_TCG for boot-serial-test in qtests_ppc", 2022-03-14)
Fixes: 44d827ea69e ("qtest/meson.build: check CONFIG_TCG for prom-env-test in qtests_ppc", 2022-03-14)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index df63909ee51..c0751ef7c35 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -155,8 +155,8 @@ qtests_ppc = \
   qtests_filter + \
   (config_all_devices.has_key('CONFIG_ISA_TESTDEV') ? ['endianness-test'] : []) +            \
   (config_all_devices.has_key('CONFIG_M48T59') ? ['m48t59-test'] : []) +                     \
-  (config_all_devices.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                      \
-  (config_all_devices.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                   \
+  (config_all.has_key('CONFIG_TCG') ? ['prom-env-test'] : []) +                              \
+  (config_all.has_key('CONFIG_TCG') ? ['boot-serial-test'] : []) +                           \
   ['boot-order-test']
 
 qtests_ppc64 = \
-- 
2.41.0


