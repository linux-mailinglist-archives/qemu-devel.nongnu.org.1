Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E7480D00E
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 16:49:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCiW1-0000v4-B9; Mon, 11 Dec 2023 10:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rCiVx-0000tm-Sf
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:48:13 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rCiVw-0000o1-0j
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 10:48:13 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-54d0ae6cf20so6524521a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 07:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702309690; x=1702914490; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Eom5AItaUxFhc9i8+0u7HL8DfpB+lgfj8kGQWf44GpQ=;
 b=xNPs2zGHwMG8oTpmTa/WnUe+6UBoKbEyVpMjC6XPTvxzObvQCEW1LcVdlzG2oAr21B
 oXYHXc9cNYabubWJ+bYxFKlNLYWf0z+XuUnNKqzb9k8lG7DlYc/QKdh18A7Z7FONnm1F
 /3PjnA7kwA6DQH7m9TmEqRek9h+B8i9CWvkTmo0JgXnk3JHM0oTWqPIxn1z8QLAIgpQ+
 3vLZ0pNRO5tpX3uwYzH58D4QABHXzmPTnN6NzUxy0lAfqRX8WqXjPdq1tpzaoo3Ovew6
 23VT1AgNEo0a1RdIMgbrD7hfnowHamd1sphp3usFXwy2SMWC/nGys5doDWME9PhF7Tsz
 vvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702309690; x=1702914490;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Eom5AItaUxFhc9i8+0u7HL8DfpB+lgfj8kGQWf44GpQ=;
 b=PGCaZsiYYOhtvLEdz3WPbJ6yqCHb5R19lnLerCjZtPudXzpofcudcgpIxqP1mPuVDp
 ooAgNQFQFiZyNtE3RJDnM2UbhCDocAyiaeZvaSY+U2kDj5cs1u+UOJTIXZ8K7YW7370R
 IbZ44ALCbn/VnWyuxqWvj2uzTuqD9RWpJH8s7+qNhXQNge7pJ3viPgGVoSR8Dsi46qmm
 IB+8lTw5xtacIRAZEheZd/Dgg1n81GyfmFHy8NSblDt3ZkpLO0/QgJ2BOpBepvCh4FVc
 JZPO91F4v5TEWm4WAtv2/MMhP89/5gUeKhRVUJ9iUY9DyGqLahL7VZhYbPqgajQ3ApMr
 uTCw==
X-Gm-Message-State: AOJu0YwvHw3RH2N1nE5TtSM/vKfTW6t8e5iljyDUnoQj2eLNeWvKmbR0
 9efHVlJTw0GBTP18JS+6sDxkf6l/oYv4XkZmhOwxrw==
X-Google-Smtp-Source: AGHT+IFZgqFJMA5PTD9uKyutODpY95n6y7B+IXO+j6QiIGO45vV1XpsRcN5QnFea9gLpug8oydG0ZWdm0VwxK1uWHC0=
X-Received: by 2002:a50:9558:0:b0:54c:97c6:fc74 with SMTP id
 v24-20020a509558000000b0054c97c6fc74mr2789415eda.34.1702309690367; Mon, 11
 Dec 2023 07:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20231130142519.28417-1-philmd@linaro.org>
In-Reply-To: <20231130142519.28417-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2023 15:47:59 +0000
Message-ID: <CAFEAcA9rXVtH6K6-iJQkK1MdF4mG3EjxrDwOXfn9UUf0sKsPnQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.0 0/3] target/arm/tcg: Few non-TCG cleanups
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Thu, 30 Nov 2023 at 14:25, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Few non-TCG cleanups extracted from a bigger rework.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   target/arm: Restrict TCG specific helpers
>   target/arm: Restrict DC CVAP & DC CVADP instructions to TCG accel
>   target/arm/tcg: Including missing 'exec/exec-all.h' header



Applied to target-arm.next for 9.0, thanks.

-- PMM

