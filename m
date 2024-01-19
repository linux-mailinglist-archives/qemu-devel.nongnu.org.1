Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F8F832D82
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 17:52:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQs5X-000339-Ct; Fri, 19 Jan 2024 11:51:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQs5T-00032a-TX
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:51:23 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rQs5R-0004YX-G5
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 11:51:23 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-559b3ee02adso1153950a12.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jan 2024 08:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705683080; x=1706287880; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99GGFKJsGkqxZjzf6eaXDRk+uN38Nnj8b78hLWlyNfM=;
 b=SngrvfWJ+fNNPpO37pIrkqhgruXxhpuhuSvTQlQjOsQSASPstYgKjzFrlmTW5IVTxn
 s0r+5dJ5Hj624ZCXursCHy8sKRGlIPwtcqctzfEe9yNxEQarZwJJml0d0IvfYx6vL8ZO
 XntDXETPT3AswI2+jkZNWiYsvRzM3zXTfIhJXQSd/houiyJx+EU8U3eSut1VCddnOwlN
 xEQxqTyyyq2Iy9kHpWDLve495Snk+FrmR2kEaswnx9peKhfynedM3E28OkPTWaSkbFfe
 FX5pIJLHFb+EKnb1ZlyfXGVT6slGJkNygrK8DwX+sgNCw58YQHm8KP+BHB3gpRK+mr5C
 ryKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705683080; x=1706287880;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99GGFKJsGkqxZjzf6eaXDRk+uN38Nnj8b78hLWlyNfM=;
 b=CBjdGhA9EDInQX6Ide1Su3/4faV7VrYpIPuc+XrIbMB4u+TDrzGOnFT6niwozpceA/
 WP8FbupdGtvrNImU5aBt88nCgVKetg/Z8AEphyZaWvRHlBARVLNBMbS4HXPhkWLN22o5
 4hA6kPY/DM3ru5v2alcfoo2LJ/D4VtsjAkvb/bqznp8Ddnf/1haEr0Naf6fI3PgwHgpX
 5rarri/1V2mYXIl5vvIJiWCOperGAbebVwLGzOMOJ3aD/8o7VYQ+5Lo0ByKpPY5QegqR
 WCTXhBqKnaqs6iOD5DS+jszW14tPAzpMgAKkAEJbHsTf38eW91rF7mm5FEyAfk0yBmwG
 rx1A==
X-Gm-Message-State: AOJu0YyTqy6lJIhPgUVjub+j6tpYwD1sx5XlJvoTMQHWjHdQERuxmLNZ
 CvrQzeo+wQMa12NG7YxPw/jjNhzZjWOCYruJwoCS4YRZHfwzeWew01gNt/MqQrDGe7FZCc1ctUN
 fBpEbHgJgcoIXSIGJpFKC3CmEanrECsxGQftw/A==
X-Google-Smtp-Source: AGHT+IFDkPMJ4qBDu+45VHFIL1rAi6BpUYsRBFqH33cByHJQSmSNfEG6S/nbGaNr5B3qB1MbsHluNqp0PSbndQEQ5h4=
X-Received: by 2002:a05:6402:3582:b0:55a:6d78:75ed with SMTP id
 y2-20020a056402358200b0055a6d7875edmr29186edc.51.1705683079875; Fri, 19 Jan
 2024 08:51:19 -0800 (PST)
MIME-Version: 1.0
References: <20240115165615.78323-1-philmd@linaro.org>
In-Reply-To: <20240115165615.78323-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jan 2024 16:51:09 +0000
Message-ID: <CAFEAcA9abVk_BvWYE6ctcsLrk0CP=aqy38ncgxNrooNroe_1mA@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/arm: Unconditionally map MMIO-based USB host
 controllers
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Beniamino Galvani <b.galvani@gmail.com>,
 qemu-arm@nongnu.org, Strahinja Jankovic <strahinja.p.jankovic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Mon, 15 Jan 2024 at 16:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> When a chipset contain a USB controller, we can not simply
> remove it. We could disable it, but that requires more changes
> this series isn't aiming for. For more context:
> https://lore.kernel.org/qemu-devel/56fde49f-7dc6-4f8e-9bbf-0336a20a9ebf@r=
oeck-us.net/
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/arm/allwinner-a10: Unconditionally map the USB Host controllers
>   hw/arm/nseries: Unconditionally map the TUSB6010 USB Host controller
>



Applied to target-arm.next, thanks.

-- PMM

