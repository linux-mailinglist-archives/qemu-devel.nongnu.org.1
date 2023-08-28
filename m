Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078C78BBA8
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 01:44:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qalsP-0003ug-EU; Mon, 28 Aug 2023 19:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qalsH-0003sj-IM
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:26 -0400
Received: from mail-il1-x134.google.com ([2607:f8b0:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qals6-0006qf-Ud
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 19:42:19 -0400
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-34992fd567bso9188965ab.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20221208.gappssmtp.com; s=20221208; t=1693266130; x=1693870930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N2zpTl6+Qn2qxjehwfDJexIkEUjfkShWM5RDsL7uCz4=;
 b=49d2Rgh8YfCfzCpfD6Cvi/6P3Ziw+Xrmhr6i7e0SolZ3ZJQyjypg7eMW+xfqItoTE2
 jw9UASR7gL/gciwNnWl4sb8/UvqEivzWEQM4MP70xE4XNLga+/z9HdM/2sqRxZwr3qRG
 kf7Do9nSdd4IooTInCSQDxt3MjZB+K65u01fvCCNJET9pDP2Fmtk5IJAb+rsZoTN8ZsF
 AkwEuSAHPoy7J+uJx33RKYdQkoZjr+i3y59Hr7WWptz+1Bi6Xsc7SCQkbAWUowQCLf7R
 L4rX8bKzvdemOcYXshYOnFAX9LAEJKPKM/aSSWsgLbfxkFesnRemzde4mSXuKnIngRkf
 2Ang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693266130; x=1693870930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N2zpTl6+Qn2qxjehwfDJexIkEUjfkShWM5RDsL7uCz4=;
 b=T3FSMq0CQczQK1ewg68kUqG3lgN+BoZB075c6z4RzMbkQxcNtfxrdVaHI1WbahnN1T
 AP68fdgKmwCFWur7Txv0zyi4QE09q1omDokRW4uLRqw2oJw0+cyQKJH7lxrkPGs9FPQy
 hud6mVYFlqSbE8oDv1TBsOv9eTLaKq05Toe0aTuPwe94iyhdnBS0h9s0ZIATTJ6pjda8
 0sHUoRbHgNhW6Z2WbKDhD0sUDUdE//yKW9fONqAjO0w6p0DmXLd1Os2wsDKzFrPByGai
 NeAv0aie5S8YdUkNm3Y8vWqrNRSNkwEtkYR4mUzsT+6EjwOvSicT2GYC6kyfjP1NcDLN
 9orQ==
X-Gm-Message-State: AOJu0Yz2CkeLBYWNXtMWqnoXv3bAcr5/KqQl7bG1Sgjzjamrq2Vz8scR
 h+UsUELd8nxeFYLb4B1vCjoXjM0DC8uusdZYoSk=
X-Google-Smtp-Source: AGHT+IHJhKFUzYSaMsrwRUwA+ZSF6AtwiP06z/5g/t6EH6I6jeTVhU/bfbvEzpHIbtcAd5MODL+jEg==
X-Received: by 2002:a92:c547:0:b0:348:797d:169e with SMTP id
 a7-20020a92c547000000b00348797d169emr1309505ilj.1.1693266130634; 
 Mon, 28 Aug 2023 16:42:10 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 t9-20020a056e02060900b0034b58dd5694sm2805491ils.15.2023.08.28.16.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 16:42:10 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>, Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 36/36] bsd-user: Add missing break after do_bsd_preadv
Date: Mon, 28 Aug 2023 17:38:21 -0600
Message-ID: <20230828233821.43074-37-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828233821.43074-1-imp@bsdimp.com>
References: <20230828233821.43074-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::134;
 envelope-from=imp@bsdimp.com; helo=mail-il1-x134.google.com
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

Without it, we'd call preadv, then write with weird parameters, which is
clearly not ideal...

Signed-off-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Fixes: 770d8abae7 ("bsd-user/bsd-file.h: Meat of the write system calls")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230820045419.89691-1-imp@bsdimp.com>
---
 bsd-user/freebsd/os-syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index e9b1b663af4..fa60df529ef 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -240,6 +240,7 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
 
     case TARGET_FREEBSD_NR_preadv: /* preadv(2) */
         ret = do_bsd_preadv(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
 
     case TARGET_FREEBSD_NR_write: /* write(2) */
         ret = do_bsd_write(arg1, arg2, arg3);
-- 
2.41.0


