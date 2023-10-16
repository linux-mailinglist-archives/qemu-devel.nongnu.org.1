Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 193697CA3A7
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 11:12:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsJd5-0001Z3-21; Mon, 16 Oct 2023 05:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsJd1-0001Wx-BS
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:11:12 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qsJcz-0005IM-6B
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 05:11:11 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-32d895584f1so3703717f8f.1
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 02:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697447467; x=1698052267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=P4S0oCWWp1HrhIb0PvutEkLfJnyOtlPoBBVpSxsD1Gg=;
 b=G0LPetJqhQaKIxCvhwghc0W7jVMOhouw5GCRFCY7apZRedW3iaftEhgmNBwybgn5Sj
 ZeiTaGnnK6MZc9EEX2+B8wQ7258gTa1yw7Lsw3uflCtffuUjm7jIfU4HQKU1prAyBzZA
 M9ejBMEhR63mQK1aynu+JvapNFdChre3gGYLmc7bnAMyCTD0Z9z9IOAfBoDGfqoOTJBE
 BkO0opK7chJegD/zC6R0usd4m+mlhRRgyfXHKyBOr8Rit852ha4/14Y3Fg8VfCZFGVNS
 0VEjgaLUOyCyRjpxQq1LtXjyIieJ+/0gmR/jAgW4WSFN+yoq1/vzq/A22dBJvkqjCoIU
 xjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697447467; x=1698052267;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P4S0oCWWp1HrhIb0PvutEkLfJnyOtlPoBBVpSxsD1Gg=;
 b=NYMbL/2LEUH7Gh/tmEfXIiVH/CtoreT1kOwYyiWgIxqvx5AeFrpFmDA0vmc/ApKbgF
 JQhvW5e+93aK0uHI7Kz2CUaxo7UXBnePob5mvKvxitwZvJK3Vk8riAU4NSzoMVGCybMo
 HzgqU7XrWDYYRF3fykNTrlsnJ+YM4Ofrou6fyZlTtAzGrTiozB4WIR4BqV0HRW93eT1/
 VPyi1dUeVqJAQ9PD7oucG1PF/EPCslI9mNl+hKpzo/sesUuTubyN6esu3uTyQK6AUOs1
 zoKuoD2gmVn2EIrjAKUnPAp2E+G4boJP0yEqgckCkpGyMZApc5pGKu/4pOnqOQKTSiE+
 CbKw==
X-Gm-Message-State: AOJu0Yz+2izxZYeLnPduLT3CbyYiUaTYLmMe0GUl+uNeSuWNZ/e5azBb
 XfLeB7AXVqhuWn+a2SkA3EUpmWifhvpLK83kgH4=
X-Google-Smtp-Source: AGHT+IHv14dckvBqnqSwofde6YMEXVheLbWqRm3j08DynIO7mTd+AMSb64ZVRpOUMZvBS4u7jgjnKQ==
X-Received: by 2002:adf:f6d2:0:b0:32d:b051:9a27 with SMTP id
 y18-20020adff6d2000000b0032db0519a27mr2214843wrp.20.1697447467154; 
 Mon, 16 Oct 2023 02:11:07 -0700 (PDT)
Received: from meli.delivery (ppp-2-87-17-65.home.otenet.gr. [2.87.17.65])
 by smtp.gmail.com with ESMTPSA id
 az11-20020adfe18b000000b0032d87b13240sm4531436wrb.73.2023.10.16.02.11.06
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Oct 2023 02:11:06 -0700 (PDT)
Date: Mon, 16 Oct 2023 12:08:27 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 03/17] meson, cutils: allow non-relocatable installs
User-Agent: meli 0.8.2
References: <20231016063127.161204-1-pbonzini@redhat.com>
 <20231016063127.161204-4-pbonzini@redhat.com>
In-Reply-To: <20231016063127.161204-4-pbonzini@redhat.com>
Message-ID: <2m6ug.d5dtxb4s48um@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42e.google.com
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

On Mon, 16 Oct 2023 09:31, Paolo Bonzini <pbonzini@redhat.com> wrote:
>diff --git a/meson.build b/meson.build
>index 010d2c649c2..251838f2609 100644
>--- a/meson.build
>+++ b/meson.build
>@@ -2111,6 +2111,7 @@ config_host_data.set('CONFIG_OPENGL', opengl.found())
> config_host_data.set('CONFIG_PLUGIN', get_option('plugins'))
> config_host_data.set('CONFIG_RBD', rbd.found())
> config_host_data.set('CONFIG_RDMA', rdma.found())
>+config_host_data.set('CONFIG_RELOCATABLE', get_option('relocatable'))
> config_host_data.set('CONFIG_SAFESTACK', get_option('safe_stack'))
> config_host_data.set('CONFIG_SDL', sdl.found())
> config_host_data.set('CONFIG_SDL_IMAGE', sdl_image.found())

Is relocatable a good choice here? The term is used in linking and might 
be confusing (when I read the subject that's what I thought it'd be 
about). How about 'movable`?

Otherwise:

Reviewed-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>

