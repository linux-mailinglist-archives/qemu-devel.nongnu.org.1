Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2187B7551
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:41:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovx-0004jR-UR; Tue, 03 Oct 2023 19:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovs-0004X2-Al
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:36:04 -0400
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovl-0007UD-Ef
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:36:02 -0400
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-79fce245bf6so58311539f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376153; x=1696980953;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QWoVmGnb5jKyajwly1l0ccTXwxvqdiZY2ICtiENtz8=;
 b=gkjYgtDvyF0zIskyJuTyf1wGj2gNyW+qI5ogHfrGNbSXFstR9blxtfZKIczpxgBy8C
 AGljVIM20G1aaA3MN5IZZgc5vlPqxfLgFVvAVNl6vQVKTJ03KF05geYjm7p8A51eIb9b
 sUDTHWApUEolZHquRITvps+J5nPGRrc7Xr11E8TVQ2LsgUuZGavFUkt8uwGIoX+D8ALs
 /kUljWQjYPoloTsHJ+ick8ehK4RFCrPROAJ7ZEsvrmMHZL5XRyIMxyyFP01Bkrzvisb8
 M92/+pDl0uB8f0du840dp7igcKsswy7ELokl9jKtsLVzN04/ijIxkYks/yDIQIr4QAQg
 ATFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376153; x=1696980953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QWoVmGnb5jKyajwly1l0ccTXwxvqdiZY2ICtiENtz8=;
 b=ther5flVnUbEt7KhpXeeMoZgTsurNPfAv+crdJeiRjc8EdFfVXk9fTCdbqZ+5ScHaf
 RCsb4uCPQniNtGFGQdbs63zRZ0rO0MaXas0kGY3KKtz2lsrUT9e9KBi44F6DI8SV8n6d
 sRpNmAPCmtn1jGRpAjY7mFi/ic3ax163Veria4uM0fqU47Hrx7YOnmL34PaSMeqR5yRc
 9lMQjEkLKAcYuhHy7Tu/q5j2qJcaJumONsB8PHMho/FqbunfvnspNZWK2xprnq713OxY
 dZF0pfreT9X7jwqnJaRa6yk/ir4hY8zPYLrJu+6XXVjynx0Kq+UJK6BEfK14QDVF+nln
 hpvw==
X-Gm-Message-State: AOJu0Yz4AUQQBtdMBy5s4wWJ3Sg6m23hwUITX21QPaHdAS1AOjc//CRl
 0T7ZrZeyZQpTiZLvFX57r2Dn1U4p2EDUbgsTdq6/GQ==
X-Google-Smtp-Source: AGHT+IGpkD2xsr+rgxMVyqd7hKzw9lQxrbyv+l7sgWG+Q+Nt0Y3px9eKMI3FBNQmiBHE4HGgj+PMQg==
X-Received: by 2002:a6b:dc0a:0:b0:795:12b0:c2a1 with SMTP id
 s10-20020a6bdc0a000000b0079512b0c2a1mr933073ioc.10.1696376153327; 
 Tue, 03 Oct 2023 16:35:53 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:53 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 51/51] bsd-user: Add stubs for vadvise(), sbrk() and sstk()
Date: Tue,  3 Oct 2023 17:32:15 -0600
Message-ID: <20231003233215.95557-52-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2b.google.com
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

The above system calls are not supported by qemu.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20230925182709.4834-24-kariem.taha2.7@gmail.com>
---
 bsd-user/bsd-mem.h            | 18 ++++++++++++++++++
 bsd-user/freebsd/os-syscall.c | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index c512a4e3756..c3e72e3b866 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -431,4 +431,22 @@ static inline abi_long do_bsd_shmdt(abi_ulong shmaddr)
     return ret;
 }
 
+static inline abi_long do_bsd_vadvise(void)
+{
+    /* See sys_ovadvise() in vm_unix.c */
+    return -TARGET_EINVAL;
+}
+
+static inline abi_long do_bsd_sbrk(void)
+{
+    /* see sys_sbrk() in vm_mmap.c */
+    return -TARGET_EOPNOTSUPP;
+}
+
+static inline abi_long do_bsd_sstk(void)
+{
+    /* see sys_sstk() in vm_mmap.c */
+    return -TARGET_EOPNOTSUPP;
+}
+
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 39e66312da1..ca2f6fdb66e 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -879,6 +879,18 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_freebsd11_vadvise:
+        ret = do_bsd_vadvise();
+        break;
+
+    case TARGET_FREEBSD_NR_sbrk:
+        ret = do_bsd_sbrk();
+        break;
+
+    case TARGET_FREEBSD_NR_sstk:
+        ret = do_bsd_sstk();
+        break;
+
         /*
          * Misc
          */
-- 
2.41.0


