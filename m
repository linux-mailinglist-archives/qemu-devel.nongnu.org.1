Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A087348B5
	for <lists+qemu-devel@lfdr.de>; Sun, 18 Jun 2023 23:52:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qB0J0-0002ob-UA; Sun, 18 Jun 2023 17:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0Iz-0002oQ-1z
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qB0Ix-0006W0-Lg
 for qemu-devel@nongnu.org; Sun, 18 Jun 2023 17:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687125087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oP1MubZhPu+IU33FcEr2ztQqoz4mfwTSrVTYTsYuNNs=;
 b=A8MF29tsrJ6M6CMVVTBGZWAhrN7FZKCd7N1LLchoDuvg9vPFPL7CFZStTVLqFoU/Iutxtw
 +fxcWwQOjqhF/jD3SvTqGWIdlXjJFiHzbjEzrdeeSxBBlDeT7CGn96b0Zbv3ImfiHfCPCA
 UgzFllhVUI7SJrVMMe15KdyWvbPCSA0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-FhUMu_dyO8e5ehSL9sQWDA-1; Sun, 18 Jun 2023 17:51:25 -0400
X-MC-Unique: FhUMu_dyO8e5ehSL9sQWDA-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-982180ac15cso221774266b.2
 for <qemu-devel@nongnu.org>; Sun, 18 Jun 2023 14:51:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687125084; x=1689717084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oP1MubZhPu+IU33FcEr2ztQqoz4mfwTSrVTYTsYuNNs=;
 b=iDCHfn5RCSWgIAbJ44UenFhWuiZlXBfNDqQySss6iH6SLYOiiCFeINHY9s5GrV+yea
 VFacV7Fzfm2KB0fH1lokQomnYbSzkIk5AxvJHXrDn8DhTRAGSba1Rwi2hnd13KNk9Na4
 MRMcpGASn0M9WJh8v88hdyg16+txc9DgLEtYn5muURJt3bl9bs3PcUxZSaf6/mgqL2Y2
 PSByo08EkuCz3jqdJMJimRAcX3kOx0Ppt4ZC4lZP/UQ+k1dfXEOVDh7gN+39BIygVoEG
 bS0jn85LOD+f5BWt9gnXrOA29yCUbjR5bgOrmApg9GEMS5vxAYsFs40GL3t64fqBL1HG
 8EMw==
X-Gm-Message-State: AC+VfDz4ZIA/i6QFXsrgkafVv9BIztxQiBoKKg+pbmcChWTmDfnIYze/
 tEpq4T8ukRC51O1V4QHVYgpdR5ga/uAnKwMQ3yUtRyUgayeuESBC1JTHAlluPA/mWIvuvlhnvW8
 tzHxT8ohi+r2Ee2t9fMVevg4g8Q6BOcD3728gbuUoMhxVFtG4aPBaRc06v4dDdEMTDu+q/S+npW
 XVmw==
X-Received: by 2002:a17:906:4fd1:b0:97e:bfb5:9344 with SMTP id
 i17-20020a1709064fd100b0097ebfb59344mr8101420ejw.8.1687125084182; 
 Sun, 18 Jun 2023 14:51:24 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58mReNFLcDeC9eAWSLPHTwHBBQqMVOlCUfOIejmHXhHcoYVMiV13lImxlsatBWNgpzsCmmjQ==
X-Received: by 2002:a17:906:4fd1:b0:97e:bfb5:9344 with SMTP id
 i17-20020a1709064fd100b0097ebfb59344mr8101411ejw.8.1687125083935; 
 Sun, 18 Jun 2023 14:51:23 -0700 (PDT)
Received: from [192.168.60.219] (server.hotelpassage.eu. [88.146.207.194])
 by smtp.gmail.com with ESMTPSA id
 gv19-20020a170906f11300b00988a0765e29sm692949ejb.104.2023.06.18.14.51.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jun 2023 14:51:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/7] target/i386: TCG supports RDSEED
Date: Sun, 18 Jun 2023 23:51:10 +0200
Message-Id: <20230618215114.107337-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230618215114.107337-1-pbonzini@redhat.com>
References: <20230618215114.107337-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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


