Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F180871712
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Mar 2024 08:39:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhPMs-0006k1-L9; Tue, 05 Mar 2024 02:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPML-0006Hp-0C
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:13 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rhPMF-0005s6-UF
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 02:37:08 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dcd0431f00so33201445ad.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 23:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709624213; x=1710229013;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=47srLypA6/YZhwYJRpgA5+2zCaB4IopvknN5bNT/5jI=;
 b=Snuk7rs2nn/ipUN/T5TuuEf3KJo3EDwQlp1al66888IKImVQwXbKcvzjiapFhq39Ad
 kXrWOEGNPR/6rqcvXvWOiU4pIPAI7tDqUGf5MLqtzNyB9FL9eymONE25DcnGZLiSPmky
 syg15SVgKKYRGHgCo4Yv+reoM7Avb44+8g9rIZGn2fdMGctJkpawHMjM7n6fwRoxWLex
 v9iTNPEeP1/dp8IgzDwDdU+qkmUwUfJhMou0xd1cMxbULO4ElyxQ2rsyLmaD8VQ48pHn
 1MTErDFlCP+sldFnL+uJveqZR8acGd3cfwWT4dTxIq9QpKoC23FFD6gRiLJ+IRwuyeln
 4RYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709624213; x=1710229013;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47srLypA6/YZhwYJRpgA5+2zCaB4IopvknN5bNT/5jI=;
 b=pAvBH1/cxd/nOEN66edi4kXlAV/5MTt2RRrpfQdyW85I1W9eIf5KPYc9bOdqmNFUn8
 E9gonhtWxjgIq29okV8Gz4jMNsySJAQUdkjNizpKf88WJym6Yv+OvUrgfRaj4NtIcS8+
 OG5m6RoqqrSDCF5yKQGbG7WJmCXmjd8fpZsQyb41vUboO4o6cWHUAwN8+kBCLl3JuC0/
 IIknRyI6OmoEDV118hOHp3+kO1Tc+4FTnJat5f5MJtWEM3SyYCf8dIynhCBWEoFPZCaP
 erl2ZhRW3/pzTzhM8THCXDGp+Rf0tQzFqKPHyh2liORaubqvKH5WlyX9dMJIKh7GfROH
 1a2A==
X-Gm-Message-State: AOJu0YwZ3THsVru4kJ29RhFlD2itB0ACBdbZ41+wxLyWf8teWMitNO3+
 SrhNBpCANlSKZcE1Lq19M3OGwHDNE619cohglrYHmcwfQs4dHbpE7+cLj+cp3w071HsD92RJNvT
 H
X-Google-Smtp-Source: AGHT+IGJy11Yl/cTTakSnu0a8sZSO1jI+ZCpAY2/hS+zTr+xTkFC0seV2zLMAWbrUZ2ltFjCC33w7w==
X-Received: by 2002:a17:902:c181:b0:1dc:c0c8:6bfa with SMTP id
 d1-20020a170902c18100b001dcc0c86bfamr912945pld.17.1709624212884; 
 Mon, 04 Mar 2024 23:36:52 -0800 (PST)
Received: from localhost ([157.82.203.206])
 by smtp.gmail.com with UTF8SMTPSA id
 t3-20020a170902b20300b001db5e807cd2sm9786767plr.82.2024.03.04.23.36.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 23:36:52 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Tue, 05 Mar 2024 16:36:25 +0900
Subject: [PATCH v2 08/13] contrib/elf2dmp: Use lduw_le_p() to read PDB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240305-elf2dmp-v2-8-86ff2163ad32@daynix.com>
References: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
In-Reply-To: <20240305-elf2dmp-v2-0-86ff2163ad32@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This resolved UBSan warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/pdb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/elf2dmp/pdb.c b/contrib/elf2dmp/pdb.c
index 1c5051425185..492aca4434c8 100644
--- a/contrib/elf2dmp/pdb.c
+++ b/contrib/elf2dmp/pdb.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/bswap.h"
 
 #include "pdb.h"
 #include "err.h"
@@ -186,7 +187,7 @@ static bool pdb_init_symbols(struct pdb_reader *r)
 
     r->symbols = symbols;
 
-    r->segments = *(uint16_t *)((const char *)symbols + sizeof(PDB_SYMBOLS) +
+    r->segments = lduw_le_p((const char *)symbols + sizeof(PDB_SYMBOLS) +
             symbols->module_size + symbols->offset_size +
             symbols->hash_size + symbols->srcmodule_size +
             symbols->pdbimport_size + symbols->unknown2_size +

-- 
2.44.0


