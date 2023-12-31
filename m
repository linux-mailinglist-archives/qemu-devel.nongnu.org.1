Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D692D820A9D
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:53:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUV-0006qu-00; Sun, 31 Dec 2023 03:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSv-00057p-4m
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSj-0000oz-B0
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQvpKRfV10v+DaxpxG4dtSEKlXRJpQzqLOwpOyalsOc=;
 b=f3axpE214PxCgFHjpNOBp62PXWyrmz7kne2dcTi3gfEdQ9sAuOuyff+O435IhbM7sLInWM
 8W0wBASL1BrEodvXw9ZOYKU3fDyKMJJbDv4v1kuEEyS3lWVJZ7IOny9SRXxyR1bK+286AG
 NLeBpzc6hh1Bz0pn6tD7mPwoNQ3BfRU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-VoSRxlOvP4ut9EXoPNNuJw-1; Sun, 31 Dec 2023 03:46:22 -0500
X-MC-Unique: VoSRxlOvP4ut9EXoPNNuJw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-336b8da86eeso4031661f8f.0
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012381; x=1704617181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQvpKRfV10v+DaxpxG4dtSEKlXRJpQzqLOwpOyalsOc=;
 b=D43g9lg3R+EPhZAnS1r4be/MVPG9Uxbmc0c7MTr2Z8jAt6RMyrW1ccCvTa/S3aZz91
 zPxLS7DoO7ZH07f9Kv6PrOWeZ1nH56sDQNW5mDvqvZ4Zc8EinhhvUtnouINfV0C5BHcQ
 yUUPZqvClCArPu+xhh2oFdoiD1dXVNMbro4rWBompW4PTQZIlYy0RxW7N1K9C1L4+Xko
 JBKcpFCSFMvPHLzyZaW3K+tRi5O+gm/iEfpIq3GeEZ6zhmbRNNt7rtSK3rt17rD0s4Ot
 ceMw1Lj1GhjM0RQC1KdJkvFWtnejeuj+YfCUKfOZ6pXzf0BpDhHhx9JUc6SN/uspL73c
 iLUw==
X-Gm-Message-State: AOJu0Yz/RgYmCCf2ihINYV68FoIFmPxr26SMx8FcOWM5le5IRQxA0JzS
 9YXeFeciOp0L/44MiFtJEc5EbwJqQOqYMy7i2DtYyG6Q6Ubl6l/b+bfYZIgFDHIRxkINL863NMG
 eesRAxCRLMW5mHUKpZDLRfFtbVy+P9wSxt3nTTrj09MxSFCswKpwF1nPqJPX4kblrvRgDa7wZUE
 IAVpTcudw=
X-Received: by 2002:a5d:4e41:0:b0:336:7dcd:a1e3 with SMTP id
 r1-20020a5d4e41000000b003367dcda1e3mr6119073wrt.141.1704012381101; 
 Sun, 31 Dec 2023 00:46:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFXRJr5xcrunxu/LymDEOh+QFPgzCenlVwF/WpkyRhPM3uGzUGi7OMuspEO7aDCfH0azHmkgQ==
X-Received: by 2002:a5d:4e41:0:b0:336:7dcd:a1e3 with SMTP id
 r1-20020a5d4e41000000b003367dcda1e3mr6119067wrt.141.1704012380820; 
 Sun, 31 Dec 2023 00:46:20 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 e18-20020a056000121200b0033629538fa2sm22973485wrx.18.2023.12.31.00.46.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 28/46] Makefile: clean qemu-iotests output
Date: Sun, 31 Dec 2023 09:44:44 +0100
Message-ID: <20231231084502.235366-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile  | 1 +
 configure | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 676a4a54f48..8f369903356 100644
--- a/Makefile
+++ b/Makefile
@@ -202,6 +202,7 @@ clean: recurse-clean
 		! -path ./roms/edk2/ArmPkg/Library/GccLto/liblto-arm.a \
 		-exec rm {} +
 	rm -f TAGS cscope.* *~ */*~
+	@$(MAKE) -Ctests/qemu-iotests clean
 
 VERSION = $(shell cat $(SRC_PATH)/VERSION)
 
diff --git a/configure b/configure
index d7e0926ff19..9885cfed792 100755
--- a/configure
+++ b/configure
@@ -1559,7 +1559,7 @@ LINKS="$LINKS pc-bios/s390-ccw/Makefile"
 LINKS="$LINKS pc-bios/vof/Makefile"
 LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
 LINKS="$LINKS tests/avocado tests/data"
-LINKS="$LINKS tests/qemu-iotests/check"
+LINKS="$LINKS tests/qemu-iotests/check tests/qemu-iotests/Makefile"
 LINKS="$LINKS python"
 LINKS="$LINKS contrib/plugins/Makefile "
 for f in $LINKS ; do
-- 
2.43.0


