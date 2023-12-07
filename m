Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3C48086C7
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 12:33:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBCc4-0006go-6F; Thu, 07 Dec 2023 06:32:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rBCc0-0006gD-E1
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 06:32:12 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rBCby-0006HR-QB
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 06:32:12 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-54c4f95e27fso727030a12.1
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 03:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701948728; x=1702553528; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/lc3VFx2xZBXKHMBWXpf5yM8bBtzy5i12/ImVyVOLCw=;
 b=mvxTMhTTMqxrml+k3M5ZdNk5Q93TFBg/gsfN3ZRUTYyIO+uuyd6kLKIE+i1lq0dqcI
 JHgpHxSKk9pcW0JbD1F1qEjDeUrGnFY/mthRtmTeVBHnN163BQfVSueCCLnxxXqZrRTd
 e4Pwzbes+4mzMNMkuNXCQBlcJEfKn4eYPRX/giNLDFuyVc+VDP+rVIL4/Lr3Az2lTPFt
 Z9MQLfVKrDgEGcjEMDDIjdWn39hzppuXUjGozVpCGqV1N3rYRrjqcv6HKhDBY3ecDmBt
 4lnQPCSpBnQpJ+3dnjRbfQqa4QYwsaGfnOr5kZvk7kFBaNaVo7pEIDG5CEk+HDq6jYPd
 /UkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701948728; x=1702553528;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/lc3VFx2xZBXKHMBWXpf5yM8bBtzy5i12/ImVyVOLCw=;
 b=CYCHVlRAAf2bV0d3NI+a/+yWFoji+66gtXJiQ0A8COinyyMyLXMJj6qNbS/aALYYhx
 2VvSXDiEXC1gO2F+35kR5bBZLa5OAAFTvY7vGBUqMESBAqIxJqpk/m7xB85Mdj6H0qRo
 Yew0qWAZnC0bx8Wovf/dmYVauoo9jz1VhDxhx/+d8sL/2t8qXNdueas1TjEbOPFr5DzL
 m6cnDqIH77S1vTJShbJ3uD+V5gumy+hJwaRQ3vY9CdaCJL2024xPv5SgxgESChshoYDS
 hkxvYQEsL+A+5SYxIZgqgVw5ZMIzOFo09t2YRKKsqJNxRjnHuGuwR7CHZZRNNE4wQbcH
 MOrw==
X-Gm-Message-State: AOJu0Yx1jRbUc1lXkQRKUR2Ki5v5SdNokxCELxFfO/wwhAtqJf69P10L
 yuS0h7VbNeqYCI58oOnhAL3sV09H0gbf8ufnmQ0NnWniqddmx16d
X-Google-Smtp-Source: AGHT+IEOBbnPDIihqX94PbaFYEgNkaZHZEqq3n7fSRbL15WygjxFCPYdRXufdSn8d9tcjEh9nJZk0u4oLcmn/qATvyc=
X-Received: by 2002:a50:871c:0:b0:54c:f947:6347 with SMTP id
 i28-20020a50871c000000b0054cf9476347mr1813417edb.71.1701948728070; Thu, 07
 Dec 2023 03:32:08 -0800 (PST)
MIME-Version: 1.0
References: <CAOYM0N27HbO8wOumn_xxNSS8Zg-Rsc6tSj9U1oU3sSAARBoCwQ@mail.gmail.com>
In-Reply-To: <CAOYM0N27HbO8wOumn_xxNSS8Zg-Rsc6tSj9U1oU3sSAARBoCwQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Dec 2023 11:31:56 +0000
Message-ID: <CAFEAcA8Mo3XJ_PXet6UoKSyUXpuQ61ejXBrg6XrgAbZGXO=EhA@mail.gmail.com>
Subject: Re: make: *** No rule to make target 'i386/fp87.c', needed by
 'i386/fp87.o'. Stop.
To: Liu Jaloo <liu.jaloo@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
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

On Thu, 7 Dec 2023 at 11:20, Liu Jaloo <liu.jaloo@gmail.com> wrote:
>
> qemu checkout tag "initial" version, then
> $ make
>
> report error, like this:
> make: *** No rule to make target 'i386/fp87.c', needed by 'i386/fp87.o'.  Stop.
>
> How or where can I get the resource about folder "i386", just like OBJS in Makefile
>
> OBJS= i386/fp87.o i386/interp_main.o i386/interp_modrm.o i386/interp_16_32.o \
>       i386/interp_32_16.o i386/interp_32_32.o i386/emu-utils.o \
>       i386/dis8086.o i386/emu-ldt.o

What version of QEMU are you trying to build? These lines
have not been in Makefile since 2003 !

If you're deliberately trying to build a very old version of
QEMU, then you are on your own for that. You'll probably
find it does not compile at all on a modern Linux with a
modern C compiler.

thanks
-- PMM

