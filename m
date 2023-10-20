Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AE5B7D0FA5
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:28:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtobz-0007vx-Lr; Fri, 20 Oct 2023 08:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtobx-0007vV-CO
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:28:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtobv-0002OH-Q3
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:28:17 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so6299325e9.0
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697804893; x=1698409693; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cwTvZKcaEjTu9+xh86tNUadoic0MXHKQPems1msTY1U=;
 b=sw2tGGU0f/I0Vzp5aSMMM+u++hCInzCrQ/NaWzolavHM25O2EHdkTGBtRR0z0hdPyG
 geqfU1fdSZsdoth4XCMKhNUXNSXtQimhDMPyvva2zvph5x9voXq9mCQvf/KhiYlJcN55
 IZO/rSPKzeyWxbLwTsq/tZU4JhQUsCuEVbfNUSwYXqR6B03066AXZ6RSjntD+XULMQnj
 Fo1u4bEx+IF27MR+b7Uh3Iom0XFqkqHVSUeahLwSVJZp9DOAjwW6tSMCliL2cLLIWzTC
 pJFyCziBRDP9UWcNmK40yuLGwmN8QaRcROBX/6LvXiyhftYZPfts4dJ3/LkVBC7YrVPD
 nCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697804893; x=1698409693;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cwTvZKcaEjTu9+xh86tNUadoic0MXHKQPems1msTY1U=;
 b=iGCUPElMioI6COvnNhSKjF3JPpdtcvtY7Bc8mnb2ugM7VOA+jM61XQIpf+uqTpDzj4
 8jCQQ55zhiFVahSo0TEq8KL2k7Api0Z2LbWKxEOCpRa3i9+cbA0DrLU7d3bM5EyyXrgP
 pRBkWiZA/fIvr5QWTza/YfA23Z0WGP2QThTFfpjNEBx8hBTCokUIIAh2rQ+/viQppo4e
 R4Mzu1F8K7DiRelPRut2WmyMdgqjgtZNRNXAzvZMZZKk+pXsamjEciVdZZwCQDQKU8gV
 IFqU2IN8qftOeZY4IXIyK2v7LynQZ7w+zlICdW7VzUfbnn9GvpirPsdxzQmg/vmSVJ5n
 o1Cg==
X-Gm-Message-State: AOJu0YxHijzVmQRwTYNKLA+gh69UZodrcOS/Rc3WopKPx8k9+cnTjJCs
 I31HsACaKkS3QN8pogCeKuif49GtYGjYRIkgqng=
X-Google-Smtp-Source: AGHT+IG3RwSBBAZ4N2Apk23FJXrXSx9bbClhSKr0EJjdZEFjopSrNQsvUe6zesz5aoWHguBKgF0AEg==
X-Received: by 2002:a05:600c:5249:b0:401:2ee0:7558 with SMTP id
 fc9-20020a05600c524900b004012ee07558mr1303451wmb.32.1697804893577; 
 Fri, 20 Oct 2023 05:28:13 -0700 (PDT)
Received: from meli.delivery (adsl-165.37.6.1.tellas.gr. [37.6.1.165])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c45ca00b00407752f5ab6sm2107647wmo.6.2023.10.20.05.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 05:28:13 -0700 (PDT)
Date: Fri, 20 Oct 2023 15:24:27 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: 
Subject: Re: [PATCH 04/17] kvm: require KVM_CAP_IRQFD for kernel irqchip
User-Agent: meli 0.8.2
References: <20231018163728.363879-1-pbonzini@redhat.com>
 <20231018163728.363879-5-pbonzini@redhat.com>
In-Reply-To: <20231018163728.363879-5-pbonzini@redhat.com>
Message-ID: <2tumz.a27pk52hntp7@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x332.google.com
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

On Wed, 18 Oct 2023 19:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
>KVM_CAP_IRQFD is always available on architectures that support an in-kernel
>interrupt controller, and was introduced in Linux 2.6.32.  We can require
>it unconditionally.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>---
> accel/kvm/kvm-all.c         | 13 +++++--------
> accel/stubs/kvm-stub.c      |  1 -
> hw/intc/arm_gicv3_its_kvm.c |  2 +-
> include/sysemu/kvm.h        |  6 +++---
> target/riscv/kvm/kvm-cpu.c  |  2 +-
> 5 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

