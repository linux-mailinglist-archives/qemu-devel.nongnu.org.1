Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 509B77058ED
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:35:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz1Mt-000663-Oi; Tue, 16 May 2023 16:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3suhjZAgKCj0rlnrsZeZfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--smostafa.bounces.google.com>)
 id 1pz1Mr-00065V-Ql
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:33:57 -0400
Received: from mail-wm1-x349.google.com ([2a00:1450:4864:20::349])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3suhjZAgKCj0rlnrsZeZfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--smostafa.bounces.google.com>)
 id 1pz1Mq-0006fm-9q
 for qemu-devel@nongnu.org; Tue, 16 May 2023 16:33:57 -0400
Received: by mail-wm1-x349.google.com with SMTP id
 5b1f17b1804b1-3f41ce0a69fso60415e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 13:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1684269234; x=1686861234;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=rBTwWhE6PBDQa6im+pyD3394JhJZUNBDisIOMyZZvSs=;
 b=yCepxvDstnpphWVHBeMBVvp65vlPPnhrE5KPaeq0WMpnzxqQBc7sr+IrRRebcUfrIe
 Rwo6UbAL+fw0k/4ei7r0PTNVuMfW5DilqQEroQZ+jFUxYRNklAtLq/KDwJIb3QGTAgrK
 n+eZKbytXxmBWRvKUk5kdjTVjv9Q52FQ+de1uHK1c8mTvC2r50L6Xi4JWLiy0evBsbwC
 HhIwDQdQkn5clFPxOSAxM15WJdszezd0zUr9+XnvjzNCPwuw19TpcpmvFzTeTZZKuiE6
 D7xKh5JnP+SV/B29FA+AhtBd6SSKMQxWcViaZLWWjXwM/Ah5JuB348EfR8vuRvAaV73j
 MJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684269234; x=1686861234;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rBTwWhE6PBDQa6im+pyD3394JhJZUNBDisIOMyZZvSs=;
 b=MFUJ0U6Fzfmn6VQjXRTXXpN/K46AGTRiJmhdnHDHvOG1Mi1e4qXr7RP7Mp1NLU+UsV
 k91m+DTQYpQ/cj788tjPCKyfnYTVLDwPJp6RGQ+XgaWKpofhjQcW5jTFVxGvfvaMyQI6
 TCI2hVpGeMf1hqmKfsM0VCgQNfLz8YVDs8Db+LCohLbjfXrBBrrubrE16yz5Gh5BB8ds
 THSJU64fqS6UGL2Db/uvrUsOfHvkbRmfgCPZq8y6QJhSVH3O20wJgKN6Z7M6doriNO0r
 lntf3TTQYHfzvYPnubxOZAbROlPU6cbBGAOFWjMAdnqLW0Cv5B7qaYhsWcIxouuuisrN
 hhHw==
X-Gm-Message-State: AC+VfDwQB7HKsLQE+QyF84vA+he+gpfEkk6UWFhLEvtnQJ234gUKvOqK
 VOc4Mm4hotLN4dtsjpOf2Z7Xh/UJ3AMTjf+dsWCSagwz/hbpmrcMWgDlRHvoHemHFKoJFwNV+WC
 US7W5OuogoqMj4HPNO4VDiZhJpBZnNNt442iHvsvf276jh6dHU8pgJipagW8gY1jHcw==
X-Google-Smtp-Source: ACHHUZ5Ukx2dh+KAy9E691R2/Cu7Cw+l5SqNCbVxhrU7aWa0AFCioLIdqzM5kkkorogj+Y12k25Y61Ooq57u5A==
X-Received: from mostafa.c.googlers.com
 ([fda3:e722:ac3:cc00:28:9cb1:c0a8:333c])
 (user=smostafa job=sendgmr) by 2002:a1c:7c10:0:b0:3f4:2610:5cb7 with SMTP id
 x16-20020a1c7c10000000b003f426105cb7mr5541663wmc.6.1684269234441; Tue, 16 May
 2023 13:33:54 -0700 (PDT)
Date: Tue, 16 May 2023 20:33:08 +0000
In-Reply-To: <20230516203327.2051088-1-smostafa@google.com>
Mime-Version: 1.0
References: <20230516203327.2051088-1-smostafa@google.com>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
Message-ID: <20230516203327.2051088-2-smostafa@google.com>
Subject: [PATCH v4 01/10] hw/arm/smmuv3: Add missing fields for IDR0
From: Mostafa Saleh <smostafa@google.com>
To: qemu-devel@nongnu.org
Cc: jean-philippe@linaro.org, eric.auger@redhat.com, peter.maydell@linaro.org, 
 qemu-arm@nongnu.org, richard.henderson@linaro.org, 
 Mostafa Saleh <smostafa@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::349;
 envelope-from=3suhjZAgKCj0rlnrsZeZfnnfkd.bnlpdlt-cdudkmnmfmt.nqf@flex--smostafa.bounces.google.com;
 helo=mail-wm1-x349.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

In preparation for adding stage-2 support.
Add IDR0 fields related to stage-2.

VMID16: 16-bit VMID supported.
S2P: Stage-2 translation supported.

They are described in 6.3.1 SMMU_IDR0.

No functional change intended.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Mostafa Saleh <smostafa@google.com>

---
Changes in V2:
- Collected Reviewed-by tags.
---
 hw/arm/smmuv3-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index e8f0ebf25e..183d5ac8dc 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -34,10 +34,12 @@ typedef enum SMMUTranslationStatus {
 /* MMIO Registers */
 
 REG32(IDR0,                0x0)
+    FIELD(IDR0, S2P,         0 , 1)
     FIELD(IDR0, S1P,         1 , 1)
     FIELD(IDR0, TTF,         2 , 2)
     FIELD(IDR0, COHACC,      4 , 1)
     FIELD(IDR0, ASID16,      12, 1)
+    FIELD(IDR0, VMID16,      18, 1)
     FIELD(IDR0, TTENDIAN,    21, 2)
     FIELD(IDR0, STALL_MODEL, 24, 2)
     FIELD(IDR0, TERM_MODEL,  26, 1)
-- 
2.40.1.606.ga4b1b128d6-goog


