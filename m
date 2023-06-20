Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E08073703F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 17:19:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBd6N-0003SV-Sg; Tue, 20 Jun 2023 11:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6D-0003Pk-Eg
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qBd6B-0007Pq-Ls
 for qemu-devel@nongnu.org; Tue, 20 Jun 2023 11:16:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687274210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o8Xy+XgrFXuq/CUb4fCCE3MUltP0l+8H/Qj1M0zYVFo=;
 b=fgMrlMssKQa6hxwTnpJkFuJ3keaNDrYvqlutqQMspEiXIe6ek4KqAoz+0wgH2IEUhVq6ad
 UubYBuQ/czPaOv4zNx09UEIL11mM4S4vWL2MSPN5usBUn5Nb0VHSbzKcuNqVJmegeQ89Vl
 LFmaUHRrfPezj5S6Y1OrH6Q0BVBu7iY=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-c1DlPBXaPRqcM8UGie5Xrw-1; Tue, 20 Jun 2023 11:16:47 -0400
X-MC-Unique: c1DlPBXaPRqcM8UGie5Xrw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a35b0d4ceso286793766b.3
 for <qemu-devel@nongnu.org>; Tue, 20 Jun 2023 08:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687274202; x=1689866202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8Xy+XgrFXuq/CUb4fCCE3MUltP0l+8H/Qj1M0zYVFo=;
 b=lkQ9JfKfCMd2PSSs0G4T+dvolfcJ3Y28Y6vRtwDTrGe94ew0QyoBUxjsHBjcL5z8zN
 MkeVv2sqeOiDPVeAjCzMfSun4imRHO5pIF1rxgyxoRbBydmNKSSS8bNo2MS6SEe2p6wV
 z10uP4cp04vo4CFg5/O6qy6TAYCSkyD5Hix7IQqVbe3sntlo78u1k6ohB50Tl6CDV65p
 otYJ3Yt+TFm50sZNttTnvsD12UpccpLcUr3tcpN8If7SlTmNoGGoiARhbKZ+xw58CNDb
 tA64LBzb0B5KRfTdFz0cyuQ3a54POxZ69zkTOvR4zLgaPDFuFNPbVfjUUPW2IQGZYPGN
 QrQg==
X-Gm-Message-State: AC+VfDwfjHbYg43BltLpbAQjFNXxmPB35wO0RT+TMJiIOQqedk9wEeMX
 0Q8DAbHakL2bsLY4nlyVcZpK8VFU5Z8/P+eBd4nbEm5O4e4mjqUtXKqOww84Gh8zj+ePKNE47i7
 DAw1KgwZ/1MwezuL2JWJCOZe0kpAMK3AGkp1IWFp2IFHOEojQlDT7lLsOaIEucqJFZY5MIJlxI2
 E=
X-Received: by 2002:a17:906:6a25:b0:989:40a9:5059 with SMTP id
 qw37-20020a1709066a2500b0098940a95059mr1489458ejc.73.1687274202249; 
 Tue, 20 Jun 2023 08:16:42 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6H411QS5/k0x0UFaVv8Uny2PrzrKCMl0SPttt+j/kPf0R/ixha8SpNVt8d1RTEB7gnffqDvw==
X-Received: by 2002:a17:906:6a25:b0:989:40a9:5059 with SMTP id
 qw37-20020a1709066a2500b0098940a95059mr1489445ejc.73.1687274202028; 
 Tue, 20 Jun 2023 08:16:42 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a170906079100b00986f9c830efsm1553168ejc.156.2023.06.20.08.16.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jun 2023 08:16:41 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH v2 03/10] target/i386: TCG supports RDSEED
Date: Tue, 20 Jun 2023 17:16:27 +0200
Message-Id: <20230620151634.21053-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620151634.21053-1-pbonzini@redhat.com>
References: <20230620151634.21053-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

TCG implements RDSEED, and in fact uses qcrypto_random_bytes which is
secure enough to match hardware behavior.  Expose it to guests.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index ff3dcd02dcb..fc4246223d4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -657,11 +657,10 @@ void x86_cpu_vendor_words2str(char *dst, uint32_t vendor1,
           CPUID_7_0_EBX_BMI1 | CPUID_7_0_EBX_BMI2 | CPUID_7_0_EBX_ADX | \
           CPUID_7_0_EBX_PCOMMIT | CPUID_7_0_EBX_CLFLUSHOPT |            \
           CPUID_7_0_EBX_CLWB | CPUID_7_0_EBX_MPX | CPUID_7_0_EBX_FSGSBASE | \
-          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2)
+          CPUID_7_0_EBX_ERMS | CPUID_7_0_EBX_AVX2 | CPUID_7_0_EBX_RDSEED)
           /* missing:
           CPUID_7_0_EBX_HLE
-          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM,
-          CPUID_7_0_EBX_RDSEED */
+          CPUID_7_0_EBX_INVPCID, CPUID_7_0_EBX_RTM */
 #define TCG_7_0_ECX_FEATURES (CPUID_7_0_ECX_UMIP | CPUID_7_0_ECX_PKU | \
           /* CPUID_7_0_ECX_OSPKE is dynamic */ \
           CPUID_7_0_ECX_LA57 | CPUID_7_0_ECX_PKS | CPUID_7_0_ECX_VAES)
-- 
2.40.1


