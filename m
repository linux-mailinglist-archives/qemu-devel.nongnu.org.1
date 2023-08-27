Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6484B78B925
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 22:11:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaiZP-0000ze-3O; Mon, 28 Aug 2023 16:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZN-0000xC-B3
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:41 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qaiZL-0007kZ-0U
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 16:10:41 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-500a398cda5so5842387e87.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693253437; x=1693858237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=51bkr9hASitHvEDp68cWD5IuyPCVoWzgBGQbztfhBlw=;
 b=LiPQUUzfEg6GX/mLWlS+VlP45tV0M2nWQn2R2WsalfZauStJ6XgikqbpcZ2erXS/PF
 UnajJ144Fi6Vh0hXm0kyQ9n/uprOk3HHO4r1DnZlCiAfSUAJdP17H/RdrUcbwl/VtnVN
 +ovT00s1iZvOpUYkAmnUXUxFkSNpm+GUw0qLExe/f7VNu0KkxB9uMFJRNDA4/Y5lnlhs
 PwNPIF047d8Qshkmky/5RBjMVbRZ9EZd06tWKv9Dg9nGl/OV1ILFbU5EI7PG6RPuCwG8
 FLUv3CJK+NlfHD/dRbPz4tHr6LBLBkmqzM7y3Dg7oK3AIj4oTuQVYTnfyihueakD7MR0
 C/Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693253437; x=1693858237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=51bkr9hASitHvEDp68cWD5IuyPCVoWzgBGQbztfhBlw=;
 b=YeqJzy1ve7VeHYzYqGIpmHo9xB3J0yNVWmPxfIFar7F62AhzDskZCbhvVdsDylLB6N
 4kx4Djzk30xrWfbDnbN/N5d2Qogoe5YWJKZNk2hefvtWboavRFoEW40INQBvDkmLith9
 1c4fjGHE7YqelgxtLMxw9gA3ZWupqlYadc9G6hY46Rxr00/SJMDhQVUX6g8yYlS36Rns
 M30YzjkBngl+bbB4zk3DBFrz/pBE+fLv/VhNzDesP4QJaPagKYMHhQ2fQjcNDAEp6Fmb
 Inm+AyPdv7TGADRkdkiLWfdfvvCDkKJT9DcZPsi1kjO+2zhsX87fO4AnNlYi1RHnCPCX
 9Wyg==
X-Gm-Message-State: AOJu0YxptBGQy0j2iYtZ51rdi6zzbWniasC69ilt6vZRwZS9iufb5/1K
 zUepjslupwoz/6IoqrsIQ5q6j3QM7LCBug==
X-Google-Smtp-Source: AGHT+IHoxYMMtNm3ML4CxFOYviJq7lNkTC73PW2Qv8seYeFraGb6b0VdN5Qxjmpdxa9GwOcJ0+ImdQ==
X-Received: by 2002:a2e:9357:0:b0:2b7:33b9:8809 with SMTP id
 m23-20020a2e9357000000b002b733b98809mr19068156ljh.16.1693253436984; 
 Mon, 28 Aug 2023 13:10:36 -0700 (PDT)
Received: from karim.my.domain ([102.60.177.41])
 by smtp.gmail.com with ESMTPSA id
 y16-20020a1709064b1000b009929ab17be0sm5043666eju.162.2023.08.28.13.10.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 13:10:36 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com,
	Karim Taha <kariem.taha2.7@gmail.com>
Subject: [PATCH 20/32] bsd-user: Add freebsd/os-proc.c to meson.build
Date: Sun, 27 Aug 2023 17:57:34 +0200
Message-Id: <20230827155746.84781-21-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index f87c788e84..d169e31235 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -1,4 +1,5 @@
 bsd_user_ss.add(files(
+  'os-proc.c',
   'os-sys.c',
   'os-syscall.c',
 ))
-- 
2.40.0


