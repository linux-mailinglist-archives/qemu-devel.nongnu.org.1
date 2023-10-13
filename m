Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDB27C80DF
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqE-000877-T7; Fri, 13 Oct 2023 04:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpo-0007dr-9v
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:52 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpd-0000pS-Oi
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:50 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-50435ad51bbso2376125e87.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186860; x=1697791660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Sb0AkXc3iSRCYbmQ6GfBzID/AYMY87FUGFWi3MqqMQ=;
 b=Gd5tVcG3+6YY+EXRHgN21ofKvRVl9Icu99AupvwpfugVxFIt22MyqG+y5DuLOecSPz
 KdlL4pWTfF1la66qnbslOWKfd7vv/VYrzDr3nZfSko5bam8EfBFVTTNN/4XCJYePywg2
 QTu1qfGw6qdght64PcYYVnukcej5xPMkGG4YX5AyxMBOmJVOoXjhmgTWMh6TFkNSVhww
 pVRsGG+ZMxzcJGokc6gzX931fsc9bbvEs6a0Tedbbn5/OMGYxZa3xwB6xQrjjCJFH7Kn
 fsjdxJ63p9zztoznmDEOBDs2V0bubxnJBvpyUR9+aw/y1IAJczWOeiAN7j2JF6NHsXE1
 NVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186860; x=1697791660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Sb0AkXc3iSRCYbmQ6GfBzID/AYMY87FUGFWi3MqqMQ=;
 b=Y1KoZlyWx/12uRcCwG6mNeAOB7kBWvwqLqeyArlI5s5PWa49BdA2lCaPSNlBF1g9LY
 NRyANF90Ufz8J/2kT5gyDuDbAfdXwsWR82IWMOOur0ht17Ehkzhta/33HXQqsW7UWz+E
 AzN2Q9MRUz0ttf9XRMJEtZGTMFknb9arHrqG6J+QFWY6LOTP1rbDMAJOgoPsKR885aa1
 1+0O+Rp1Eb5/p+BSmrhsmgEyJV6UAeBrIlMyLINSe9ZgEqrjfq+BKlsfn6cRUHImGu0r
 98pnCxFZ4TtPkloiKfpYbXaN44ivxlRANJ2zSfHzdMZR2RCt5h3zYvzXQXVWrPQ9jF+a
 wRww==
X-Gm-Message-State: AOJu0YxrspEl0h4Z0YuxOCU2yqSWHg4Hq01258bSx13AjCXxvAribRPU
 d0DOPUQp6Y1kmRYboAX/2Y82/5DsCsgmr2pUJzU=
X-Google-Smtp-Source: AGHT+IGHM5zPuHmLG9VcbCu7Wq1Aza2blTzXbcC2q6zQRsuXQ0k3mE4t2q8D81D4kdIIek7w6tfyWw==
X-Received: by 2002:a05:6512:1154:b0:505:6cc7:e0f7 with SMTP id
 m20-20020a056512115400b005056cc7e0f7mr26801205lfg.44.1697186859923; 
 Fri, 13 Oct 2023 01:47:39 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:39 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [RFC PATCH v3 15/78] accel/tcg: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:43 +0300
Message-Id: <40e1a5781ec924302f09c279707c97615d7cb23b.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x136.google.com
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
 accel/tcg/cputlb.c             | 4 ++--
 accel/tcg/ldst_atomicity.c.inc | 2 +-
 accel/tcg/plugin-gen.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b8c5e345b8..92b7ab529a 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -2244,7 +2244,7 @@ static uint64_t do_ld_beN(CPUState *cpu, MMULookupPageData *p,
                 return do_ld_whole_be8(cpu, ra, p, ret_be);
             }
         }
-        /* fall through */
+        fallthrough;
 
     case MO_ATOM_IFALIGN:
     case MO_ATOM_WITHIN16:
@@ -2664,7 +2664,7 @@ static uint64_t do_st_leN(CPUState *cpu, MMULookupPageData *p,
                 cpu_loop_exit_atomic(cpu, ra);
             }
         }
-        /* fall through */
+        fallthrough;
 
     case MO_ATOM_IFALIGN:
     case MO_ATOM_WITHIN16:
diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
index 1cf5b92166..3752f74214 100644
--- a/accel/tcg/ldst_atomicity.c.inc
+++ b/accel/tcg/ldst_atomicity.c.inc
@@ -41,7 +41,7 @@ static int required_atomicity(CPUState *cpu, uintptr_t p, MemOp memop)
 
     case MO_ATOM_IFALIGN_PAIR:
         size = half;
-        /* fall through */
+        fallthrough;
 
     case MO_ATOM_IFALIGN:
         tmp = (1 << size) - 1;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index d31c9993ea..ba9a8c8789 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -190,7 +190,7 @@ static void plugin_gen_empty_callback(enum plugin_gen_from from)
          */
         gen_wrapped(from, PLUGIN_GEN_ENABLE_MEM_HELPER,
                     gen_empty_mem_helper);
-        /* fall through */
+        fallthrough;
     case PLUGIN_GEN_FROM_TB:
         gen_wrapped(from, PLUGIN_GEN_CB_UDATA, gen_empty_udata_cb);
         gen_wrapped(from, PLUGIN_GEN_CB_INLINE, gen_empty_inline_cb);
-- 
2.39.2


