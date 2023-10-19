Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDF7CF59E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:47:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQYW-0006X6-OJ; Thu, 19 Oct 2023 06:47:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYS-0006FT-B2
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYQ-0006Cp-Rq
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9AH2w7IcRILYZ2JEj5EmCtr4xLbCojrRKRbWDyxGwE=;
 b=O2rzjq+h1RG5bi1Vky4bkpb12XqoIhECTBnKW+Qame8s4hZ+5o8fyvFMiGDOi29uMBqt9T
 oYBPdp3/lq6dwe+uB2TzwOPyOdsLh3idyrhR8r3XgQWnLjkFuqQgH8lpGBkDnHaE4pF7Ne
 5PNY6vPHZUdfY7sEoL2x9aiebVNdJzA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-hOG-D-DaMw61vcb1i2MGaA-1; Thu, 19 Oct 2023 06:47:01 -0400
X-MC-Unique: hOG-D-DaMw61vcb1i2MGaA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99bcb13d8ddso577675066b.0
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:47:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712419; x=1698317219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9AH2w7IcRILYZ2JEj5EmCtr4xLbCojrRKRbWDyxGwE=;
 b=ge6ErDdLpHu5oNbp0yW1LDxMhe8vnyVVgIMVJRB7FdDeZZ3iRhDAKMkaJ0uY7+tJOW
 m7zfZwZYbRtpT8hiGNqkwKZu/1d2HWUo+qUaro3dxCC5WyX9rAD2FO6IPT0i2Qf5tOKX
 SWBvex64R44CCABBVhoSSPDrNhvJm9XdZ8R1oRc/aavFcVEYfn1S8wlIGcygegzO4A9O
 0/vAqw7F9iws8EDBrumW3EfqwYKZDXytRGb9eDfgzsjQs5C+wVlk8Mm0Ds1LkqvCtc20
 X04IQVeExwUkChg8lCXCHRg/81Vqs4OB/ckJ4DpI70FhVPk9kWklCFLftrAzk1Jtu7b4
 9Yvw==
X-Gm-Message-State: AOJu0Yy4gh/MnHpqnW4Y0dNuyoD4fRMKrpw+CmxghIcNCvQ58Oyf/DV1
 xAbzvfi2pHG71dhupJYQ7o6aPHOwOLP+S1FiDHiEG+PWjIysJben5QJNWCJQZjmgk9KkpkzSYoe
 ovW8BJTTa9pBQLgtjdLo8PD30GVLC5xdKDm0Bq+UMtVCdKphFifDUXBYcLnX8jMOLJ/yQRjgiiv
 4=
X-Received: by 2002:a17:906:eec5:b0:9bd:b8d0:c096 with SMTP id
 wu5-20020a170906eec500b009bdb8d0c096mr1576490ejb.21.1697712419523; 
 Thu, 19 Oct 2023 03:46:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbxz1GVwrajUgSC73v7tyV1Cg8PS9hKAufc34pV+bqCKRMqqbUVJU+SW/33jx/1OaxBmpKgg==
X-Received: by 2002:a17:906:eec5:b0:9bd:b8d0:c096 with SMTP id
 wu5-20020a170906eec500b009bdb8d0c096mr1576479ejb.21.1697712419188; 
 Thu, 19 Oct 2023 03:46:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p6-20020a1709061b4600b009b65b2be80bsm3295871ejg.76.2023.10.19.03.46.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:46:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 05/19] tests/tcg/i386: test-avx: add test cases for SHA new
 instructions
Date: Thu, 19 Oct 2023 12:46:34 +0200
Message-ID: <20231019104648.389942-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231019104648.389942-1-pbonzini@redhat.com>
References: <20231019104648.389942-1-pbonzini@redhat.com>
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

---
 tests/tcg/i386/test-avx.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/i386/test-avx.py b/tests/tcg/i386/test-avx.py
index 641a2ef69eb..6063fb2d11d 100755
--- a/tests/tcg/i386/test-avx.py
+++ b/tests/tcg/i386/test-avx.py
@@ -9,7 +9,7 @@
 archs = [
     "SSE", "SSE2", "SSE3", "SSSE3", "SSE4_1", "SSE4_2",
     "AES", "AVX", "AVX2", "AES+AVX", "VAES+AVX",
-    "F16C", "FMA",
+    "F16C", "FMA", "SHA",
 ]
 
 ignore = set(["FISTTP",
@@ -43,6 +43,7 @@
     'vPS[LR][AL][WDQ]': 0x3f,
     'vPS[RL]LDQ': 0x1f,
     'vROUND[PS][SD]': 0x7,
+    'SHA1RNDS4': 0x03,
     'vSHUFPD': 0x0f,
     'vSHUFPS': 0xff,
     'vAESKEYGENASSIST': 0xff,
-- 
2.41.0


