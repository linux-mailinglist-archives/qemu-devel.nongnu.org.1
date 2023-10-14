Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AAE7C940C
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:05:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbSm-0002Tw-FK; Sat, 14 Oct 2023 06:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSk-0002Ti-0O
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSi-0003yZ-JN
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9AH2w7IcRILYZ2JEj5EmCtr4xLbCojrRKRbWDyxGwE=;
 b=CBQceuhrRwmg+rdREm2yeNoP40eDJlIXSlC+heo6+AD5Xyvjx/mrKoEfrJAEfqOIMjTT3E
 Igdyz388zODIcw/XRfr2PFPuh7ZQwaWcKocrNyfdN6GIMh0awMWYWuPXQC94et0bixsvl6
 ZOOXhW2lQ1Gu8o8u5y3qJmYSCKBC5jY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-2T0pXLbmNyOvB4JEvxBXvw-1; Sat, 14 Oct 2023 06:01:34 -0400
X-MC-Unique: 2T0pXLbmNyOvB4JEvxBXvw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32d879cac50so1724778f8f.0
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277693; x=1697882493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e9AH2w7IcRILYZ2JEj5EmCtr4xLbCojrRKRbWDyxGwE=;
 b=k5WeVbllIwtWWL+urjqvQfnWa23v6iJ5/4MXfHNfKuEcUz/EfziPOTTfROt0Bpr5kI
 4wJnR75UQ+a+NnEwmNJaGPjr1PW8vuF5t+9sHLXtXExYUa79zrgT2Qw8dW+FDeiQebOn
 PGNQE2sjYjiH81BSzyEA0uag0BWAlCY9/gPSu6Fagan3UrQpwKcCoYPnVA1SwH5oN5Ab
 eguC5qCZ4Ro+TXzAgz6LyiBCR1esoLLpdlUdJ1oEMUSEzM4ZJQlq5hgdUyJGDRlWxH8B
 3VmhLTtI+nUJlkPI/Sf1wPjN6Ik31n4uqNOA6ZgeNZQbUOTQlbf+NalyOsiq4GCl7lLi
 hoiw==
X-Gm-Message-State: AOJu0Yy6R3YhF2jyiCB7tFm+wImUMao1A9Ff+ASR4D4T5J3Wo/853zdm
 e4RvSq0g/cOUkRPRaUAywehkJ3B/SfW3z6LhEp/VdSPjVxwcKNDvcpQqIqF2Gp86KlTY8r4NIDi
 K/pNiAIEQb2nbWDLOQ1OZNYAxvjSFB8ap7VHLm+IezykGRjt+2XiHZOCdwbBbkNz738o5JFaAul
 A=
X-Received: by 2002:a5d:6548:0:b0:327:e070:15b8 with SMTP id
 z8-20020a5d6548000000b00327e07015b8mr25587674wrv.41.1697277692884; 
 Sat, 14 Oct 2023 03:01:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgbyxsOd2Y9iCnqt02rUj8l0gPsnJWWGQBiIllDLIxXmIeWAL0Xyliinhwer+CRKTQPcE9lA==
X-Received: by 2002:a5d:6548:0:b0:327:e070:15b8 with SMTP id
 z8-20020a5d6548000000b00327e07015b8mr25587660wrv.41.1697277692394; 
 Sat, 14 Oct 2023 03:01:32 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 k12-20020a056402048c00b0052ffc2e82f1sm12592156edv.4.2023.10.14.03.01.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/18] tests/tcg/i386: test-avx: add test cases for SHA new
 instructions
Date: Sat, 14 Oct 2023 12:01:07 +0200
Message-ID: <20231014100121.109817-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014100121.109817-1-pbonzini@redhat.com>
References: <20231014100121.109817-1-pbonzini@redhat.com>
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


