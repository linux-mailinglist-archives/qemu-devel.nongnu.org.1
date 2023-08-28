Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F32B478BBB1
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:44:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalrr-0003jI-IK; Mon, 28 Aug 2023 19:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrm-0003go-QS
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:54 -0400
Received: from mail-il1-x12f.google.com ([2607:f8b0:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalrj-0006j4-V5
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:41:53 -0400
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34961362f67so11651465ab.0
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266110; x=1693870910;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lHhVGY2K5IoodFPGk0u454gwl2cIZz8X0aAqanzMoZE=;
 b=EHUb/DTVrL2xRij0Xcy8+5KFuT3uM0lpdiU7lLjo2HoxaTfl/DkXkvl2RVaS6evL3j
 41Qz7EOf45COw1hD9ZPHa5ofBAKSi09J8b6gt+7a9D00wJOxjqZBbB5W5ju7qK24TY3X
 TVUwZZx+QADWOwvN3NyyGKJfguFQAJwFr/v868yUs4naU+JMpQgF2089AhdXQTgLC4yZ
 lV+0OANoIKv8sCy3jRqt5tsgfLnD2UebbBy4VO7f4HW9RFLNjexwkGz0yiWmH7i1ntYx
 DwN+9VwtO2nCk1n3qWHr8srIvQ2so+7uqEgjTR8oBz+QGWdE80VujBfTwXeAu7vgvFC5
 9CVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266110; x=1693870910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lHhVGY2K5IoodFPGk0u454gwl2cIZz8X0aAqanzMoZE=;
 b=VgOxESOE9bTv39gVAtdcBHA6FMAbehu3mRj4ONvFqqBcEPNJjcYPUZA3UQum6IAqMN
 uQL7NtRPcJzW20ufFE/E64orhJisoDJVIZ4CqY7OUwtoH9J9nsGttDFMaO+DNU/+UYAo
 cU44LndrGPtkCu53N9w4KTEmc08kmOmI2aXhI+vUMPhFenGXCjA7E7o9++QtpDDDY0Xo
 ctCfl1CsIYqcfx6+xkZWbep9D+3mfad+LCK0xErxIJfx7FsOqYj+hTmAWCXlouIBiNcX
 aydTtprnVXIXfyQa5BP1eGVvbe/l7fu4AfNmjk7Qk4rLfkwVweiq7YbTo5M5Mk1XsfdV
 qxuw==
X-Gm-Message-State: AOJu0YyJu2MtWkGInd1gIYt2h/WVYSChYj5DJzo9sEQB7brZplT40SAD
 uvuhITMUKtRDXSaRsn9TkAtJ+t1bc7FFYkFdXP8=
X-Google-Smtp-Source: AGHT+IF8AklY3IYRaWZRy/6C7Ptv3/UiEZpmr8RoCcUk9Wg1A/SUMnO6tHG1pWyBHpD461yWtZ8poQ==
X-Received: by 2002:a05:6e02:168d:b0:34c:f9c5:f375 with SMTP id
 f13-20020a056e02168d00b0034cf9c5f375mr1215035ila.8.1693266110270; 
 Mon, 28 Aug 2023 16:41:50 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:41:49 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Kyle Evans <kevans@FreeBSD.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 13/36] bsd-user: Define safe_fcntl macro in
 bsd-user/syscall_defs.h
Date: Mon, 28 Aug 2023 17:37:58 -0600
Message-ID: <20230828233821.43074-14-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::12f;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x12f.google.com
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

From: Kyle Evans <kevans@FreeBSD.org>

Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/syscall_defs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 96ae90b0631..c6699c9943e 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -437,6 +437,8 @@ type safe_##name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, \
     return safe_syscall(SYS_##name, arg1, arg2, arg3, arg4, arg5, arg6); \
 }
 
+#define safe_fcntl(...) safe_syscall(SYS_fcntl, __VA_ARGS__)
+
 /* So far all target and host bitmasks are the same */
 #undef  target_to_host_bitmask
 #define target_to_host_bitmask(x, tbl) (x)
-- 
2.41.0


