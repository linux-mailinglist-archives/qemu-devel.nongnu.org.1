Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 039F070A917
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 18:28:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0PQH-0003kL-Rm; Sat, 20 May 2023 12:27:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ9-0003fO-64
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q0PQ3-00039B-1v
 for qemu-devel@nongnu.org; Sat, 20 May 2023 12:27:03 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ae851f2a7dso11661935ad.0
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 09:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684600016; x=1687192016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AHAmgIp57eQq/xk6K8cmnraRLR5HX4TvEutgtaIW/48=;
 b=gVu4BAXH5NbAJI0BPJ2q1YYcSDfuVbxJV8Jtpze6pFN5Ow8tbjCDYwsd2Hnre/CYWS
 x0Nq25pzGKhpqA9bacvZy6inhNLlfysgpqUDWKgBQpYn9IRIb8soCNynNGTkC+2uU/Cj
 uH6JFJg2SfTGpcFQDbcJukVweHHZDiU2/PunLTbIvp18RB+i+whcWyA2+W776LmSMDsE
 woqwHEGtaulH8/orhywc189NWc1dG5YwChzo9TL8Zy0ZIYI0UcIpQi3Z26KgVyaWKReZ
 yGCVdEKH/b3T49/aMM/NDkmsLfUzD7AHrEGNx39ue+/84KctH16mbh+qKG69oJM2sLvD
 DZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684600016; x=1687192016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AHAmgIp57eQq/xk6K8cmnraRLR5HX4TvEutgtaIW/48=;
 b=aokROlIISklo7EEWDhe+3MXcsN8FgvW+Vgqt//8Sfa1aMXHfd6k/o2jKrtGqYW8WzR
 Ca64DhWBqwTKiyV27udMN7sJu0Hxa/0lxVgUhfJB+eLDZefMUhHxwx16OWJ5QiJ9l8uv
 VR+1gaM2ouF98hiGmIiP63FxebK204xjCS+ETbLZ8LKYRi3AkB6Zw905t6Gzk1EqLic9
 L4t/WPuToyIopdD/BZdnmQSNudmfM+cULb2wxYvSAyUVo/C0xFC9IoUd67zV3akloaW5
 w6YAE5WXT/Dbiyrp1OLqqTdvdkJ2wA3f9cjo6pMGovmHSplZNxHQcBty/5MYV/vE/ji0
 67CQ==
X-Gm-Message-State: AC+VfDxT3R4DRMnv5PcKT79mcsu29fnkTam3pU888sKcj7IpFk4tp1ZJ
 r75ixIVXesZQRjgcMQwWKHEzVjtGTkxcdHQllDI=
X-Google-Smtp-Source: ACHHUZ6hdvvLmHaOP+THgifHMGSA4GtZDo0e5lX8T9I4QYRCIFgi+8xNyWPO/hWc+Thee4wZ76gFIA==
X-Received: by 2002:a17:902:ce81:b0:1ac:61ad:d6f2 with SMTP id
 f1-20020a170902ce8100b001ac61add6f2mr6773788plg.5.1684600016500; 
 Sat, 20 May 2023 09:26:56 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:d078:d94e:cb2b:a055])
 by smtp.gmail.com with ESMTPSA id
 d12-20020a170903230c00b001a5260a6e6csm1697104plh.206.2023.05.20.09.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 May 2023 09:26:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 12/27] meson: Fix detect atomic128 support with optimization
Date: Sat, 20 May 2023 09:26:19 -0700
Message-Id: <20230520162634.3991009-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230520162634.3991009-1-richard.henderson@linaro.org>
References: <20230520162634.3991009-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Silly typo: sizeof(16) != 16.

Fixes: e61f1efeb730 ("meson: Detect atomic128 support with optimization")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index 4ffc0d3e59..5e7fc6345f 100644
--- a/meson.build
+++ b/meson.build
@@ -2555,7 +2555,7 @@ if has_int128
   # __alignof(unsigned __int128) for the host.
   atomic_test_128 = '''
     int main(int ac, char **av) {
-      unsigned __int128 *p = __builtin_assume_aligned(av[ac - 1], sizeof(16));
+      unsigned __int128 *p = __builtin_assume_aligned(av[ac - 1], 16);
       p[1] = __atomic_load_n(&p[0], __ATOMIC_RELAXED);
       __atomic_store_n(&p[2], p[3], __ATOMIC_RELAXED);
       __atomic_compare_exchange_n(&p[4], &p[5], p[6], 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
-- 
2.34.1


