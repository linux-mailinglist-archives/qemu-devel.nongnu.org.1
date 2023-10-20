Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 942F97D0F93
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:21:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtoUk-0001da-Od; Fri, 20 Oct 2023 08:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtoUe-0001ay-6R
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:20:46 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qtoUb-0007tq-73
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:20:43 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-2c50cf61f6dso11705011fa.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697804438; x=1698409238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zdtqZofbDunWz3e7qXcpiNxmixw8yaCSKWaDeJEwaYo=;
 b=wMpmE/3jFs+5krUfGxAeVmTyHjnx95PUQuifKT1L1RLRNVccY8lIMErrfiC/UyIuyz
 l2D11FfnwAOhzUrIw4Hv6EsIRSxJCsbAHLVAN1TlqqYtw1/QyjnntQoZL69NC7ke4ED1
 H6vNx0bVbBV4ELGEexqODR44BT/y5yIlsXI+Ltbd8wm3GN5mSywXKpuQYRPIIFNBn/cW
 Y+Vzvvoz5ctsp2f/zrUKgCP1v2QgZcMFovNvlgQwIo8sIkRhI2Axaegx5mUYus+rEzfu
 j31UoxBfQW++DFOzDLLRGpVFn0IMu9DUHnAU0vHjvbda1gqEh22+ogugKk9wZM9KcIX2
 Uzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697804438; x=1698409238;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zdtqZofbDunWz3e7qXcpiNxmixw8yaCSKWaDeJEwaYo=;
 b=fVaUsj6BcLDffCujFlnG4yIxexab7bg+VXOHV/c234cvlwsIEUFOiAOSZbuFJHXAM0
 7S1QZhE+UVXLttE8Dw9Kf/3BVpUR2JSCTUCXAc5alqUJ5UjyljXsL2ZYqeouNpz6PT+I
 stJ/x+ko/R4wifshMNCkn2tq/6qS9g4CUmFzzQ00oRD6WdKSdz2BNJ7dtpp0Ho7DY6xg
 bsjcrUw8tkTodM9R9NcjWnXco2cqhHwx9xJloj5aE8dmahVYgoGohl4HIyJauC3+gA/u
 +l0QonBNUk9DGAxJP5PMShs9+G/ITAtBEAeA5Wn35zJrDnUg3zYzxRcxNgiUsvBl8ed8
 k6+g==
X-Gm-Message-State: AOJu0Ywcb3sAWPMw9X/vCKR09q84dPzfOzhK9BQqL5lcL5OcnIQzlWWd
 DYNow1B9ukjtk5q9b7pFMOGFvLUy4B7B1w0sm9g=
X-Google-Smtp-Source: AGHT+IG02NTrstYHUd5OLBReoyp3qBvZ6breu16iy2EgH9a1+cT5xxrjRTlBcHE5Sm+4G7FpdP7N6A==
X-Received: by 2002:a05:6512:546:b0:507:9fc1:ca7a with SMTP id
 h6-20020a056512054600b005079fc1ca7amr1276922lfl.9.1697804438660; 
 Fri, 20 Oct 2023 05:20:38 -0700 (PDT)
Received: from meli.delivery (adsl-165.37.6.1.tellas.gr. [37.6.1.165])
 by smtp.gmail.com with ESMTPSA id
 o7-20020a056000010700b003232d122dbfsm1573075wrx.66.2023.10.20.05.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 05:20:38 -0700 (PDT)
Date: Fri, 20 Oct 2023 15:19:37 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: 
Subject: Re: [PATCH 01/17] kvm: remove unnecessary stub
User-Agent: meli 0.8.2
References: <20231018163728.363879-1-pbonzini@redhat.com>
 <20231018163728.363879-2-pbonzini@redhat.com>
In-Reply-To: <20231018163728.363879-2-pbonzini@redhat.com>
Message-ID: <2tuac.nbt0cz1cv5i@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x230.google.com
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
>This function is only invoked from hw/intc/s390_flic_kvm.c, and therefore
>only if CONFIG_KVM is defined.
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

