Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAE5773729
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 04:56:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTCt1-000702-GD; Mon, 07 Aug 2023 22:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCsz-0006zk-O7
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:55:53 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTCsy-0003PW-6z
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 22:55:53 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-686f090310dso5192563b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 19:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691463343; x=1692068143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rRyoj2OUdrglSd81krMhVIZ8XhMwBWYK+HGCEaAMaiM=;
 b=u1g9XQVBBzaJS1wkCBDq2n9AqZRIEcCtKDnPtyo6AQXe9dF/fqrTSCEYWppGLHNcfk
 IB+mWUx5poc/1UZSDm/lTNvPTYcp0Kam2xNJda96jTFpnekS6qSPCUoRXXm6WX1cEUPS
 Bx2Sw1d02QwRbx8u97L4KfqPpz0Q7/jW5llQqjZpfLNifDrwalP4w77Ii2RjIRZYffpJ
 J5aHTlnBQbbg5/oTK7mQYrpPlDv30sikV3TgrbgvYLNgS34tcQSCfFyS/E20ZI8FqSEd
 LlZnDC5TuGQY9DjJqcGiB3DkLMGoF/I9aMfhVj2gg4lSmzzn8yn4nlLTHmN7uaqob57Z
 y58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691463343; x=1692068143;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rRyoj2OUdrglSd81krMhVIZ8XhMwBWYK+HGCEaAMaiM=;
 b=AAqo/8mipFME30Jp8h1ySPc9NHIoPf5jBgvu9Kd9n8+JBpzqsYbzA5kBcUX9sYzZIl
 SnXPUbY8TxHKSOuP9q6RWoar0mDG8R38a+GRYhbhOlA6xOfbnCsO498N9xiZovbc3qtQ
 uUZlw0JGzM9/tLWVZ5pOGD351KFXOc/uZUROULYLOYUUylop7mAgbcLkbjD7gSOw88bP
 dCDysvB1qhDUC7KPODAkcK+tnbUAVP5ObrUlAAdS+9JatlWM2a2iU3yiLfvPOc5mrcav
 cXlLa22TVnH528yUDHv8Au5YETYPwCMLt3RroOVV6HwaaMk80Uz4T0ZlmH6GwdlJpseR
 fhiw==
X-Gm-Message-State: AOJu0YzvxuzeLvHVyTDc9x09BLvwpaW7U8VUSM212fgUHb9cUcaPCv8V
 BO7Wsq3f2KhOd/UUX+PRkJ6NCLE1I45YntCjYAA=
X-Google-Smtp-Source: AGHT+IH47zI25d0NQgca96QOuVBOzmU8cdMjCWcFauafdVtVWBswrdvgSJCBf3ynPIsK9oR/GGBM8Q==
X-Received: by 2002:a05:6a20:3242:b0:f3:33fb:a62b with SMTP id
 hm2-20020a056a20324200b000f333fba62bmr11460513pzc.9.1691463343624; 
 Mon, 07 Aug 2023 19:55:43 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:e306:567a:e0a1:341])
 by smtp.gmail.com with ESMTPSA id
 t2-20020a656082000000b0056353c0a03esm4900037pgu.37.2023.08.07.19.55.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 19:55:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru,
	laurent@vivier.eu
Subject: [PATCH for-8.1 0/2] linux-user: Fix MAP_SHARED_VALIDATE,
 MAP_FIXED_NOREPLACE
Date: Mon,  7 Aug 2023 19:55:40 -0700
Message-Id: <20230808025542.50392-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Fixes LTP mmap17 (MAP_FIXED_NOREPLACE) and mmap20 (MAP_SHARED_VALIDATE),
both of which were added to linux-user during the 8.1 cycle, and so
would be nice to fix right away.

Does not fix mmap18, which will fail depending on the guest memory map.
The real kernel avoids placing new maps immediately prior to GROWSDOWN
regions (leaving them no room into which to expand) and qemu does not.
This is a long-standing problem and will not be fixable for 8.1.

Reported-by: Michael Tokarev <mjt@tls.msk.ru>


r~


Richard Henderson (2):
  linux-user: Split out do_mmap
  linux-user: Use ARRAY_SIZE with bitmask_transtbl

 bsd-user/syscall_defs.h   |  2 +
 include/exec/user/thunk.h | 15 ++++--
 linux-user/syscall.c      | 96 +++++++++++++++++++++++++++++----------
 linux-user/thunk.c        | 24 +++++-----
 4 files changed, 98 insertions(+), 39 deletions(-)

-- 
2.34.1


