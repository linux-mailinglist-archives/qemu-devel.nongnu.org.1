Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4787B753B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:39:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovb-0004Ga-C2; Tue, 03 Oct 2023 19:35:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovZ-0004Ff-AT
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:45 -0400
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovT-0007QG-7r
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:45 -0400
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-79fa387fb96so59614439f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376138; x=1696980938;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snLfS2fmcfQu7v+qFvXCzYllQM35vPKtXXGh7bze+p8=;
 b=vylYitD2pk2dn9bkA/Em4T3PyTXXFGammOLqrTvZ+VnlpddavYE6nBu579hMYhl5/2
 xtiXqiiQh9YoJbd52zmhv37jb6atXQOPZbnVIINP7GAxvPdjQ4nlrQcJDIPbvaWKx8Ql
 Dfp2cbNWcjKrPk9C0+6FGOIekggEhY+lPKtO2toHfZ/dlj1ZiOaUCphlJyvIufae385p
 M29X28NipsvhTzZY5xa55/uPFAsM6+sfAwz3+eKr9SSaXvUgmdCQTMO4AlB5bsDwUCeA
 F02g4dUTcpyHUOu+f5ucstNBH1QOhWQ5Go4RFTGy/ZsNaVW+lsmh/vlMVjd84djNPnA8
 Cvyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376138; x=1696980938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snLfS2fmcfQu7v+qFvXCzYllQM35vPKtXXGh7bze+p8=;
 b=aoFXb6tvMExXdr4SV7ohH/F5e0J+efbOBZOW5m5aq41agxnwtQAUcJD0gzYlfj4EMu
 wlU9ASzoFRkd0F2lyovQH70aIp2wlqB4TTkz3vk8u2iXTO0rmSSWNJCzfSotONE683ui
 JXDrSfg6TSmiTlaL555P79rTorln9qJp1IZsyS+Bn66lyi7GcRaAwn+OkQBaeIWyaEYY
 0bvE6Ykya3KxYNJ5NvJE+IGnN2wyx9259zPLlDO1FsWGBVPYhngmgaCdtZBR9uKJwVZP
 6p0UEWVmoeQYLcv9Xq/EKqfOjXRFaSj2rqDkEv+D97zkv5rzNzl1/BxCuZi0nd/xIL+i
 mrIQ==
X-Gm-Message-State: AOJu0YxayNUJZEnSW7wxdJeEamCWasgcKHatzfUfMM1it8H2FS4Wfum6
 1wjSL5A4z0bM0AMTVipZZ/kg/pfvWsem3k5z322vRA==
X-Google-Smtp-Source: AGHT+IGYKg2LvvQOV0NqnYxEDxK5SFIv2jJoDtbxF7lgzJERLovzPpCs1+xsqQx481RDwL45NeGf1w==
X-Received: by 2002:a5e:8919:0:b0:787:34d:f1ea with SMTP id
 k25-20020a5e8919000000b00787034df1eamr873017ioj.8.1696376137916; 
 Tue, 03 Oct 2023 16:35:37 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:37 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Kyle Evans <kevans@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 34/51] bsd-user: Implement shm_rename(2) system call
Date: Tue,  3 Oct 2023 17:31:58 -0600
Message-ID: <20231003233215.95557-35-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d36;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd36.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_NONE=0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182709.4834-7-kariem.taha2.7@gmail.com>
---
 bsd-user/freebsd/os-misc.h    | 24 ++++++++++++++++++++++++
 bsd-user/freebsd/os-syscall.c |  6 ++++++
 2 files changed, 30 insertions(+)

diff --git a/bsd-user/freebsd/os-misc.h b/bsd-user/freebsd/os-misc.h
index d5e8b5484c8..71145764a4d 100644
--- a/bsd-user/freebsd/os-misc.h
+++ b/bsd-user/freebsd/os-misc.h
@@ -70,5 +70,29 @@ static inline abi_long do_freebsd_shm_open2(abi_ulong pathptr, abi_ulong flags,
 }
 #endif /* __FreeBSD_version >= 1300048 */
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+/* shm_rename(2) */
+static inline abi_long do_freebsd_shm_rename(abi_ulong fromptr, abi_ulong toptr,
+        abi_ulong flags)
+{
+    int ret;
+    void *ufrom, *uto;
+
+    ufrom = lock_user_string(fromptr);
+    if (ufrom == NULL) {
+        return -TARGET_EFAULT;
+    }
+    uto = lock_user_string(toptr);
+    if (uto == NULL) {
+        unlock_user(ufrom, fromptr, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(shm_rename(ufrom, uto, flags));
+    unlock_user(ufrom, fromptr, 0);
+    unlock_user(uto, toptr, 0);
+
+    return ret;
+}
+#endif /* __FreeBSD_version >= 1300049 */
 
 #endif /* OS_MISC_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 122e186b501..5fb42b2c218 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -807,6 +807,12 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         break;
 #endif
 
+#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
+    case TARGET_FREEBSD_NR_shm_rename: /* shm_rename(2) */
+        ret = do_freebsd_shm_rename(arg1, arg2, arg3);
+        break;
+#endif
+
         /*
          * sys{ctl, arch, call}
          */
-- 
2.41.0


