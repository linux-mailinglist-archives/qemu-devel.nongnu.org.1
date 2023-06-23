Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E707773AF31
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 05:54:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCXrU-0007ZJ-3s; Thu, 22 Jun 2023 23:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCXrR-0007Ys-RC; Thu, 22 Jun 2023 23:53:25 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qCXrQ-0008S2-0T; Thu, 22 Jun 2023 23:53:25 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-39ecbb4c7d3so139698b6e.3; 
 Thu, 22 Jun 2023 20:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687492402; x=1690084402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OhW3E3xWssrafYu/bX32cQW035/oY7yen0wmLDyc/ks=;
 b=Uc/ON+k4gZWQYdtmKtVmufwp1pvjbh86vs0iIdvgLla4msto8VYI6BCigWy/MfrnF6
 w/fGXuLgSzhLJ+WzO4AJnYcJWlvVUqvJbzJvOSsGULMV0MxMcOGivgehSbFh8QhdBR7x
 R5NO3bsW5IEHc7myyJSeKeXwYXp4cTmKWMJk8+keJagdDCVYUFBpHE+sSmF191mxRHkE
 ZsZYBb2qAS4gBDe6urr6+Sf7iTkeH0vP8nCRj7VZ/4AJsfc/T/ZkYxFOUUvaTI9kQgBv
 zsIo9vh0KgSgg6hqX1WdcyEDRJPe3pNRFmeP81KBf0QAJlO++VyzGJH//S0r6HumudKM
 wT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687492402; x=1690084402;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OhW3E3xWssrafYu/bX32cQW035/oY7yen0wmLDyc/ks=;
 b=TszyiTy/cI0mmYaG3AqMrLm9Ai8UT8v60/VP/TnCFFsFFMt8sO8dd9pz+RhBbeeODz
 8LgaKZx1uUuoguubTamtBXcN/GPrsxLyGgef60RQh54ipIFcNG9DRXyuBhqKNLmEUdeq
 jnzr5D8UCxa+mCtM9JyRvTP32xshs2fB5h58JaoCXvg8l672MjJBGpvuzMmged4VEtz+
 NQ6/Umi+uSh8jMFA//QgRFADnGP35x9RqhfMOkWWgcJqzbrYtkym716WVm8qIhsiJDm4
 qUx1/z70vELc2ehdmwTXGbiioiOvvbq/WuCOtLOc6OaxwlBM6+O5SpMQlKsCurmhQ//7
 tcnQ==
X-Gm-Message-State: AC+VfDyIlsFyeIBT3JCeZFDvk3pAOXxMl3AFTtZMAylBs6gsLknz5AQ8
 XL2ieG+hhQnaSwcYawmanTNaqwLwaOw=
X-Google-Smtp-Source: ACHHUZ6X1dphZSbOwolh9gPeBAR/167ZoVO3GacvbVqBl7EyVrk1dskJfnCCWBjT1Oj6hecY1np0fA==
X-Received: by 2002:a05:6808:3009:b0:398:5d57:3d08 with SMTP id
 ay9-20020a056808300900b003985d573d08mr24004774oib.37.1687492401952; 
 Thu, 22 Jun 2023 20:53:21 -0700 (PDT)
Received: from wheely.local0.net (193-116-203-37.tpgi.com.au. [193.116.203.37])
 by smtp.gmail.com with ESMTPSA id
 4-20020a170902ee4400b001b531e8a000sm6090192plo.157.2023.06.22.20.53.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 20:53:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-stable@nongnu.org,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>
Subject: [PATCH] gdbstub: Permit reverse step/break to provide stop response
Date: Fri, 23 Jun 2023 13:53:04 +1000
Message-Id: <20230623035304.279833-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22e.google.com
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

The final part of the reverse step and break handling is to bring
the machine back to a debug stop state. gdb expects a response.

A gdb 'rsi' command hangs forever because the gdbstub filters out
the response (also observable with reverse_debugging.py avocado
tests).

Fix by setting allow_stop_reply for the gdb backward packets.

Fixes: 758370052fb ("gdbstub: only send stop-reply packets when allowed to")
Cc: qemu-stable@nongnu.org
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: Alex Bennée <alex.bennee@linaro.org>
Cc: Taylor Simpson <tsimpson@quicinc.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 gdbstub/gdbstub.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index be18568d0a..9496d7b175 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -1814,6 +1814,7 @@ static int gdb_handle_packet(const char *line_buf)
                 .handler = handle_backward,
                 .cmd = "b",
                 .cmd_startswith = 1,
+                .allow_stop_reply = true,
                 .schema = "o0"
             };
             cmd_parser = &backward_cmd_desc;
-- 
2.40.1


