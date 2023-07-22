Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 463FC75DAEC
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 09:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN7QV-0001md-5j; Sat, 22 Jul 2023 03:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qN7QT-0001lu-2U
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 03:53:17 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qN7QR-0005PP-C2
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 03:53:16 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bb775625e2so4900305ad.1
 for <qemu-devel@nongnu.org>; Sat, 22 Jul 2023 00:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690012394; x=1690617194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bN+VKWG1+IOztgVSANu62XflYn5gYOmAgQC0VPwsiCw=;
 b=jQon0Yf7szj552v/VCJW+ipTm6W/fJ6WLkXV8j6S/O5zS6i6eBpUB1zltCWR3QiNfB
 3DrbDOokD6olH0pQTQRiXfI2jXguQGmNIozBjB4OdQqQUyLANxYCFNp/KJXzYhUVRwGe
 7nddYdqd0KTVHc6IN/VboBxvHON3PJW8Cti8wkAgHELYJrYaf8izW6o6IpGP+YGWQRmD
 OBctte/l2ulLpFKFFfoSJi0hRhfm/F0oxcgJUy5ibrz9j3D2rFkyuSGTNG+nsmK9zf8u
 gOt0jl94wFNZoatpSFDff3gvwAO+PHyyOqeocpyHadlfr7Vpk23eqeOe4bEMWvvUwcqt
 a6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690012394; x=1690617194;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bN+VKWG1+IOztgVSANu62XflYn5gYOmAgQC0VPwsiCw=;
 b=JBVTZ4snHJ2gWun1LxMJiDAUqFT781JaKKDWrNZBH7Auo0x91vTf2chK0dEOKkTTTk
 jgayFvzG14WsuRsFZ6iw0PSpFPfNzjzck7315FwoGYDllF/ksA01fTTPlYoCNZcVrq2D
 FIbKwJKQLnHqoC6YxtFVoBNMJVcOGTP13Jcb9LCyK6jQxNh6CPmfMxpEDSqrVLYQ4kUe
 mHzUgAPJR1wAqRfQ7dfM0y6aT6Kq7lhOin7XoSyhBgjGOjgxNryFI1OasUJ7gTn/tw9t
 B8YZHF/0137wPuMvahdgQfHkhphBFrLwbKyoQsrNNqorEKl+dy0U886POddFBCkGAoNO
 IJgg==
X-Gm-Message-State: ABy/qLYDiYPAt1NHMDTTpsMuKVF7Heyn6sMlfr5H6q+Zbh1uOBnFj+Qi
 BBO9cEkk0ryxrY/L4rMc5xamKVet7qZAG6EvCWE=
X-Google-Smtp-Source: APBJJlGa5lYO3zvqjWaxdvLxHQCwPfMohLqfWOXm43zeaW4njVX59Op2uErrSdHR/A53vZa2JwjCcA==
X-Received: by 2002:a17:902:f7d1:b0:1b8:76d1:f1e8 with SMTP id
 h17-20020a170902f7d100b001b876d1f1e8mr4644921plw.28.1690012393834; 
 Sat, 22 Jul 2023 00:53:13 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 i17-20020a17090332d100b001b86dd825e7sm4753119plr.108.2023.07.22.00.53.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Jul 2023 00:53:13 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/2] accel/kvm: Specify default IPA size for arm64
Date: Sat, 22 Jul 2023 16:53:04 +0900
Message-ID: <20230722075308.26560-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Some Arm systems such as Apple Silicon Macs have IPA size smaller than the
default used by KVM. Introduce our own default IPA size that fits on such a
system.

V3 -> V4: Removed an inclusion of kvm_mips.h that is no longer needed.
V2 -> V3: Changed to use the maximum IPA size as the default.
V1 -> V2: Introduced an arch hook

Akihiko Odaki (2):
  kvm: Introduce kvm_arch_get_default_type hook
  accel/kvm: Specify default IPA size for arm64

 include/sysemu/kvm.h     | 2 ++
 target/mips/kvm_mips.h   | 9 ---------
 accel/kvm/kvm-all.c      | 4 +++-
 hw/mips/loongson3_virt.c | 2 --
 target/arm/kvm.c         | 7 +++++++
 target/i386/kvm/kvm.c    | 5 +++++
 target/mips/kvm.c        | 2 +-
 target/ppc/kvm.c         | 5 +++++
 target/riscv/kvm.c       | 5 +++++
 target/s390x/kvm/kvm.c   | 5 +++++
 10 files changed, 33 insertions(+), 13 deletions(-)

-- 
2.41.0


