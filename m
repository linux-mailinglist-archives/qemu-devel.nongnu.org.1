Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B963B7DF7A6
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 17:30:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyaYq-0001uy-Cd; Thu, 02 Nov 2023 12:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyaYg-0001tm-AX
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 12:28:39 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qyaYb-00078M-OX
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 12:28:35 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52bd9ddb741so1942779a12.0
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 09:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698942511; x=1699547311; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aS/RoEt1TrnY877Sd45bYPfga+bIKxaDZM5rmeWiXxk=;
 b=oylguF/TUrjNPnSb+Av/wD3mhReMFOnOcfh3en0mUDiWxbVcS4zE6HoVrnoIoK6JXt
 D/dKv1lTS1p6c10UjgNiTtGX6N+FQjOZDSsGY2TWO+VJpwzhPZQqvwlFzbO9cr7oW0Vj
 ZpnfQ5mctctlcM2gWZSwbYVYCRt+cunuRgrkzftreBSioHc3Verw8vF5dtEKg2ySe4F+
 THA1yd8MaEcu60Pr4Rw8XTtjnv4gD3EL1nGhtUe4ddfuyVdbYM60RhJdX54CR0abBlsJ
 Ok5toNiY9S7d8AenlP+fCCk7T072hxVDmbsDOQdNbLi/STmc2LWGcgG5sNJJKe46axK3
 ulZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698942511; x=1699547311;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aS/RoEt1TrnY877Sd45bYPfga+bIKxaDZM5rmeWiXxk=;
 b=coichswouZNKB50LXkDRphUNAIM53pmzQDCZdaxZgxqjc2guyzv6dnMkh8Yxg6OExi
 b198K2n9zfZlSUfFoyYKsBVlfU6RlPUSCFhyMChOghAN5aBQu66wGE1lSAP+6SlHzu9m
 UAwvNW/jaQhPpumQfVlgrHRRxR06r1RqobEASTWXOOcDz8njF2HJHpXsLvEb2ld4iKo/
 xQnfV7+sq7LTVBs/GuPLRNB4rZ+/LIlBa9JQkFVfdJblfVGpFBtaLGq/dJUJHKKkha1K
 ugdobmp9pIOh+5kJwcVKRf83MfdiNskYLWlGcEeJpNhqMHenJ+Fwv+gQKV2cWiK9qBo2
 HyPQ==
X-Gm-Message-State: AOJu0YwuBKdmSUkQTyRjIUVS5g1Wf3aGf+MZOdTHYiYKxQieBxXbV0di
 lZbZeTCtTPHuRyu8KEciR+m4fqNs/dIZKyuE9dGuf/XvwbAueQjv
X-Google-Smtp-Source: AGHT+IGr4G2TO67WFCkb0p9zrWB8fKD1CtmwPEX9Qv/H5QZWpQ6G2iTNbfafbNYTyc921WXHBo34qViIJHm39W48UAo=
X-Received: by 2002:a05:6402:1bc4:b0:53e:3b8f:8a58 with SMTP id
 ch4-20020a0564021bc400b0053e3b8f8a58mr15017202edb.11.1698942511413; Thu, 02
 Nov 2023 09:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231031134505.4110877-1-peter.maydell@linaro.org>
In-Reply-To: <20231031134505.4110877-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Nov 2023 16:28:20 +0000
Message-ID: <CAFEAcA-Z-eLYgoqbzUjay-nkSQXjm6w-z7DkOcCDi_L58z7Jtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] virt: Report UART correctly in ACPI DBG2/SPCR
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Udo Steinberg <udo@hypervisor.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 31 Oct 2023 at 13:45, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchseries is Udo's patch, plus the necessary extra patches
> that update the golden-reference files for bios-tables-test so that
> 'make check' continues to pass. I'm sending these to the list for
> completeness, mostly: review is of course welcome but I plan to put
> these into target-arm.next fairly soon.
>
> Patch 2 has already been reviewed.

This turns out to break the Avocado test
machine_aarch64_virt.py:Aarch64VirtMachine.test_alpine_virt_tcg_gic_max
(which boots Linux under UEFI) -- UEFI boots and hands off control to
Linux, which never produces any output, presumably because it's
getting confused by the new ACPI table.

I need to investigate further, but for the moment I won't put this
patchset in the target-arm pullreq I'm setting up.

thanks
-- PMM

