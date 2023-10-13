Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAD17C7F92
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:09:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCw8-0004O9-KS; Fri, 13 Oct 2023 03:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCvx-0004Fx-P9
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:16 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCvi-00045p-Hh
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:02 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-325e9cd483eso1746180f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183391; x=1697788191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3SnoIpcz8PzllcxndXq3GJ2EOT2IcTPDKK2bNLd5KNY=;
 b=hqRr4PQfCV6iCNzV3mSYAjHw7NHjl4/GSoDO7VlgE4pYTllwunmX0L1GmgKSeCY8om
 Z+WmymhpcJFPurTAfoumTbZb/m0EGVTKrAR6oLXiS1k6aG1nNWm60kW0fdWVIUnE3/I5
 MkwCB0rTLwMTxfnn+VjyWZ53Lt8HjjdLlArKAUN5aKVkn95IApXaXZFXakmDLgDcGN/W
 3FZvQXbFvEqPIoW4ZaE0CcH18GUGdT+ISyAGfHZ9II5vW+ZWBfS8esgYxvWi1xLpasN7
 ILgirODejx5j8mkOSLX+vBaErCru4AOM9gBGUt5ALzSTMuM4GCPQzhqKS7aD/6pUgAud
 Fj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183391; x=1697788191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3SnoIpcz8PzllcxndXq3GJ2EOT2IcTPDKK2bNLd5KNY=;
 b=dUAwKiAsP3zT1e6Qnk2u2RRv74oomOVabC3h2pYp/udfn0dvzERj3yQJd93TMQUG2W
 jJdGtF9iwodQIsoYfhdT3RsDkNdH6Gjimw7GLG1LbNV4NlbNUoY83y/9lVeGL/hWappO
 SqRygSyG3LAhxkY6Urv2L1jER0L9p95sQeZI3FkZTSrteOd4Qlu5fMDqJstQmJ+FY6tM
 woYAzaXwJXLmJKWJQHK1ghvOWzE1B6EQNGUAFE7J3TpnJP3Ne9EMshePjySWCMhpAZCM
 odbSBnl8El0pVa9UzM12ZrCrUG+IYyZ3Q/RZz+BfphrkJ5LgtRdy3M8yrTGICh544CzM
 RUlA==
X-Gm-Message-State: AOJu0Yx2WSE2nx0scpWEtBcGEmkoR4m08gq+fDx+gLtwg5w0Y/hWhKyu
 VnZ49pRLfHqdBwMONoUXjiZWerPfPllnkH9d+oI=
X-Google-Smtp-Source: AGHT+IGuhXIHVMoXJHy3CIDKzcNuKfzEjA7lpg9he8mP4fp1iIG49JQdmA2joGBt5y/X0SKN3NA8Uw==
X-Received: by 2002:adf:edc3:0:b0:321:56af:5ef9 with SMTP id
 v3-20020adfedc3000000b0032156af5ef9mr19036438wro.70.1697183391732; 
 Fri, 13 Oct 2023 00:49:51 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:49:51 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>
Subject: [RFC PATCH 04/78] qapi/opts-visitor: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:08 +0300
Message-Id: <da9d0ba48a5be92f212e6bc04710803ca0ffa7b3.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


