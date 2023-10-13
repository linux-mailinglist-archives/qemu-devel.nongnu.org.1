Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B53B7C80E8
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDqx-0002La-N3; Fri, 13 Oct 2023 04:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqg-0001KX-83
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:49 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDqd-00019H-Pd
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:48:45 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4066692ad35so19357015e9.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186922; x=1697791722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9byQtVhOpUxeLye9si4YMG5YGVFhs0vt6jainaOsryU=;
 b=tLu8m2WmRAtkLuP7PmKsosgIr/CAdsSkfArBp3hx14a8IFCLtnlQBeqnnLoSYth1ly
 SRhpbUwLSR89M7GZtvtnhym6/3AWFwHv9XSbYeWqYwY3I4ycP1ybTsccOQQBqh6dMdV7
 27XaM9HYi3kwG4YfcpBLyjyISbQ5PTVbbAKa7GF+ztntceGujm8JGkR4aKkf8iABPtBp
 DzmWlsmfJV9ykwmO1eWIa63T8daGAjsivLX23sZhUmVvse3Q/6SHE+JEz8s0A2V/4vDP
 ssi70cckwyVu1mI3LwyWmIW1NoD12ZRi89bxihuho9b/inCMLfQdFnQH4I6hma+5Ia9z
 l/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186922; x=1697791722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9byQtVhOpUxeLye9si4YMG5YGVFhs0vt6jainaOsryU=;
 b=SF63AFWY8TrpaBVq4U2vVAPrVmew7Uy18TYRTJOCVm+6xuFvfeTEb0U4qXSk8B9RXW
 hkj11GPSxck+mk9W+S3HzHKi+ceifRY/N4Fq7ysOvdNPwC1viqNvbRKletUWIpg+T/pP
 zf+cqB27k+A2asPVt3dd93J3C3on8C0odoyq78dQ2LKqogr05Omhozmwts6lko/IOfbH
 yTVc3E/mGE81GDvS1utKs9tovv1A4vnqT8Yo6CCi/VylkcmG+52D8VzILaKD8sUpnr4v
 9V9axRQM46N34ZDquCsRq2asqe63ph818oXLJ+QoDFRBDfigOzR5aIJVIDO9gitJCEvy
 wINg==
X-Gm-Message-State: AOJu0YyMKyi6L+2kXBKyhXiwWTZCN7D+0TkVdNjmv/gwH7PpGHItEflE
 r76BvxTkzjtS7/slBGT4G/hy24fNrEy907mitbw=
X-Google-Smtp-Source: AGHT+IFMcCryYoEcfKcmP7Evj5Be4me6Lp7I/T1NZYnOaMRSRQHQPKLiJmAuqR3EVVIbEX99L55j0Q==
X-Received: by 2002:adf:e607:0:b0:31f:b9ea:76c with SMTP id
 p7-20020adfe607000000b0031fb9ea076cmr21474443wrm.48.1697186922165; 
 Fri, 13 Oct 2023 01:48:42 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:48:41 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [RFC PATCH v3 53/78] nbd: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:21 +0300
Message-Id: <e851517df6c73a99988e9b05e1664e855ca188a6.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
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
 nbd/client.c | 4 ++--
 nbd/common.c | 2 +-
 qemu-nbd.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 29ffc609a4..04507249b2 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -1051,7 +1051,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
             }
             info->base_allocation = result == 1;
         }
-        /* fall through */
+        fallthrough;
     case NBD_MODE_SIMPLE:
         /* Try NBD_OPT_GO first - if it works, we are done (it
          * also gives us a good message if the server requires
@@ -1074,7 +1074,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, QCryptoTLSCreds *tlscreds,
         if (nbd_receive_query_exports(ioc, info->name, errp) < 0) {
             return -EINVAL;
         }
-        /* fall through */
+        fallthrough;
     case NBD_MODE_EXPORT_NAME:
         /* write the export name request */
         if (nbd_send_option_request(ioc, NBD_OPT_EXPORT_NAME, -1, info->name,
diff --git a/nbd/common.c b/nbd/common.c
index 3247c1d618..1140ea0888 100644
--- a/nbd/common.c
+++ b/nbd/common.c
@@ -249,7 +249,7 @@ int nbd_errno_to_system_errno(int err)
         break;
     default:
         trace_nbd_unknown_error(err);
-        /* fallthrough */
+        fallthrough;
     case NBD_EINVAL:
         ret = EINVAL;
         break;
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 186e6468b1..41e50208a5 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -632,7 +632,7 @@ int main(int argc, char **argv)
             break;
         case 'n':
             optarg = (char *) "none";
-            /* fallthrough */
+            fallthrough;
         case QEMU_NBD_OPT_CACHE:
             if (seen_cache) {
                 error_report("-n and --cache can only be specified once");
@@ -708,7 +708,7 @@ int main(int argc, char **argv)
             } else {
                 sn_id_or_name = optarg;
             }
-            /* fall through */
+            fallthrough;
         case 'r':
             readonly = true;
             flags &= ~BDRV_O_RDWR;
-- 
2.39.2


