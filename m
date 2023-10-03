Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A09BF7B6210
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 09:05:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnZSP-00012W-TL; Tue, 03 Oct 2023 03:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZSO-00012B-22
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:04:36 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnZSM-0008M9-KV
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 03:04:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4065dea9a33so5288165e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 00:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696316672; x=1696921472; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t7bRjku5e3F1u88Ym725On2StuO+R/NkzZcj5nwce/E=;
 b=kEzhtjQ+jKup9isc4rdP0C7ic4a2HE+S3MigdoC++UTtCuN7k6eWw6jOwF1NqtoeLq
 6rp+lDP3eVFDkDo5av7lmpzMWxCPBc1Iy4NnpOzNTTVzlbXCp3RbDFdOMe5HYWOuUcvz
 yew2LVzYoO715m/VY5QF/C8s26uviLO9r22QxJ4NIHdSZyMbSD6lBrvtbBraP+joSza8
 n6tAID/XLJ4BWxWX46VODt7JaUFs2skKmOYRpT6rJRHzlPJS1C+c5jqxKz6ZrBH2vCGd
 xDSUcrC6OnTOSt7HHPoGp37g+khgc+iL/srJGxzM5qyyVBStDz17XLyFr8AbQ6X30R0v
 Uviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696316672; x=1696921472;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t7bRjku5e3F1u88Ym725On2StuO+R/NkzZcj5nwce/E=;
 b=u/U054tffOAZEBxFwI8P6nZhu7bPgEPcxeVO5UwIzOnQ8VaRtxTGMonqRk57aEaSJ9
 k6rkwnj2M8KLAUCcBGcQNpkiqYfLsL1saGfOYqmlX+I6batMrbFe/v/DHDrlarAbIL32
 7uEVcihC3Pb8JNaR2GqTy8IPF8CXLH0TKPwUvjivaCythUvpzpUDo2SXhLvNWAxu1dFm
 lbwXXO51d82dIy7IFufTi6Lp1IMiFxlfSvH+0xuzV3dleCOqNrK7AZuylLcC4a56RLiI
 rFdwctLupPtDyNsWQh/t0Gc9x8NiHIuhVgwuDWsRqHqFR0Pj2AwNQQ0VN/CCtZK/hpD9
 cz4A==
X-Gm-Message-State: AOJu0YwuIU5rOd4vHxs3ZVgdc4PKCKGCLX7aPjgALG7znUUw/K0gvOKh
 galtngSFybi/xd0MNIPoG9Xz1aqrb3Wjcti1T92l7g==
X-Google-Smtp-Source: AGHT+IEp17Lzh57Gx8VFBOlfoslRVPDGk0mKkvOGCp+wHJhaOAQkNaX7qg2XuEwgXd0EbxU8JqNFrw==
X-Received: by 2002:a05:600c:b59:b0:3ff:233f:2cfb with SMTP id
 k25-20020a05600c0b5900b003ff233f2cfbmr11266364wmr.23.1696316671193; 
 Tue, 03 Oct 2023 00:04:31 -0700 (PDT)
Received: from m1x-phil.lan (176-131-222-246.abo.bbox.fr. [176.131.222.246])
 by smtp.gmail.com with ESMTPSA id
 t15-20020a1c770f000000b00406408dc788sm8666076wmi.44.2023.10.03.00.04.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Oct 2023 00:04:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Greg Kurz <groug@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/4] target/ppc: Prohibit target specific KVM prototypes on
 user emulation
Date: Tue,  3 Oct 2023 09:04:22 +0200
Message-ID: <20231003070427.69621-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Since v1:
- Addressed Michael review comments,
- Added Daniel R-b tag.

Implement Kevin's suggestion to remove KVM declarations
for user emulation builds, so if KVM prototype are used
we directly get a compile failure.

Philippe Mathieu-Daudé (4):
  sysemu/kvm: Restrict kvmppc_get_radix_page_info() to ppc targets
  hw/ppc/e500: Restrict ppce500_init_mpic_kvm() to KVM
  target/ppc: Restrict KVM objects to system emulation
  target/ppc: Prohibit target specific KVM prototypes on user emulation

 include/sysemu/kvm.h   |  1 -
 target/ppc/kvm_ppc.h   |  4 ++++
 hw/ppc/e500.c          |  4 ++++
 target/ppc/kvm-stub.c  | 19 -------------------
 target/ppc/kvm.c       |  4 ++--
 target/ppc/meson.build |  2 +-
 6 files changed, 11 insertions(+), 23 deletions(-)
 delete mode 100644 target/ppc/kvm-stub.c

-- 
2.41.0


