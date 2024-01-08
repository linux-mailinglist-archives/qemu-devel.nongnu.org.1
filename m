Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DB8826BF2
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:59:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnL6-0004JJ-7Z; Mon, 08 Jan 2024 05:58:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMnKt-0004Ib-TL
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:58:29 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rMnKs-0006lf-9f
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:58:27 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-557dcb0f870so191582a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 02:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704711504; x=1705316304; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pFPm+QTRIY/2aMeb/V3Dt2ax93yQ4YriyjnrcMPm0Rk=;
 b=yxNyS51GvkHVMm8o+8/pFtYlba3SrCzmIT0uudvRqFwB2fvMPlcgK8itwjmnmZ7wDW
 Bk/SxKvX0wzcgIpXGfQ/vAzAgU7FJIoZIZWaaESPqr1AD0gW7z6PeeS/cJSzIjVfdTce
 SjynHBkzYFOrEpWEqSWDGPOwQ3cGt3jhOjlFKyn4IZKeeNTaaRfEm7ZmKh5L36lgg8Sf
 J5FVdr5TrFvgitf+C4t67wjXU7+GJJk9LYODw9hHaH8hgxvDJpFONpPKnTT79Q66txau
 jUvxohdqunebr76+n3JOgf0wTuOtiyebN8RV/+PT/c4s9Onw2wykVHGxoFuM8XHsqxcF
 tpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704711504; x=1705316304;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pFPm+QTRIY/2aMeb/V3Dt2ax93yQ4YriyjnrcMPm0Rk=;
 b=QIXJq+cmr0v2nzbEGNTdRc58X8NSPWJwIj8RTbpY4L7F9i58W6aDgX+DjF8hSmLbMl
 xYkBK8EsU6zn7SGjSOuK575w9nzFsAojWonr6LzH0akF8ia/+isHpjXPi4CQSDm1CXAN
 c8v8WaG2169/34o1Ap/sMOSQvnfdYBIN03vcO2au1IsQRP1wcTcn5n2V7h1ZoMRk2eHa
 w0KiOemjnjJkKcKmdxBSu8ebhHSCYptzmaDuN7bDo4jDrHpJdA27f27JR+QSzc/SN34D
 ASm8xb5G983SwF3pLLfONSEJdwLYDtjxKIxOaBWsZj0o2yrYxeJrBYSx+9IxGV1yg2Yb
 EjkA==
X-Gm-Message-State: AOJu0YxCzVYcQauAeCvhKjwCF7u0oaGZSw1Cacy39pdeBjV1BUiA2t2g
 ZeVbRm4u9OCD3KsdVERVTx/YCWPieSph8IGFHL+UMs8L7FzejA==
X-Google-Smtp-Source: AGHT+IHBspMVz5WcN5NftBfxPO0CV3UEDEJ9KSDL3g+wXfUgI+cTkH0vIHTIassxME8zHwNApPBEXfrvY4ewenYwH0Y=
X-Received: by 2002:a50:8e5d:0:b0:54c:b185:2895 with SMTP id
 29-20020a508e5d000000b0054cb1852895mr1577741edx.27.1704711504581; Mon, 08 Jan
 2024 02:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20240108103439.4369-1-anisinha@redhat.com>
 <20240108103439.4369-2-anisinha@redhat.com>
In-Reply-To: <20240108103439.4369-2-anisinha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2024 10:58:13 +0000
Message-ID: <CAFEAcA-1Te7mGCBON_z4tyu9pewjiyjAU8g6_is_7MrRrWb0=w@mail.gmail.com>
Subject: Re: [PATCH 1/2] acpi/tests/avocado/bits: import smilatency test from
 bits in order to disable it
To: Ani Sinha <anisinha@redhat.com>
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Mon, 8 Jan 2024 at 10:35, Ani Sinha <anisinha@redhat.com> wrote:
>
> Add smilatency test script in the bits avocado tests from bios-bits. No changes
> have been made to the original test script. The test will be disabled in the
> subsequent patch.
>
> CC: peter.maydell@linaro.org
> CC: crosa@redhat.com
> CC: philmd@linaro.org
> CC: bleal@redhat.com
> CC: mst@redhat.com
> CC: wainersm@redhat.com
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  .../acpi-bits/bits-tests/smilatency.py2       | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 tests/avocado/acpi-bits/bits-tests/smilatency.py2

I'm confused -- why do we need to *add* the test? This
test already exists somewhere, because we're running it.
So why isn't the patch "disable that existing test"?

thanks
-- PMM

