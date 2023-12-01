Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3F1800205
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 04:23:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8u6S-0002wc-2D; Thu, 30 Nov 2023 22:22:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3WlFpZQMKCtMH1L5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--scw.bounces.google.com>)
 id 1r8u6P-0002wS-TE
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 22:22:05 -0500
Received: from mail-yb1-xb4a.google.com ([2607:f8b0:4864:20::b4a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3WlFpZQMKCtMH1L5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--scw.bounces.google.com>)
 id 1r8u6O-0002gN-Ag
 for qemu-devel@nongnu.org; Thu, 30 Nov 2023 22:22:05 -0500
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-db53c05f802so99554276.0
 for <qemu-devel@nongnu.org>; Thu, 30 Nov 2023 19:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1701400923; x=1702005723; darn=nongnu.org;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=VKbYtxb998M7xtd1yWMMXx/v8cMCtWZz5lASK6nmDYE=;
 b=4mTAgyMVZeq3N6N/j1b3Gf5Jj1+8UV+yzfO1bol6nRcvQ3xmijXdCs74KrcFwW0uUN
 oM1sjkfgCUCqCH5tayH4Gh4+P4oP1AvyH8U/rhjG8Zx3fAHGnuLZWhakRRiDYT/NvxUW
 XG/OKQDQsiCRHFEK3osPwtcZTUJ+4QDJ27k2GjUMBZo7PiKYjbItTZ3E7cvGUttTK/8r
 R6QYLHv7eFW/42BA/dqMAusqHOKSNlqncZ/D/qeH7zLXtMiKj9BinVP0KuE4v6oorTXI
 71cBPSI4Ct8Jjx/GHUY/nnYGAlPs3DKorH9R83PZi0fNkEB5HNUe5YpEFUaV7xOvAPoL
 4EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701400923; x=1702005723;
 h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VKbYtxb998M7xtd1yWMMXx/v8cMCtWZz5lASK6nmDYE=;
 b=Cvcn1Q/mMTUa2Mn0ahwgxrOj/O0adNfrwVcGd8EQXKJ3zg5Zrwt/OAOVbDcfjXsyk+
 KCAWD7bTtxQrKzZb1VWFiKTp2IlClOgjAYMYV1rh6OLZBCxs0R5Tm6C9TRJwIbo/t27l
 Y0DFhd9NGIr1X+i8uwxuaTHrOMhnBORfN2Iqoqm8tgy3zPBu21WYnR2uXoMMF0KUKV24
 LaGP2ib0ki5hUCksG8pLJqgvqr+zB4WPIc8aSNnDL8qWp+lcRLxMxTjH5V70ettewwCc
 G8Unfyf2gBEqaie91bZ5V3/ine03XAVxUQKPyhJshapf8mUQ1aXfl/Ox6BU6uCMKeh/i
 fKHg==
X-Gm-Message-State: AOJu0Yy7iTr05lmtPHYpc8n0BRTEZS+GwgwM+Zn7M+GQSgcyy5fYsZNf
 8Irz/karxi/o7IfZRT7p/65E+OHrybNwGw1C0OdPsw0huvLqih84AKR5J/0iFvuyNDsbh6viICz
 3rJxbAOpJW2KdMUi6BbWNufjicy0z1zWmNjOmneR0e+FvkedwQNr9
X-Google-Smtp-Source: AGHT+IF0pkFEVEe24I1m+2hvHcW84ltuusXuQag8MxkVDGE9QApvMMBseTFz6rveXp8lt93r9r4G1ow=
X-Received: from scw-glinux.svl.corp.google.com
 ([2620:15c:2d3:205:73b4:ef07:4b25:48e5])
 (user=scw job=sendgmr) by 2002:a25:3055:0:b0:ca3:3341:6315 with SMTP id
 w82-20020a253055000000b00ca333416315mr828722ybw.0.1701400922851; Thu, 30 Nov
 2023 19:22:02 -0800 (PST)
Date: Thu, 30 Nov 2023 19:21:39 -0800
In-Reply-To: <20231201032140.2470599-1-scw@google.com>
Message-Id: <20231201032140.2470599-2-scw@google.com>
Mime-Version: 1.0
References: <20231201032140.2470599-1-scw@google.com>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Subject: [PATCH 1/2] linux-user: Define TARGET_O_LARGEFILE for aarch64
From: Shu-Chun Weng <scw@google.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shu-Chun Weng <scw@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b4a;
 envelope-from=3WlFpZQMKCtMH1L5DD5A3.1DBF3BJ-23K3ACDC5CJ.DG5@flex--scw.bounces.google.com;
 helo=mail-yb1-xb4a.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

In 050a1ba, when moving the macros from preprocessor-guarding to
file-based definition, TARGET_O_LARGEFILE appeared to have been
accidentally left off.

This may have correctness implication, but so far I was only confused by
strace's output.

Signed-off-by: Shu-Chun Weng <scw@google.com>
---
 linux-user/aarch64/target_fcntl.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
index efdf6e5f05..55ab788a7c 100644
--- a/linux-user/aarch64/target_fcntl.h
+++ b/linux-user/aarch64/target_fcntl.h
@@ -11,6 +11,7 @@
 #define TARGET_O_DIRECTORY      040000 /* must be a directory */
 #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
 #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
+#define TARGET_O_LARGEFILE     0400000
 
 #include "../generic/fcntl.h"
 #endif

