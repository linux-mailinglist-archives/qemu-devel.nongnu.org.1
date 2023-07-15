Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 023FD75490B
	for <lists+qemu-devel@lfdr.de>; Sat, 15 Jul 2023 15:58:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKfir-0004EX-Ri; Sat, 15 Jul 2023 09:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiH-00042a-4j
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:34 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qKfiF-0001FS-Je
 for qemu-devel@nongnu.org; Sat, 15 Jul 2023 09:53:32 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742eso29395465e9.3
 for <qemu-devel@nongnu.org>; Sat, 15 Jul 2023 06:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689429210; x=1692021210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM1xXL81EtFD9ExbvPk3EQKQbkl//TA55SFLIHfjSWw=;
 b=ZSNp0u33UreTJeB22qnslIsn7ZkAqD/6fW7QNFIp75qmN064npL8vy8OW5Sk3oVxbb
 vtMMR+W2iRmoDlh8FK0Nb6xNIJKuJXRiAfJvWVcX3IUBcjxYpjL2d2VwGRmSTmNx4P8+
 qP537i8EQBEUP/1pMhLeSGFzG5ripphJ+X/bDoWrUM6zet2ajoGpsZErmG1ca8JJDytm
 bQScIx4LBh4ttfPb8S2XyVeTik24aRfc6X5jXcF+IDM5pO69abLo/CcP2dn+xjn/omC5
 giDCAxPyLBd1X3zxHTGpyE8oBEpMCkDW+/VEaBM514lUvIzPKRsPTwdQ2LmtrqZTa1+e
 Nd8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689429210; x=1692021210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NM1xXL81EtFD9ExbvPk3EQKQbkl//TA55SFLIHfjSWw=;
 b=XQu8INQ7qoDwisOSnhZr/meetAoEWM9dh6SpcWhkJLvCHfzd1NF0RTkUSXklUNmawK
 J2CgJWn7+tcqn2eiJFlJtK8Y0u7wrQx96ooesUNw31hMdADN/SE3x9U+c+kLlHjMlGXv
 t256xB0bQiBQocqs/aqixq4BpqLnG9JDlaVtO3Zfz0bxVQ4vom7IRjpn8UzzfP1SBJ57
 uOHF3RJYeG0ly/PcaMlwmzi0flC71uziDlezynlX1hw+vCbb2BXiKE7GKrWtRStEjsys
 bfnM6AyFLKIYTAcZM4PbSMLl2LI6HLN8OkTvkwJwFn4GfRslxWIBI3VJDLLAlnxdKU3q
 aBdA==
X-Gm-Message-State: ABy/qLa8bgWZxaYXA1/S6XnsBkAhR7H1LoOPOnSuvm9bjUOxqmBklw54
 Rq826VILlk3uxKdnBxJu6kTPPTww887A5ZhOCUtb4w==
X-Google-Smtp-Source: APBJJlEloWOI4ocrvfPGgLjAHMRgWcLD25fj4r4N/25lC1GaMeFB69psyWciPtLjmlIR0mrNKqK5Pg==
X-Received: by 2002:a7b:cbc6:0:b0:3fc:70:2f76 with SMTP id
 n6-20020a7bcbc6000000b003fc00702f76mr6605414wmi.20.1689429210308; 
 Sat, 15 Jul 2023 06:53:30 -0700 (PDT)
Received: from stoup.lan ([51.219.12.49]) by smtp.gmail.com with ESMTPSA id
 k10-20020a5d66ca000000b00313f9085119sm13838014wrw.113.2023.07.15.06.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Jul 2023 06:53:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/47] linux-user: Use abi_uint not unsigned in syscall_defs.h
Date: Sat, 15 Jul 2023 14:52:43 +0100
Message-Id: <20230715135317.7219-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230715135317.7219-1-richard.henderson@linaro.org>
References: <20230715135317.7219-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall_defs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 9dc41828cf..c8ffb4f785 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -1776,14 +1776,14 @@ struct target_stat {
 
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
-    unsigned        st_dev;
+    abi_uint        st_dev;
     abi_long        st_pad1[3];             /* Reserved for network id */
     abi_ulong       st_ino;
     abi_uint        st_mode;
     abi_uint        st_nlink;
     abi_int         st_uid;
     abi_int         st_gid;
-    unsigned        st_rdev;
+    abi_uint        st_rdev;
     abi_long        st_pad2[2];
     abi_long        st_size;
     abi_long        st_pad3;
-- 
2.34.1


