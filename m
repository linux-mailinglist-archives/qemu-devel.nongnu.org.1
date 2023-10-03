Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 542D07B7535
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 01:39:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnovH-00045g-Pl; Tue, 03 Oct 2023 19:35:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnovE-00042x-3r
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:24 -0400
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1qnov2-0006go-Sz
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 19:35:23 -0400
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79fa7e33573so58980239f.0
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 16:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1696376110; x=1696980910;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jzja6mNX65PpCCE06Mbtlzy3xvt/FsjtzuhPRGjLIms=;
 b=EqytJkaDM8SWnvM3CJX1ie4CpcfiRL+xluIA+rTFLy0b8Qtr6NzlvRNLCotygRyhMk
 8aEkrVX3nb+QGEJVrFCPJSm4U2WAhGJcZK82PdsVWjnsnh+c10PzbKkILTqE6Ko1siFB
 j4L/qpbg/BZDO1uCGZHiUf/LMdZA4AevsIPjZ7Bko3JArENFOqY1ckoUem4rIrzUF480
 IDWcn34e2s9o2F1C7WZ6Dendm1gWeHCInGUn+UyftXH0+jqf5Jd6P7kLW/Ij8h5qZSko
 v2lGEMbgIRgPsx0WeS0+vE/sAq7dg30WIPbnpPt1rCNlU39B4s3h6IlnyQKWtqNBitvc
 pKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696376110; x=1696980910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzja6mNX65PpCCE06Mbtlzy3xvt/FsjtzuhPRGjLIms=;
 b=MGrB1zAS+ynUp2uni3QU3tLH37shipc56RjiuShRqcWYOv57i5NLNhRgHJ3EJ8WsHO
 PEA+lKtsZB2Pg7q0axPBdiaH+lMUQgynGZTAN8s73Ox6VCEL/Tf+r2HIXBcD3IGDEtZv
 cpQa/BF/lQqk9brRwsDBAkLfGgm7ei9PeruKE+hykvQpWuDdxc8ddEK0fY4x4x8ldmK0
 gb4Ifi57edxNoAUCYYaYuYR1DjOsA88/O7uqLBZF1N4NOPOwEWBNH620vcBEKgNCmGqI
 9hKdrUnAY3sJGYCQm/KMv/z2bjb/IMPeQeO9oo/VvUAwXUY8xHLFXf6wgPGo77ekw3aD
 x8iA==
X-Gm-Message-State: AOJu0YyAnB5fLovlLuSYmXDgnrtoUe4GTNUagEcIzokB6eq+yyXFN1iQ
 RAk5jtDaDnNrfe1uAC8ZZ3uSl7/s4dy472PRAsjvPg==
X-Google-Smtp-Source: AGHT+IF/BCWCGZiB7eEc3AFzNcEWEKbSfeTt/NuYIOfecsuJkLwQ5ZIlvWL4WnLoEtwt1bddfPOkTA==
X-Received: by 2002:a6b:6514:0:b0:783:550e:33c0 with SMTP id
 z20-20020a6b6514000000b00783550e33c0mr961383iob.7.1696376110631; 
 Tue, 03 Oct 2023 16:35:10 -0700 (PDT)
Received: from dune.bsdimp.com (50-253-99-174-static.hfc.comcastbusiness.net.
 [50.253.99.174]) by smtp.gmail.com with ESMTPSA id
 w25-20020a6b4a19000000b0079fa1a7cd36sm593596iob.30.2023.10.03.16.35.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 16:35:10 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Stacey Son <sson@FreeBSD.org>,
 Karim Taha <kariem.taha2.7@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/51] bsd-user: Add freebsd_exec_common and do_freebsd_procctl
 to qemu.h.
Date: Tue,  3 Oct 2023 17:31:28 -0600
Message-ID: <20231003233215.95557-5-imp@bsdimp.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231003233215.95557-1-imp@bsdimp.com>
References: <20231003233215.95557-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2a;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2a.google.com
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

From: Stacey Son <sson@FreeBSD.org>

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Message-Id: <20230925182425.3163-5-kariem.taha2.7@gmail.com>
---
 bsd-user/qemu.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index d9507137cca..41c7bd31d3c 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -249,6 +249,12 @@ abi_long get_errno(abi_long ret);
 bool is_error(abi_long ret);
 int host_to_target_errno(int err);
 
+/* os-proc.c */
+abi_long freebsd_exec_common(abi_ulong path_or_fd, abi_ulong guest_argp,
+        abi_ulong guest_envp, int do_fexec);
+abi_long do_freebsd_procctl(void *cpu_env, int idtype, abi_ulong arg2,
+        abi_ulong arg3, abi_ulong arg4, abi_ulong arg5, abi_ulong arg6);
+
 /* os-sys.c */
 abi_long do_freebsd_sysctl(CPUArchState *env, abi_ulong namep, int32_t namelen,
         abi_ulong oldp, abi_ulong oldlenp, abi_ulong newp, abi_ulong newlen);
-- 
2.41.0


