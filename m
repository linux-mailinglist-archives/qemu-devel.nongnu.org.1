Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A261078F703
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 04:24:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbtpZ-0006wd-4q; Thu, 31 Aug 2023 22:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpR-0006wM-HD
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qbtpG-0001SX-RL
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 22:24:09 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68a3ced3ec6so1287305b3a.1
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 19:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693535033; x=1694139833; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKBqBWVnteg7nBg0Ct8xapNabPHsKvd3tq3kc9va8Z0=;
 b=nRjNEN53iW8r9Y5eWZONgwSvQ4WTdV6jcr+U9/LyPcHfsCjxsWUuwfvydxX/nbCr2h
 4T3vs7JgWaCDZxVF3xp8AdDz5JXp2wCRe4/huTaZ0pzoeJFO4X/FwKFRr4DThpPGjItC
 5bTqKldoWuKKTtKFGRCRFDLL4YA9Z/1YfvJCjaHNGQ7myAUOVInIFhez3YotG+XyDb87
 s+EAgKhAgAJhsbYypI/NXuNbT14rQTA5rZJwQAhYgI67zK38e0cJOEuD7IAjQOOfMQdi
 Bqztp+mvFZu6DdOXntAbzo+WpU+pJAfZl5R92Zly1+8wR/qiqkJpVRIWoU9+lzqXPagy
 4+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693535033; x=1694139833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKBqBWVnteg7nBg0Ct8xapNabPHsKvd3tq3kc9va8Z0=;
 b=h8zBQf9APAdkpriZ+BhBLFLLKOGLgZbqT0XhMcJESSxyoQpS9FQq6jdUNbYJjMPhT0
 JlLzWLxc0lXlsSbXPjUjqnhm8WI5bjn8f0fiWP++MFYqvzUuxupDlZUyJQyTUDnlmo68
 y4ZgWvXubt3zpWJ5tXKjm5Slwk56Ss4kwV2iD5+ThqpF4/c/iDh1DoCk+lltqPJUJSFO
 4UVv8ipaWaJNuU4HyXA662pqB6VAArp2B/+0DsiV6VhCoHUZGLUAylDmMIom93n0q2IY
 1NIrAUFKATRwZ+gZVc9llrsj6VyMYhG6IBI2B44zJfX5yvqbUZQ+dtro/U6hrIwE1M86
 wd6Q==
X-Gm-Message-State: AOJu0YwsDy0nJjq/kuE8hpHNjV38Plc4FALz+rUqCS4zRE1Nq4yNSsBX
 Mj/b2Y/3X4RjoDfcTSG6jFizIc+DKwHNmww9M9U=
X-Google-Smtp-Source: AGHT+IGsjQJT8a50FXO5Bp/hsUlLsk/YaYflleoUClMmMUfE6JXxwipWf6ks5i2KgxEtyaZMUkkPmw==
X-Received: by 2002:a05:6a20:8f15:b0:129:d944:2e65 with SMTP id
 b21-20020a056a208f1500b00129d9442e65mr1874328pzk.13.1693535033039; 
 Thu, 31 Aug 2023 19:23:53 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 c25-20020aa781d9000000b0068a54866ca8sm1906977pfn.134.2023.08.31.19.23.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 19:23:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, alex.bennee@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 25/33] tests/tcg: Extend file in linux-madvise.c
Date: Thu, 31 Aug 2023 19:23:23 -0700
Message-Id: <20230901022331.115247-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230901022331.115247-1-richard.henderson@linaro.org>
References: <20230901022331.115247-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


