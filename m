Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D58C5785407
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 11:30:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYkBA-00057D-RP; Wed, 23 Aug 2023 05:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkB8-00051i-Jj
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:29:30 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qYkB6-0006YN-VJ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 05:29:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-686be3cbea0so4311565b3a.0
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 02:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1692782967; x=1693387767; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x77jGpzmruuxQnEwz6iNzx3FW0qgVmvAGg6kd+BPzF4=;
 b=IEJ28iv6HLXWcFjoz68X8qkZlJaJDSZUN1tfAhFvkB4fTJRb+t/viM3XUMqmS/Zz28
 dp8ZknP1dCcDoPcOhWjfP4V71o3EELS2xmDDDPNsKOYeUG4v21NLJoe9czixZWPoUel7
 BPcGBzhePaF30SvN0/TvIb4VukP9/0a8lDODbVQc8bF1wvjEput+ZwaW50xShdUvYw+j
 UHrIH+M8+PlifjxEujYiq8sYPGNoUpQHshIe6qqi0PcOyTEuGHNzgvR5AZXsPZWUrs8i
 IEjN/XgxJ1gucMUut0Hb0KKI+HZQGhSyyrz93x883/BSLo2a/SgfYy2w/sk22Hir6dgL
 MANw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692782967; x=1693387767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x77jGpzmruuxQnEwz6iNzx3FW0qgVmvAGg6kd+BPzF4=;
 b=LguT3pjgckoNTBVEIQ1LROvDkDXkkaZStVpxfD9GoT4GQeBrhVVoTDrO3lK7vEver/
 XIkAun6oKnUxzlwdKS8mHB0rCmprZB3fi32qHMGXPyDKOzV36s09hRvcfh46xmHi5sfC
 9XAUAozSTtqA1f0r8p83voSV1rGHA2yPJPMsYjHLrWo0nI0zXKGgj1nja7CVcOzbRgql
 d4ohPyumZOZlu8eKa4WVKLlEu+3cg4PUZgFiEIT+ez5i441VQzXb6W7MZGJy66e6SI0/
 5jKgNoS68qBWcnXQjunUhpiGlyZEk+qzIFVZSQAJ7152aS2yB4O6kxpCrPhGNyTvU4jx
 q77Q==
X-Gm-Message-State: AOJu0YyJZmXwZv4JaexSVMmDUklDa8/92Xvcbm5ZoUiyTWJsIp3HV7gk
 272WeR06+tKpnEUftDWg4HM18k6BzML/GeoUO8I=
X-Google-Smtp-Source: AGHT+IGKv5b/4f3tOOw0ifRz23Pg8RlDVD/Rz9ktZk/9HWNknRbN4I/GaCmvAmAxJemSWmZ8VMhHyA==
X-Received: by 2002:a05:6a20:9148:b0:133:38cb:2b93 with SMTP id
 x8-20020a056a20914800b0013338cb2b93mr18108978pzc.9.1692782967371; 
 Wed, 23 Aug 2023 02:29:27 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm1169462pfd.163.2023.08.23.02.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 02:29:27 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, stefanha@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v2 2/4] Update subprojects/libvfio-user
Date: Wed, 23 Aug 2023 02:29:03 -0700
Message-Id: <20230823092905.2259418-3-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823092905.2259418-1-mnissler@rivosinc.com>
References: <20230823092905.2259418-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Brings in assorted bug fixes. In particular, "Fix address calculation
for message-based DMA" corrects a bug in DMA address calculation which
is necessary to get DMA across VFIO-user messages working.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 subprojects/libvfio-user.wrap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/subprojects/libvfio-user.wrap b/subprojects/libvfio-user.wrap
index 416955ca45..47aad1ae18 100644
--- a/subprojects/libvfio-user.wrap
+++ b/subprojects/libvfio-user.wrap
@@ -1,4 +1,4 @@
 [wrap-git]
 url = https://gitlab.com/qemu-project/libvfio-user.git
-revision = 0b28d205572c80b568a1003db2c8f37ca333e4d7
+revision = cfb7d908dca025bdea6709801c5790863e902ef8
 depth = 1
-- 
2.34.1


