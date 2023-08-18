Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA3F781154
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 19:13:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX329-0008OT-Ii; Fri, 18 Aug 2023 13:13:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31z-0008JY-W0
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:05 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX31x-00086d-OI
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 13:13:03 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1bf3a2f44f0so6379325ad.2
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 10:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692378780; x=1692983580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rdwt79BwZaWBN00DwtMN42IvreCD09Jb8OcGXDyYgYc=;
 b=bw0Pj8oEUVgthlGpaMA+PZHB+Of/T13bg0doLYlK9tFSelKS93ZAG1duFsXvhpcehl
 fEc9oMraE8E8G+fTTsKsRdT4pL5dqVFoQI8+Uf97xTzbCdHiwUqMRVrbnFcHdckGBnbu
 5TFXKdAenjxrA/v0eGBYC2JzC1m4uamqAWu+EFYmfpnbKzuwM+jhrIlTlaLKBBGGdHxx
 wBKBpyNTDJ8tuglfoUSlY8Ob3m7UhYCOKGmvhHiV+lKFWlaDcT0l2pCV53xlH/7Sv93N
 qme/Z2m7unimtvc2jaWR3O91n8eZqv1Ca8FTji/H5/YM3XXFOZ1rezaxguZO8Y/D1oh9
 h2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692378780; x=1692983580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdwt79BwZaWBN00DwtMN42IvreCD09Jb8OcGXDyYgYc=;
 b=mCny+Ny3ilRmlyy70kAUDl1i1XwrzEqraE9AXLa60U3XEfgOEF9FDJbCipnBOpE2lF
 QxuEAoCmIOoVSNIazQ5s5BxmwTBwmRdC+swkh3bPujyHV7depqjkly7v72sD6fqp1UQg
 jPiZHpl8kbb42A3UHJ+R+4iwxT+dDTvKRuUGB28Xv/a+e1epm7/6LGeMipOJjlR7YZZV
 jdJ7hvXPOu2gkHo+kJAUpR5ha5PaqbtIrrIuWuxj2SZzlUwxjoYTEsmiQkKZY77TU5DU
 /lpEd0mH4KuFf1WUgJtQqtFBdp3rd33pcLdjvZ8FhDKrlmvl+YYLdmdshiiX1W0y9+M2
 85NA==
X-Gm-Message-State: AOJu0YzGnhXNFxlXrnr7I7ggbFYrhlgV+0U9+S82x4yzBcl8a9aMWfWJ
 C6sVvEx0hkU5XT7mvBRXMZMIGCWnlY2UV2jS8EM=
X-Google-Smtp-Source: AGHT+IHUXHw+xf/bp6e74j+aEvfmuDZNLD1T56MAGM2XuwKdOaLzKidWEme9JSfHESAKvgmbbNT1GA==
X-Received: by 2002:a17:902:db03:b0:1b2:4852:9a5f with SMTP id
 m3-20020a170902db0300b001b248529a5fmr3548246plx.54.1692378779880; 
 Fri, 18 Aug 2023 10:12:59 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 jw24-20020a170903279800b001adf6b21c77sm2020025plb.107.2023.08.18.10.12.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 10:12:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 25/33] tests/tcg: Extend file in linux-madvise.c
Date: Fri, 18 Aug 2023 10:12:19 -0700
Message-Id: <20230818171227.141728-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818171227.141728-1-richard.henderson@linaro.org>
References: <20230818171227.141728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

When guest page size > host page size, this test can fail
due to the SIGBUS protection hack.  Avoid this by making
sure that the file size is at least one guest page.

Visible with alpha guest on x86_64 host.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/tcg/multiarch/linux/linux-madvise.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/multiarch/linux/linux-madvise.c b/tests/tcg/multiarch/linux/linux-madvise.c
index 29d0997e68..539fb3b772 100644
--- a/tests/tcg/multiarch/linux/linux-madvise.c
+++ b/tests/tcg/multiarch/linux/linux-madvise.c
@@ -42,6 +42,8 @@ static void test_file(void)
     assert(ret == 0);
     written = write(fd, &c, sizeof(c));
     assert(written == sizeof(c));
+    ret = ftruncate(fd, pagesize);
+    assert(ret == 0);
     page = mmap(NULL, pagesize, PROT_READ, MAP_PRIVATE, fd, 0);
     assert(page != MAP_FAILED);
 
-- 
2.34.1


