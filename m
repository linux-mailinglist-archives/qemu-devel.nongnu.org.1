Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8302775DA56
	for <lists+qemu-devel@lfdr.de>; Sat, 22 Jul 2023 08:24:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qN61l-0001lU-5N; Sat, 22 Jul 2023 02:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qN61F-0001l8-JH
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 02:23:10 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qN61D-0004fv-QR
 for qemu-devel@nongnu.org; Sat, 22 Jul 2023 02:23:09 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1bb81809ca8so2795845ad.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 23:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690006986; x=1690611786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Uuareea16HQjMJsl+LvKjlyyFX1fn+ZlqEjqWc7cml4=;
 b=EC1oU8Yu2wRJhZcFevDVdPLBXG4inVW40ssVbOpdONYFCvMlvVdHzj5qbZCVgVq14T
 9X52X9j4beDJD8lPkfk++4pR6h8bWyLgHrIYXAkmWEL91U3YtkMyFOq1sKf45UDK0W4+
 lSeWBn0HbWxKEPGyje0yh0EXUWGlbzMYH+p7wg3AdkbX6vzNpAQOv189IEZg1TZhYitW
 Yyn3f9A6onfkDJsplxRFmoLbtGQ12zCyN2jzgVRnY3+JRzJdSANKWN7KZjQT27nvnf6W
 48z7KA73hrbj3eXVx341gvEtkriuREWm+Sbe1fwryxLaVJ/tJiW42FnDFb5QHE+hSmnf
 H14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690006986; x=1690611786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uuareea16HQjMJsl+LvKjlyyFX1fn+ZlqEjqWc7cml4=;
 b=Nxh4feih303F+37jU5vFy3fwwgyk2jY2KaLa0rPbHzb8kH0YvkcMywP5TtTyW7rlfL
 +L4KLpBiiLT3Jj2cxwuje8WSqHoRCjx15/+caTIbRVwBYIgg2cN6krUlhdODtI9CEAkf
 U86JqSrQV2sMXZiWGD/9agYqWSb8xXwFkxcm0/gPvxXIvv7bp8sZql4wy9ymm4/EtMVs
 e0XVFjUmrWljlzPyHL88fhadXkx2qkKYqFyIzNq+TMZSkcevoovEAvXOrR8tQkGpIJb3
 fmkzIU4AIfJfGS/vNWF2+X+n3Wcfx2gVaNMsKxyCjGbbvCiS/bZsy9TlhrJW18i8Wblh
 YDEQ==
X-Gm-Message-State: ABy/qLaH9gCWdQVQioNrwNGF/uLaANFoRoi/siyBzOn/YlAU+q/QDEtn
 +DrMuddoVLUPnvcIgblTsjxjn6qLcZj+rHFKqzA=
X-Google-Smtp-Source: APBJJlHaygqCOX/TEsYaiU+Jb25W0sMz8LjEUud+ltKrnHN0R4tiaRK9AUXngdBD6OM5N/rnZ/bBiQ==
X-Received: by 2002:a17:903:2341:b0:1b9:d335:2216 with SMTP id
 c1-20020a170903234100b001b9d3352216mr5594186plh.20.1690006986169; 
 Fri, 21 Jul 2023 23:23:06 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a170902989000b001b9be3b94e5sm4509198plp.303.2023.07.21.23.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jul 2023 23:23:05 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/2] accel/kvm: Specify default IPA size for arm64
Date: Sat, 22 Jul 2023 15:22:46 +0900
Message-ID: <20230722062250.18111-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62b.google.com
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

V2 -> V3: Changed to use the maximum IPA size as the default.
V1 -> V2: Introduced an arch hook

Akihiko Odaki (2):
  kvm: Introduce kvm_arch_get_default_type hook
  accel/kvm: Specify default IPA size for arm64

 include/sysemu/kvm.h     | 2 ++
 target/mips/kvm_mips.h   | 9 ---------
 accel/kvm/kvm-all.c      | 4 +++-
 hw/mips/loongson3_virt.c | 1 -
 target/arm/kvm.c         | 7 +++++++
 target/i386/kvm/kvm.c    | 5 +++++
 target/mips/kvm.c        | 2 +-
 target/ppc/kvm.c         | 5 +++++
 target/riscv/kvm.c       | 5 +++++
 target/s390x/kvm/kvm.c   | 5 +++++
 10 files changed, 33 insertions(+), 12 deletions(-)

-- 
2.41.0


