Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E88183191B
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:26:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRS5-0004BW-4S; Thu, 18 Jan 2024 07:24:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRS1-0003zI-60
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRy-0006XV-Vg
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNAly1Va9uOmD/aqKC3qQhN78zjE+pQNvRpWao8WKWA=;
 b=ihlIBBzvclCpYUnF2WYD6/RV/EovF3qou2FG3dFyibgs2VmMQvEm6LU2NJNjY7gOLYi+lf
 CsT2l0AszQub0/vA+WNdskjMN0d5b4yrbDUwh6TuiOP32zRPglaZRGncFoelAbog8gIfuJ
 q/xdp/F/JTP/qJGX2zTfdPWZK9jQ2YE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-8r1f-T6hPEy7qoDn1AIP6A-1; Thu, 18 Jan 2024 07:24:48 -0500
X-MC-Unique: 8r1f-T6hPEy7qoDn1AIP6A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2eace36abdso84192066b.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580687; x=1706185487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VNAly1Va9uOmD/aqKC3qQhN78zjE+pQNvRpWao8WKWA=;
 b=jVI24DgAunKYyIZXaTYsdf13Z1SWg5VhcF5KryaLhjq5XFCmMVgJtsaFhvLGfD+EzL
 W9m9tMHnupNNovh+y2VlRD4gR3Q8Fvn+QKJJ4kiU5nFx1nVH7jdA4EVUeYA+2VQhRZ0g
 SfUMUUvdrByxytn9SGMDD1Of148RTJS1FquhtlyrbdU8yUF1+fbTN2t5eI0wy1J4CFZ9
 rqrLBCob5RO4U/8wpL6QBqYAI1fH9ePbSEiU69IITi1+w/4e29PE/j+X38zigxWWsEiz
 83/t9PJ5U5isgu8w8LErlgwXnoa7RrPpK1Vp8mwTzeZFPnM//oQKfldHpc5+t/x+E7hU
 kvxQ==
X-Gm-Message-State: AOJu0YyQmBomTc0c1mJP6xuF6v9QRucDjItI9y8aaQ3ULsQ0piNoS8aP
 WmWOyYvkBrcp6gqt+HxhCwyQkTSpQMSC9MYd/0Ax7RSQYmdSJz5pb5Kak0xPxZSTa09HotCdmh9
 HAqXX5T9vi32GFwCCK6Es64pNTnioFD0k1TLw+kI+lYr27hPFYSA3VzsiDac8x6I9yscAL1KhnE
 wMuQ9AAzKDzjIp4Eh3Yey2kks3FiAHuqU3508C
X-Received: by 2002:a17:906:81c8:b0:a28:ac5b:5814 with SMTP id
 e8-20020a17090681c800b00a28ac5b5814mr242678ejx.185.1705580687201; 
 Thu, 18 Jan 2024 04:24:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEALDULHaUhl5dvug/meiFhbXGn7QXpJ5MBYQ1zGM/KqHz3OIeWvopMDCUEkgYIml6f6mBPyw==
X-Received: by 2002:a17:906:81c8:b0:a28:ac5b:5814 with SMTP id
 e8-20020a17090681c800b00a28ac5b5814mr242673ejx.185.1705580686895; 
 Thu, 18 Jan 2024 04:24:46 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 x27-20020a170906299b00b00a2c0fec4240sm9091833eje.158.2024.01.18.04.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 16/16] tests/tcg: Don't #include <inttypes.h> in
 aarch64/system/vtimer.c
Date: Thu, 18 Jan 2024 13:24:16 +0100
Message-ID: <20240118122416.9209-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

make check-tcg fails on Fedora with:

    vtimer.c:9:10: fatal error: inttypes.h: No such file or directory

Fedora has a minimal aarch64 cross-compiler, which satisfies the
configure checks, so it's chosen instead of the dockerized one.
There is no cross-version of inttypes.h, however.

Fix by using stdint.h instead. The test does not require anything
from inttypes.h anyway.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-ID: <20240108125030.58569-1-iii@linux.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/aarch64/system/vtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/aarch64/system/vtimer.c b/tests/tcg/aarch64/system/vtimer.c
index 42f2f7796c7..7d725eced34 100644
--- a/tests/tcg/aarch64/system/vtimer.c
+++ b/tests/tcg/aarch64/system/vtimer.c
@@ -6,7 +6,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
-#include <inttypes.h>
+#include <stdint.h>
 #include <minilib.h>
 
 /* grabbed from Linux */
-- 
2.43.0


