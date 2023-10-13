Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C468F7C7F3A
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:01:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCyU-0003fp-GB; Fri, 13 Oct 2023 03:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxX-0007LJ-5Q
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:47 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCxK-00058U-QE
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:51:46 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-32d80ae19f8so1478869f8f.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183492; x=1697788292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XyvoLQsYBwCacSjXMUeo1JDpYe89rtdX65GHrpNFkEk=;
 b=w4bv00WcV/vKtkCuEHhNiPEkWvQtiRMezLkKwYWO3HAGT2xdnMNlkm1IaOFmSNGKXl
 MOS+eFLbt8rd6fwMzpo9vDGZmlnFVUp6pMWJRBEp7BPJxiKYthP85maEU9wOygoCcCsK
 +1Gd1FQwpDMdsnsbJy6IWws/zMwCJNASUXDaNwyZ44AGVVepIreXWcIDuBxyreob740N
 MYKRcey8iJZfayQ5ptHQ+oKxoU5PIBFiB5W871t/ngxdQeERSggNbShIxZtlDvlEpFYM
 cntKQ7Zmje+s+exgsyhr1qxwtZnMXtt4XmLwvQarnlO01GD+6ngNSJP8XwaVm1vVMIsF
 VOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183492; x=1697788292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XyvoLQsYBwCacSjXMUeo1JDpYe89rtdX65GHrpNFkEk=;
 b=s509/KGMuUWsloNgQ7kCJl7LsvZJ/+BrDbOuxBYLNXZlQk432MTBYbgB5NEmAtJ3Ek
 /ts4xQk8V+hYpQYdJn3w6X6xb8kKOr3FIq6FouSioWzX34IqxQXGhy4r5XvZah4GF7Nn
 nWi/nYKXIr+wUj6YIDyEep7otN6aiFbryVbWy8MnciBOcDlFZNwdzuasxdEydAIWvUI/
 jOr1TbTS5SWEBaeiHfW/qGmsM1SsdUKonyxH6DMTKHc4KgKJRfenn1K7gd0ugSwQOSJA
 2aG75LIvEss25dlY3UNKqxyzkktaEE0foBmgOvj5X3z3yJd2tpNG+qv8f/5pS83fbXJI
 ly3w==
X-Gm-Message-State: AOJu0YxVPey7Rqa8eUS8D4H6opZ0+1EfFnNUcUKXwN0Ho95GPHwtEGVg
 1jFloHditef4TNTQ5+VPmmv6QwJL5I2gAD/vke8=
X-Google-Smtp-Source: AGHT+IEg3JYiaHC/DjNleQvMjxeyr4DMvvo9tfBblxI/xzs3j7brMQ9/7AJn1+T5yCJkYfYSr7gDcg==
X-Received: by 2002:a5d:4443:0:b0:323:36f1:c26b with SMTP id
 x3-20020a5d4443000000b0032336f1c26bmr21907035wrr.6.1697183492020; 
 Fri, 13 Oct 2023 00:51:32 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:51:31 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 46/75] contrib/rdmacm-mux: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:59 +0300
Message-Id: <a45dd47fa12e2e8fe817b1816dfbbecd4f4e8065.1697034504.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
References: <cover.1697034504.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42f.google.com
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


