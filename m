Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F48E831D26
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 17:03:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQUrJ-0001P8-MJ; Thu, 18 Jan 2024 11:03:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQUrA-0001Jn-5J
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:03:04 -0500
Received: from mail-io1-xd34.google.com ([2607:f8b0:4864:20::d34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manolodemedici@gmail.com>)
 id 1rQUr8-0005Cn-7k
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 11:03:03 -0500
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7ba9f1cfe94so19493539f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jan 2024 08:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705593781; x=1706198581; darn=nongnu.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pHLx0RWDrMD/U0a4mVTOtedBh+Y/pXU8iVfMzavoMiI=;
 b=ZAfAYVXBwwP0j0qVG+Rd38Xk5uA+EXBzoHAGgcQw9Yq/GHvQJH59m8J0YomLbRxBmb
 d8lshtVGNNKOcNuOTcJw8nJGvKBt9H5I5BXULSqPshWAXE1dZsxm/FuXXDibwa9Zgvr0
 IVH76IsvYF+ZeDC5Ywp2RWaV/UqXVAdcZPxJ2f8kSFIemMIFU2qKo/mwlrOK7KOTHvA2
 +ebz8t6No0t769z9McPn4DnHWfO8FCqDj8pYtmtg7Jus5WLoNwF31Z8UIPwcPmTCvdFx
 9HuW2RrpEuO2H/EQKKYKRk5FoRQBLyiu4q5hqF6rYc/DrIKxaar2aoIEbELlIe3tJeS8
 lwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705593781; x=1706198581;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pHLx0RWDrMD/U0a4mVTOtedBh+Y/pXU8iVfMzavoMiI=;
 b=kKIoVOCu61M1XBgKeSGZfqe0ECQT+6J+aoELeqTwZ8KpixxpUT9k+NAPtAKDnmr8PP
 xNQrakTt1VPCmoyUpW5YqykJtziF4Bm0RIoyol585gleX2mv6ZBmQ5meg9hmaUJBLzSs
 5CD42GAvo/p8rlCAM8qbFr/zDpjROFnlp9TOdt/j1ibyzzUEeJaTNZUNbt98P7St6Xdq
 FfRwkAGGo1y+QhR3M8hLdLsehswPFP0Occ/B56ePwU0LC4n9wcrHABiLNsgyPVQ6yF8E
 4dVt2fcb7PFcdJxDQNpdP7sTfDtYxNiL/+oPUCDBgQopPT635V28/pbrMa8d5CP3Uvsv
 na4w==
X-Gm-Message-State: AOJu0YwhMh9+MPEH0xOJ6MVR3DA5OUY7ha1jaRZTFslen1pw6SbX46VW
 lWyLHJDAUHLDvmBRho45oHATlGZissfbVU7p0/aoAssiOeqIq3bxt+ENlZB5Ph++XrxrYG10NLg
 ysH1MGwdPJBfsKqfhCAhixhIQkcQNfXZZvps=
X-Google-Smtp-Source: AGHT+IEsKWDRu6dSKlUlhhFeMYkFXRao3Jj+CLkL5e9Fs5BQyaYPV/wwXf1uoNEUQp9Ptd6eGp/JTrOGDB4FWDwxD/k=
X-Received: by 2002:a92:b09:0:b0:360:73de:be5e with SMTP id
 b9-20020a920b09000000b0036073debe5emr827934ilf.14.1705593780915; Thu, 18 Jan
 2024 08:03:00 -0800 (PST)
MIME-Version: 1.0
From: Manolo de Medici <manolodemedici@gmail.com>
Date: Thu, 18 Jan 2024 17:02:55 +0100
Message-ID: <CAHP40mnyxgmwY39jKMHsZCrCXdozNwFO+RDTYMPUhfkGu_pfFQ@mail.gmail.com>
Subject: [PATCH v2 2/4] Avoid conflicting types for 'copy_file_range'
To: qemu-devel@nongnu.org, bug-hurd@gnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d34;
 envelope-from=manolodemedici@gmail.com; helo=mail-io1-xd34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Compilation fails on systems where copy_file_range is already defined as a
stub.

The prototype of copy_file_range in glibc returns an ssize_t, not an off_t.

The function currently only exists on linux and freebsd, and in both cases
the return type is ssize_t

Signed-off-by: Manolo de Medici <manolo.demedici@gmail.com>
---
 block/file-posix.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 35684f7e21..f744b35642 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2000,12 +2000,13 @@ static int handle_aiocb_write_zeroes_unmap(void *opaque)
 }

 #ifndef HAVE_COPY_FILE_RANGE
-static off_t copy_file_range(int in_fd, off_t *in_off, int out_fd,
-                             off_t *out_off, size_t len, unsigned int flags)
+ssize_t copy_file_range (int infd, off_t *pinoff,
+                         int outfd, off_t *poutoff,
+                         size_t length, unsigned int flags)
 {
 #ifdef __NR_copy_file_range
-    return syscall(__NR_copy_file_range, in_fd, in_off, out_fd,
-                   out_off, len, flags);
+    return (ssize_t)syscall(__NR_copy_file_range, infd, pinoff, outfd,
+                            poutoff, length, flags);
 #else
     errno = ENOSYS;
     return -1;
--
2.43.0

