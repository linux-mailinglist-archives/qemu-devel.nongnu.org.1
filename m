Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F8377136D
	for <lists+qemu-devel@lfdr.de>; Sun,  6 Aug 2023 05:39:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSUa5-0003cu-8c; Sat, 05 Aug 2023 23:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa2-0003Zt-6S
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:22 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qSUa0-0007WF-KK
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 23:37:21 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-26854159c05so1828867a91.2
 for <qemu-devel@nongnu.org>; Sat, 05 Aug 2023 20:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691293039; x=1691897839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGTKa1g9aGwPuG4tk4crlE1qhIW/f2V62gcPYilpvuU=;
 b=eRiAju0gWTsQuqYxsso8xl9xzggXxTNAthvnXoONu8Tuh9SHwwk25DNtJhb0hJALrC
 aki3q16tBtJTrgm+AOUwqkedhD/TH0q9UTQ9tC1PUCPPrQYJWIlOJcv6995zPR7ie3Sf
 y3OsuEvKI1ePtLM2qeqxfuH+6RLQDk77Oe0jfU4pbakcnVOqvYiFHFm6Tb14hK23z3Wd
 0QuDjtLcg4YAGc5bZknZJb2B/M24M0zz4Hb0SaRMh0Sn+FVfY5atfJpbdqxU0Z+nHtku
 52EEL7RxwuRAIy5qnCnmI5+isRqNMEg7EOZh6BtsL58Sg9PawMim+yNs0Gvs0xDcT/oI
 4mSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691293039; x=1691897839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGTKa1g9aGwPuG4tk4crlE1qhIW/f2V62gcPYilpvuU=;
 b=e3xCvMPR2QvU0ZoGjkYvZTlhoRm648rtGIx0WjljAHXtdkKetNwuPOZLKnGFGyoX3z
 ak5ZjbpAy1sEYnAwsJiY7kZSU/igRUHaMxX7L8OKqL9MaR1vOFscM+dtnTy5C6sNTTvk
 GTuQM1XwspzMFcjsXoQ/KcHyTmTP7JaLTEhahUAAdR6z8L/7AmhQNHYIc6WlrWK0pD4A
 u1CuhJ7RmnDtNT8WT23KhM84VzBm9FTJxvUEt9CoVXvKlngWjjjdsyj38CK7fLzSqejP
 Nr/KZIVX7sc5tTQ/83nSthD0WfaYyGWGMEVOKfPn5tcNtyxkIzWJxHiFoM6zaqCby7UR
 AoLg==
X-Gm-Message-State: AOJu0YzdClTiHQKhw0n2b892g2EYbMWC6iRvUq9LfYB/NI+rHu/vKoKR
 XZm3XYFiIamDvnLeqeNwzKly/GmvGazZ2sGl178=
X-Google-Smtp-Source: AGHT+IHHqj25PBS6MqXuKhJib7gt07jZ9oWhAQjMND0nRS2crPcjSavNHl4aRvVNwLyPxbOMHlFT7A==
X-Received: by 2002:a17:90b:3755:b0:263:fc43:5f39 with SMTP id
 ne21-20020a17090b375500b00263fc435f39mr4295795pjb.13.1691293039417; 
 Sat, 05 Aug 2023 20:37:19 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:9454:a46f:1c22:a7c6])
 by smtp.gmail.com with ESMTPSA id
 a5-20020a17090a740500b00262e604724dsm6306451pjg.50.2023.08.05.20.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Aug 2023 20:37:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 04/24] gdbstub: use 0 ("any process") on packets with no PID
Date: Sat,  5 Aug 2023 20:36:55 -0700
Message-Id: <20230806033715.244648-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230806033715.244648-1-richard.henderson@linaro.org>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>

Previously, qemu-user would always report PID 1 to GDB. This was changed
at dc14a7a6e9 (gdbstub: Report the actual qemu-user pid, 2023-06-30),
but read_thread_id() still considers GDB packets with "no PID" as "PID
1", which is not the qemu-user PID. Fix that by parsing "no PID" as "0",
which the GDB Remote Protocol defines as "any process".

Note that this should have no effect for system emulation as, in this
case, gdb_create_default_process() will assign PID 1 for the first
process and that is what the gdbstub uses for GDB requests with no PID,
or PID 0.

This issue was found with hexagon-lldb, which sends a "Hg" packet with
only the thread-id, but no process-id, leading to the invalid usage of
"PID 1" by qemu-hexagon and a subsequent "E22" reply.

Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Message-Id: <78a3b06f6ab90a7ff8e73ae14a996eb27ec76c85.1690904195.git.quic_mathbern@quicinc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 gdbstub/gdbstub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index ce8b42eb15..e74ecc78cc 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -537,7 +537,7 @@ static GDBThreadIdKind read_thread_id(const char *buf, const char **end_buf,
         /* Skip '.' */
         buf++;
     } else {
-        p = 1;
+        p = 0;
     }
 
     ret = qemu_strtoul(buf, &buf, 16, &t);
-- 
2.34.1


