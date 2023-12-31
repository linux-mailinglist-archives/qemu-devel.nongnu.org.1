Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 32165820A99
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:53:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrRr-0004B4-8O; Sun, 31 Dec 2023 03:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRo-0004Ac-PK
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRm-0000ge-9a
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kYA4HfjADI4Xy8ZdhxyqI1foFbYl+t0+8orNZuloaxs=;
 b=TNFl2/dLBYzBrgiAKVjUiMGqkMKdX386N5aMvhwsKEGrpfXdmUVpcjqy68sxUboUcXIqin
 V3qdupDkZVT6QBnEKjBjLYmoK6aQxMrMsOmqPBs8CXDejC7CZK4EdUymqMFYN8WmHcb7D7
 rHVHDW7HGOe1mw1SHqL++FBQZEYLfhw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-z58buiiaMPOOQ9-WPNqGow-1; Sun, 31 Dec 2023 03:45:15 -0500
X-MC-Unique: z58buiiaMPOOQ9-WPNqGow-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a27eddc968fso2697666b.3
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012314; x=1704617114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kYA4HfjADI4Xy8ZdhxyqI1foFbYl+t0+8orNZuloaxs=;
 b=htxf7eYBUPoGJA1icSdk3NdjNDQUWmq4+qYQvCTs6J5UG3NxJBgs1zXRzs0+UCLKuy
 WoUAqEqZNH910M6QjEzwurAj1a44CHHnijD6LtD2s5Mg1uvOCQMRzMx9X2ZmekVHW9lk
 P6mV6kAjEgaucEpW6sloO9cHsmEL+OorJDHO6WbZgpwqug76g08KUGH0DsDi/+3sC6LO
 T+rYwnOSqHuqxmk+Cvk4Q2IAT4bEZGXrytaW8kUC6Yu1nPkNyyWTsIhUn9ckzFJ8pe6U
 7e0H7Tf5ALdiUViJayby3IwZuKkjOJ3zAn+Ii6qEmy3PHw198cRVTnw/8Pe8xU6v6IKQ
 uV3w==
X-Gm-Message-State: AOJu0YyMzx74qeZmRbu0hG4SeO7/xxFALY4eauGt3MDPyK2iaDH4Wp/c
 OL6jhKYlTTt/kMn1GN6LFh8n7eVhIKcn1te5teTDFA7t+lwCyEdeh7nXM8A3Imlpac2WDce6w58
 bYYXiYcwsyktqqDo0VerElJblY0FDkIR+UAe56duwkBTjJqh3UHxNm9Rvb09E7rlTTFUGsXzn4c
 PKNfd+R1M=
X-Received: by 2002:a50:c25a:0:b0:555:3143:f9dd with SMTP id
 t26-20020a50c25a000000b005553143f9ddmr4050830edf.19.1704012314026; 
 Sun, 31 Dec 2023 00:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkQemkmRuEgPAAfLgHvuMaoUPgBKzv+3CCO+Fz/rFfKJVLiWGLKFQRoeRK6qRuNUnQTPZsqA==
X-Received: by 2002:a50:c25a:0:b0:555:3143:f9dd with SMTP id
 t26-20020a50c25a000000b005553143f9ddmr4050823edf.19.1704012313801; 
 Sun, 31 Dec 2023 00:45:13 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 g6-20020a056402114600b005561ad0368fsm1004538edw.12.2023.12.31.00.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/46] target/i386: speedup JO/SETO after MUL or IMUL
Date: Sun, 31 Dec 2023 09:44:19 +0100
Message-ID: <20231231084502.235366-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
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

OF is equal to the carry flag, so use the same CCPrepare.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index 8fb80011a22..a16eb8d4008 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -1020,6 +1020,9 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_CLR:
     case CC_OP_POPCNT:
         return (CCPrepare) { .cond = TCG_COND_NEVER, .mask = -1 };
+    case CC_OP_MULB ... CC_OP_MULQ:
+        return (CCPrepare) { .cond = TCG_COND_NE,
+                             .reg = cpu_cc_src, .mask = -1 };
     default:
         gen_compute_eflags(s);
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src,
-- 
2.43.0


