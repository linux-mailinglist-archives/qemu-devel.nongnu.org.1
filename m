Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CD181CE5B
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:18:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4m-000133-RP; Fri, 22 Dec 2023 13:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4S-0000yg-IS
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4N-0006BG-BN
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0yUBkQzFh3a9KRMh1nbXJFawjLsTwGveKP1L+EzZKCI=;
 b=T9ppWGyCHy8D9zersa+cQH03dpr7jVko9D2WPbFviYDynB9ASUuYZQlPa/e6Nzowvw6+uW
 AJKmNnbnuCxhD/y+aZb4F9lMpm9RD7eKJ2yYINExzI7XNW4cDXt5igKlXW9blQ1ImMXOlx
 +no0uNGTO/KjZ3QDaiWygimXVByO7dU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-m8e55krCNqq8iBWRnPGpww-1; Fri, 22 Dec 2023 13:16:19 -0500
X-MC-Unique: m8e55krCNqq8iBWRnPGpww-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33697ddbf63so415776f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268978; x=1703873778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0yUBkQzFh3a9KRMh1nbXJFawjLsTwGveKP1L+EzZKCI=;
 b=u94hzl2KxYNW0jpA6NedH8f+pi9Sk2OoKYBnyXuNHvgzjwIy2Venhu5/AdenxDLxK1
 C+0SifaUvsrGa86gopxUer2eM8Y+mt2rJzzbpIUKUf+eMXr0iaiAYh9dN5oAPBXWXtdL
 wuPkg0j6OYSVWJxgY/QC4koBk5pNz87k71YaPlrAaw66aynLAaEhfvPbqKj8eS2P9Qob
 EJenoPFPptlOY4J8FmZC3Xqashc0cOCx3bNG1n7GbcNavnLTi2Ds4JbVw81iJUWbUru5
 1xWm/NPf/F4mwn3O5/ij3us7JJGtmu/XHNfLEMAzNGDM4E06HIJ3fToLWnxMJIJdJfQ4
 sOjQ==
X-Gm-Message-State: AOJu0YwhQHPlyULNfDJU4c2Szw27TDnhVMCywEQKRrgf0csoNzr6pgp6
 pEWpepsaPCGWy418JkwmNhgnzagGhQAcGneaK5AjrpRdTcnEOegLgd7/VLFfVhrMVwOSvShpmLi
 jbo2RMrPpwA6sCc3kJ2RYEQzgUQAJoafIa+nyhupnzCwmZU4INkpMz/71nr/Uo8hFnwAejvNYBY
 xkrXChRGM=
X-Received: by 2002:adf:ee43:0:b0:333:39d4:ff80 with SMTP id
 w3-20020adfee43000000b0033339d4ff80mr1052609wro.90.1703268978373; 
 Fri, 22 Dec 2023 10:16:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/TzdZuXgI7Nk4e/HKdVap9gcHelBTKgHM38fbNn1VidDO4So+Jix6sBiTLVpRb1aPKcCvAA==
X-Received: by 2002:adf:ee43:0:b0:333:39d4:ff80 with SMTP id
 w3-20020adfee43000000b0033339d4ff80mr1052600wro.90.1703268977925; 
 Fri, 22 Dec 2023 10:16:17 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 z16-20020adfec90000000b003366fb71297sm4816870wrn.81.2023.12.22.10.16.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/22] target/i386: document more deviations from the manual
Date: Fri, 22 Dec 2023 19:15:47 +0100
Message-ID: <20231222181603.174137-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231222181603.174137-1-pbonzini@redhat.com>
References: <20231222181603.174137-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 2bdbb1bba0f..232c6a45c96 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -26,6 +26,13 @@
  * size (X86_SIZE_*) codes used in the manual.  There are a few differences
  * though.
  *
+ * Operand sizes
+ * -------------
+ *
+ * The manual lists d64 ("cannot encode 32-bit size in 64-bit mode") and f64
+ * ("cannot encode 16-bit or 32-bit size in 64-bit mode") as modifiers of the
+ * "v" or "z" sizes.  The decoder simply makes them separate operand sizes.
+ *
  * Vector operands
  * ---------------
  *
@@ -44,6 +51,11 @@
  * if the difference is expressed via prefixes.  Individual instructions
  * are separated by prefix in the generator functions.
  *
+ * There is a custom size "xh" used to address half of a SSE/AVX operand.
+ * This points to a 64-bit operand for SSE operations, 128-bit operand
+ * for 256-bit AVX operands, etc.  It is used for conversion operations
+ * such as VCVTPH2PS or VCVTSS2SD.
+ *
  * There are a couple cases in which instructions (e.g. MOVD) write the
  * whole XMM or MM register but are established incorrectly in the manual
  * as "d" or "q".  These have to be fixed for the decoder to work correctly.
-- 
2.43.0


