Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B80017C7F29
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:59:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD3j-00070C-OP; Fri, 13 Oct 2023 03:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3g-0006nM-AU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3d-0006j3-3H
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:08 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-405361bb94eso21989315e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183883; x=1697788683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SnoIpcz8PzllcxndXq3GJ2EOT2IcTPDKK2bNLd5KNY=;
 b=jFIH88IlS2gUNIkAl9wOZKjCmL1YcKdS0lY2F9s23ZsZOzYZgnGygW9kkxmavrapMn
 qEmi72dVNm0dpiSRn7fUmpLJbhXCD7BT9SqbGWmBEGTow5umMqwuwY1ZEzan+kfD9Nqu
 gYbAZdKzCFpB5XPasbiKIcpf6DBPQn33I6T2XR6Ev6OqqVsEBU/kT7bDcu/4Gpvp4qnX
 8aRg71BtvOsLmwHU3vZMB4dWHTyhPolRM7dNAszmQwqmT0IDSOtOwPcWPUcUzkQAF/NK
 3bJZl3vvCygPkTvnWhb4c0w8B/V/1SFTVYH9b7DRYAbad/WyQPk3DnHnKqlU9ljT/qDF
 2zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183883; x=1697788683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3SnoIpcz8PzllcxndXq3GJ2EOT2IcTPDKK2bNLd5KNY=;
 b=jHJ/rvQjNwLGlFWOGzOwYnh7Jeivez2Ml9+0WylFNLVoziTDSNwRrT+/guGzFl69cu
 t8cBwVrPgW01DzNS2zAtycvQwKA7GBGQ583ZRFKUPo8o8gvyO8cpYDy/gBR3xEAkR6mB
 k4ix6iuHMC4WbS8MwJN5SlYXA+42MzMDEWiLD+9gosZSz60Wz3/AZJagEVIO2s2o+jm1
 pxG5MhDUGqM4p62C+Zli6PRCsO3Sbed3UFy10Pi2P7DjoP8HzACKrm9Kbl0H7HqzXp0l
 YlGDT7tw8oCxqlCHocXud9t+S7ziVLebD3hFNZ1yXQdyRmo/RWu6I6YEcmlSyxDnHijO
 nuDQ==
X-Gm-Message-State: AOJu0Yx8hGsogw/khNgUgpXzEqI1xPDHdys35p8C+wAjabUiOzZQgl0X
 BNYTg5f3QR4NNu2iVPsExB048K/bsmWQfxnHTfU=
X-Google-Smtp-Source: AGHT+IHYnn7X+z4WODAmIPaCDR2OUtawHiiqq7uGu9USAEWV3Zy0nzYiVg3tdMm8o99OAh9YnfSOCQ==
X-Received: by 2002:a7b:cb96:0:b0:406:53e4:4d23 with SMTP id
 m22-20020a7bcb96000000b0040653e44d23mr23446026wmi.23.1697183883291; 
 Fri, 13 Oct 2023 00:58:03 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:02 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [RFC PATCH v2 04/78] qapi/opts-visitor: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:31 +0300
Message-Id: <da9d0ba48a5be92f212e6bc04710803ca0ffa7b3.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x32d.google.com
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 qapi/opts-visitor.c         | 1 +
 qapi/string-input-visitor.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
