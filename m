Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BA67BF4F5
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:55:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7YW-0005ju-LA; Tue, 10 Oct 2023 03:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YU-0005b1-E4; Tue, 10 Oct 2023 03:53:26 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YS-0005K9-R2; Tue, 10 Oct 2023 03:53:26 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-692eed30152so3945899b3a.1; 
 Tue, 10 Oct 2023 00:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924403; x=1697529203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqotvT7s2KNx9nGdrthTh0VLKSX7c1BTmCAddFJyYLE=;
 b=aWbDbZl1M1f+tSLlQrvahn+4YnA2lqy09so2KJLCsKwZcEwj8dAvLOJboMXZxzBE6g
 usEOTOSY3mFkZb1z+/agJdykyW40KIg2vBYyDZywY8G6nRBs68sirtAF+P+ejO5kGvWp
 exoKSshWuiM/D/cIIwqbbLabOf8Xov5RGmfGS/X0jTL6vCEoTA6Py/i5LJWhUGOd+jAv
 88qtO4ZsctUtKXu5hPzaGNeSnyb5D/hy6l04t3dUxqQb/ZUyS3d+3NkcVBjW1H2xa1Ub
 /Ul+CZ0wujA9cR3pWdaSozCxEnbb9Lmf+wdzQ81TtmZQpXSg5hMjNhEO0bpELbdBH3VO
 dEjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924403; x=1697529203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xqotvT7s2KNx9nGdrthTh0VLKSX7c1BTmCAddFJyYLE=;
 b=vrAkmNw6xU14LiE4TlS751nxRj7gPywFqDkfTHld4XydtMPvnyX0P7yxZYvte3By+C
 czlFr1LWbXjFs744czGbakp4412EjtHQoS1tgduXlurrS6XjjuXUCZTNnSQDUNlL5vOa
 FT4auKipIlgW40kQGCIv1ILKDRZaFQOLOALlN4P08xlQ79FfxBRKdVCBmCzTdji1k2Dp
 8nUSSqs0/a07cup5soGMCjtfeSNrPebKstyfTbme+0zNhyoQvztaGj3dDTz0i2LMt35r
 TEjURoC+LhaxwQU96cqYVaoS3zpFvudnFkzt5jkwQG8zQ5AQM2IQ3KTkfpZ8ilSStdhX
 AJPQ==
X-Gm-Message-State: AOJu0Yysa6hvuqwFcYxMe2VSvmrosqL151lIjqvaJa48IwFN/aub0W6Z
 YcRqcMTB3tONgC18N9k0TVMR5jhDSB0=
X-Google-Smtp-Source: AGHT+IGkoWM3U++R5fSZteHO6AILGH2qp3Nu9yK9zNVp4qR+AdDSEx3T/OrvbTeUm1SNo3vp7Yi7jw==
X-Received: by 2002:a05:6a20:7487:b0:15d:3a10:18c6 with SMTP id
 p7-20020a056a20748700b0015d3a1018c6mr17087391pzd.45.1696924402845; 
 Tue, 10 Oct 2023 00:53:22 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.53.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:53:22 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 09/11] tests/avocado: Use default CPU for pseries machine
Date: Tue, 10 Oct 2023 17:52:36 +1000
Message-ID: <20231010075238.95646-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Use the default CPU with the pseries machine unless there is a
specific requirement.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/migration.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/avocado/migration.py b/tests/avocado/migration.py
index fdc1d234fb..91ac33919b 100644
--- a/tests/avocado/migration.py
+++ b/tests/avocado/migration.py
@@ -123,7 +123,6 @@ class PPC64(MigrationTest):
     """
     :avocado: tags=arch:ppc64
     :avocado: tags=machine:pseries
-    :avocado: tags=cpu:power9_v2.0
     """
 
     def test_migration_with_tcp_localhost(self):
-- 
2.42.0


