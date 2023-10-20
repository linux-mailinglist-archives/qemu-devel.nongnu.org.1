Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F38FF7D0959
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 09:22:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtjpP-00007y-LX; Fri, 20 Oct 2023 03:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtjpJ-000072-9R
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtjpF-0003fC-LN
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 03:21:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697786500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=OlNWLkTTFD8gDImZgaHtyzT5EX9N3BacUBXGIw6j+8Q=;
 b=gWVV4MBcPXTEODEO7PqnmvnklCT9gtnyuAeh3+c0N26w+uJWPTdF6MqtRb9GT6/nA6p8BA
 m80fCGNX85jw/N5wjoRgtgY3o4IStsL6Jq3Q0SZXc7BraWwMwWQG5RtKCn1mw8r61IcI4j
 V31XsjuPr9Unop3Hfe3poq/In0OrRyE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-gYxnnB1pMC-jtZUmRk7j3Q-1; Fri, 20 Oct 2023 03:21:39 -0400
X-MC-Unique: gYxnnB1pMC-jtZUmRk7j3Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-9c6a4a60033so32054766b.1
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 00:21:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697786497; x=1698391297;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OlNWLkTTFD8gDImZgaHtyzT5EX9N3BacUBXGIw6j+8Q=;
 b=NyF/hYc0JjA4/8FfpfOEv6FF6uy+0X1YGC+ey8j/f7UAqR8UHEB5fSC0Em0p0dTY7S
 Ux1qU8O6mbRMIggSsHdctiCKs4hP4c1LaCt12vvovByo/iavA92VrUqEl6OW5/o5hvxv
 VenQnHYam5AMwrXHuXKFM2ND+/eQk/WQ57dP7s9AGDfT44Kof7yAYvwl+psRbGn+ATbt
 XTSzxsp5wF4SMPGmd48rZKdhJoB1SRG2DE+s/NGqTlwG7ox9nIMYMVP/QW29W5ITMJOA
 At5QhfpKLFkYsM+beCajg1TidQMl/xXdopL440WYJeABJukEXiQLxMNIbAJkOKkFl2Ay
 MShw==
X-Gm-Message-State: AOJu0Yw31AtImmAiJf6vj6OjmPqLlTBASiNMgnxWA36TzbUFLXwiq/w8
 O/bV46msNhaHm88jA9sbmD/CrUlH+qGqfGhURfHSMMec3kRx3OAuZEn6v+BxiqFNZNWWRjbZeHT
 x3KVa7RGuj4YqdMog5z23GgyWdyiu4R+TbanYM2582vdm0oz5tqT9X+CjwNzzGFV58wXw7HMoQG
 o=
X-Received: by 2002:a17:907:d29:b0:9bd:f902:9a61 with SMTP id
 gn41-20020a1709070d2900b009bdf9029a61mr742346ejc.18.1697786497606; 
 Fri, 20 Oct 2023 00:21:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeroumZyxKluHy4LNNEfU2NeOyTSGeBpl7HsDtF500J5BYtdCfTP4JIk2bdIeekmWR4LH92Q==
X-Received: by 2002:a17:907:d29:b0:9bd:f902:9a61 with SMTP id
 gn41-20020a1709070d2900b009bdf9029a61mr742332ejc.18.1697786497067; 
 Fri, 20 Oct 2023 00:21:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a170906348f00b009c387ff67bdsm922190ejb.22.2023.10.20.00.21.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 00:21:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests/tcg: fix out-of-bounds access in test-avx
Date: Fri, 20 Oct 2023 09:21:35 +0200
Message-ID: <20231020072135.450301-1-pbonzini@redhat.com>
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

This can cause differences between native and QEMU execution, due
to ASLR.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/tcg/i386/test-avx.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
index c39c0e5bce8..910b0673535 100644
--- a/tests/tcg/i386/test-avx.c
+++ b/tests/tcg/i386/test-avx.c
@@ -236,12 +236,15 @@ v4di val_i64[] = {
 
 v4di deadbeef = {0xa5a5a5a5deadbeefull, 0xa5a5a5a5deadbeefull,
                  0xa5a5a5a5deadbeefull, 0xa5a5a5a5deadbeefull};
-v4di indexq = {0x000000000000001full, 0x000000000000008full,
-               0xffffffffffffffffull, 0xffffffffffffff5full};
-v4di indexd = {0x00000002000000efull, 0xfffffff500000010ull,
-               0x0000000afffffff0ull, 0x000000000000000eull};
+/* &gather_mem[0x10] is 512 bytes from the base; indices must be >=-64, <64
+ * to account for scaling by 8 */
+v4di indexq = {0x000000000000001full, 0x000000000000003dull,
+               0xffffffffffffffffull, 0xffffffffffffffdfull};
+v4di indexd = {0x00000002ffffffcdull, 0xfffffff500000010ull,
+               0x0000003afffffff0ull, 0x000000000000000eull};
 
 v4di gather_mem[0x20];
+_Static_assert(sizeof(gather_mem) == 1024);
 
 void init_f16reg(v4di *r)
 {
-- 
2.41.0


