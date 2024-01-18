Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 572FC831918
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 13:25:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQRS6-0004Jt-Dp; Thu, 18 Jan 2024 07:24:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRy-0003hj-6o
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rQRRw-0006Qa-EP
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 07:24:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705580687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5sh/MzaGjWxLlgh2MspMlqhV3rmhSqr08po1WDn+uqs=;
 b=Js6ZDjaHNCjDSA24y4RssyJx2fxHK68Hk2MVr5S76MzG4CkCTudiToHL06+hAGj3hNYhK9
 G9lByT3RsSFjk9P8YP5NE9sMqzEr95XJdC370g9257A0Ano/rueplTUvyrzncIKlmg5ycp
 h1ZCrz/isF360H6JHMFauxCiig3nVNY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-UwLlthGaN4qE9EVq-vLRiA-1; Thu, 18 Jan 2024 07:24:46 -0500
X-MC-Unique: UwLlthGaN4qE9EVq-vLRiA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2bc65005feso460746666b.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 04:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705580685; x=1706185485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5sh/MzaGjWxLlgh2MspMlqhV3rmhSqr08po1WDn+uqs=;
 b=eeRQ3m6kHA8h/C3aYDr0KMEtpJfqAQUvoFZ8W/+HJx0QDkyudXA461cB0fR+jAhrqw
 sV9z9E0baJ0JRFblxLpi42gq+qCbMx1VkJzFDRH/xiIhiNaW/hFYWyrkAI1Q5BKWwTgl
 MwKUlzEtaMsZ7YaPIlMp/NraRXZOIm6yZ8gKSXRFEPAcBqPII3xB1DXxS3MqVpTo3nec
 ujTkelGujef3bTd0unSyY2dGTIvhpIIY2b5oKtHLwOp0icRI31ND9xhUbjuICjwvbnNS
 Kjh5EZrfIV2Wze94qrYsmgYRAft2FzAClWH7GTF+b4+y4qDPChXGIvqriLfVHLGrqi1d
 jeXA==
X-Gm-Message-State: AOJu0YwOwybVFG0XZH96ucH+m2ZfdRe1l6rmkmeuAGD1oVCy2Qd1jQIE
 O0ogkcnxwC3k7ZaXueB9i5unPlQ1GUla6HvOOHT2pNwEfu6+jUVlDBvEbzPaq+596QRDSIODCII
 lkcNo8YAZmMVmPes1ZzMSMBEfRdu86JmNWDGr+EWlUtRhr2lh0U0/zTCQdVast7mm23RcAMIsDg
 r9Kbh0I8SKR8Qf2aPfSclq7T3m1A4ccQSwpTjc
X-Received: by 2002:a17:906:c34c:b0:a2d:4383:78c7 with SMTP id
 ci12-20020a170906c34c00b00a2d438378c7mr430536ejb.132.1705580684925; 
 Thu, 18 Jan 2024 04:24:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJ/CAdaZhHz1QduMdvvFbH6q52VUqfQ36AfUfQMRsvOqjc+iedr1UzAMzAD8bzdfdygtGytQ==
X-Received: by 2002:a17:906:c34c:b0:a2d:4383:78c7 with SMTP id
 ci12-20020a170906c34c00b00a2d438378c7mr430530ejb.132.1705580684541; 
 Thu, 18 Jan 2024 04:24:44 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 cw8-20020a170907160800b00a2cd72af9cesm7871793ejd.146.2024.01.18.04.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 04:24:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 15/16] qemu/osdep: Add huge page aligned support on LoongArch
 platform
Date: Thu, 18 Jan 2024 13:24:15 +0100
Message-ID: <20240118122416.9209-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118122416.9209-1-pbonzini@redhat.com>
References: <20240118122416.9209-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bibo Mao <maobibo@loongson.cn>

On LoongArch kvm mode if transparent huge page wants to be enabled, base
address and size of memslot from both HVA and GPA view. And LoongArch
supports both 4K and 16K page size with Linux kernel, so transparent huge
page size is calculated from real page size rather than hardcoded size.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Message-ID: <20240115073244.174155-1-maobibo@loongson.cn>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/osdep.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 9a405bed893..c9692cc3142 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -547,6 +547,14 @@ int madvise(char *, size_t, int);
 #  define QEMU_VMALLOC_ALIGN (256 * 4096)
 #elif defined(__linux__) && defined(__sparc__)
 #  define QEMU_VMALLOC_ALIGN MAX(qemu_real_host_page_size(), SHMLBA)
+#elif defined(__linux__) && defined(__loongarch__)
+   /*
+    * For transparent hugepage optimization, it has better be huge page
+    * aligned. LoongArch host system supports two kinds of pagesize: 4K
+    * and 16K, here calculate huge page size from host page size
+    */
+#  define QEMU_VMALLOC_ALIGN (qemu_real_host_page_size() * \
+                         qemu_real_host_page_size() / sizeof(long))
 #else
 #  define QEMU_VMALLOC_ALIGN qemu_real_host_page_size()
 #endif
-- 
2.43.0


