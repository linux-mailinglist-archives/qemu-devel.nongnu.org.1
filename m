Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58389744204
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 20:17:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFId8-0005ki-NS; Fri, 30 Jun 2023 14:14:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcl-0005T1-4f
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFIcg-0003XY-LP
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 14:13:38 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3fb4146e8ceso24686915e9.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 11:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688148813; x=1690740813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tV6uJjNfKxjFHFViquI0SJu1Ss2OiTFYxgVHQ5LvQag=;
 b=OoJv59s6DKWXwTqzOtPlJEpShOSxoQvzfmw/Q7NevrMIOxHOBPj5glmCOJaetH9Fml
 TAjkFFeaz6J4xW94nYXWNFN3YtlQPtIiBZOzZunzagKMmO4T9JjhumgvtNivnJr4bdoz
 6pA96NB4/uc30H1ff2QVp5p6DGYjxO8Xgh3XhbWUj7UFzuIynyR7+R1NdJqobn1fyK1O
 PKUMiC4nR8f4lhDRGRK4epEosjIASKDcS9gUmSSc2j6ISNkUF08gfpIzTqoWnShQqbLH
 4RP4Gir1WeR36WZJs3JjS6VWA+vy2ddNHUU3aoNL0QPYsyJw2j6RdcCUrgO9H5fXKZXc
 Z6oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688148813; x=1690740813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tV6uJjNfKxjFHFViquI0SJu1Ss2OiTFYxgVHQ5LvQag=;
 b=gtCkyGuD1z5fDzgtcPqICD9k+CXSgqa/A23XM6rVwgm2TQ4k+0adL7lPGRXd8zClWL
 i26xyNsvpZrSFJLafuSJjbmhj6JpdspF5VkkbV8YXRAyb+U1NicSCti0QIbNrJL3TRpi
 RaFnfa8G7LHXT1QrBxevSAyF31Ml/7wmUdfwS4cX/Ignokkz2xoKIhgFQYs5DxH45EGd
 FxuGINgys2E6sDdgY7lIhZiTi+d2L56vJMdZtaq01XM0Kakf/5M6CfSUb6zrElUcj+cf
 AijrxlnbDsIKvdaWwO6F6uyMCguRyyUOVCix8Qv9EtYtOxTRTzoZ+OZPrq/x8oXb+pMF
 uXpw==
X-Gm-Message-State: AC+VfDzx0vfvOCNnk7VlariqOY3qtOBxThKAsrMJ/XN0O3Cju7x0bReF
 KRC1wISFMkEFLKb8EWQIE++AQw==
X-Google-Smtp-Source: ACHHUZ4W1hWCmtbfdg+muYwsbuPF0LM+oj1MSFmhzzIu3hi5OGh9eWzrf+k2nh8vJWZEjM0vf/6WdQ==
X-Received: by 2002:a05:600c:22d4:b0:3fa:9850:8b12 with SMTP id
 20-20020a05600c22d400b003fa98508b12mr2554049wmg.21.1688148813030; 
 Fri, 30 Jun 2023 11:13:33 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 25-20020a05600c029900b003f42158288dsm22573094wmk.20.2023.06.30.11.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 11:13:30 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4FF8A1FFD3;
 Fri, 30 Jun 2023 19:04:27 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Riku Voipio <riku.voipio@iki.fi>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Bandan Das <bsd@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Darren Kenny <darren.kenny@oracle.com>, Alexander Bulekov <alxndr@bu.edu>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-stable@nongnu.org,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Taylor Simpson <tsimpson@quicinc.com>
Subject: [PATCH v4 29/38] gdbstub: Permit reverse step/break to provide stop
 response
Date: Fri, 30 Jun 2023 19:04:14 +0100
Message-Id: <20230630180423.558337-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230630180423.558337-1-alex.bennee@linaro.org>
References: <20230630180423.558337-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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
2.39.2


