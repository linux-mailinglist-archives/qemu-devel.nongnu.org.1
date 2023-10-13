Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4257C7FF1
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:21:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyP-0003Nm-KP; Fri, 13 Oct 2023 03:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxg-000054-82
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:56 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxP-0005AX-1n
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:55 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40537481094so19558555e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183497; x=1697788297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qbwPqKejPqCfjx3i0hAQng1S5moLMZkGirk9RhHcbns=;
 b=SlPQ21WPhJwIWURQS8kqkMImWwdbfw4oGQ9WN0ijiBc8Yqa0UZAYcvq1DqIxGlnJkT
 S6y+fSznRa11xpUFtLPZL1qKSYUHL4bkfP41gOxwc8YquVg29CTpF/+oAGShIXDltfCk
 Cu1OMpVSiskGQLD28rigO3xg3MGZ6+mQ1IZhhfaX7GdNc+RtK3FP75iHSFm86IBuhNUf
 V8Ega2J0mTUGx9ZHFQLt/qnVtn4BSB5lRE+bXj7Ixm86vah5gZBrnIre8zuCacfNKu4F
 hEUvGcnL4A3aEe6Gm9pVhBls9pKbZcBZjNQDSuuKTS6frEmI9zH9fHUGQzLRxQtTpX6T
 DKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183497; x=1697788297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qbwPqKejPqCfjx3i0hAQng1S5moLMZkGirk9RhHcbns=;
 b=UF5rHVHqqsdRA23vegnPhTwz/me+Yy4ZtG+bV0zTTQnKhhbNCYW0WVD128XUcL4G2H
 u+CQFJyoZC+Nx29LMYihgEaz8L2fv0B7ITs6dnCki2FR75WZbSNgIksYfgqja1FsmBZU
 lqo3BS2THbSDgx+HXK67CR/oBNLSVTrpLyhffWuAcM9NHQ0Mez5XUAWltGX13IDoSDZq
 SDZrKWCyGbATLll4S/AD6k02i3wL7IHcry9489P89V2nxrxjd/+VYZpiOrHEsVnLwrFA
 ZpqkoBDJ77qZZt2nK/R+Z/G27qbdn2ljgJJVCz+DMtrIIdlIbmycfmr+8kMDNzKqaERo
 WLvQ==
X-Gm-Message-State: AOJu0Yz3yBlCepDI2iI25ZBrxNhMYK4QjkF9rOECTjz5P6DuW4zw3Brs
 Acdt7XYTKBvYK02krZPK6oWBeKX0H54oLxnG9lI=
X-Google-Smtp-Source: AGHT+IG4megVYdbdLkMXZmzi2g4UzHjW2key7fBPtxr037QQePGzaaovX0SM6OAk9cz60PMZPijxIg==
X-Received: by 2002:a1c:6a0d:0:b0:3fc:1a6:7764 with SMTP id
 f13-20020a1c6a0d000000b003fc01a67764mr23258413wmc.16.1697183496749; 
 Fri, 13 Oct 2023 00:51:36 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:35 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 47/78] contrib/rdmacm-mux: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:48:01 +0300
Message-Id: <79d156347f37b8f4984e52ebb3063604093ae8f4.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 contrib/rdmacm-mux/main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/rdmacm-mux/main.c b/contrib/rdmacm-mux/main.c
index 771ca01e03..dda6917d58 100644
--- a/contrib/rdmacm-mux/main.c
+++ b/contrib/rdmacm-mux/main.c
@@ -303,72 +303,72 @@ static void hash_tbl_remove_fd_ifid_pair(int fd)
 static int get_fd(const char *mad, int umad_len, int *fd, __be64 *gid_ifid)
 {
     struct umad_hdr *hdr = (struct umad_hdr *)mad;
     char *data = (char *)hdr + sizeof(*hdr);
     int32_t comm_id = 0;
     uint16_t attr_id = be16toh(hdr->attr_id);
     int rc = 0;
 
     if (umad_len <= sizeof(*hdr)) {
         rc = -EINVAL;
         syslog(LOG_DEBUG, "Ignoring MAD packets with header only\n");
         goto out;
     }
 
     switch (attr_id) {
     case UMAD_CM_ATTR_REQ:
         if (unlikely(umad_len < sizeof(*hdr) + CM_REQ_DGID_POS +
             sizeof(*gid_ifid))) {
             rc = -EINVAL;
             syslog(LOG_WARNING,
                    "Invalid MAD packet size (%d) for attr_id 0x%x\n", umad_len,
                     attr_id);
             goto out;
         }
         memcpy(gid_ifid, data + CM_REQ_DGID_POS, sizeof(*gid_ifid));
         rc = hash_tbl_search_fd_by_ifid(fd, gid_ifid);
         break;
 
     case UMAD_CM_ATTR_SIDR_REQ:
         if (unlikely(umad_len < sizeof(*hdr) + CM_SIDR_REQ_DGID_POS +
             sizeof(*gid_ifid))) {
             rc = -EINVAL;
             syslog(LOG_WARNING,
                    "Invalid MAD packet size (%d) for attr_id 0x%x\n", umad_len,
                     attr_id);
             goto out;
         }
         memcpy(gid_ifid, data + CM_SIDR_REQ_DGID_POS, sizeof(*gid_ifid));
         rc = hash_tbl_search_fd_by_ifid(fd, gid_ifid);
         break;
 
     case UMAD_CM_ATTR_REP:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_REJ:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_DREQ:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_DREP:
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_RTU:
         data += sizeof(comm_id);
-        /* Fall through */
+        fallthrough;
     case UMAD_CM_ATTR_SIDR_REP:
         if (unlikely(umad_len < sizeof(*hdr) + sizeof(comm_id))) {
             rc = -EINVAL;
             syslog(LOG_WARNING,
                    "Invalid MAD packet size (%d) for attr_id 0x%x\n", umad_len,
                    attr_id);
             goto out;
         }
         memcpy(&comm_id, data, sizeof(comm_id));
         if (comm_id) {
             rc = hash_tbl_search_fd_by_comm_id(comm_id, fd, gid_ifid);
         }
         break;
 
     default:
         rc = -EINVAL;
         syslog(LOG_WARNING, "Unsupported attr_id 0x%x\n", attr_id);
     }
 
     syslog(LOG_DEBUG, "mad_to_vm: %d 0x%x 0x%x\n", *fd, attr_id, comm_id);
-- 
2.39.2


