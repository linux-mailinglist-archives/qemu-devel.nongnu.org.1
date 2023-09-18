Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF7D7A4774
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:45:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBl2-0007F2-VS; Mon, 18 Sep 2023 06:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiBkh-00079n-Ge
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:45:15 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiBkQ-0006Gg-Tv
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:45:13 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-523100882f2so5521181a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695033896; x=1695638696; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ewH2NLsTRFu015y52HgrX6Ba49oJNfW64QTSZ0Y+pxI=;
 b=XkQ/i8edc9rFWLNRvziIFog5/0GWn8D+BUNfQK4QPxsN5uAeLH9hgZv70r0wBJHrHk
 oOta4I7xs2AkmT60JieW/+Jv33DGIcm85PUuKOujuD1vsJooZHVRyQoDKGfyj4K6nEX8
 lEmP+60nBxzSEWHb626u1pDfESRPsTVznM6onodO31fWVcPWr3B39EDliqrVdvJXwQl3
 iPnRlndwMOPY/OmA4TJt4GpsXYjyTnApbqWnJmkPhBip5aCAFkjOLd6k302eiBBxvR4B
 +YouAg3ECvjFaal/u3vCtPgDrGr5f08e3rfx/VfQC7Vf+ORwBchJUfYJ5pFj77KJVIaS
 4LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695033896; x=1695638696;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ewH2NLsTRFu015y52HgrX6Ba49oJNfW64QTSZ0Y+pxI=;
 b=syrNoWErldyg1E6GEjJ6paqOD/xkkh3z/AR/UmDC4Ixtm53e1FHQVjxJx42H7CNMxT
 JvW7z4v9j5VMg4cQJFHFYyN6Dj9YW6rY80ug+x3dw6NSkw6wmqRwBjkv74HdzW9ElDAp
 l9Cr9T30vrghrqeBAr72HIpNsppgqegJV5JFkx1Oqm/Y6Zn5BX+tGChL8Jb5BYVJ3y6P
 jIwwAKSwM/BebqjIRBU9IogS/lCGi8wv1MML12NEjhqTgyScHZqmH+EgBubJ/s2asdaV
 CBLwuJFEUgPDKT1DtZs1XTfyT3so8XRWXn3N4eBjID4BcdFsPgBGcLUH3olEfgmYeFbI
 uyGw==
X-Gm-Message-State: AOJu0YzCupR7P+kmy/VbQYfEc9qnYnxGsx5dOOqBfh/5SOGZ7VNXOAt6
 B16W+9h8gveve83kBCQO0rmHKTM5Mw10tNv8020ejw==
X-Google-Smtp-Source: AGHT+IEH/q6IPYAL7YTkhGZ6kmUDGIUBWGW2N0FAN3n3R2q4t+Dz4TsXu+01bSvJrEBc+8cnpym16K+23BsKMetZzVg=
X-Received: by 2002:a05:6402:128f:b0:523:100b:462b with SMTP id
 w15-20020a056402128f00b00523100b462bmr7613449edv.5.1695033896362; Mon, 18 Sep
 2023 03:44:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230915115535.129834-1-quic_llindhol@quicinc.com>
 <20230915115535.129834-2-quic_llindhol@quicinc.com>
In-Reply-To: <20230915115535.129834-2-quic_llindhol@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 11:44:37 +0100
Message-ID: <CAFEAcA-Y6km+SY+qkHV91rJ8fpG4JpJwT5KobwYxVM8PA74eKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] {include/}hw/arm: refactor virt PPI logic
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

On Fri, 15 Sept 2023 at 12:56, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
>
> GIC Private Peripheral Interrupts (PPI) are defined as GIC INTID 16-31.
> As in, PPI0 is INTID16 .. PPI15 is INTID31.
> Arm's Base System Architecture specification (BSA) lists the mandated and
> recommended private interrupt IDs by INTID, not by PPI index. But current
> definitions in virt define them by PPI index, complicating cross
> referencing.
>
> Meanwhile, the PPI(x) macro counterintuitively adds 16 to the input value,
> converting a PPI index to an INTID.
>
> Resolve this by redefining the BSA-allocated PPIs by their INTIDs,
> inverting the logic of the PPI(x) macro and flipping where it is used.

This patch changes the values of ARCH_TIMER_S_EL1_IRQ etc, but doesn't
change the code that writes those values into device tree properties, eg
in fdt_add_timer_nodes(). The device tree bindings want the actual PPI
numbers, not the INTIDs.

Plus keeping the PPI macro name but changing its function is
a bit fragile if we end up needing to backport a patch from after
this change to a QEMU release branch that predates it. If we want
to have the base values be INTIDs then probably the macro should
be INTID_TO_PPI() or similar.

thanks
-- PMM

