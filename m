Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE8178BBA4
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:43:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsP-0003uh-PU; Mon, 28 Aug 2023 19:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalsH-0003sg-Ho
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:26 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals6-0006qE-Vp
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:21 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-7927952ca67so111767539f.2
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266127; x=1693870927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjyYBPaaCRmWFwjKQO0ANajfRRSHfBsR4cDK15Y/bxE=;
 b=EaVF/HzPLKUHzrGLxiAFN2Iq9CgZIIsLaEkskBHPazdH50a9cneIB9kCok4jNhHcqm
 DpemaPua47IXT65jYFLTjCfWTmbMYsJCQie4Jl2mjB5fRzteia3yWxZa0p7DUjfs66N7
 nLyicxDs+AXU6FpO3KTyyMdV4P6XxFSdlWyD5WzkHzI6hL/Q/NBO9Cp36lsNt7g+5C0S
 ir8xD5oI4t3dOFd5h7D/DmNM5FIZVMv/gLXDkOAztYlNamVKSG9TcQp5ka/cJNeV/LS0
 RmbJL8liPmFnu4XFAVmJvL44tqrBZE4Us1M32gxye9OhXL3wi4C87IdGBTDXeLeRpKOp
 31wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266127; x=1693870927;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cjyYBPaaCRmWFwjKQO0ANajfRRSHfBsR4cDK15Y/bxE=;
 b=bQwkaU8PAPtlWGXhQemZtqOKXLyto259BnJBRKDAOa2JHCGqEtAQHsuWQcav2Ousaj
 3Ggj4OcKjC5QEEa1qbHqVeSpNj7Dkxru7rqJl240yWDJQDtewXiLALIY9j2fbOgfBCxG
 b4ox1qWLpvdspinPieDJ2igBkknXAu+oOnOpIjIcZe+uo/u5b16dEAiwk5Z33QD88uPV
 +UDa+d+W2NxF59TWjpZ8y/9Uvj9wBm+X7B87OjELZwF2BsJwLZd+ajGXB+RWoR20d+ye
 xYqT/FpV0oiyKCAR9WSseUdvj6weFFqDrV9Dme3Ksc3N09zgURs4vOAgSBtmqSY41PlF
 FWyQ==
X-Gm-Message-State: AOJu0Yz5DE7U0JQMfpSQQ7/cv5huLTOLDVWix5nMCYxN0lxpBJhJtfXA
 vNlIiPqJLAmN4Hs67Qra0+YP55OWraMMC1UaPG0=
X-Google-Smtp-Source: AGHT+IER1KiAMAN/33MJAOMgFUarkEMM02VypV91zwF/zgu252KrwNHC096MMNTILu5dH7HqRk432w==
X-Received: by 2002:a92:c5c6:0:b0:34c:b57d:f282 with SMTP id
 s6-20020a92c5c6000000b0034cb57df282mr17922028ilt.19.1693266126840; 
 Mon, 28 Aug 2023 16:42:06 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:06 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 31/36] bsd-user: Add os-stat.c to the build
Date: Mon, 28 Aug 2023 17:38:16 -0600
Message-ID: <20230828233821.43074-32-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2f.google.com
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

From: Karim Taha <kariem.taha2.7@gmail.com>

Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/freebsd/meson.build b/bsd-user/freebsd/meson.build
index f87c788e846..f2f047cca31 100644
--- a/bsd-user/freebsd/meson.build
+++ b/bsd-user/freebsd/meson.build
@@ -1,4 +1,5 @@
 bsd_user_ss.add(files(
+  'os-stat.c',
   'os-sys.c',
   'os-syscall.c',
 ))
-- 
2.41.0


