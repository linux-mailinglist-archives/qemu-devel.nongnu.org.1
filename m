Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0A2B184E8
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Aug 2025 17:26:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhrdi-0007Pc-DV; Fri, 01 Aug 2025 11:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrBN-0005ht-RT
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:56:42 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhrBM-00082J-D7
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:56:29 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-71b71a8d5f0so7833447b3.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754060187; x=1754664987; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cqX3GRJJgYlpziaxeGacp2FrJ2qD78Y+8aTRRaYZH38=;
 b=NEofa8oV/w7W8lQj8pfWV7JJEFyaFcutm+WIJr8IH2B1ikckISy3k0cmx9v84xRMP1
 +0Qe2fjsfcsrbmwFdbZDDz82lvHlM/dU5w67ntUzMo+E4YEQEPHEJjQ8J2a6ySxLiBEP
 jTfT4Chw01JCs+/Dx1YtGtiIHXUGdPfK/SnYE5scHpXPmDmw3otUKG1wRiMdhKOJJbwt
 PWFsazWP+Vt15GbmFwu1rniHcbeoFmiARypyiszXuTzroCyqKUTNvZoCrQY4bUEvKCJQ
 XCE3ao6/x4NImfinjS0d2UC2XAuxwaWdhTTJksv9teRwV9tmb3iu5LLF0xEnFNA6331o
 roJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754060187; x=1754664987;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cqX3GRJJgYlpziaxeGacp2FrJ2qD78Y+8aTRRaYZH38=;
 b=HXzqnDtp6OP38qOMav+YKo0pAOFmmFDvj7UDGhJmCx1REHQUxY7fs3l8Dfp1VbIpdP
 1P4noQ28pvg3ALB6CZc8URw8KVb//It0PxYumiNgxTAe421xWRj/6NRjSAKo1u2SSWiP
 MlAg9W1xJ8/MyUdXqJBChPYpbAKIHfqIM/ftspbTYzbem6rXwD+nfbKa9peZCi11oj+U
 cCgrxQfHBYvQrQtek3eBOB5i4CXJDcrn8DaZmIItXBv2VZL1iSqj64Mfxv6I5DvIlo0V
 VXRdh6AyDpfrv53AzoPlCCV08zHRjP5YDrhQn+yDr6gWXmyVTwjgALqwlgqij4ELdFyb
 8GYw==
X-Gm-Message-State: AOJu0Yw3PkBEI6vjbCxaulp75QaBKh7BrEdU9SIUFd+YJOqXZuV0I4rF
 VRQfKyKyrBjIHZmykn8zzu82Cbj0I2gclBHUu6v50XwhTG3/VdVCVD/2qPrYc8EX4JYR/ETW2l0
 uQaFHyx6s5bvoDuQLRkECvF8SRlyOHOhX4zmPUc5wZQ==
X-Gm-Gg: ASbGncvSzC0cRqgY42tNw2UT2JJgNW4aXsNAZvK87Ou9+9ACu2eILtRIQDR82ZWX5st
 B1/3j0/rqAeBcOWwBtnLojvPFEVQ+RBia00v2bUEtD/bBLnJFtuz5rkKEVD0lYBZztO+4JbCmh9
 v+2qt/MadfiD/KoGyVCEVTHGr1SyQrgE1nD4Lj3m9KFxqzBO3N8FDx2H7P2lPYcp3qPKsrNE17F
 3xKuzda
X-Google-Smtp-Source: AGHT+IHD4/wDIDW+tLN9hWkEJT3U60Ilm36QlTBtN5q+gvU6I0XCgNNhErJaPKKbZZGSwXC1YaAtcnchRpoza9U8p4A=
X-Received: by 2002:a05:690c:6913:b0:71a:323a:b297 with SMTP id
 00721157ae682-71a465edbf6mr147154447b3.7.1754060186925; Fri, 01 Aug 2025
 07:56:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-9-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-9-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 15:56:15 +0100
X-Gm-Features: Ac12FXzbmW3BSCE2VfXUQUP0DHwQUhHGi68gQ_YURqxHLUUJz2bgbq2ylqyceYg
Message-ID: <CAFEAcA9ATO4Gb1ipytVyNRP2Rm2YoMa-cC8Atn18-XQkCimSJQ@mail.gmail.com>
Subject: Re: [PATCH 08/89] linux-user: Move get_elf_hwcap to sh4/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 30 Jul 2025 at 01:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Change the return type to abi_ulong, and pass in the cpu.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/loader.h      |  3 ++-
>  linux-user/elfload.c     | 29 +----------------------------
>  linux-user/sh4/elfload.c | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 29 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

