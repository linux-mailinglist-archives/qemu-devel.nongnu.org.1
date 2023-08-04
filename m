Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB62770BA5
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 00:02:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qS2r4-0004mf-G5; Fri, 04 Aug 2023 18:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qi-0004X5-HX
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:46 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qS2qe-0001hv-9F
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 18:00:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6874d1c8610so1992198b3a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 15:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691186437; x=1691791237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PGTKa1g9aGwPuG4tk4crlE1qhIW/f2V62gcPYilpvuU=;
 b=s9cAvl0v4H4zwkHp1GZ77ZUqutqZYy1YF9LPPySv8NJK1+jttVkJxaKyoWghoOrhE5
 N45bFSSOu3VJ4goYkIdbm/T3D/lasAS4AwZ+YBXzoBLbV9/9RpGGsQTAeu64H65VOGrk
 5B1+ZlEpelpnHdmObccylzhTtu9d7RpNxGsHcazfbxR4Q5vpXjF+yd7aK5GyuqyAWGbT
 XgfWAK16jY06hwp8CO/r6bHlaV4ZokQpSVyT9f4hGV4lu1fZEn49hqa4+2LRSSlkQfM/
 lopJvU3opo2NWuw8cVB/LgA22PdtDjqmg5ikr5TW9ftHMLrmC94sVCTF/MTV9FSGZgUh
 TeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691186437; x=1691791237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PGTKa1g9aGwPuG4tk4crlE1qhIW/f2V62gcPYilpvuU=;
 b=S4PsaJ9T0q01esMDTOaUjajFfvc7RxYRdB33MUUosep0Crnz+LCh2GGclTTZG5HEES
 proDXhivkkDIFa6yEf+zHSCvIJDfmsvzDo/gc0lPusA26NYTLlFBRatYhDUoIEH5vddc
 ONQGp6EwSustdn7VM8ZW2DD3EcZ/F3rp0OEnEoD9Mt/Gf6aJmy8hOzItIbegcMY50VM5
 h+BJznyhnWY/Q/7ZbEedWjskEvn28ysV8duCLL2yIga6zUa7ufeIAHUU8RX2k6S8w59H
 wdlxGgbjpHovGG8RM0H2Pf7m551xlysnunwcdWmweGwLxMvECAnaGgiz9/Z0axYBbfig
 HpnA==
X-Gm-Message-State: AOJu0YwCbJc67VSO++Hlum653H5KOXfpl8JPPT6OBf+b6hiCgsyoV4+B
 ICXUlFsNZFgdVrzqLHH++bd8SQ2EO0r3Qq/9xj0=
X-Google-Smtp-Source: AGHT+IGybyUU1dJU0XPYU0BYXNuf1Sl9Qc2NvYjRHbge/8qmYWCuS8uEl7wSJ9JSbyTsIrQ0Qu+3xQ==
X-Received: by 2002:a05:6a21:3b49:b0:140:2805:6cc8 with SMTP id
 zy9-20020a056a213b4900b0014028056cc8mr1277625pzb.27.1691186437430; 
 Fri, 04 Aug 2023 15:00:37 -0700 (PDT)
Received: from stoup.. ([2602:47:d490:6901:1eed:f77f:f320:8b14])
 by smtp.gmail.com with ESMTPSA id
 u1-20020a17090282c100b001bbf7fd354csm2185568plz.213.2023.08.04.15.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Aug 2023 15:00:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v9 04/24] gdbstub: use 0 ("any process") on packets with no PID
Date: Fri,  4 Aug 2023 15:00:12 -0700
Message-Id: <20230804220032.295411-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804220032.295411-1-richard.henderson@linaro.org>
References: <20230804220032.295411-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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


