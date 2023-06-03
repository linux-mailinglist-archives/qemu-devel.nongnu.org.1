Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6907213AA
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 00:27:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5ZfR-00074c-2W; Sat, 03 Jun 2023 18:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfO-00073G-O6
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:10 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q5ZfN-0004xq-87
 for qemu-devel@nongnu.org; Sat, 03 Jun 2023 18:24:10 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-650c89c7e4fso3369735b3a.0
 for <qemu-devel@nongnu.org>; Sat, 03 Jun 2023 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685831048; x=1688423048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlLAKbin88s2Bcshj2HVcftPX+wBtI4PcDZ8BFVeJFc=;
 b=zmMOg0RF3HRwKEBXpSHT3Dk80mYnFW54I0kM2TUj1P9QiG3KbLg4VtFDCm6ma9KrwP
 SDwDy0LD/uCeAkCmbzLMDo2/rgdAEBaMpMw8DVUeB1kzq3VPmZ4WhfobYZNlN4yweAWE
 eazvblP2oaSOLctBqmaBudWv31PuU2B+SqauuLOoTTA2fK3VC2ltwoGafBBvOhXzNYLb
 8pusm05Ges7BIJy5zGkMWo6TW9EtkrsZcXuvKs/XxR0vDGl05uSncd8lfnQbwIniJqqu
 Qt3WiNJvGEIGHW56E94gY8lFfoA8vuowO/kOcrShTfwkge2PCyOLmyVJeDBTKHDpQANp
 g2GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685831048; x=1688423048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RlLAKbin88s2Bcshj2HVcftPX+wBtI4PcDZ8BFVeJFc=;
 b=YcxsEPuPZpon4LOVZFJR2vi0rGm4YZXak79qmBPmTfpqNFv1CXzePYwBrIHKpGZ+BH
 Qwo0DcXk/nAWFMf1DTMp7u0GgQN8BHfhDPaNAI0U9Ys+yY0+0yMpaB0Wzg9Cypg2Z2gB
 CiKJhwz3SWCRXm2s81CWSpOjY1mXv+Py5NRpNhFxAgqTgaEWMW8YWEKX93GHp/hG9xSn
 T0DqzurjNCUy1XSkFw/JHeT4drxTnd6ldPkt79ElYEUaToCDUR1/68g/7j8DANLcuo+a
 IfHfSMePtL2LESsiHmYVnsxA/N4B759/xJMu4H8zFSBKhCdPf+9Lgx4tT/M8GTvCA+Vv
 /wSQ==
X-Gm-Message-State: AC+VfDz208/wY5B9avb6xJ0er4xIs2DzzwosP4ASJvGDRfjmILosWw2n
 PtKpeAMlv2QeiZ9lElegtfP8YrnuokUdQdVxOf0=
X-Google-Smtp-Source: ACHHUZ6kASK5YTVoeujX6n31RWQhWSr20xtUSV3aNa+5qJbxWAkBy8xSi3kRC9Owqh/FGCd5/xBeGA==
X-Received: by 2002:a05:6a20:7f87:b0:10b:5ce1:beb9 with SMTP id
 d7-20020a056a207f8700b0010b5ce1beb9mr3100450pzj.33.1685831047717; 
 Sat, 03 Jun 2023 15:24:07 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:9a37:84b6:b3f0:f301])
 by smtp.gmail.com with ESMTPSA id
 m14-20020aa78a0e000000b0063d2dae6247sm187208pfa.77.2023.06.03.15.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Jun 2023 15:24:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Subject: [PATCH 13/15] linux-user: Use abi_uint not unsigned in syscall_defs.h
Date: Sat,  3 Jun 2023 15:23:53 -0700
Message-Id: <20230603222355.1379711-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230603222355.1379711-1-richard.henderson@linaro.org>
References: <20230603222355.1379711-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 9dc41828cf..c8ffb4f785 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1776,14 +1776,14 @@ struct target_stat {
 
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-    unsigned        st_dev;
+    abi_uint        st_dev;
     abi_long        st_pad1[3];             /* Reserved for network id */
     abi_ulong       st_ino;
     abi_uint        st_mode;
     abi_uint        st_nlink;
     abi_int         st_uid;
     abi_int         st_gid;
-    unsigned        st_rdev;
+    abi_uint        st_rdev;
     abi_long        st_pad2[2];
     abi_long        st_size;
     abi_long        st_pad3;
-- 
2.34.1


