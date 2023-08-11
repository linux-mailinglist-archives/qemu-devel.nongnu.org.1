Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA241778A71
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 11:57:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUOrv-0002AH-DV; Fri, 11 Aug 2023 05:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUOro-00029G-Fc
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 05:55:36 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qUOrm-0000sX-0R
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 05:55:36 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-52256241c50so2330976a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 02:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691747731; x=1692352531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tOBooZ3v+WXGtRHmSt+Sm6Zx4Er6lpKedMxrO3X7A2A=;
 b=tyANfAmDWFl7VeuGbAi2agHqDPUuCqKXygOMVL69CAsYlkUKTRjYLiMsoeWNdIw6Sw
 L8t+N/1sLeNPinMTsaaTPvf2oRrLM8aeD4+ouwjPovwQa3IJXN5DOMNnok2F5jSWD1sq
 IR4jUl++noLqUmij53aZqHTBKKqIPmhC1NRbTH8mvhmd5zFIJ+iNiBi9E5yAGiGyUjzi
 pzcNhVHr0X4qpknbE2hSMgPC/HXnPsRHRoGpcd4RYfVjyKcIS7OgjTURFMTxycl9bgA8
 oKxzoPHVBFNTeg/QMmZjCFhG7A8rPh/JPpYcOvrTt07tn3/kWUHOUGTaLsjO/vdeKRhz
 772g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691747731; x=1692352531;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tOBooZ3v+WXGtRHmSt+Sm6Zx4Er6lpKedMxrO3X7A2A=;
 b=RQHi9bqmQKu2LEsGGwVKhinLBajd/RZ6t23AREYTPTeOVRU4e9GhDKDGJCn2EhwG4i
 TtRwQGqp3ip+5ItsjVRklisVuUzG30lU7gpJiWNKJMHI73uK/u8fEnTPbv7cvi+gVhzj
 laNQSUKEcKyxSIpbLUuPlMZ4LJ0o8JPIoN9m73SFhKKWm89wQdVNMGLuZtebVfZ251Kg
 uUonYwZaaEG/X1ZuwqUvAp3fNg/HSB+71qcgbyALeKmmJ5EnZ7ls4msYBP96bnUaNch+
 hfsVeFEf+7EoDVwUwKrXZEB76D73AzQw7acgIcs3VzlIftY9+bZRVIf4U1jn/2SjjlRl
 +igQ==
X-Gm-Message-State: AOJu0YzRUFbbBFkiZYiKv47ezRq2n8UB7Pa1CMYYQQFVTnip7XenuizO
 rxIrj9BSxwXdFALMNVuhuTGvK5qHW9X5fxJpt7rQJg==
X-Google-Smtp-Source: AGHT+IHQPu5RK4YO64vpSUAn7XGgqNVfr/xMF1s6z0nUewvLKBx31w4ycq9DChthkfxv9NHkD0R5ZWtR7ra4T/yW6tc=
X-Received: by 2002:aa7:d3d3:0:b0:522:1bdd:d41a with SMTP id
 o19-20020aa7d3d3000000b005221bddd41amr1261414edr.4.1691747731314; Fri, 11 Aug
 2023 02:55:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230809102257.25121-1-jason.chien@sifive.com>
 <20230810135050-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230810135050-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Aug 2023 10:55:20 +0100
Message-ID: <CAFEAcA_B5W5CX7-C_a7iWTL87kpcLsGEjAsqs5t54sgjTKi3Eg@mail.gmail.com>
Subject: Re: [PATCH] hw/pci-host: Allow extended config space access for
 Designware PCIe host
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Chien <jason.chien@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, Greg Kurz <groug@kaod.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 10 Aug 2023 at 18:51, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Wed, Aug 09, 2023 at 10:22:50AM +0000, Jason Chien wrote:
> > In pcie_bus_realize(), a root bus is realized as a PCIe bus and a non-root
> > bus is realized as a PCIe bus if its parent bus is a PCIe bus. However,
> > the child bus "dw-pcie" is realized before the parent bus "pcie" which is
> > the root PCIe bus. Thus, the extended configuration space is not accessible
> > on "dw-pcie". The issue can be resolved by adding the
> > PCI_BUS_EXTENDED_CONFIG_SPACE flag to "pcie" before "dw-pcie" is realized.
> >
> > Signed-off-by: Jason Chien <jason.chien@sifive.com>
>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> I'm not planning another pull before release, hopefully
> another maintainer can pick it up? Peter?

At the moment I don't have anything intended for 8.1 either,
so whoever of us does it it would be a 1-patch pullreq...

-- PMM

