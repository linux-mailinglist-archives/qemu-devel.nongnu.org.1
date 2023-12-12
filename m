Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C9980F9B7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 22:47:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDAad-000236-9w; Tue, 12 Dec 2023 16:46:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rDAab-00022j-GC
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:46:53 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rDAaZ-0002gX-Rh
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 16:46:53 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-28abd1ecb85so937401a91.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 13:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702417610; x=1703022410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=H6UlGTJNlH12Da0T8zPOzrTq+ngZ9c8MgbIcoT5zd84=;
 b=gTa1BeUiVR9/fed4PzUTzkmR0/Lp6XFy0tCRjT1eZGqniKny5Y+x1mGUP3UsrLgMGi
 wGlWpV23o9yFJJq760KFtafY79LQebkRzwDLVyQ+WT4r8lPvJ8iqxo+agav58DuO7hh+
 GCg6cjZpLJjGMqLpHDE6kZQYtzdDZpQobwgyjfOUS4GJaBr9oqyBiJkG278JtmzMR0LG
 56ROxUrqJP2i2ptoLbEcqP9Mw5cy+kQcZkxkKdP8ulDCwsWo1IW+NYy8Jv+hwZ7jIEnO
 cpmM/EiuFGX3aAhvXhMZRWzuoFAkp9bSi9ewqJDKGYZd5KU+FmOXhtcEEPAm3j/7wTZG
 3QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702417610; x=1703022410;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H6UlGTJNlH12Da0T8zPOzrTq+ngZ9c8MgbIcoT5zd84=;
 b=kKZcYpYBuiYKQy2FpZheJreyhoEag5yl0JGTUlZCs5Ir5KgkRYW8Zv1qE77BjbeNZu
 iSLixIuWu731oHYvweq3cpup4cqfH8o5rxXdy/6X7jx0uKEHQLS8UoJo24mZssl8fKU3
 sCw8EHvs1iLlzpQryXGYS6s7qcMBs3RrWI6zx8xU/ROW5qFI/SE3DUeI5pKA3tj2xLmc
 Oa0BFmzoLuCLn8wlOm1BZzumjgVLoIdcSA7znFrC/wd8JxRZ+xJ3KwJmXxLjTPAJs/CE
 lUhlEo5EIe+Vn2goc+SasWKLy34vLbRQPsIba/aB7+x0rMEjF8nP2vv9mUMZv6gYw2kM
 7/qA==
X-Gm-Message-State: AOJu0YypyYZL3jPaSSXMGyJzuHiScRjNZKdBJIvvfIUJ87b/MpdSfwpo
 q+7j3S7EZYA5fKAwNgp2fPe8Gpxg+0mOlMz91rLN/A==
X-Google-Smtp-Source: AGHT+IFoJ4QFwBV1KufGNIuPPIPwbQK/+YujxPKWyvLCDNiH5weoWu6ppbYhWMysXSFtndgowHxCpQ==
X-Received: by 2002:a17:90b:1210:b0:28a:6137:149b with SMTP id
 gl16-20020a17090b121000b0028a6137149bmr3175278pjb.94.1702417609968; 
 Tue, 12 Dec 2023 13:46:49 -0800 (PST)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 qa6-20020a17090b4fc600b00286dd95143fsm11037538pjb.50.2023.12.12.13.46.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 13:46:49 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] late fixes for rc4
Date: Tue, 12 Dec 2023 13:46:46 -0800
Message-Id: <20231212214648.300959-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

The following changes since commit 9c74490bff6c8886a922008d0c9ce6cae70dd17e:

  Update version for v8.2.0-rc3 release (2023-12-06 14:34:20 -0500)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20231212

for you to fetch changes up to cbb145567c21d2bc41e8197a243c7d5480c6fca0:

  tcg: Reduce serial context atomicity earlier (2023-12-12 13:35:19 -0800)

----------------------------------------------------------------
target/i386: Fix 32-bit wrapping of pc/eip computation (#2022)
tcg: Reduce serial context atomicity earlier (#2034)

----------------------------------------------------------------
Richard Henderson (2):
      target/i386: Fix 32-bit wrapping of pc/eip computation
      tcg: Reduce serial context atomicity earlier

 target/i386/cpu.h           |  9 +++++++--
 target/i386/tcg/tcg-cpu.c   | 11 +++++++++--
 target/i386/tcg/translate.c | 23 +++++++++++++++++------
 tcg/tcg-op-ldst.c           | 28 ++++++++++++++++++++++++----
 tcg/tcg.c                   |  9 +--------
 5 files changed, 58 insertions(+), 22 deletions(-)

