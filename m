Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C08B75BD9B
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 07:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMiIO-0004QQ-3p; Fri, 21 Jul 2023 01:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMiIL-0004Q2-Ei; Fri, 21 Jul 2023 01:03:13 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qMiIJ-0004Zi-Qc; Fri, 21 Jul 2023 01:03:13 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b9defb36a2so1337889a34.2; 
 Thu, 20 Jul 2023 22:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689915789; x=1690520589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m88Ud2SWfoPJ+ErRtTlX28NI+F1Zz+F1v4cW9zWWclk=;
 b=YTQRytE7J767o3FLbnnZdDWEbBcLB+Hmryw2um1K7AaWW/R4fYZIufxtvdRR3aRUAP
 kqaMlLGxdkEY75zSYjRCkYS3p3+FQJarEPS26iNcY2xGw4/cVuwS60jjXNjzxAM/XXLa
 G5csswo706CKU1T4FsrU6A0dC3WfrpPOI0XVTyRwqgFm9FUs3csX4+HLHzGZ85Cs85aZ
 DDre2xUvmgmT6rDRlnG6T4+W4BCfy8W89j/ALpQiWgdsl3RzfLjSjDhMYWNTxa2ujIQN
 4Z1sRoNgbFwVoQUpmZUK14cJSIBkvjroermpBdZlB4woI7LunsD7hJne79DyzLkEUSuG
 yvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689915789; x=1690520589;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m88Ud2SWfoPJ+ErRtTlX28NI+F1Zz+F1v4cW9zWWclk=;
 b=Tsg4jQc5J4K+xd436t0eozTHmLAZDPP+n8qNJgULOSHIwx+DDS//6QAV8vt+BZeCPb
 8IXrtfPWCz2+HM58Prm6VGJTWLc5UuHhzK4T7yNCQYS99ZvOOdNAlEG7aWYxK2yDQN+x
 caV+Wnyjn8gm0lw3/0HQTAXJz2S4uxSkbQRz5i62xgeyms/mD81CCrup3MFCggjozQKF
 SfHVvXMAFC4nQE/YrqQJY9amuBoOr+uTNkG+/ZPohF3E2hFlbKFli3eS2zAhQFDfqCJ8
 KZh4CvHZylhJ4bhSFnZhehqyEq2zFi6srp5tcJwnct3alnCD6nCUom3p4xO87xkaPTvE
 Tivw==
X-Gm-Message-State: ABy/qLacTcCc92cKW3oRlxcZn084v+yQ4iYVnLbKXSVGvwIBSSAxATuh
 T/yswdN7aFcE+HufWNw0yoE=
X-Google-Smtp-Source: APBJJlGLWOFV+eLpZysA118PRQVUyY0O96QK43f9s0D4mPGODBjtXmOZBpXqfMQPU8TH+6G3q88+fw==
X-Received: by 2002:a05:6358:930a:b0:132:962d:b5c5 with SMTP id
 x10-20020a056358930a00b00132962db5c5mr968817rwa.30.1689915789333; 
 Thu, 20 Jul 2023 22:03:09 -0700 (PDT)
Received: from wheely.local0.net ([203.220.77.10])
 by smtp.gmail.com with ESMTPSA id
 z13-20020a63330d000000b0056001f43726sm2129444pgz.92.2023.07.20.22.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jul 2023 22:03:09 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: [PATCH 0/2] target/ppc: Fixes for hash MMU for ISA v3.0
Date: Fri, 21 Jul 2023 15:02:53 +1000
Message-Id: <20230721050255.100090-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This fixes a couple of deficiencies in the v3.0 and later (POWER9, 10)
HPT MMU implementation. With these fixes, KVM is unable to boot hash
guests on powernv9/10 machines. Bare metal hash or pseries machine with
hash works, because VRMA is only used when a real hypervisor is
virtualizing a hash guest's real mode addressing.

Thanks,
Nick

Nicholas Piggin (2):
  target/ppc: Implement ASDR register for ISA v3.0 for HPT
  target/ppc: Fix VRMA page size for ISA v3.0

 target/ppc/mmu-hash64.c | 68 ++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 17 deletions(-)

-- 
2.40.1


