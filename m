Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C43B782C6F9
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 23:05:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPdB-0002xi-Ej; Fri, 12 Jan 2024 17:04:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPd8-0002xU-Hz
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:03:58 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rOPd6-0006Ky-4p
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 17:03:58 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6d9bd63ec7fso4550634b3a.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 14:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705097034; x=1705701834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u4LRimjddHn6FLcDA0l6nIscB51EJIDCBTIf6bI3kl4=;
 b=cgPguSl68uMLCyQ4sukOQKC9cTilFDXpUzSyPkhAnRCCULQ76/2DOQ9J01HgqDGkl8
 Cf0MgOpS2I19dsB4k1qcOs+VrZBxbBiKPSj5k3GeNgdzlR0ngvVAP3CAZ5nwHQVyfqng
 nS9qZk3TMDdRmg/bThDSKLIbZwrhlNK1ZIhAVtkrTtoo2CdaGUWzJ5NYWHX7QCd6vjlO
 h8g9t3NidFdUDGlFWoVBv1RBJrBTynfhEllZjHMpc5BUmAXm+DDGE9EZ1Cfh2Ixlcn2p
 U3ffLKZYYMEscNAC6Xag7qroxXkb/GaHrFH+7yEc2z8cZYYJaoAO/4Luv1pUv7uWn6Ds
 +lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705097034; x=1705701834;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u4LRimjddHn6FLcDA0l6nIscB51EJIDCBTIf6bI3kl4=;
 b=V0yNThT80upLeu28L1g8jS4946poIlCTGgu51XCJnZ4LMj8+O0YahfJQKVsHChjKqW
 3awdT/1s7fAHKjL0fypRlYZxwyBrj7NSvSqDaPg6iRXkF7OwRBcs9pJntoCLv1wyfLAC
 DWz2CW6wqNgzNCaTbwwL9CFJQiY1mpeR4oRdsIB3fmxlepg1MXVtdbEvWzojgTKEmgLH
 w4g9wpWWUp5RHzXXXfuNPJ3KtrAzXZ8LWv9P7Zh0gAo6kyjbuRRA7eH9wq6mL1lZNttO
 HOsGvzYZjEsVxTtSrmRCSHL+ZoW/sOnVWx7Is1aiDtjJSsQ3/4ZyMvTQD1ONpjnqSXRH
 W1Rg==
X-Gm-Message-State: AOJu0YwuYBEFXjenw5g8AYX9JERFQKgzfZPCD+zumY/hh6oQAzKjoQbh
 E+dhC4lJY1IQKmrU7+rkk0jnA2jq8bVR60QoLmTkwwEdnnSNMQ==
X-Google-Smtp-Source: AGHT+IGgwy7uEA26iFbiNC6ypOyzBBG2+zG01V8LftRNjHZKM3G3LidXsdreqIS64G3ZcCGePoaFjg==
X-Received: by 2002:a05:6a20:816:b0:19a:46b8:fd1e with SMTP id
 z22-20020a056a20081600b0019a46b8fd1emr1210287pza.43.1705097034408; 
 Fri, 12 Jan 2024 14:03:54 -0800 (PST)
Received: from stoup.net ([2001:8004:2728:2ad6:e985:c1c8:a4fc:508])
 by smtp.gmail.com with ESMTPSA id
 st8-20020a17090b1fc800b0028cec396567sm6941857pjb.44.2024.01.12.14.03.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 14:03:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vineet Gupta <vineetg@rivosinc.com>
Subject: [PATCH] linux-user/riscv: Fix sizeof_reg typo in vdso unwind info
Date: Sat, 13 Jan 2024 09:03:48 +1100
Message-Id: <20240112220348.49021-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Reported-by: Vineet Gupta <vineetg@rivosinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/riscv/vdso-32.so | Bin 2900 -> 2900 bytes
 linux-user/riscv/vdso-64.so | Bin 3856 -> 3856 bytes
 linux-user/riscv/vdso.S     |   2 +-
 3 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/riscv/vdso-32.so b/linux-user/riscv/vdso-32.so
index 1ad1e5cbbbb8b1fe36b0fe4bcb6c06fab8219ecd..5829c1dc90f1c1aafde69f5b9f5bc9afb85251f7 100755
GIT binary patch
delta 112
zcmV-$0FVFF7StB71OXHyD|k<wiZ(XN!ME<$oE!73r-+KP7y<qQJ!67mgJFbVg<pnV
zhh2zViCc<Vi&>0VjaQCVk5!OVkyDaVlTnmVl~0yVmra;VnM;~Vn@OBVokyNVpGC7%
S1ndF^OjB%HZ#A<;2M+}Mt1p-U

delta 112
zcmV-$0FVFF7StB71OXI7ek-E|Z8Fh9(G%V1AYqwmRqNri7y<qQJz|1jgI<JOg<6JK
zhgOJGiBgJCi%yJ8jY^J4k4BJ0kwTI{lRlI@l{%I<mo}I*nKGI%n=YIzohqIvpC+?Y
S1ndF^P;+@qVQaHR2M+{CwJgd2

diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
index 83992bebe6d0182f24edfffc531015fd2f4e1cfb..de18e35537a493ba35307e93a2d33faaf489c0b3 100755
GIT binary patch
delta 118
zcmV-+0Ez#Q9*`cepaB$miap5s7G5`$2#eqLH6<vG8d2V}v;pe_KY{^*fB}PkgnWg1
zhIof|h;)f^ig1f=jBJf+j%bf&kYtf!l3<fwlw6fsmROfom{gfknoyfgoJ^fco=BfY
YlidYEvmgdT0|snTdTn?%vuO#Z1^ZDlW&i*H

delta 117
zcmV-*0E+*R9*`cepaB$}OC4Olbn*vwtO;!U^UJ?5jVB4Sv;pe_K7av&e1mv|bcJw+
zY=>xwWQkykT#HzYRE<!MOpi#AM3F#}Jd-$-G?g%xESD&lB$*(Z9Ge)N6rB*B44(*-
X-UULl9|lAN23SxxMKVLPX$hwVbapOM

diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
index a86d8fc488..4b4e34aeea 100644
--- a/linux-user/riscv/vdso.S
+++ b/linux-user/riscv/vdso.S
@@ -101,7 +101,7 @@ endf __vdso_flush_icache
 	.cfi_startproc simple
 	.cfi_signal_frame
 
-#define sizeof_reg	(__riscv_xlen / 4)
+#define sizeof_reg	(__riscv_xlen / 8)
 #define sizeof_freg	8
 #define B_GR	(offsetof_uc_mcontext - sizeof_rt_sigframe)
 #define B_FR	(offsetof_uc_mcontext - sizeof_rt_sigframe + offsetof_freg0)
-- 
2.34.1


