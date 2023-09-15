Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0447A23A6
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 18:33:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhBkb-0008Et-P5; Fri, 15 Sep 2023 12:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBkZ-0008EM-Ii
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:32:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhBkX-000374-VF
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 12:32:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-68fe39555a0so2109248b3a.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 09:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694795576; x=1695400376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C0v1vcdfRG3rJzddGqRUjFd5xX+DwP3u41b4zspi+WU=;
 b=EUYFqFrx6IAptoUaDh8VoTomPQXv4kv0FLBqaauiGM47fm7UgxlXaZZblocZI2T+IC
 j22xWEoYvakB7Arc62ATem8+Zd78sQESgPrBWhELRtxlMzYd4cjAm7ytLRUcb73uXApx
 xOZvssQqTrRahtlObzJOAKlshBtkFhqod1D/pdEBHhhRUMutr9XqdP0Nr5L6NDuNvC8Q
 V2QqCk+dzF2/iMCnF+9Cw0JCXBZNHyeIyszf/hlqgoCezCDcTHEhlDX4IqccoTamPmZo
 Cc+PHQiZmyoJXfUpOPJr1eCnPXmq5rPKT7giwZmZhdIzB2T7blebazGS9Tak17Ik8Hcw
 xEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694795576; x=1695400376;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C0v1vcdfRG3rJzddGqRUjFd5xX+DwP3u41b4zspi+WU=;
 b=m7oqhuPtTCmQ1jIDbqAn9TNOIztlUerfA2DJvL90oqu/j1D5kR6Etd3ccY4v3Ejtc2
 HQuw8FDc5vMHmCNa76aVZ8n4m7V2sHPUeMp1Mwbpne/N40lbWtKWtN9tqKBHyuv+GmVC
 Q6aB4cLl7uYfgpMWN9ew05lytBm+n2ktEPpBk9iPcqRU0osBeOGrtw4Mzzwg2a3BTKv0
 ZdPGqFQ8NWGVCxBmdV1BUBznoQpejlIgcCZONVjXXQXOa1TFt21mou/tDxB3kqQS1zV6
 yNB5IZkCFSOsYwgmaJa4xslbGFBWyzReOoXbxskAJn3s7Irc56asTPRyCgUv1M+vlX8n
 gRfQ==
X-Gm-Message-State: AOJu0YxC2nXVI4fDd0tHN5hGTWHBP5DSR+3nddtC8rGiu+Uu3nW0twVo
 JRTWV66ianX3u2JN6Jh8GspxEttlL+fTdJatHxk=
X-Google-Smtp-Source: AGHT+IFcEnkoaddy/YkLGTXaqBFu/XL+hrAfLRxeEcbIBTLS8UaFK1pd6dgoLGExx9ckqWyxJw8zmw==
X-Received: by 2002:a05:6a20:8410:b0:153:591b:4101 with SMTP id
 c16-20020a056a20841000b00153591b4101mr3078708pzd.49.1694795575991; 
 Fri, 15 Sep 2023 09:32:55 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 z3-20020a637e03000000b0057754ae4eb7sm2958497pgc.39.2023.09.15.09.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 09:32:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 0/3] accel/tcg: Alternate fix for #1866
Date: Fri, 15 Sep 2023 09:32:51 -0700
Message-Id: <20230915163254.123338-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

Supercedes: 20230914174436.1597356-1-richard.henderson@linaro.org
("[PATCH 0/6] accel/tcg: Always require can_do_io (#1866)")

An alternate fix for #1866 without touching can_do_io, and is
perhaps a bit cleaner and clearer.

Instead, the current cpu checks whether an address space update
is required on each entry to the slow path.  This certainly
catches all i/o.  It easily works for the sequential case of
two i/o, the first of which changes the address space and the
second of which requires the new address space.

I've done a tiny bit of performance testing between the two
solutions and it seems to be a wash.  So now it's simply a
matter of cleanliness.


r~


Richard Henderson (3):
  softmmu: Use cpu->created in tcg_commit
  softmmu: Introduce AddressSpaceDispatch generation numbers
  softmmu: Introduce cpu_address_space_sync

 include/exec/memory.h |  6 ++++++
 accel/tcg/cputlb.c    |  2 ++
 softmmu/physmem.c     | 46 ++++++++++++++++++++++++++++++++++++-------
 3 files changed, 47 insertions(+), 7 deletions(-)

-- 
2.34.1


