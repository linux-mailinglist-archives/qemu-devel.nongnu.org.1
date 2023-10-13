Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C257C8015
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:24:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD5i-0007zN-A0; Fri, 13 Oct 2023 04:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5L-0007nw-AC
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:52 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD5F-0007Ls-5J
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:59:51 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4054f790190so20948655e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183983; x=1697788783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8d0EXOV7KkXlxH+2K4IEwUGnGFtgljFry1hA0vZtzXU=;
 b=gEV3B2HyogBILNLTOYzJXhfvh6Xl+kBerzuwSB4p4GlIkPgVPNwo1O7Prf4YnIPfxG
 +KYfgTFJdKMGqX6h3LXu4Gl2/kL9h5a2PLmzL8YtyRqbjpEe+B7pIE737n6soqfukfic
 SgxSy52dgIrX2MuTfKl6AZWGDyrodyPTJv555WQAl4+pwvZrv98RuAtw48lFokpg67SL
 Ip4263rOhZOhS4HPRfIVS6AboozNNiyUC09o8cxlaM2uInbZmbt238Z6OA15LV7/4Jew
 RWctYJ9mzlKCg/jcM0BmQM2kDqghi0jPuLfJ+m58N0NydVZO9hya2ISA8aI2PBjf2BXw
 M0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183983; x=1697788783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8d0EXOV7KkXlxH+2K4IEwUGnGFtgljFry1hA0vZtzXU=;
 b=E8y3JrF1SaqUlIAAyS4Ld6VMiHzhg2uhS52TNXasKb5vFXslXwpv/DUHtM6FhSuTQv
 Vu1+8tMIHZ3qHzlEy6UfGhyvBCEfNFkZaRd3H/euHq0IBJZiegfXoN8MuuMIs7MkVZVl
 0/f1LGYs97CpRQ7KZJGCtKUrFJHD20yyAdOo/8EB6X3b5GqjdN+k6hXBxHIIljpGfIk5
 /CCbIOaQwCg6KyqYNGhUbf+Zr2TqgulMzdSKYLwe+Lo3U3DitkanSlMz645J+6jjhXaz
 ReMD6wR6B3VBqAIYOyePurvbtaXqLl4SHvaCl0GN0isycp4APRLFuvxk+yVGCBqUp6qH
 tKRw==
X-Gm-Message-State: AOJu0YzvZX4j+R+ASdDdb9J1eiIJRvabRWEU2e/rLxJ0gV52tHp4D3W1
 vlzxRp4PXawkOX3LlvNiJw9XLbEM40eLnUTuPWk=
X-Google-Smtp-Source: AGHT+IFjgv/EeX+6+QvUSBlYCWQErFz89d6jHk7LHWc3dFRwQv5vqTZSYWcj0N27OBfQAb2TV+tNTA==
X-Received: by 2002:a7b:c391:0:b0:405:359a:c950 with SMTP id
 s17-20020a7bc391000000b00405359ac950mr22357580wmj.19.1697183983524; 
 Fri, 13 Oct 2023 00:59:43 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:59:42 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [RFC PATCH v2 60/78] qga: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:57:27 +0300
Message-Id: <4af9c55f0b548bd4df233dc3aeb2bd34efb8929f.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x335.google.com
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
 qga/main.c                  | 2 +-
 qga/vss-win32/requester.cpp | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index 8668b9f3d3..40471e8a0b 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -644,37 +644,37 @@ end:
 /* false return signals GAChannel to close the current client connection */
 static gboolean channel_event_cb(GIOCondition condition, gpointer data)
 {
     GAState *s = data;
     gchar buf[QGA_READ_COUNT_DEFAULT + 1];
     gsize count;
     GIOStatus status = ga_channel_read(s->channel, buf, QGA_READ_COUNT_DEFAULT, &count);
     switch (status) {
     case G_IO_STATUS_ERROR:
         g_warning("error reading channel");
         stop_agent(s, false);
         return false;
     case G_IO_STATUS_NORMAL:
         buf[count] = 0;
         g_debug("read data, count: %d, data: %s", (int)count, buf);
         json_message_parser_feed(&s->parser, (char *)buf, (int)count);
         break;
     case G_IO_STATUS_EOF:
         g_debug("received EOF");
         if (!s->virtio) {
             return false;
         }
-        /* fall through */
+        fallthrough;
     case G_IO_STATUS_AGAIN:
         /* virtio causes us to spin here when no process is attached to
          * host-side chardev. sleep a bit to mitigate this
          */
         if (s->virtio) {
             g_usleep(G_USEC_PER_SEC / 10);
         }
         return true;
     default:
         g_warning("unknown channel read status, closing");
         return false;
     }
     return true;
 }
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 9884c65e70..36fa4fdf28 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -563,72 +563,73 @@ out1:
 void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
 {
     qga_debug_begin;
     COMPointer<IVssAsync> pAsync;
 
     if (!vss_ctx.hEventThaw) {
         /*
          * In this case, DoSnapshotSet is aborted or not started,
          * and no volumes must be frozen. We return without an error.
          */
         *num_vols = 0;
         qga_debug("finished, no volumes were frozen");
 
         return;
     }
 
     /* Tell the provider that the snapshot is finished. */
     SetEvent(vss_ctx.hEventThaw);
 
     assert(vss_ctx.pVssbc);
     assert(vss_ctx.pAsyncSnapshot);
 
     HRESULT hr = WaitForAsync(vss_ctx.pAsyncSnapshot);
     switch (hr) {
     case VSS_S_ASYNC_FINISHED:
         hr = vss_ctx.pVssbc->BackupComplete(pAsync.replace());
         if (SUCCEEDED(hr)) {
             hr = WaitForAsync(pAsync);
         }
         if (FAILED(hr)) {
             err_set(errset, hr, "failed to complete backup");
         }
         break;
 
     case (HRESULT)VSS_E_OBJECT_NOT_FOUND:
         /*
          * On Windows earlier than 2008 SP2 which does not support
          * VSS_VOLSNAP_ATTR_NO_AUTORECOVERY context, the final commit is not
          * skipped and VSS is aborted by VSS_E_OBJECT_NOT_FOUND. However, as
          * the system had been frozen until fsfreeze-thaw command was issued,
          * we ignore this error.
          */
         vss_ctx.pVssbc->AbortBackup();
         break;
 
     case VSS_E_UNEXPECTED_PROVIDER_ERROR:
         if (WaitForSingleObject(vss_ctx.hEventTimeout, 0) != WAIT_OBJECT_0) {
             err_set(errset, hr, "unexpected error in VSS provider");
             break;
         }
         /* fall through if hEventTimeout is signaled */
+        fallthrough;
 
     case (HRESULT)VSS_E_HOLD_WRITES_TIMEOUT:
         err_set(errset, hr, "couldn't hold writes: "
                 "fsfreeze is limited up to 10 seconds");
         break;
 
     default:
         err_set(errset, hr, "failed to do snapshot set");
     }
 
     if (err_is_set(errset)) {
         vss_ctx.pVssbc->AbortBackup();
     }
     *num_vols = vss_ctx.cFrozenVols;
     requester_cleanup();
 
     CoUninitialize();
     StopService();
 
     qga_debug_end;
 }
-- 
2.39.2


