Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D24577C93FE
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:02:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbSy-0002XB-1w; Sat, 14 Oct 2023 06:01:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSv-0002WV-Or
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSu-00040G-9J
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PbL9eV8FETwkZ+RBb2kdxilAqE6oNEiIH3KHJJ7nEys=;
 b=Ehgln7Mcu5pe2803LMOxTlpkfXQYuGiKii6YSO4eG8Ej5uxhtoiGWNffZZFzxGeclF1yzA
 Nt1kEg/RKrgExOgoaK9MJLnZdH5GE7WcvBQHoNT9qMw278It359MroaXmnxTrmum7j3WYb
 4wGgcMBxvPnjH4ZoaA3M3RftSaGB0q4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-aqt-5n_6MnuJLKt7bZj5Pw-1; Sat, 14 Oct 2023 06:01:45 -0400
X-MC-Unique: aqt-5n_6MnuJLKt7bZj5Pw-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-53e1fe5b328so1858423a12.1
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277704; x=1697882504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbL9eV8FETwkZ+RBb2kdxilAqE6oNEiIH3KHJJ7nEys=;
 b=UHZtTROOT4oeQI9Tr+HWBRPhaVZPu8Qj9lY6ec0fICS/mPZ4OfXsYalrbvFQa0aeYJ
 zC9f3MB2TLDkgR3rYFabJsvvmhuIel3VNX7g+e8NeMbb13dtIhPHaqXRkqYoKn0kbIsu
 DjWnMVp5mwjTnAMjonYtjj5wz+xALniemf1ivodkDx8PwqtHY6+1EUUoRpRwT1l3GfQ4
 I3ez3Ftf3uD4qoTPW2ZXYrjNuQLmoGLv+79nfu4B4rOwUy5xoPK04lSC6ZKBHoXJdUb9
 b93D27QPgdd7d7FCFqB/TyUc7OKT/X5+Q0Fy7W4BSR7epvRH+XwgDD4Rv36+/pzPqlUu
 I3Og==
X-Gm-Message-State: AOJu0Yy663XtJCJbyhGWWdQfCwJr0UBONEUWwETGCLp/YDuvThwYStr3
 TnspZQ0MjoXr7jzYRkQkIv8FCxNqBZTIqPkhpGYM72H5WuIH8d9L3660xP50ia+OjT54gZareyT
 /2SFZh4xiCjzTUwfHohVslN5Kf34TzPtyNxzzuvW/zAnC4PEYQYxtc2Ax04n38otgKS9ArmK9DP
 g=
X-Received: by 2002:a05:6402:1e89:b0:53e:12dd:b9d0 with SMTP id
 f9-20020a0564021e8900b0053e12ddb9d0mr8349178edf.36.1697277704370; 
 Sat, 14 Oct 2023 03:01:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGku33bpa2PDWmquakdriKK8iL15GNBPNy9XtrnNLqnwRX3yZBf+C2u6fkBP6Y0oVcDI3y2YA==
X-Received: by 2002:a05:6402:1e89:b0:53e:12dd:b9d0 with SMTP id
 f9-20020a0564021e8900b0053e12ddb9d0mr8349164edf.36.1697277704062; 
 Sat, 14 Oct 2023 03:01:44 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 u5-20020aa7d545000000b00534e791296bsm12556591edr.37.2023.10.14.03.01.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/18] target/i386: adjust decoding of J operand
Date: Sat, 14 Oct 2023 12:01:14 +0200
Message-ID: <20231014100121.109817-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231014100121.109817-1-pbonzini@redhat.com>
References: <20231014100121.109817-1-pbonzini@redhat.com>
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

gen_jcc() has been changed to accept a relative offset since the
new decoder was written.  Adjust the J operand, which is meant
to be used with jump instructions such as gen_jcc(), to not
include the program counter and to not truncate the result, as
both operations are now performed by common code.

The result is that J is now the same as the I operand.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 91f79c09b73..37ed669bde0 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1448,19 +1448,9 @@ static bool decode_op(DisasContext *s, CPUX86State *env, X86DecodedInsn *decode,
         }
 
     case X86_TYPE_I:  /* Immediate */
-        op->unit = X86_OP_IMM;
-        decode->immediate = insn_get_signed(env, s, op->ot);
-        break;
-
     case X86_TYPE_J:  /* Relative offset for a jump */
         op->unit = X86_OP_IMM;
         decode->immediate = insn_get_signed(env, s, op->ot);
-        decode->immediate += s->pc - s->cs_base;
-        if (s->dflag == MO_16) {
-            decode->immediate &= 0xffff;
-        } else if (!CODE64(s)) {
-            decode->immediate &= 0xffffffffu;
-        }
         break;
 
     case X86_TYPE_L:  /* The upper 4 bits of the immediate select a 128-bit register */
-- 
2.41.0


