Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABA7B7C0C
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:26:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qny89-0000FT-L5; Wed, 04 Oct 2023 05:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qny85-0000F8-IO
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:25:17 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qny82-0006Uj-P8
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 05:25:17 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4065dea9a33so18277255e9.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 02:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696411512; x=1697016312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L+fZeU2U0Qs+GrK7gveQ84IlRg4Um65ungRTYzja3w8=;
 b=u9sRP0h9yF48RVdnDnIZ/pQjVhrsdTdLYVX1LiRhAbL8lXdih/QFkIqMIBCVAhzkw8
 1aVZHlYlKyzs94GFx+QHcCAjbqNBuK/Wyfve0G+EOnihm7Sh9T9apuLgCwGBEMZ2306A
 MpsTnhzNkBPnKU6EkOcg90POCJfMf2JtN6Kh05BGKVfuriGfH3JO3Y/R8A+jvDMup0uv
 1Fef5fw+WkBzvJ8DOfgqV/yw3zHmv+WVVha0Gy6Gzoo51+jIGArL89SUQ//1sfGlIJ/7
 qcx3c/nTCTR8bvsQVTQ6EeR+GfxImjBw9PBcH8FThs7zwsUZbD3VKmtiks5z+QkUuFKJ
 qUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696411512; x=1697016312;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L+fZeU2U0Qs+GrK7gveQ84IlRg4Um65ungRTYzja3w8=;
 b=cbcyn2sgs4D7CNsB6FdSefL9/QOOTfWzXKslDcp34Wjqyjdaee0QIyGs9SqICZtDmI
 gvnoTP7MmKLnRox7l+ZQF99uDeZIKbVY4BaBaU87jdxhUW9PIKnaTr/a19u38PbJGoE3
 PZuGLPzRCjUvfoY9MipOoi3tpi99BSYiLmDR+RYZaWCj5fQBNwl3nfQBuaPBlYRa78UR
 ZUZR8kUR7GyR9MiREWygCls9xrbKtB4vFnIh3EsW0AOQbclrTyeC8zPOH9+WVy+ylqwl
 NMBHV/Z26XOQZprIO+fnh7BqS+WK9j8jxOaEbaxSxuFkbuMuBoCykbGa3bRQDPjR4rPm
 d/kQ==
X-Gm-Message-State: AOJu0YxFa4HilN1PXLeZ+X5Px/+Yl/awY7mCJtoWXmLLloYgYcZ+pv4B
 O71UWuvHb+W2KvdzQjWZn+F+9BemIBfWt7xVKOI=
X-Google-Smtp-Source: AGHT+IFMeSGSgb7fK3QJHu6yJi2ruGrBBtEKbx4LsNstjM/M40gj6uejZRa39w0oX00P264L2/RKsA==
X-Received: by 2002:a1c:4b0b:0:b0:405:2e28:4878 with SMTP id
 y11-20020a1c4b0b000000b004052e284878mr1669063wma.30.1696411512738; 
 Wed, 04 Oct 2023 02:25:12 -0700 (PDT)
Received: from m1x-phil.lan (5ep85-h01-176-173-163-52.dslam.bbox.fr.
 [176.173.163.52]) by smtp.gmail.com with ESMTPSA id
 c6-20020a5d4cc6000000b00325c7295450sm3553687wrt.3.2023.10.04.02.25.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Oct 2023 02:25:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] sysemu/accel: Simplify sysemu/hvf.h
Date: Wed,  4 Oct 2023 11:25:07 +0200
Message-ID: <20231004092510.39498-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Trivial cleanups which simplify "sysemu/hvf.h".

Since v1:
- Add missing header in hvf-cpu.c/x86_cpuid.c (Roman)
- Added Roman tags in patch 1

Philippe Mathieu-Daudé (2):
  target/i386/hvf: Remove unused includes in 'hvf-i386.h'
  sysemu/kvm: Restrict hvf_get_supported_cpuid() to x86 targets

 include/sysemu/hvf.h        | 3 ---
 target/i386/hvf/hvf-i386.h  | 6 +-----
 target/i386/cpu.c           | 1 +
 target/i386/hvf/hvf-cpu.c   | 1 +
 target/i386/hvf/x86_cpuid.c | 1 +
 5 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.41.0


