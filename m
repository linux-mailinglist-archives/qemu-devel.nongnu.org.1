Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE4800D30
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Dec 2023 15:33:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r94Ys-0003XH-Qs; Fri, 01 Dec 2023 09:32:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r94Yq-0003Wk-D8
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:32:08 -0500
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r94Yo-0002Vm-R0
 for qemu-devel@nongnu.org; Fri, 01 Dec 2023 09:32:08 -0500
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50bc39dcbcbso3052982e87.1
 for <qemu-devel@nongnu.org>; Fri, 01 Dec 2023 06:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701441124; x=1702045924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xwueZRhq2TeT+o6ic/j7f+3sIl0gG5LOrM78r5l+kjU=;
 b=Invc9+kvLZq270IOoDOuttweEKt0LckhVbUsCy5T1iWffq0wKniCpYHXPjPxwCRAL1
 yAwwd9zxJifS9r76Q0PQA+0q7mtF7EbNE42TEzfKQqHJ2qzmzkA2CwlWEDwXnNS3mRXD
 b4mD8jHRleFhLSYjzn3+b7ReRZN7zpzglvo0mj6TCwJ+1B6WvuHeQLEKXewPh/4wCy5s
 w1WXovKXgVVJiFVcSxoOBCcAsfUM1/BESvZ3KAm1LINuYF7gTLjavH7VL/frNsjj+W6X
 iI/EGfuTc967o72eO+LSvExOcptpHKRE8NxzZZd1Pn0ZVQUW8SWODV6uoXJlQjUVQWRJ
 3JmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701441124; x=1702045924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xwueZRhq2TeT+o6ic/j7f+3sIl0gG5LOrM78r5l+kjU=;
 b=SQIsoe0QElh4pc1xnTj/Ic/8JrcY21sR/gkeVfZaW/sSVrg5Mp9w0cN9DRp/xEZJly
 0HsY3c0vHg/5zvxIYNchUdPmmLBAtB7uw+noduWUAAyaOGnzcH7ZHcuf1rhTdwlOeKfd
 SjxeyyEfVAQpyTJuPzOzrksFXtRiuF8UilzD+V64fUSAm8gZsggtajtj1J2cbTihG8iT
 NEfx5hpGDBmk4gC8422+s+cqWdp/aZ7ANQuI9/2NqREVHViJ7uyCb2mw77fSdRCR7OHr
 Vorf4YHE1lC0whwa2XVVYhEHyjTP8TK5Fk895EStsAQfQ5DWzBJOcpcJ3OM3CUfrcNSv
 m1vw==
X-Gm-Message-State: AOJu0YxAvngqrA2WEfgPssV+tyHNJjiYoRnGwKHuvxKOenwMfp4+8bQY
 HIddpElLE1D75ejjGvvUXPFZvsZ37T8QxrYktzY=
X-Google-Smtp-Source: AGHT+IG+i5oTJrMGcXU3dLzjwDLlF60WGvP45lcq/lrWskltUNDKHSHfD6UrYjW0v1l+7x9xMDtklg==
X-Received: by 2002:a05:6512:318d:b0:50b:b834:d3c0 with SMTP id
 i13-20020a056512318d00b0050bb834d3c0mr1133486lfe.32.1701441124226; 
 Fri, 01 Dec 2023 06:32:04 -0800 (PST)
Received: from m1x-phil.lan ([176.176.160.225])
 by smtp.gmail.com with ESMTPSA id
 f12-20020adfdb4c000000b00332d3b89561sm4338984wrj.97.2023.12.01.06.32.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 01 Dec 2023 06:32:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 0/2] target/arm/kvm: Use generic
 kvm_supports_guest_debug()
Date: Fri,  1 Dec 2023 15:31:59 +0100
Message-ID: <20231201143201.40182-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

Expose kvm_supports_guest_debug() to all targets
and simplify ARM using it.

Philippe Mathieu-Daudé (2):
  accel/kvm: Expose kvm_supports_guest_debug() prototype
  target/arm/kvm: Use generic kvm_supports_guest_debug()

 accel/kvm/kvm-cpus.h | 1 -
 include/sysemu/kvm.h | 1 +
 target/arm/kvm64.c   | 9 ++-------
 3 files changed, 3 insertions(+), 8 deletions(-)

-- 
2.41.0


