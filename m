Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 77495770000
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 14:13:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRtgJ-0000f8-2D; Fri, 04 Aug 2023 08:13:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRtgG-0000bT-8E
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:13:20 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qRtgE-0003vQ-Df
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 08:13:19 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-522c9d388d2so2487795a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Aug 2023 05:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691151197; x=1691755997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oP6Nv/sWOF7ZKHuQERNU0H3pM8N2LUjQWlVQj7efbV0=;
 b=KU0YAg8KfSJc9VaiF0NMiDu43sMOBsVp7AyiqOJUSxfCPkufmsnQjMLYVQ9BSTvWBv
 LiR7sCzwj4riQfwLTBinf/JpGfgxJsLZMsvz6bpJT5jHJe4uh9eMjlRQZRIUGMbc9aFN
 AuRJaZbjny5C2dM3KJU5gqp/0xUJ/27244QuX50L2TYrC2O+Mm8sEYydkWGw8KNx5oXp
 s4ZEZvctq51DLAUmknnpjlaKBox2vo3kRoOKipwNwvRXtwXOimy8KCzz9Uu1ZXcJ6gDK
 nKf97mOraF+CSI7zN1TL65TA8Xre9varf9JWgx2285K/WUaJRX9LIgEHkpnR2AUqQvgQ
 dgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691151197; x=1691755997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oP6Nv/sWOF7ZKHuQERNU0H3pM8N2LUjQWlVQj7efbV0=;
 b=TafVb+6I8woZKDtQq/+fph2j+DX0wwpLuaUUXCE+pNs2+xtvvbOlmJZYmpeiU57af8
 uWj2g1rg+vjr0uPGhLK0c2fLANfL2LkW/rbHN5E021qf1Z+gFZwpCarFK8CpLxSDx4i9
 KzZA6r9aVZHudG6sjclZN5CPgLJyJmWLihW6g4ai69vvGpzBFvBEX4MiP6KsUTjw/VE0
 DOab4YLZpxhSkra8rOmXP8sqLVd39z+9HXRynWL+L6rB8/yepQeiH3DQ0tAVq3hjmAz8
 4qmU524whD8fPL8FIAUfpWoncHFNNou0LZMQrqDaN8D8orpR0FzV8F0Y9r9QdgWZFGVD
 c38A==
X-Gm-Message-State: AOJu0Yx3w/t+3WmimIBxii68dxZFH06rXJ8Hfr9t8EM53wA70wXKbE/R
 8QgQEnIXC/JOAhluYITkJo8WPdG9N60twuQiilcLtQ==
X-Google-Smtp-Source: AGHT+IEhMSZDygLH88medWSr4ZgTPDAG9LRAtzuf7thFap8fdhfwtDDt6RWe4sKVgAhVXpte2L0Y4E6Nph42thwkTe4=
X-Received: by 2002:a50:fe8c:0:b0:522:472c:cc36 with SMTP id
 d12-20020a50fe8c000000b00522472ccc36mr1261764edt.4.1691151196867; Fri, 04 Aug
 2023 05:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230726132512.149618-1-sergey.kambalin@auriga.com>
In-Reply-To: <20230726132512.149618-1-sergey.kambalin@auriga.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Aug 2023 13:13:05 +0100
Message-ID: <CAFEAcA_xyq3KjKVkrbtGktbS5OySZU2Q-gh_qqzv_iqnnDbQqQ@mail.gmail.com>
Subject: Re: [PATCH 00/44] Raspberry Pi 4B machine
To: Sergey Kambalin <serg.oker@gmail.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Sergey Kambalin <sergey.kambalin@auriga.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 26 Jul 2023 at 14:56, Sergey Kambalin <serg.oker@gmail.com> wrote:
>
> Introducing Raspberry Pi 4B model.
> It contains new BCM2838 SoC, PCIE subsystem,
> RNG200, Thermal sensor and Genet network controller.
>
> It can work with recent linux kernels 6.x.x.
> Two avocado tests was added to check that.
>
> Unit tests has been made as read/write operations
> via mailbox properties.
>
> Genet integration test is under development.
>
> Every single commit
> 1) builds without errors
> 2) passes regression tests
> 3) passes style check*
> *the only exception is bcm2838-mbox-property-test.c file
> containing heavy macros usage which cause a lot of
> false-positives of checkpatch.pl.
>
> I did my best to keep the commits less than 200 changes,
> but had to make some of them a bit more in order to
> keep their integrity.

Thanks for doing this -- I really like the way the split
has turned out, and the overall structure of the patchseries
is good. I'm going through the patches individually
(which will probably take me into next week to finish)
but I'm not seeing anything major, just some smaller
issues.

-- PMM

