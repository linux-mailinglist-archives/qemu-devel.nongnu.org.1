Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EF1820A8B
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:50:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrUy-0008DK-1Y; Sun, 31 Dec 2023 03:48:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSb-0004x7-3h
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrSZ-0000mZ-Je
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owx05OOR9mZgM/WrKUsYkE67eZ7xm66ZLa13wAuF+Rw=;
 b=Lbsc29sUVjG+XY0q3cowHBBw8Q/zGGGZmUGjcGW5HfLNRxXNNwc0IS5NRui7g5f5YcDo9v
 zj2TLo+kalfndoHO00M31a1aPMRydolW3OZ/1vvLZwEokB67Cl/pg8uV5S6jedGTvPtxzu
 U8lZlEQGALt5C1714s3JrmdSGfjU7z8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-GpRXzkxdOxOrS3akQeRNAQ-1; Sun, 31 Dec 2023 03:46:13 -0500
X-MC-Unique: GpRXzkxdOxOrS3akQeRNAQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40d2f7007e6so79182405e9.1
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:46:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012371; x=1704617171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owx05OOR9mZgM/WrKUsYkE67eZ7xm66ZLa13wAuF+Rw=;
 b=W+dSPptYWiRb243W2CA9x05y9Yvq80yXWjkYtve5tt1MAahCshzqQrs5yRu8mA/4n/
 5lbaLwru1qfGMqFtCKoKmTkBnENPLWtMjNvq2sOjeqjTQ5tLCHO30ckkCFq1ZWxGp8Mj
 h9BcKSp46PL3XPu42qOkIy7Yn4RVEoyGMDpAjMt101BDUsC1Ycs7Jwy/igsx4t1raUmE
 MWJwQBw/GDK8Sswy04RyhDBCqTPPiZr7NHWMbbW21pzopmriE7vDvmLa2ePSQ87NB0oo
 HiwmiAZOoerJbtmGJDS3Dmmg/lzbz2xU9Xbe6yTvO8ZuFQMflVSXn2mhKC20uTWtsK8u
 k+ow==
X-Gm-Message-State: AOJu0YyW6vb2CCArmPzYnalHdoaIeLFrcBzmefkuRaPK3ef20G5cxpu/
 WelvCS8AIT+T7BXGnKlgIriGln/3PnHXhQTZnF6SEmi4+1LXLHF6gBtYKAyFUCh+czHJz0Z7CTL
 fT5q2qEYrGMzdB+Al9bO+FoDY86DnF0bocjQxuxGzqZf6TZJPgx7LNu40BGYwCs1FbNXSw/DhW7
 hcNnGrveo=
X-Received: by 2002:a1c:7507:0:b0:40d:5821:516b with SMTP id
 o7-20020a1c7507000000b0040d5821516bmr4699027wmc.54.1704012371203; 
 Sun, 31 Dec 2023 00:46:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUlPoEvlecPXWHdVJ/PQP0eqTexseMvhHKGqpYt61ZqjZHJs73aoC5R4NGT8dRdDwby+cxDw==
X-Received: by 2002:a1c:7507:0:b0:40d:5821:516b with SMTP id
 o7-20020a1c7507000000b0040d5821516bmr4699022wmc.54.1704012370963; 
 Sun, 31 Dec 2023 00:46:10 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 jh3-20020a05600ca08300b0040d81d16711sm5062153wmb.16.2023.12.31.00.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:46:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Vladim=C3=ADr=20Bene=C5=A1?= <vbenes@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PULL 23/46] target/i386: the sgx_epc_get_section stub is reachable
Date: Sun, 31 Dec 2023 09:44:39 +0100
Message-ID: <20231231084502.235366-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The sgx_epc_get_section stub is reachable from cpu_x86_cpuid.  It
should not assert, instead it should just return true just like
the "real" sgx_epc_get_section does when SGX is disabled.

Reported-by: Vladimír Beneš <vbenes@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20220201190941.106001-1-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/sgx-stub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 26833eb233c..16b1dfd90bb 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -34,5 +34,5 @@ void pc_machine_init_sgx_epc(PCMachineState *pcms)
 
 bool sgx_epc_get_section(int section_nr, uint64_t *addr, uint64_t *size)
 {
-    g_assert_not_reached();
+    return true;
 }
-- 
2.43.0


