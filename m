Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 207B47971EB
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:45:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDQj-0004oq-SM; Thu, 07 Sep 2023 07:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeDQh-0004oa-Bw
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeDQf-0005Me-AY
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694087048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Pri4hduQIRtgO8yAnyNoVyNSUX6XmYzjO0mzFMCRYmw=;
 b=BXnyHSPGQAy+QteXYXmUGBYLat3ijcOakmQevrumAhZRq556/lEj4JnMNIfQucSUz17M+d
 Rx3tpj5Uu3/r2gVdPGcvk449lpSJB9dXhczu8gvgzu41E2RKE6vjl6FzmB0TtmKUT/tL0b
 B2y6XeMjS7hRYQ4COwJPIcNCeZzZShw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-rF8UQFWtMFCR-M9DIPzlEA-1; Thu, 07 Sep 2023 07:44:07 -0400
X-MC-Unique: rF8UQFWtMFCR-M9DIPzlEA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c5adb698aso529350f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 04:44:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694087045; x=1694691845;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Pri4hduQIRtgO8yAnyNoVyNSUX6XmYzjO0mzFMCRYmw=;
 b=l/59vbS+1DbqvOtOJD1f+3Pf3mlgVdkm/jRzQPVXMTTCwJQAaTCekp5Z1EtpRd4r9Q
 eB9cq1193x25vX0ToRv09QU57cVRVT6ZaBgAnhAGcAZIOuvVBapGpOu/XwJp0Jf2Y9nU
 Ad4nPhP/nTAWthpRbPdAzISY4tz6ngeDg2DXY9gu5Ihec7eEa0IKkMVVCGsmA6BJklU9
 wweI500uot17srnbtfQky8CSQRaAZBwH4SLVh3aQIKhvKS5yGfum4G4bBu5ROPlouPRB
 pJcnGVYiezqj7hgqUWjeZsHpdBUQi8Ia2OIXSh9+wcFua4Z9BoAv29Yk8CGrhlP9O4wM
 1tgg==
X-Gm-Message-State: AOJu0Yw0v3Ld1BfAalRZeoo+OeDyERYeb3L73QyoZh2fPtrlxQJmE1/i
 E8dml7CaVQJ41+qk8cOTj8VDbyn6sSxpOp8J1t+YY/xeA9UEoPcl0rBN8Yb0TaP/U7L6syIvOTk
 4rjuJri85661BQEyK47A7E7xboHt3mJ452eCCzxASzCytqgY/Bi73TwOXgT1nQH5W5VLTr5UNop
 M=
X-Received: by 2002:a5d:690b:0:b0:317:6fff:c32b with SMTP id
 t11-20020a5d690b000000b003176fffc32bmr4665671wru.53.1694087045436; 
 Thu, 07 Sep 2023 04:44:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrIYmDg57Zjfb+6gB7iXRHU2RghVvehJyajRcygsnqTAlJdYg1gNW1qiGm2+k8+gq64ZN1og==
X-Received: by 2002:a5d:690b:0:b0:317:6fff:c32b with SMTP id
 t11-20020a5d690b000000b003176fffc32bmr4665658wru.53.1694087045022; 
 Thu, 07 Sep 2023 04:44:05 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312::1fc])
 by smtp.gmail.com with ESMTPSA id
 i14-20020adfdece000000b003142e438e8csm23050791wrn.26.2023.09.07.04.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 04:44:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	philmd@linaro.org
Subject: [PATCH] contrib/plugins: add Darwin support
Date: Thu,  7 Sep 2023 13:44:03 +0200
Message-ID: <20230907114403.493361-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Under Darwin, using -shared makes it impossible to have undefined symbols
and -bundle has to be used instead; so detect the OS and use
different options.

Based-on: <20230907101811.469236-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        This replaces Philippe's patch to link with GLib, and also fixes
        errors like

          "_qemu_plugin_get_hwaddr", referenced from:
	      _vcpu_mem in execlog.o

        I guess this shows that we're kinda losing in not using Meson
        for the plugins, but as I said I appreciate the didactic value
        of using a standalone Makefile (with only a handful of lines
        in configure).

 contrib/plugins/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index db1bd04dfa6..c26fa08441e 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -37,7 +37,11 @@ all: $(SONAMES)
 	$(CC) $(CFLAGS) -c -o $@ $<
 
 lib%.so: %.o
+ifeq ($(CONFIG_DARWIN),y)
+	$(CC) -bundle -Wl,-undefined,dynamic_lookup -o $@ $^ $(LDLIBS)
+else
 	$(CC) -shared -o $@ $^ $(LDLIBS)
+endif
 
 clean:
 	rm -f *.o *.so *.d
-- 
2.41.0


