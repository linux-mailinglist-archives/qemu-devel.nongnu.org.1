Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1697DFB49
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 21:11:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qye1G-0004N3-KQ; Thu, 02 Nov 2023 16:10:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qye1E-0004MU-4h
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 16:10:20 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1qye1C-0006se-O1
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 16:10:19 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-1dcfe9cd337so664291fac.2
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 13:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698955816; x=1699560616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XYffJWKxPAG1+woL4v6dzrkVET0Jn4SD6hAm7Qu4mFw=;
 b=lZxuLGErTvn1/W6ZFfq2K21P00DgT7ly1VnNiqaT2dMFPZPcxRNAyIPzvuoNut0+AB
 gNKMNWR4xA5YeGxU61mtmckz0RGQWipkzMctHHtWmcz1X6ZTEGVpJFy2IthvvfwCwRrA
 5v0KibalB+8ZT+iVaJyxZokTWPwheTn+25ZhBXn2Byn1KhUItvlP/yJ6VJKdHK1nODKL
 k/wSnn8nYaM755G2SSlwJVp6FnFzsDGB59LW0EDyx7w3A7mDkUrvGEIlnt/Msk3TwWEq
 sN5b8zj2K/lvj1FU4qdg4jRgEm80JIHbY3x/vJOwm9vk1SQtS7FuM+uMwwrJSt5+Fs9Y
 g/lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698955816; x=1699560616;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XYffJWKxPAG1+woL4v6dzrkVET0Jn4SD6hAm7Qu4mFw=;
 b=vHi45FouBP6fk8RwLL4jARhW72MOTv74NZukkc/UQ/rh2D/IaQvAlVPofAJGKJvi+2
 sGB6/vOuMfa25euqTbFRFyLwFkKTw5Pb+T5gjRyf5RjjCg7VrlaAjD5Yw+tghDbwSbfI
 LUkaB1WqNTWNYYJs38/kWs1ZCzJljt5STU5aBPP8lz2a1IJw8o0gpW50cxhZMODsbOZ3
 /XOnHngT9XtR81lmOoX1JXI+/tLFegGznAIVqCdvzI2F7luCQpexsGcKDWqKWihyQ1vS
 TpohJYHVtw9RKHHcJLE7v8fVvVm4QaRpTZsV43rXnppUIR4nS5s77yRNhhovmRQizdOp
 msNg==
X-Gm-Message-State: AOJu0Yx+Pj1E+IcGPCIiwdtZnuhl5/1ywSVemy5emVrVJ+AauJ8dXzdO
 metzV/YQFsIkddGswlul/CwffI0jsFk=
X-Google-Smtp-Source: AGHT+IGHskeqgz8SMWzyGQKjJk8uFX+a5OtuRNU6uPB0yuPbVUZgv3/3xZf/zE3Pb+pZasT+uU4gJg==
X-Received: by 2002:a05:6871:5209:b0:1d0:f5bd:6e9 with SMTP id
 ht9-20020a056871520900b001d0f5bd06e9mr19647831oac.22.1698955816365; 
 Thu, 02 Nov 2023 13:10:16 -0700 (PDT)
Received: from taylor-ubuntu.austin.rr.com (cpe-68-203-8-61.austin.res.rr.com.
 [68.203.8.61]) by smtp.gmail.com with ESMTPSA id
 z9-20020a056870e14900b001e98b1544fesm63543oaa.9.2023.11.02.13.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 13:10:15 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: Taylor Simpson <ltaylorsimpson@gmail.com>
Subject: [PATCH 0/3] Hexagon (target/hexagon) Enable more short-circuit packets
Date: Thu,  2 Nov 2023 14:10:03 -0600
Message-Id: <20231102201006.33143-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: test/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2f;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x2f.google.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, EMPTY_MESSAGE=2.32,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patch series improves the set of packets that can short-circuit
the commit packet logic and write the results directly during the
execution of each instruction in the packet.

The key observation is that checking for overlap between register reads
and writes is different from read-after-write.  For example, this packet
    { R0 = add(R0,R1); R6 = add(R6,R7) }
has an overlap between the reads and writes without doing a read after a
write.  Therefore, it is safe to write directly into the destination
registers during instruction execution.

Another example is a .new register read.  These can read from either the
destination register or a temporary location.

HVX instructions with generated helpers require special handling.
The semantics of the helpers are pass-by-reference, so we still need the
overlap check for these.


Taylor Simpson (3):
  Hexagon (target/hexagon) Analyze reads before writes
  Hexagon (target/hexagon) Enable more short-circuit packets (scalar
    core)
  Hexagon (target/hexagon) Enable more short-circuit packets (HVX)

 target/hexagon/translate.h          | 117 ++++++++++---
 target/hexagon/translate.c          |  75 +--------
 target/hexagon/README               |   7 +-
 target/hexagon/gen_analyze_funcs.py | 252 ++++++++++++----------------
 target/hexagon/gen_tcg_funcs.py     |   2 +-
 target/hexagon/hex_common.py        |  10 ++
 6 files changed, 227 insertions(+), 236 deletions(-)

-- 
2.34.1


