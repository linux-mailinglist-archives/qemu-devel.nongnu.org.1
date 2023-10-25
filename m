Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C94767D7894
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 01:30:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvnHw-0001Y8-OB; Wed, 25 Oct 2023 19:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHv-0001Xz-M1
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qvnHu-00052d-95
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 19:27:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698276465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UY1wAEDNFydOtexdv37dGc4LgmSZcTd8TGDxaQVmZ0c=;
 b=UEI0CaTG9KtsN/atES14A1tPCOtzs+VzN5U89ZBe1NsNrKIQRKUvCd4rmbqDVpzyxk0idK
 pgqDOT4tqE6UmZe2td9xQ6l6Gly537PJagQbPKN2T/UDpipyDjz6+4WLXrSf1dFWfYkle6
 AY4oD4iAxa5Yy+IQgq0mov5/VbisSrM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-dCzBCzcBNqapZJOUM4Ghrw-1; Wed, 25 Oct 2023 19:27:34 -0400
X-MC-Unique: dCzBCzcBNqapZJOUM4Ghrw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d12cd3591so4453546d6.3
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 16:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698276453; x=1698881253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UY1wAEDNFydOtexdv37dGc4LgmSZcTd8TGDxaQVmZ0c=;
 b=W4fk9szCLBzqMidRzaMKs1fTibNGvTYBE/s0o7c6cN6g18OzZi5qdYP8zMbDGgUhMv
 g2NWbwuzfCwF0HGZRH2HdfCwuH9V/sXpA/Zw3i+RmTk/kg1Xxw/ImItNv7tHTHXWSBer
 ye7M1S1l99XIxNfNzTILY9FJVgfZuzNAjhdO2aPDGM/Eu1xJsZGEqrm4TZdPHFegx8Cb
 LGNdiLwHc5Ka248g1cgCMsYPWdn1pEgJvAWyVsqY6lDsg4MRqU5pJYDyrvnHRpM/yVf/
 2v/Rs/FIeTfGV+buPzkXNsRpmhldZgXnUfrW0Tr+wYOkHkHdWYYJivAOoc5wmXc9VbQJ
 Hynw==
X-Gm-Message-State: AOJu0YzREVnlBPxBmW2scyybf4lU98rWgFE2f3B9dAWL3pK10FRr+IVE
 /xwuxb4Q8KHJjXT+HOG5suqrtdbs0nJKJa/DjnIAOVG0cyQDPtKYHyoxEH8XZZYo2+DWu0fhrMu
 czNJpLuozSwmc/qgu24g++C9iRCV3oOLTj0M2UdnLOVRg+zlK/0yoKpZkJ7nD1cypkIprQVu4Te
 M=
X-Received: by 2002:a05:6214:c4b:b0:66d:66bd:e60a with SMTP id
 r11-20020a0562140c4b00b0066d66bde60amr14020578qvj.64.1698276452846; 
 Wed, 25 Oct 2023 16:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHR/UY/yCIgMT9nKwzW0p/N3JR4nWvNX155Bqa/JOGwiWZesbg7WS41PGELxO1vS33zWlCrTg==
X-Received: by 2002:a05:6214:c4b:b0:66d:66bd:e60a with SMTP id
 r11-20020a0562140c4b00b0066d66bde60amr14020558qvj.64.1698276452459; 
 Wed, 25 Oct 2023 16:27:32 -0700 (PDT)
Received: from [172.19.0.201] ([192.80.84.35])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a0cd60f000000b00658266be23fsm4757135qvj.41.2023.10.25.16.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 16:27:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 07/24] target/i386: check CPUID_PAE to determine 36 bit
 processor address space
Date: Thu, 26 Oct 2023 01:27:00 +0200
Message-ID: <20231025232718.89428-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025232718.89428-1-pbonzini@redhat.com>
References: <20231025232718.89428-1-pbonzini@redhat.com>
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

From: Ani Sinha <anisinha@redhat.com>

PAE mode in x86 supports 36 bit address space. Check the PAE CPUID on the
guest processor and set phys_bits to 36 if PAE feature is set. This is in
addition to checking the presence of PSE36 CPUID feature for setting 36 bit
phys_bits.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20230912120650.371781-1-anisinha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 070c02000fe..fc8484cb5e8 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -7377,7 +7377,7 @@ static void x86_cpu_realizefn(DeviceState *dev, Error **errp)
             return;
         }
 
-        if (env->features[FEAT_1_EDX] & CPUID_PSE36) {
+        if (env->features[FEAT_1_EDX] & (CPUID_PSE36 | CPUID_PAE)) {
             cpu->phys_bits = 36;
         } else {
             cpu->phys_bits = 32;
-- 
2.41.0


