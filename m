Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C89E07CD696
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:32:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1uY-0000Vc-HZ; Wed, 18 Oct 2023 04:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uW-0000UL-8V
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt1uT-0003ZK-Ry
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qs2cdu48NJ8nNMZ+IMyHr6DXt2M1atOD37VWsF3E5pY=;
 b=jH0Jlf2AobtcLGHF/NTg9lWxUo5JFbAeIcR68+OtVuCCjzueWuKPTo08pOJBUgsJEkn3f5
 D0AJ+mllY85EMXLQgdOoIUp6gSeIU0H1iBMRrw2/J+Rl1clkMVvLJ3xb/cjJPTk81Ixn39
 +S14L4VRChY6kn61ZUpX3wcprY2vkMs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-XkWsb5C6MFWcO7a69Utwmw-1; Wed, 18 Oct 2023 04:28:07 -0400
X-MC-Unique: XkWsb5C6MFWcO7a69Utwmw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99c8bbc902eso494975466b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 01:28:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697617686; x=1698222486;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qs2cdu48NJ8nNMZ+IMyHr6DXt2M1atOD37VWsF3E5pY=;
 b=qNUybpaViLh7zS7c1C1s3RZywts1Hc0zxx6vSjCWPiUYTlv1pydKRf6gSNBn1Jl+E4
 IdlCdXrujJzXs745q1rBDTd05kQhT88hN3rieJ+ll7tL1P2Dc3TgmabCBraLY1hVHWM4
 eCoeUA/9eV8k5l25n0PRLKHQHCSbXE/uls82r1MFqGCTf/ah51DFU5uRR3TNhcqsJ570
 BwBQdLUvDReMbkKCue43N7bja23nA8lzCHJSnDsy8E4hgJhk544vFWdeJBUikwHAQSzU
 az5Fr1iiSzUqMBDdlCln5y0D4HhERfM8gTTuNMJAM2Z5CppYFJQfhB2txK8q2anRz+R6
 3L4Q==
X-Gm-Message-State: AOJu0YyQ4PzG7YAgiQL4ZgOgzI779KCghR7tMesVJOLqiC8hJIsHMXRt
 kHwc1NHEFnreW8Df4fhDrVm83TMzeSEjkCemlrOAIbXrToxixuQ54JGhFvID5V25RKXN3s04EHW
 sOf2qbRBXFeHVZxj5z6jxdS7WseiAm6uJi0Ksaj1B78w6WXb5eEyWjOg2ntNEOP94IuQL54IpJN
 E=
X-Received: by 2002:a17:907:7ea8:b0:9b6:50cd:a222 with SMTP id
 qb40-20020a1709077ea800b009b650cda222mr3866957ejc.54.1697617686197; 
 Wed, 18 Oct 2023 01:28:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFymaQkNqQ8KkpLXAD/zpxsAJEH6icUNfNn//G1pTbldiB6YlaaW5DoBJD+AlwlycSYSA3gQ==
X-Received: by 2002:a17:907:7ea8:b0:9b6:50cd:a222 with SMTP id
 qb40-20020a1709077ea800b009b650cda222mr3866943ejc.54.1697617685789; 
 Wed, 18 Oct 2023 01:28:05 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 e26-20020a170906749a00b009adc5802d08sm1177397ejl.190.2023.10.18.01.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 01:28:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PULL 06/32] tests/vm: netbsd: install dtc
Date: Wed, 18 Oct 2023 10:27:26 +0200
Message-ID: <20231018082752.322306-7-pbonzini@redhat.com>
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

Install dtc as it is now a mandatory external dependency in order to build QEMU.

Co-developed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/vm/netbsd | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/vm/netbsd b/tests/vm/netbsd
index c7e3f1e7357..40b27a34694 100755
--- a/tests/vm/netbsd
+++ b/tests/vm/netbsd
@@ -40,6 +40,9 @@ class NetBSDVM(basevm.BaseVM):
         "gsed",
         "gettext-tools",
 
+        # libs: basic
+        "dtc",
+
         # libs: crypto
         "gnutls",
 
@@ -67,7 +70,8 @@ class NetBSDVM(basevm.BaseVM):
         mkdir src build; cd src;
         tar -xf /dev/rld1a;
         cd ../build
-        ../src/configure --disable-opengl {configure_opts};
+        ../src/configure --disable-opengl --extra-ldflags=-L/usr/pkg/lib \
+                          --extra-cflags=-I/usr/pkg/include {configure_opts};
         gmake --output-sync -j{jobs} {target} {verbose};
     """
     poweroff = "/sbin/poweroff"
-- 
2.41.0


