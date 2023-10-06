Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 509347BB11D
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 07:13:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qod7l-0006L7-QE; Fri, 06 Oct 2023 01:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qod7j-0006Ip-7J
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 01:11:39 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qod7g-0003md-9H
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 01:11:38 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-692a885f129so1456205b3a.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 22:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696569094; x=1697173894;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XNY5obo1lFRY1rzOM4EOFb12ZSNj3/8ms3FBcaRflBM=;
 b=rgncR7yomLvNjudP7oAHqzgjuzDxjZNfeUf48oz1uFZGDZQcBF8MMnb8cdPy2SXNcG
 eYV7EavFokG0QmUcVqAI3j9xvk509zvCrOITokHME/TtijB86+i9Pk11Isec9x8kyKX3
 65EusaJ3rFkb5wHLTiMfgTy+T91RU5eA5Kn6r0crFcDF2XsgwfSJkBSvcXceaEeQ4lth
 uiVc1w1ZflgsXYpMNZPsr6yExofwgppEK2K8EG63JqFY/u+WM5nvbM6JopwE+qtUMBlp
 f561MiK+g/OblFnCyGnXWQ6zMWhxVc+2iczm34RjcrGpWNgdIGomhnttUWRfOvEP70Xj
 YL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696569094; x=1697173894;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XNY5obo1lFRY1rzOM4EOFb12ZSNj3/8ms3FBcaRflBM=;
 b=IDUvUGLGBM4hSh7bLlEHT2FVTnRmXD0R5+6LtgI+pBwz/1frR1zDgdj7miuJHbfX5F
 5g6/Voipi/EnjIpgWIDmPdrChNzAYPgJg8OdCP8vml5z3tp2FboB408ggseRDur8YF6D
 VDPpUbpz9XbEXlqdvpwP0oRzZiauT3hiIcB/CHWMIwIgB2TuMDTp/mF164iaHzMqTKJg
 tX28TBDcX1CIlq1LpG9FEzRy6DCaZkNSWJo4igVWCPCZ/vZeUqssPIA3GIfItmkL7Q2U
 6lD7jMnx2sXWY4NuYKs6x7jUxIBacLL7Lvp/6x7iqkI8QEvT7gVn17DqSWBu7wo67KLz
 OfEg==
X-Gm-Message-State: AOJu0Yx2lpTK8vriw3XsGpNCBj4MVDRs0sAeHeY2jkwt7kbc0265r9ON
 dLMmJUEdgQ9NDFPpOw5NITeuzQ==
X-Google-Smtp-Source: AGHT+IFNj98Wvv8nqMfMxMGWxi75GPaVxxJkJ/LSdE9WNy5dLVN6WAxo1CyXZ+K5J2qtqlmPbTpZSA==
X-Received: by 2002:a05:6a20:7f96:b0:131:b3fa:eaaa with SMTP id
 d22-20020a056a207f9600b00131b3faeaaamr8371535pzj.61.1696569094350; 
 Thu, 05 Oct 2023 22:11:34 -0700 (PDT)
Received: from localhost ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with UTF8SMTPSA id
 je12-20020a170903264c00b001c74876f018sm2765782plb.18.2023.10.05.22.11.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Oct 2023 22:11:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Weil <sw@weilnetz.de>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH] tap-win32: Remove unnecessary stubs
Date: Fri,  6 Oct 2023 14:11:26 +0900
Message-ID: <20231006051127.5429-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Some of them are only necessary for POSIX systems. The others are
assigned to function pointers in NetClientInfo that can actually be
NULL.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 net/tap-win32.c | 54 -------------------------------------------------
 1 file changed, 54 deletions(-)

diff --git a/net/tap-win32.c b/net/tap-win32.c
index f327d62ab0..7edbd71633 100644
--- a/net/tap-win32.c
+++ b/net/tap-win32.c
@@ -707,70 +707,16 @@ static void tap_win32_send(void *opaque)
     }
 }
 
-static bool tap_has_ufo(NetClientState *nc)
-{
-    return false;
-}
-
-static bool tap_has_vnet_hdr(NetClientState *nc)
-{
-    return false;
-}
-
-int tap_probe_vnet_hdr_len(int fd, int len)
-{
-    return 0;
-}
-
-void tap_fd_set_vnet_hdr_len(int fd, int len)
-{
-}
-
-int tap_fd_set_vnet_le(int fd, int is_le)
-{
-    return -EINVAL;
-}
-
-int tap_fd_set_vnet_be(int fd, int is_be)
-{
-    return -EINVAL;
-}
-
-static void tap_using_vnet_hdr(NetClientState *nc, bool using_vnet_hdr)
-{
-}
-
-static void tap_set_offload(NetClientState *nc, int csum, int tso4,
-                     int tso6, int ecn, int ufo)
-{
-}
-
 struct vhost_net *tap_get_vhost_net(NetClientState *nc)
 {
     return NULL;
 }
 
-static bool tap_has_vnet_hdr_len(NetClientState *nc, int len)
-{
-    return false;
-}
-
-static void tap_set_vnet_hdr_len(NetClientState *nc, int len)
-{
-    abort();
-}
-
 static NetClientInfo net_tap_win32_info = {
     .type = NET_CLIENT_DRIVER_TAP,
     .size = sizeof(TAPState),
     .receive = tap_receive,
     .cleanup = tap_cleanup,
-    .has_ufo = tap_has_ufo,
-    .has_vnet_hdr = tap_has_vnet_hdr,
-    .has_vnet_hdr_len = tap_has_vnet_hdr_len,
-    .using_vnet_hdr = tap_using_vnet_hdr,
-    .set_offload = tap_set_offload,
-    .set_vnet_hdr_len = tap_set_vnet_hdr_len,
 };
 
 static int tap_win32_init(NetClientState *peer, const char *model,
-- 
2.42.0


