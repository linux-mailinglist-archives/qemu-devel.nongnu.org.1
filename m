Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E28897D3EF4
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:18:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzRH-0005qs-CR; Mon, 23 Oct 2023 14:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRC-0005iy-Pg
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:03 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1quzRB-0008I5-5M
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:14:02 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5842a94feb2so1970730eaf.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698084839; x=1698689639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zU+v3676qRcEsyxppjdiDrJD+V8v/rvklw88kLBv4us=;
 b=thEWhLrvBKwu7FLa/CVVfGnBCoYRTjw9MkS4oe4mtnQl5XA06TilmiEeghPFaCoDSf
 0eVnNI0rUjWEOnBNPD5j3lF5ICNBLoNFkA+vFd5jm74PPdTWXU/EgF17rR/TIhlrUwje
 vNY8WjJ9CYEjFZ6yvouNrHYjTWgc+l3VsUk5r2tuQId5l6Q/6dQjd+xd7c3bglZf9/pv
 zmMb50p4jVZjmeZbBa2rRuUkB5Ib64QRF8fi6ZXMqsa4WWjZ+c4Kz9y99f6UjZx0DI+P
 CuetvCRXeV+7BoK+wcXaSC3+w68iYdhQqn6a8y4hImyX+1H0YGVLqp6oXvsJLU1LgF6C
 mNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698084839; x=1698689639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zU+v3676qRcEsyxppjdiDrJD+V8v/rvklw88kLBv4us=;
 b=WGmsr48Q/plRlwi8hZkKkDjJU5xF351Wu/tNjoIeGyWKWppZ2r6MLombJDxVa25ZCY
 vQANa2lJULdNMuQqxbaoUTM8FoJHtBRotIWYNALQU/T7tfUbFwiz0ubz/8B7VSEYu3BM
 qMZ6c5YgcJYX797bLrF4RcN2H9w1r5O/V7e1Ag9Dg3MMK3Hg+WB/zpEyVovrjuwYJr2F
 iDHDbNq/aJrOJJ5Q323CKH7W+Y5Ii1/l1O1CIYT5gEywWcq/7XUchoaH54IDzJeC1kbR
 rQe+Wl+YsNo/GT3Iss5HXEcGFVJRsMljl8kshQk+Vs3c1QtsMxWVW01XVsQnyuOTELSs
 RgPQ==
X-Gm-Message-State: AOJu0YzpbCV5oPLjiKXSEotUcmgW58t3a5wqtw2lV8C3TZJui9B9YhtE
 vCtkGDP3DTejM9+khxbmFgGjyb4dVJy+DBPkJ38=
X-Google-Smtp-Source: AGHT+IF1s+aCrA6vfLq4ExczpSAKIRKjvN5q6Iq9OcPFS8uZoFvXXtLqY0L05vpX0FqyIPo+bbxlXw==
X-Received: by 2002:a05:6358:1a9e:b0:168:e3e1:11d5 with SMTP id
 gm30-20020a0563581a9e00b00168e3e111d5mr2539604rwb.28.1698084839703; 
 Mon, 23 Oct 2023 11:13:59 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 v10-20020a65568a000000b005b83bc255fbsm5205137pgs.71.2023.10.23.11.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 11:13:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 32/38] tcg: Define MO_TL
Date: Mon, 23 Oct 2023 11:13:23 -0700
Message-Id: <20231023181329.171490-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023181329.171490-1-richard.henderson@linaro.org>
References: <20231023181329.171490-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

This will also come in handy later for "less than" comparisons.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <03ba02fd-fade-4409-be16-2f81a5690b4c@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/target_long.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/target_long.h b/include/exec/target_long.h
index 93c9472971..3cd8e26a23 100644
--- a/include/exec/target_long.h
+++ b/include/exec/target_long.h
@@ -29,12 +29,14 @@ typedef uint32_t target_ulong;
 #define TARGET_FMT_lx "%08x"
 #define TARGET_FMT_ld "%d"
 #define TARGET_FMT_lu "%u"
+#define MO_TL MO_32
 #elif TARGET_LONG_SIZE == 8
 typedef int64_t target_long;
 typedef uint64_t target_ulong;
 #define TARGET_FMT_lx "%016" PRIx64
 #define TARGET_FMT_ld "%" PRId64
 #define TARGET_FMT_lu "%" PRIu64
+#define MO_TL MO_64
 #else
 #error TARGET_LONG_SIZE undefined
 #endif
-- 
2.34.1


