Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 160A7773746
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 05:04:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCzp-0001LM-6h; Mon, 07 Aug 2023 23:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzn-0001Kq-81
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCzl-0006Z3-Mn
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 23:02:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-686b91c2744so3775048b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 20:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691463772; x=1692068572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gzultf+jtck/t6l0Eeu17uiLO6p6YZ8+8SqLRnEu8vk=;
 b=C+DFQ/Ykkyv2W0z+7ShbzpzGweaWP/s66mJ6w70LE199T8oHW1Uy9Te6mpXhGK5OEl
 iDYLs92htRi8AjWELec7bWqd/7lq5m/EXZmPAcV6Mdr1jaH+tHI7CvZ8JxrGuIfy90Jr
 O2mrCoZ+dfKjt8whtYtpqHaXsy84FNZ73Ael5k2NSrnopjy3FKcA2QOz6Sq7onInHgJM
 XKG2v0cnItK+3/IOegxk7zcQFF9O5EqlSXpXVmJuk9I7aju+zxrdBkUIkhufPQ70+m6M
 JIPD/DbgHa98Zy26jLrsiUaSnNuPTea6XHVaaLhWS5xfnraOOu5Yk4t4VJb/df/1aBzh
 hgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691463772; x=1692068572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gzultf+jtck/t6l0Eeu17uiLO6p6YZ8+8SqLRnEu8vk=;
 b=hbddy8bvSVoga055U725S+ibsrEDpz+oJQR5Py8e1/oFuPbN76Z+i45o0EtoXxeeaa
 HJ05oZQT5WXXkBhzbPVGJwXxDvN5kdu6ZM4LTh8ohmBrVz9Ut3kRKjtqxs0ki3tRQH9f
 56+DgvtXWTniIyM7rLenkePoB4CZXgPv9o8+8F5skj5W02QXEuYH8BZMB+atz0rWleD0
 Xue8CjC9iBx4IDD7ZbqYvBB0+HcqVnlppu/BhwW10M0j35cxMeGLxZJT2xJh79yB+qyx
 al+awEEv1d6odxxsC4mmQwC7XXf/DQb5GKe5+4C+ve6EpsyXHSpX3QU9PaL58E04VQd4
 RfIQ==
X-Gm-Message-State: AOJu0YwmHwJEYMCmsjzMfwJ26QpuUaC5L1tUPq0W9m7wteVwtVTylkyp
 ay43KaLK7drSKuO6MO6BHQE1t6v6KBxcIbEo3VA=
X-Google-Smtp-Source: AGHT+IFm/bdsq5tOlBA8Z31DlABe1ERiq3sUzS9csPRK/yLNPbkSifA5u4bWgUuxse/a8Xo2zZYtVA==
X-Received: by 2002:a05:6a20:3945:b0:134:a478:6061 with SMTP id
 r5-20020a056a20394500b00134a4786061mr13568329pzg.26.1691463771945; 
 Mon, 07 Aug 2023 20:02:51 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a62e407000000b006870c50efaesm6903609pfh.9.2023.08.07.20.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 20:02:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: npiggin@gmail.com,
	jniethe5@gmail.com,
	qemu-ppc@nongnu.org
Subject: [PATCH for-8.2 v2 0/7] tcg/ppc: Support power10 prefixed instructions
Date: Mon,  7 Aug 2023 20:02:43 -0700
Message-Id: <20230808030250.50602-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Emit one 64-bit instruction for large constants and pc-relatives.
With pc-relative addressing, we don't need REG_TB, which means we
can re-enable direct branching for goto_tb.

Changes for v2:
  * Merged Nick's adjustments for goto_tb.  Only patch B/NOP,
    falling through to PLD for indirect branch; drop PLA option.
  * Fix sx typo in patch 3 (jordan).


r~


Richard Henderson (7):
  tcg/ppc: Untabify tcg-target.c.inc
  tcg/ppc: Use PADDI in tcg_out_movi
  tcg/ppc: Use prefixed instructions in tcg_out_mem_long
  tcg/ppc: Use PLD in tcg_out_movi for constant pool
  tcg/ppc: Use prefixed instructions in tcg_out_dupi_vec
  tcg/ppc: Disable USE_REG_TB for Power v3.1
  tcg/ppc: Use prefixed instructions for tcg_out_goto_tb

 tcg/ppc/tcg-target.c.inc | 192 +++++++++++++++++++++++++++++++++++----
 1 file changed, 176 insertions(+), 16 deletions(-)

-- 
2.34.1


