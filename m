Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEE677A6C4
	for <lists+qemu-devel@lfdr.de>; Sun, 13 Aug 2023 16:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVBpT-000884-Pr; Sun, 13 Aug 2023 10:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpQ-00086d-LT
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:24 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qVBpP-0000q2-4g
 for qemu-devel@nongnu.org; Sun, 13 Aug 2023 10:12:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-31963263938so1538015f8f.2
 for <qemu-devel@nongnu.org>; Sun, 13 Aug 2023 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691935940; x=1692540740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0uTjuUZfn1BMnx+++7JtIeJPCYgZiSfPp9MKsrrDqfY=;
 b=pPjW/VJxrK7XFzoiswlUikeShu8pDScHUCeNSF+zp7ab3zr8gvehS1mP2O6oGwQhBq
 EUD1LsbokrOeG6/gWk6gZ2po2AhdQESnjmclZzCUyPwGi2CuT8mBOUGn4pSreeV6jaak
 20Tevb5R+TdH9Ay14giAOwtYfZLjblD7C2wYbMBBmY05VDH4WCJSLRLamnnY/QMz7hYD
 e8TkvflzN5JvKqH2aUzoVgsRitneHKO7HCp39AW/+iYcSy4goFb/RbIm7kKG1Dgiqy2+
 3F/5Yukv0kuWxAGSPDJ9DleSRl3Kg1t7dyg+t8XxFfDYBuwt/+KAf9nyX0e3ED4XdoLk
 QEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691935940; x=1692540740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0uTjuUZfn1BMnx+++7JtIeJPCYgZiSfPp9MKsrrDqfY=;
 b=TZwzOoz+OnYJHN7V5cRSbcIqifCN5XaiofPdHRpWFT7/PVAC8B468spIvw1FNpRYUD
 Fm+DDEIOCKKjHTJhJfEJ9SSfkOQvyiAwSvucQPye9nl+KQdTNN4XNIT92FK3BuHus2N0
 0ExxY95W54df0LE5EBFGaUfcrIChxhGzyNvhKGGAsWTg6qu1AXv1ZJxt2DcXXV7IcWWz
 dbmPsYlWWS+XNCejkVViCzKEDgBAuyM/xt4LdKi0rHv2K/E2SEyAsXUgr9CrDMhmyMw/
 IYGdmQJzcgSUrYtuxxHRnJUR55votDCuri94OJoGWKR69ejIlB+EwHpQzh+mbPFb/Uf0
 wHoA==
X-Gm-Message-State: AOJu0YzA9bjHT92bmphl46YDzI0mjYQekPGM/u+GuUdTSMBCwYdxhW/b
 CG04WoU6IwdalJd8WMnHtIWvdOFWHQU=
X-Google-Smtp-Source: AGHT+IEjnUDlrou2daoz54W3bvmWM+AqKva2sm3PevogWH57s28ii8baFFLdH44FSeADFQJeQK7R6A==
X-Received: by 2002:adf:ed05:0:b0:317:6f5b:2fb7 with SMTP id
 a5-20020adfed05000000b003176f5b2fb7mr4910052wro.57.1691935940636; 
 Sun, 13 Aug 2023 07:12:20 -0700 (PDT)
Received: from karim.my.domain ([197.39.204.50])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a5d4112000000b003144b95e1ecsm11409101wrp.93.2023.08.13.07.12.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Aug 2023 07:12:20 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 10/32] Define safe_fcntl macro in bsd-user/syscall_defs.h
Date: Sun, 13 Aug 2023 05:09:51 +0200
Message-Id: <20230813031013.1743-11-kariem.taha2.7@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
References: <20230813031013.1743-1-kariem.taha2.7@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 bsd-user/syscall_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 68db9cf4b2..bdcdc4c0fe 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -437,6 +437,8 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
     return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
 }
 
+#define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
+
 /* So far all target and host bitmasks are the same */
 #define target_to_host_bitmask(x, tbl) (x)
 #define host_to_target_bitmask(x, tbl) (x)
-- 
2.40.0