index 8f1efab8b9..d7376bf239 100644
--- a/qapi/opts-visitor.c
+++ b/qapi/opts-visitor.c
@@ -249,41 +249,42 @@ static GenericList *
 opts_next_list(Visitor *v, GenericList *tail, size_t size)
 {
     OptsVisitor *ov = to_ov(v);
 
     switch (ov->list_mode) {
     case LM_TRAVERSED:
         return NULL;
     case LM_SIGNED_INTERVAL:
     case LM_UNSIGNED_INTERVAL:
         if (ov->list_mode == LM_SIGNED_INTERVAL) {
             if (ov->range_next.s < ov->range_limit.s) {
                 ++ov->range_next.s;
                 break;
             }
         } else if (ov->range_next.u < ov->range_limit.u) {
             ++ov->range_next.u;
             break;
         }
         ov->list_mode = LM_IN_PROGRESS;
         /* range has been completed, fall through in order to pop option */
+        fallthrough;
 
     case LM_IN_PROGRESS: {
         const QemuOpt *opt;
 
         opt = g_queue_pop_head(ov->repeated_opts);
         if (g_queue_is_empty(ov->repeated_opts)) {
             g_hash_table_remove(ov->unprocessed_opts, opt->name);
             ov->repeated_opts = NULL;
             ov->list_mode = LM_TRAVERSED;
             return NULL;
         }
         break;
     }
 
     default:
         abort();
     }
 
     tail->next = g_malloc0(size);
     return tail->next;
 }
diff --git a/qapi/string-input-visitor.c b/qapi/string-input-visitor.c
index 197139c1c0..1ce43da20b 100644
--- a/qapi/string-input-visitor.c
+++ b/qapi/string-input-visitor.c
@@ -182,41 +182,41 @@ static int try_parse_int64_list_entry(StringInputVisitor *siv, int64_t *obj)
 static bool parse_type_int64(Visitor *v, const char *name, int64_t *obj,
                              Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
     int64_t val;
 
     switch (siv->lm) {
     case LM_NONE:
         /* just parse a simple int64, bail out if not completely consumed */
         if (qemu_strtoi64(siv->string, NULL, 0, &val)) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE,
                        name ? name : "null", "int64");
             return false;
         }
         *obj = val;
         return true;
     case LM_UNPARSED:
         if (try_parse_int64_list_entry(siv, obj)) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
                        "list of int64 values or ranges");
             return false;
         }
         assert(siv->lm == LM_INT64_RANGE);
-        /* fall through */
+        fallthrough;
     case LM_INT64_RANGE:
         /* return the next element in the range */
         assert(siv->rangeNext.i64 <= siv->rangeEnd.i64);
         *obj = siv->rangeNext.i64++;
 
         if (siv->rangeNext.i64 > siv->rangeEnd.i64 || *obj == INT64_MAX) {
             /* end of range, check if there is more to parse */
             siv->lm = siv->unparsed_string[0] ? LM_UNPARSED : LM_END;
         }
         return true;
     case LM_END:
         error_setg(errp, "Fewer list elements expected");
         return false;
     default:
         abort();
     }
 }
@@ -272,41 +272,41 @@ static int try_parse_uint64_list_entry(StringInputVisitor *siv, uint64_t *obj)
 static bool parse_type_uint64(Visitor *v, const char *name, uint64_t *obj,
                               Error **errp)
 {
     StringInputVisitor *siv = to_siv(v);
     uint64_t val;
 
     switch (siv->lm) {
     case LM_NONE:
         /* just parse a simple uint64, bail out if not completely consumed */
         if (qemu_strtou64(siv->string, NULL, 0, &val)) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
                        "uint64");
             return false;
         }
         *obj = val;
         return true;
     case LM_UNPARSED:
         if (try_parse_uint64_list_entry(siv, obj)) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, name ? name : "null",
                        "list of uint64 values or ranges");
             return false;
         }
         assert(siv->lm == LM_UINT64_RANGE);
-        /* fall through */
+        fallthrough;
     case LM_UINT64_RANGE:
         /* return the next element in the range */
         assert(siv->rangeNext.u64 <= siv->rangeEnd.u64);
         *obj = siv->rangeNext.u64++;
 
         if (siv->rangeNext.u64 > siv->rangeEnd.u64 || *obj == UINT64_MAX) {
             /* end of range, check if there is more to parse */
             siv->lm = siv->unparsed_string[0] ? LM_UNPARSED : LM_END;
         }
         return true;
     case LM_END:
         error_setg(errp, "Fewer list elements expected");
         return false;
     default:
         abort();
     }
 }
-- 
2.39.2


