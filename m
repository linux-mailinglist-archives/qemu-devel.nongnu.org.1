Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 933C274A2C8
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 19:06:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHSQM-0006gP-E2; Thu, 06 Jul 2023 13:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHSQI-0006eC-Hv
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:05:42 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHSQH-0001MH-43
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 13:05:42 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fbc77e76abso10563605e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 10:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688663139; x=1691255139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QDc0d2vFAXHVAlsZcS72EOuarHd+LttspSaXM/ba1G8=;
 b=kYIM335KhwwTIhkNmYzd5GieHGTrZs4YqVd+Uc2gXHN72Nk8Z3bbzNKw/OLWDAwA1T
 LiNg3WO4lSfsVncd5L/TOSmufr8crZuPLQwjmGYab9riAoS+5KDQXeKThUC//g25qFO3
 /ZJev3xVlTKazuIRBDH5gc0GgZT18qfPEFZnUEpCA4TPBdBt6FhJ6ZnaeJ2BCq3lr1jZ
 aOf4bPIXGsmV4k2eDkbP+ivfON3naNDIcCCSsg1ml8FeOKd/YbFne6rcqGw1qdbzvOEy
 naLLAz6hpLuIdWjHrh0gX0st534BQH00yc0wvbD6N56sSAnotfZanUI5G9W7n/4YLy/k
 O60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688663139; x=1691255139;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QDc0d2vFAXHVAlsZcS72EOuarHd+LttspSaXM/ba1G8=;
 b=imt6kLuRziMBQsPoH8GmQlbLjAZM2VDqHSzO865pV3BXqLrfWPYSx7sbb3AjkKIeir
 q7vBz4W6RIi73+re0SZpcRZAhbNpyYwecdrDrre0e0aPSJhEIh6Pb2fzLaLkeHUtmjR+
 lRK1lvC6DRdbAoMnySeLY1WQgvJlb5T8qlgk7OdyhnjBkKUQxsSCYaXJV/rRV9mS6OlK
 17sdA2QOTfFU4qQh1fIJ4A84yZbf0l1z3stoXnb36PcW92nR1UcJ6r9Rv2dv5Ijgqy1T
 i9ur43oOS7YKkd33hMUgod25uNnKNWKisoRbl26Hb8YiY4CUL9YqLaKd/46OcnOyDeB2
 kwDw==
X-Gm-Message-State: ABy/qLbtsmj+uQZN7bg+onCm3bMOWEK1bEROywjxEt9NDBsoo72sBHGA
 nYJq48VtVbaiIZMCZm1Kr8B2Z8yVLrMFJCg43O3RXg==
X-Google-Smtp-Source: APBJJlHEBAyaKRTj7dmtDKkFFoVoW4DwaqoWIzuLBwczf7uy+XxsETSUn1W7WXdXFRuOT9l14M7MCQ==
X-Received: by 2002:a7b:c4c6:0:b0:3f8:b6c:84aa with SMTP id
 g6-20020a7bc4c6000000b003f80b6c84aamr1782518wmk.24.1688663138897; 
 Thu, 06 Jul 2023 10:05:38 -0700 (PDT)
Received: from stoup.quadriga.com ([95.152.217.99])
 by smtp.gmail.com with ESMTPSA id
 24-20020a05600c021800b003fbfa6066acsm71888wmi.40.2023.07.06.10.05.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 10:05:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: rjones@redhat.com, peterz@infradead.org, arnd@arndb.de,
 naresh.kamboju@linaro.org, anders.roxell@linaro.org,
 daniel.diaz@linaro.org, ben.copeland@linaro.org, pbonzini@redhat.com
Subject: [PATCH 0/2] accel/tcg: Fix race condition in tb create/invalidate
Date: Thu,  6 Jul 2023 18:05:35 +0100
Message-Id: <20230706170537.95959-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Thanks for the test case, Richard WMJ.  Using the fedora rawhide
kernel-core-6.5.0-0.rc0.20230703gita901a3568fd2.8.fc39.x86_64.rpm
I was able to reproduce the problem within 30 iterations.

I'm now at 650 iterations and counting.


r~


Richard Henderson (2):
  accel/tcg: Split out cpu_exec_longjmp_cleanup
  accel/tcg: Always lock pages before translation

 accel/tcg/internal.h      |  30 ++++-
 accel/tcg/cpu-exec.c      |  47 ++++----
 accel/tcg/tb-maint.c      | 242 ++++++++++++++++++++------------------
 accel/tcg/translate-all.c |  43 ++++++-
 accel/tcg/translator.c    |  34 ++++--
 5 files changed, 239 insertions(+), 157 deletions(-)

-- 
2.34.1


