Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FC4777FF9
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 20:09:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUA6I-00027b-Qs; Thu, 10 Aug 2023 14:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUA5s-0001yb-CN
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:09:10 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUA5m-0001yM-E6
 for qemu-devel@nongnu.org; Thu, 10 Aug 2023 14:09:06 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b9c5e07c1bso10702985ad.2
 for <qemu-devel@nongnu.org>; Thu, 10 Aug 2023 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691690938; x=1692295738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iU+C7JV6FbRgzBVC3R2lwvlAYCK7PTnMEPRpbCh3lQ4=;
 b=u4xReyEiduAa4QPqqP4aQsYdKCZivVj0uaVEqP0oyPLjnVa8DiZ8D5d2MGwoN2gAd5
 GBZt/t6yOI+Htsj/gKii8+DYYD92KcZNnhsRX4KvXe7e1iUbawOCVPyO88Z8F/0DAG/S
 EUVOXSRR4NmmLIuYDpBYXI9KOM/I34Qyi9OjRfDtBKRF0ijwAWdDCp6s91zJVqIhF4Dm
 Mm1SW3q4FKhImBQLSDsoZVGCBw3qe6vm2kS+nAOHgWr69xrRkxVlZY8cQdssaEzk6chd
 c/cfNHJVUvqVgrvK+Hi+CC7MVgD3BwB7ISe7DiHgDcte57ihOzXLU5mb5gDTctmbeA5C
 QRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691690938; x=1692295738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iU+C7JV6FbRgzBVC3R2lwvlAYCK7PTnMEPRpbCh3lQ4=;
 b=M6CorlAK1PovWAmhuq/m5wQp0mCtf0kWTHkNlShMq2XwRE4n3TdFIn3wZjEzV+Mjkf
 ICevO7up2EFNq4OihyjHs0JChL1XjLMHLkiJrcARBDojtpZfbD0yNGR6U/GFSovBpFFU
 JoW0sN0WHc2ywCPItzAUJovjt55lxZssFY52CpRLBZxWtDSAxiExpafXGqhtZtr4qYsR
 bDNzxd85LBNAF1BVjwPsbOfD1a40SC6W7Ug0UWbH7sKeuNEqflTnTsLp4PxmEJTxiTxA
 lFKiqrZBdnr3ACMcvAe73wzivSkHn9Gj/zoxSjBGo4dhmcxxi2mrRCPvGGPeNox8HGZP
 mrlA==
X-Gm-Message-State: AOJu0YyVVq602izMwga4nGZhC7l92xAkHAbzp1GaQTbOKzlnvfncj7Hx
 kT7RCCMuZOvt0nnwKczBFO2kBO4NjBVAKB9ta2g=
X-Google-Smtp-Source: AGHT+IG9CaD3itHY1VXsxUaoP/wll9eupisFYO/QWFELt+lNRDjEfS8WhUUaC30jFme5671xc50gVw==
X-Received: by 2002:a17:902:e741:b0:1bb:8e13:deba with SMTP id
 p1-20020a170902e74100b001bb8e13debamr3233468plf.11.1691690938381; 
 Thu, 10 Aug 2023 11:08:58 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:9e4d:b830:d4fd:9164])
 by smtp.gmail.com with ESMTPSA id
 b14-20020a170902b60e00b001bd41b70b65sm2085212pls.49.2023.08.10.11.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Aug 2023 11:08:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 gdb-patches@sourceware.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/4] gdbstub: don't complain about preemptive ACK chars
Date: Thu, 10 Aug 2023 11:08:52 -0700
Message-Id: <20230810180852.54477-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230810180852.54477-1-richard.henderson@linaro.org>
References: <20230810180852.54477-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

From: Alex Bennée <alex.bennee@linaro.org>

When starting a remote connection GDB sends an '+':

  /* Ack any packet which the remote side has already sent.  */
  remote_serial_write ("+", 1);

which gets flagged as a garbage character in the gdbstub state
machine. As gdb does send it out lets be permissive about the handling
so we can better see real issues.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Cc: gdb-patches@sourceware.org
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20230810153640.1879717-9-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/gdbstub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index 20b6fe03fb..5f28d5cf57 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -2074,6 +2074,11 @@ void gdb_read_byte(uint8_t ch)
                 gdbserver_state.line_buf_index = 0;
                 gdbserver_state.line_sum = 0;
                 gdbserver_state.state = RS_GETLINE;
+            } else if (ch == '+') {
+                /*
+                 * do nothing, gdb may preemptively send out ACKs on
+                 * initial connection
+                 */
             } else {
                 trace_gdbstub_err_garbage(ch);
             }
-- 
2.34.1


