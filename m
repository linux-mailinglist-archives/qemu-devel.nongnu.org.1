Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB804725951
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 11:04:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6p4z-0002NC-N5; Wed, 07 Jun 2023 05:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6p4x-0002MU-3K
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q6p4v-0008Ky-Ga
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 05:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686128621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=hogVfhhg00EJA/XGUN602uwS3PNVXGeY/2ZIORjD97s=;
 b=OW8PozD1Z6ZcTqztsrygSiL5RuERqBox/ePugVWPlPB6K+AcnJ09Iva20Bq8t9/41PLPVg
 Ae0t9F3axdVqi5I6pFAky/NAWtT1j0ut7MiCFV+EsddT1mFIMoXlcPph3pjYmnduF26czi
 i13ZYRuqTc1RjQU8T2pmCM92fJOEmM0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-JoBpO_22N0aOqX8vMu9nfQ-1; Wed, 07 Jun 2023 05:03:39 -0400
X-MC-Unique: JoBpO_22N0aOqX8vMu9nfQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-977cb78acfcso324385266b.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 02:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686128618; x=1688720618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hogVfhhg00EJA/XGUN602uwS3PNVXGeY/2ZIORjD97s=;
 b=R6hMc8uX3lPBhOkbjdI/wWWUmKGKfbGnuCHgfdcbzsBPNQ0qMIGa26BEhmShpdJDex
 oZ7/AyPNXdWCf7257wOJhGzk5Ha1A/79AR6vHodXiinMdWLgzrJBYxBD8qHsIgKOgY5q
 Z1yBTGGzueOK8Gfa2BJqxUqa84lR3ngl5xqM/HJYPczuRNjHt5yriqtZF0FMN/u3AlIx
 i+EpZ44427Vk6PMlpbfivcgoa6U7pPEFa7Hr8C2caqtdSL4Gy9TOGrFf30QfJyGbfnVF
 pLulvpwiLtgygQOk6ghSIBNlTspqGx1iuha2P/IdwC9WTMpKw8nFAD07HbSxN1SqhnrT
 zJxg==
X-Gm-Message-State: AC+VfDxrq3LDvMnXgUK8gGoRXjGHKC1Ltt9LY7wYg9UfzltFWslF6EX6
 YHwTQTKQGdudGpLc1ADcif2SbPmiFHr3JAachFvHXuq5zesaeo6JL6mBJ5H8BMRx0ig6FYxutRk
 gVOfklP83P3LlagrTvrV6TxiX938lgYl0yxnThM14AtYjvcUbpzqjOHo0jzM+T76CgSQUK++Mmz
 8=
X-Received: by 2002:a17:907:2d8c:b0:971:484:6392 with SMTP id
 gt12-20020a1709072d8c00b0097104846392mr5092630ejc.38.1686128618291; 
 Wed, 07 Jun 2023 02:03:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4MLVfDp3AXeUyYe1gqMH+zHAty91KQ1k3mbO+akkKOmZvwERjBQ8AfSxAwTuJ8U2VZFv7B3w==
X-Received: by 2002:a17:907:2d8c:b0:971:484:6392 with SMTP id
 gt12-20020a1709072d8c00b0097104846392mr5092614ejc.38.1686128617991; 
 Wed, 07 Jun 2023 02:03:37 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 w2-20020a1709062f8200b00977ecf6942bsm2828035eji.90.2023.06.07.02.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 02:03:37 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Subject: [PATCH] meson: fix "static build" entry in summary
Date: Wed,  7 Jun 2023 11:03:36 +0200
Message-Id: <20230607090336.59424-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
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

Fixes: a0cbd2e8496 ("meson: use prefer_static option", 2023-05-18)
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 553c8e0b9c5..34d0444ffbb 100644
--- a/meson.build
+++ b/meson.build
@@ -4088,7 +4088,7 @@ summary_info += {'QEMU_LDFLAGS':      ' '.join(qemu_ldflags)}
 summary_info += {'profiler':          get_option('profiler')}
 summary_info += {'link-time optimization (LTO)': get_option('b_lto')}
 summary_info += {'PIE':               get_option('b_pie')}
-summary_info += {'static build':      config_host.has_key('CONFIG_STATIC')}
+summary_info += {'static build':      get_optin('prefer_static')}
 summary_info += {'malloc trim support': has_malloc_trim}
 summary_info += {'membarrier':        have_membarrier}
 summary_info += {'debug graph lock':  get_option('debug_graph_lock')}
-- 
2.40.1


