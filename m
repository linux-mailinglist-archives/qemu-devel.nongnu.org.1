Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC4B771C7B
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 10:41:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSvmq-0005IO-S7; Mon, 07 Aug 2023 04:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qSvml-0005Hv-CS
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:40:19 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1qSvmf-0005yq-SC
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 04:40:19 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1bb893e6365so26489185ad.2
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 01:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1691397612; x=1692002412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=g0bTpnzWG0O3NVLO6TCIQyRtHyybTdzTBPWD/KXQfLM=;
 b=lzGO/+P+KGpQke2ImxRJEvhrKNKbrGmwvG+8F2OqOv0q5pxRH0ADdtqZLRF5HuNQ1k
 nLNfFp3TX1jH+rcud8x6+k9GQb5KDLH9SI9ktx/TS2tixGPWeOYnI84I5klgfeuxDuXK
 imOo1dcqx1DiwBB1J5N+NCPp2hUzrlb2m1SplPjSAHJRjHcRa8BO24ASPO8KiXrbfclO
 f1zRh9N4h6VR/Tk4T+JW2QTlnVai6HAO7mR/MQwIylWICr6PuywZrmFnmFTxEbOifkN9
 mPl8TIGww90DxfMGFtIfiETn/kPMQF+Ujk4ULF2rtG9MCpMGra5YXp1wvCcydEpy7kiQ
 kYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691397612; x=1692002412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0bTpnzWG0O3NVLO6TCIQyRtHyybTdzTBPWD/KXQfLM=;
 b=b/+uVM6fNeHyymjiPUNbZJVtoMBouN82rrFw43vSNJGJhFnfPlniI426rAIDIw98FT
 gMkRLa+ivKT1Q6w70vkU659DEGiHxk1JfHWkGrUONssGLMNM8aYFB+AD+GsByZdVhH2Q
 sfwqb0PX84rW6re55J2fcbK77h5COowISVBp86zXTg+Z8g1FKa0HB3iWcF1gvoRTMeeZ
 MVjz19zGXprLUJYr8QHpTQvK8PQG19KLrN7SS/PBpFBpR9o+vv+RJha5Ui2TJmAFShaI
 dWwEy5+om4dwIJzo/I3AZ5mz3fwb5WXJOKdM5q/b/2Eow9MviAkD6+AlMHHi0G+mP8DP
 IqCQ==
X-Gm-Message-State: AOJu0YzfwuxWm6MBXGzZ7phabBrnuPK/MdRmp+UpnuhcYmaMjLBvt4a9
 ZG+c6FJIZQCqpIjr0Lz8QeU=
X-Google-Smtp-Source: AGHT+IFza0dMAybnzG07HD0x0JcgradxVuI2tRHZaTxlrPIWDY3+fkkBqSpCvSFWNtO6PIGLd7XetA==
X-Received: by 2002:a17:902:ecd0:b0:1bc:7001:6e62 with SMTP id
 a16-20020a170902ecd000b001bc70016e62mr1212676plh.35.1691397612221; 
 Mon, 07 Aug 2023 01:40:12 -0700 (PDT)
Received: from localhost.localdomain ([45.124.203.19])
 by smtp.gmail.com with ESMTPSA id
 u18-20020a17090341d200b001aadd0d7364sm6301766ple.83.2023.08.07.01.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 01:40:11 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: [PATCH] configure: Fix linux-user host detection for ppc64le
Date: Mon,  7 Aug 2023 18:09:50 +0930
Message-Id: <20230807083950.29521-1-joel@jms.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=joel.stan@gmail.com; helo=mail-pl1-x632.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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

Revert the changes in the recent "Fix linux-user host detection for
riscv64" patch as it broke ppc64le. Instead add riscv to the switch
statement that performs normalisation of the host cpu name.

Fixes: 89e5b7935e92 ("configure: Fix linux-user host detection for riscv64")
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
Tested on a ppc64le host. Please check it works on riscv too.
---
 configure | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/configure b/configure
index 98dc78280e67..fd0efa69bc36 100755
--- a/configure
+++ b/configure
@@ -469,13 +469,6 @@ else
   echo "WARNING: unrecognized host CPU, proceeding with 'uname -m' output '$cpu'"
 fi
 
-case "$cpu" in
-  riscv*)
-    host_arch=riscv ;;
-  *)
-    host_arch="$cpu" ;;
-esac
-
 # Normalise host CPU name and set multilib cflags.  The canonicalization
 # isn't really necessary, because the architectures that we check for
 # should not hit the 'uname -m' case, but better safe than sorry.
@@ -508,6 +501,9 @@ case "$cpu" in
     cpu="ppc64"
     CPU_CFLAGS="-m64 -mlittle-endian" ;;
 
+  riscv*)
+    cpu="riscv" ;;
+
   s390)
     CPU_CFLAGS="-m31" ;;
   s390x)
@@ -810,7 +806,7 @@ default_target_list=""
 mak_wilds=""
 
 if [ "$linux_user" != no ]; then
-    if [ "$targetos" = linux ] && [ -d "$source_path/linux-user/include/host/$host_arch" ]; then
+    if [ "$targetos" = linux ] && [ -d "$source_path/linux-user/include/host/$cpu" ]; then
         linux_user=yes
     elif [ "$linux_user" = yes ]; then
         error_exit "linux-user not supported on this architecture"
-- 
2.40.1


