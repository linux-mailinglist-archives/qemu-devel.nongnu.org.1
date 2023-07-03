Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3319745DF9
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:55:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGJzl-0000ZT-9m; Mon, 03 Jul 2023 09:53:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzh-0000UD-5e
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:33 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGJzf-00081y-5J
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 09:53:32 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4fb7dc16ff0so6924531e87.2
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 06:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688392409; x=1690984409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26POj3Pp+gIP3un1OHTdCprJFHUE2qyF+wMmQYT3qCc=;
 b=n0XSF8Rck5Et9usUCtaJvF4oZ43rppy52jY2c61oPqRrP3tJtXTeIAfn7bdkVqfPe3
 vMMIRxsYYJlfwqo1MdLldWMzRa1lXVPJvzoKIY/H93Lf3PQSYHhkchTlzRaIvoOcA+cW
 S5x3n4EIyXSPs0E1RszfUAaon/FNCoBF2EJWFzzPTrN9Cm8H07nIGDneM57MxT5fKGA5
 2btc96bFB6OmS+gMdzdG/samNINXcLikDocFq3dVeUmNmqhlWMZq7LKQimNimtzrn421
 TQTsKbLTh0bTBXPJd3lt04q0AcPKWuwMLvqUFpQqOaVGN2qzf9h5qVZMHPLVzN2riGDl
 1O9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688392409; x=1690984409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=26POj3Pp+gIP3un1OHTdCprJFHUE2qyF+wMmQYT3qCc=;
 b=dClu8EVnRdvVZUvCK0EZ4fFUBbbbSeKvXPMLyyGmHJdS39UL4FMH4MJVALRrp14JM/
 ZxfTr5AxJXVcWpRB6jQ/BF52J4NwUvUFvjstZbeb9vJmdAiCf5b3pOfNqJVgHDqoQnxO
 qQ4aCmruSDX4jyN8RKHjkGVJ5ws1rb49zcayRMY0icSrQT73SB5KtwawfGjxT7hPvmHp
 9mRcdHtX/Y9Zim+ClSnSYcLtSfUOmqhMH/eobO1G+AdIE+0wfhw0hvlPkJlYSWGpWPvC
 9eHgDQhqKZyYNPSMQIln3Qoha3C941fURoFwIgknfX1z0aPx14FBjUvsO9ZRLPg5hrAl
 EXTA==
X-Gm-Message-State: ABy/qLb1kCDoWuxzGFtWxXUeU3khcEzwplpf8B0vK9yWr81+hhPbGUd/
 oivXM55WbXgwLRnl1UeJANHKau0Hg9doeYylHQg=
X-Google-Smtp-Source: APBJJlElOqfeWjkzQsBPWBLtXT0qguqx2dLPL3JRJCHnaWfpe4ghIvao7DdaBbZ/I7PpfibDKZBIYg==
X-Received: by 2002:a05:6512:2107:b0:4f6:6b:a43b with SMTP id
 q7-20020a056512210700b004f6006ba43bmr6581280lfr.52.1688392409507; 
 Mon, 03 Jul 2023 06:53:29 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 b2-20020adfde02000000b0030c4d8930b1sm25548544wrm.91.2023.07.03.06.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 06:53:28 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 317E61FFD3;
 Mon,  3 Jul 2023 14:44:31 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>,
 qemu-stable@nongnu.org,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Taylor Simpson <tsimpson@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/38] gdbstub: Permit reverse step/break to provide stop
 response
Date: Mon,  3 Jul 2023 14:44:18 +0100
Message-Id: <20230703134427.1389440-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230703134427.1389440-1-alex.bennee@linaro.org>
References: <20230703134427.1389440-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

From: Nicholas Piggin <npiggin@gmail.com>

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
Acked-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Message-Id: <20230623035304.279833-1-npiggin@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20230630180423.558337-30-alex.bennee@linaro.org>

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
2.39.2


