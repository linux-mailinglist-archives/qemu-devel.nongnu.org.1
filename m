Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C96317B7549
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:40:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovo-0004Qg-35; Tue, 03 Oct 2023 19:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovk-0004M6-Lh
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:57 -0400
Received: from mail-io1-xd32.google.com ([2607:f8b0:4864:20::d32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovU-0007QR-7H
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:53 -0400
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79fa2dbd793so64833339f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376139; x=1696980939;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lf2DJ/U5pZm2sH4vEROH814jsncDavzfH54NHOK5mnI=;
 b=beIBeVRIwr+iSLVT759fEoGoOwGNpIPQliRIS6sMlQ8MoCKGALY1CsDugMFvH2jwDL
 VikPvFILhUxjiZwMGZm/pAwnw7lqxGUvn8X4SwWSoFI8y1W7bT7DBX162p6SuR8azRLo
 IeLoggEYfhYUb0zWgdpy4hcWqNj0WcSI9qyftwk5NGZc8VoJNHo6/u6MVTf84ayj9QYc
 rOgkfMJAZraL4eqWFOOdhNoTlukg021sZuoidbQMmVt6cMF6Gx5s1OSWxPxAEHJyGNLI
 W5f+ugVjMozDCfEwWM8WjMI3oLjIV5XUiMfpFVrUeDP2T7YJ2ns4EVoZwsdQV5lnmFl2
 eFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376139; x=1696980939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lf2DJ/U5pZm2sH4vEROH814jsncDavzfH54NHOK5mnI=;
 b=tQC7m/otSkgZfLNwSaA8oIS+F4yX3NY6vmZC7GyzcLEb8KYnwppnq1JuCuIa+ekil/
 /jailcvE4KK4/NGVJFYD8roJAvRLOEtkMpU9xMC0eRZ9fkfsjZhadd2JR1LjVZb6NSXj
 4SReFeDvGrE+SdLyd3JY3oQ/iymd6sjqVzMztdDn/EwRPDGMCiTBNZhsdjkJmdGjj706
 ztANSq9owQjghQAS7u0/Unz2KkEjeAQnn2cZO6i787Tf9xtfQEYx+D/XmXQohX291mz6
 DD13GGxT+cPBtQBpebx1CI4bmPOrVmNslb6ElF/F/m9ZOV30xu66EKaIa9WsB53g7ueJ
 mLNA==
X-Gm-Message-State: AOJu0YxWt33S+7Umh3+1Mckyx1MS/vnXmsKqgG0hdT28bnsMZ5bTYqfT
 i/wXeXsmnHw43Szg0B1GSMNPpjr8cmGOyN48vAm0yg==
X-Google-Smtp-Source: AGHT+IGeMItmvoNFnerw+z4zcjU4ecusxV9/NxaqduSB0gjpJvCGQ+oL+5u6yjH70RsXsGI/Vah4dQ==
X-Received: by 2002:a6b:a05:0:b0:792:70f2:a8ed with SMTP id
 z5-20020a6b0a05000000b0079270f2a8edmr963506ioi.4.1696376138891; 
 Tue, 03 Oct 2023 16:35:38 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:38 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 35/51] bsd-user: Add bsd-mem.c to meson.build
Date: Tue,  3 Oct 2023 17:31:59 -0600
Message-ID: <20231003233215.95557-36-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d32;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182709.4834-8-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.c   | 0
 bsd-user/meson.build | 1 +
 2 files changed, 1 insertion(+)
 create mode 100644 bsd-user/bsd-mem.c

diff --git a/bsd-user/bsd-mem.c b/bsd-user/bsd-mem.c
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/bsd-user/meson.build b/bsd-user/meson.build
index b97fce14722..c6bfd3b2b53 100644
--- a/bsd-user/meson.build
+++ b/bsd-user/meson.build
@@ -7,6 +7,7 @@ bsd_user_ss = ss.source_set()
 common_user_inc += include_directories('include')
 
 bsd_user_ss.add(files(
+  'bsd-mem.c',
   'bsd-proc.c',
   'bsdload.c',
   'elfload.c',
-- 
2.41.0


