Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED07F7CBAE4
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 08:19:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsdK2-0008Oe-Nw; Tue, 17 Oct 2023 02:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdK0-0008NE-Db
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:52 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qsdJy-0003pH-QS
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 02:12:52 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6be1bc5aa1cso1587059b3a.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697523169; x=1698127969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xd5Svu0+B7OGG++QiM45a02WgNYRHjpbrT0y5ShkAgs=;
 b=WfuHpglZnG5ZjPSh3W77/LCOpPSKW5xqHvPwZSTbDp8r3XKXmwyoRp0fLmTfPEUFOf
 tnicUqPl66+wOUkKCdsbX3o5/GSnbRDgleZXGVtSVpHgvWS4Ng2NYo1EcD4HJ3OHzxCc
 73GI93IiNBkTOMQZYvSYxZkpil9JHOJYqabFNREpByufby6sXok0CwHHd/7X5nL1gK8Q
 jkGrZXFQAnWUXb6o5Sy8ahLf6HT0j6ylD+acncDk88hz0wCBeBOwxKB0N4kqwPQFJpMX
 PfqGBTNc+cXn4w3xzlB1WKJ4z2W6J+2Tl+U/Ivza6q8UP783UBrwIraAK2KlzMvOL6wB
 W2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697523169; x=1698127969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xd5Svu0+B7OGG++QiM45a02WgNYRHjpbrT0y5ShkAgs=;
 b=hHJMrGKKgHzxt9EO+viNYkMyQtPBQbHBwB01VuVn9FFbA4b07k+Dn4+NAHCs8GOu0L
 4D7vo7teYjLlW9FqSHgiwI2g+bC0tsaHC7lAta2H/3IDPmdocLZYRKjzQ7dCr6BhyECr
 1iJIVSxmx2yBLgwLRJuWgvlzsEy0piytXX9UOLUtvLigSPFA7BnDLrL1eGHkTzunbg8Q
 ikP0kLdetBl+i1+EoWPitf76x0OEPiKNS2RukAq/m0Kwgb/gxtHya0CEsdclQ9kM2Bfc
 bh09m5P9U1uX3r8YscdorLl6Ug1ePkomFjm4MOYyqfQvQPQhW0xL86ivhdrIo7K4I26C
 +b7Q==
X-Gm-Message-State: AOJu0Ywg+jmtZzhEYr13mM1393gKz+eIrwauGJrTSty3IElu7Lv+0TAi
 JQvyRhMyKuLnARhxloWZIKBSHYXC5RA+ztoICek=
X-Google-Smtp-Source: AGHT+IGY8ypunH7Mv1IwJp1oldClYoriKdXXo588/0Iu/2IkpUO7FgOZKPkNCBlBrVB/yj3Nzer2UQ==
X-Received: by 2002:a05:6300:8086:b0:17a:de5d:1d7e with SMTP id
 ap6-20020a056300808600b0017ade5d1d7emr1201543pzc.55.1697523169292; 
 Mon, 16 Oct 2023 23:12:49 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf4-20020a170903268400b001ca21e05c69sm629150plb.109.2023.10.16.23.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 23:12:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/90] target/sparc: Set TCG_GUEST_DEFAULT_MO
Date: Mon, 16 Oct 2023 23:11:18 -0700
Message-Id: <20231017061244.681584-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231017061244.681584-1-richard.henderson@linaro.org>
References: <20231017061244.681584-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Always use TSO, per the Oracle 2015 manual.
This is slightly less restrictive than the TCG_MO_ALL default,
and happens to match the i386 model, which will eliminate a few
extra barriers on that host.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
index b3a98f1d74..9fc5c401d2 100644
--- a/target/sparc/cpu.h
+++ b/target/sparc/cpu.h
@@ -6,6 +6,29 @@
 #include "exec/cpu-defs.h"
 #include "qemu/cpu-float.h"
 
+/*
+ * From Oracle SPARC Architecture 2015:
+ *
+ *   Compatibility notes: The PSO memory model described in SPARC V8 and
+ *   SPARC V9 compatibility architecture specifications was never implemented
+ *   in a SPARC V9 implementation and is not included in the Oracle SPARC
+ *   Architecture specification.
+ *
+ *   The RMO memory model described in the SPARC V9 specification was
+ *   implemented in some non-Sun SPARC V9 implementations, but is not
+ *   directly supported in Oracle SPARC Architecture 2015 implementations.
+ *
+ * Therefore always use TSO in QEMU.
+ *
+ * D.5 Specification of Partial Store Order (PSO)
+ *   ... [loads] are followed by an implied MEMBAR #LoadLoad | #LoadStore.
+ *
+ * D.6 Specification of Total Store Order (TSO)
+ *   ... PSO with the additional requirement that all [stores] are followed
+ *   by an implied MEMBAR #StoreStore.
+ */
+#define TCG_GUEST_DEFAULT_MO  (TCG_MO_LD_LD | TCG_MO_LD_ST | TCG_MO_ST_ST)
+
 #if !defined(TARGET_SPARC64)
 #define TARGET_DPREGS 16
 #else
-- 
2.34.1


