Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F2C7DD163
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 17:19:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxrR6-0007Zb-NB; Tue, 31 Oct 2023 12:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxrR5-0007Y1-7x
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:17:47 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxrR3-0002BM-Q7
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 12:17:46 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-542d654d03cso5407148a12.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 09:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698769064; x=1699373864; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xBSyK3FHQ+KE2LrZmhqh+WokgESDBygvJ4SHaVNO608=;
 b=a6xy5gBioCWShRgALPEVlYxsQywi2ljzQvjiXLqBCjCwDtr757wemOJqdEX+rgHXsV
 T4UfTi5QAzbO2XgTw2GywZj6DA6kTj3F2H9BDJ1c1f30bF5UrNuJoRFylTRzTmL/IjJK
 vJgWrYe8iAnHYesCTAzKZmAZXWloduZ+TY7lCPTnEJanAmtTiUecdQn086oejzNJw1cR
 mraMeB6WR8g5Trt3EG9gptiPmnvy/UifjzLCmS8C3XXFxeFd3d4cjpiX+za+z92RHhWT
 4BEgmBaohF4jQ9mQmMzWlrWIWEHonH/SsVIVTeMEtOp01m9PdwSLMMWvYR77nQiX+O7s
 R7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698769064; x=1699373864;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xBSyK3FHQ+KE2LrZmhqh+WokgESDBygvJ4SHaVNO608=;
 b=IYdfbzPauws85pf6UKLb1jNZH3cwHSqaeL27bf9VSuczwsNYwvH0KR3NuvxzxVhN/6
 tryikJm3pSRLLgjPkOrjbXVOuWTmoULeeyfIycAO4Zgj8sepsS/c50s9MBx3aUPowEyd
 xu8n9iuKW/kwZQECt/xHM6134Bi6gLDq6npWkG6Wf20/E7M95xA7wIuThwKIv7U3PCEg
 3IWVgrQ7+UuYoxo1xaXU1vaVOHDz9Qq91UxTrMapMXFamOOYlCsWLMFi0mtNsGb/Hv7R
 dNtOGZCiHLo/GDNs5IMNVk/ZS7rrI0aIpUzgP1px7+wz0qUkEECHTVubc80aLQRkaG0a
 g3FA==
X-Gm-Message-State: AOJu0YyE0Dyc4d529uFykxJ/Z5meDnG1jlAF/jskU4ZL+6xfOdjObz6C
 lrk+fEB+fF8KNuRfGdhvMrDHAeUmP6BE2PGuNQQtlA==
X-Google-Smtp-Source: AGHT+IGrx6B4ZNK3FSNYgYUUhdtd4T9m1i04WigHKvhobTP4/RQ2p9y4wExzS+k5DNUrajwXZRjogWsYyR3m1n7wk7w=
X-Received: by 2002:aa7:d298:0:b0:53e:7881:6bdf with SMTP id
 w24-20020aa7d298000000b0053e78816bdfmr11226917edq.14.1698769064061; Tue, 31
 Oct 2023 09:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20231028122415.14869-1-shentey@gmail.com>
In-Reply-To: <20231028122415.14869-1-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 16:17:32 +0000
Message-ID: <CAFEAcA8XE3xUcc0kmN-1ki6eKZmGiTFM7Xavsvmc3+rMCJk7QQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Various tracing patches
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Sat, 28 Oct 2023 at 13:24, Bernhard Beschow <shentey@gmail.com> wrote:
>
> This series enhances the tracing experience of some i.MX devices by adding new
> trace events and by converting from DPRINTF. SMBus gets also converted from
> DPRINTF to trace events. Finally, when tracing memory region operations, host
> pointers aren't traced any longer and are substituted by their memory region
> names.
>
> Bernhard Beschow (6):
>   hw/watchdog/wdt_imx2: Trace MMIO access
>   hw/watchdog/wdt_imx2: Trace timer activity
>   hw/misc/imx7_snvs: Trace MMIO access
>   hw/misc/imx6_ccm: Convert DPRINTF to trace events
>   hw/i2c/pm_smbus: Convert DPRINTF to trace events
>   system/memory: Trace names of MemoryRegions rather than host pointers

Since these are mostly arm devices I've taken patches 1-5
into target-arm.next (with the addition of "Hz" to the
frequency traces in patch 4). Patch 6 looks like it needs
further discussion.

thanks
-- PMM

