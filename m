Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C249D74B2B3
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:07:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHm4u-0007EY-UP; Fri, 07 Jul 2023 10:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4p-0007Cs-M5
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4o-0006P5-Bs
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688738689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eUGUC4ov6DrmuNFBvNshE7uD0YHJbuDYyq31gljpPZ0=;
 b=KpEnSWapl438jmIHwehr9SEBPSnOAHS0F4+718AXjo6LauNsldmwy+TEnw3AdYThR2demu
 ghi4p2BrSN2O5mqYJGJXT7I64rQIneEmL4vQSIqOF4f29+JIgwVkWFYZTnL3IBdDS+DPu7
 qatkrqkdY8fiTJ2/qGjL91cThLYO05Q=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-GxD8IDgLOdid35KRHlVJJQ-1; Fri, 07 Jul 2023 10:04:48 -0400
X-MC-Unique: GxD8IDgLOdid35KRHlVJJQ-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b70347bf04so19092511fa.3
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688738686; x=1691330686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eUGUC4ov6DrmuNFBvNshE7uD0YHJbuDYyq31gljpPZ0=;
 b=mHDr0WsqY4lM5YCAZrSSX61XdEEmp3gKcGtDml+8SJNE/WFUUZDMMACMBx7SmTvX+n
 wI3YW8ynWMMzCPpCrSWFjcXFjxTPI7RtYOLOEscyOMk4/d0i6lT9eNif7RQgIpC3/p5R
 Y9v5fONlQzcp0pvvI4qxOK6fqvqkLGQh/+6lsxV3cBJTCYnn1pTdSdI3VD23EUQhlSLN
 d6JHYMYN/0OFgHOSBtui1mS25IKndnha5SwAm01O15uax+38Rm/Wd6ka+QOe4mJdKBAN
 szjT5NYLcv/ZZtCSUYgLcYXS7lNUOpeMkYOoonvOJaoAD/lblsPAD/RvsQhYbHJRUZIN
 bNHg==
X-Gm-Message-State: ABy/qLYj2VETB7V1lRsswzvY1SRM/SLf4EPqKcN8ybbWHkU/mngJbIpK
 HI1+nz34RAKABdsri3Ao2I5RH4PMU+YWRyrphFvsTAV/QiNNNPocUfkMqOuAUXHbAPQkkeECkI9
 dFSvsqM1M9NGd1FQlMVmnseL8LVTrE83SrrTeqDrEhC3B9j5CU+X2GmYVy3sROx7GPj3eyO0NkV
 k=
X-Received: by 2002:a2e:9959:0:b0:2b6:d495:9467 with SMTP id
 r25-20020a2e9959000000b002b6d4959467mr3674604ljj.6.1688738686232; 
 Fri, 07 Jul 2023 07:04:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG5e1LjyO7+MHsEhv6ys3VkfuPQs+TMBOHIEjS0+Fdgjk+WcB90gGm8yguMxeNqeRt46c5MIw==
X-Received: by 2002:a2e:9959:0:b0:2b6:d495:9467 with SMTP id
 r25-20020a2e9959000000b002b6d4959467mr3674575ljj.6.1688738685833; 
 Fri, 07 Jul 2023 07:04:45 -0700 (PDT)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 e25-20020a1709067e1900b0098de7d28c34sm2218540ejr.193.2023.07.07.07.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 07:04:45 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tao Su <tao1.su@linux.intel.com>,
	Igor Mammedov <imammedo@redhat.com>
Subject: [PULL 7/9] target/i386: Add new bit definitions of
 MSR_IA32_ARCH_CAPABILITIES
Date: Fri,  7 Jul 2023 16:04:30 +0200
Message-ID: <20230707140432.88073-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707140432.88073-1-pbonzini@redhat.com>
References: <20230707140432.88073-1-pbonzini@redhat.com>
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

From: Tao Su <tao1.su@linux.intel.com>

Currently, bit 13, 14, 15 and 24 of MSR_IA32_ARCH_CAPABILITIES are
disclosed for fixing security issues, so add those bit definitions.

Signed-off-by: Tao Su <tao1.su@linux.intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20230706054949.66556-5-tao1.su@linux.intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c196b0a4826..e0771a10433 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1022,7 +1022,11 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define MSR_ARCH_CAP_PSCHANGE_MC_NO     (1U << 6)
 #define MSR_ARCH_CAP_TSX_CTRL_MSR       (1U << 7)
 #define MSR_ARCH_CAP_TAA_NO             (1U << 8)
+#define MSR_ARCH_CAP_SBDR_SSDP_NO       (1U << 13)
+#define MSR_ARCH_CAP_FBSDP_NO           (1U << 14)
+#define MSR_ARCH_CAP_PSDP_NO            (1U << 15)
 #define MSR_ARCH_CAP_FB_CLEAR           (1U << 17)
+#define MSR_ARCH_CAP_PBRSB_NO           (1U << 24)
 
 #define MSR_CORE_CAP_SPLIT_LOCK_DETECT  (1U << 5)
 
-- 
2.41.0


