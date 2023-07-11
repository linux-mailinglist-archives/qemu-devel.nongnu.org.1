Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E54A974EAB2
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 11:36:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ9mM-0006hG-6A; Tue, 11 Jul 2023 05:35:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJ9mI-0006gc-B7
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:35:26 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJ9mG-0001Im-Q1
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:35:26 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-51e590a8d0bso2601671a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 02:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689068122; x=1691660122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iB684Ael7by0XX7WzctreKMDzf739uS73Zb4xi5Hl0c=;
 b=kaWaDEQ+KnR8Vd/VfHq+gw5Z/KS6xTplFHfKnD0d9Tvr3NZU+lIlUi7h9jQVi3oHL+
 HzrKpCWMrC79adZmMo5HmtDhvLbIh8K11YR0KnAiQHwA7ozkP2BgV2WcVJms4oGvqIL3
 AFxE1ykaqoKtEcmbxqak09SlOAPlA9LTRjkNrhXEI3Tg2B3d/XGdlZ6ch4iUAqyUIFZ+
 oMqn3C7l9WacZQLLk3oyEp6J8urpB45CRNrZdTX9B3w4uye0RmemZ1wDgi9snYvv1K46
 aDIDJJ7VzS3Xz/rJ7nWAok93+2x28xu0jBCJHOpG93jsbJCHcBAowV7DbnlCTvFT7Mi4
 jxlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689068122; x=1691660122;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iB684Ael7by0XX7WzctreKMDzf739uS73Zb4xi5Hl0c=;
 b=TAl9a8ZHbrtDxtbo9SpRHiBxwrNcyYvkhh0HGCRE5zpxGn9MgX+kyPPDNFbNSpxz0/
 L44oDeXbfjajdyrCMcl7SJ5i81uxNhBp7zAp1T7Sovt1JfClvG8R6sy1fxZYMgVkzpF+
 olsVQRgsvUCn1Sq+N2ZymQFP8g05yMzItzTGmkSraJ1uAE47p1m8P6UNNvsuIvTlsfsL
 3FNhzjiFXTblsGK6gVv3uANlFCKYij/VhpdPmlrgdatctWclfwD5CTBbCAndldzDTTug
 lmJHofswlxtdOAyT0zLfhxOI0NMgK21yaT8tUNSA4KXkYk33x/u64JXCIHhICYAT2ss7
 ndcw==
X-Gm-Message-State: ABy/qLajOPKvZkSMxdLw381H8T5Hgx38P9VQ/L/8asSfoN0PiFBEO8Us
 bxTpcekslrbSF06MBOjdCsIQUo/Lyrjhu0Vk+NN71A==
X-Google-Smtp-Source: APBJJlHZ9gulqJ4On/Izs9csX9Cxs/nLzCxmdZsLaCUZ8vqMxiLdxHVI8EXoGOcGaRV8gjCUepkdOx9DXrsFpWPxp0g=
X-Received: by 2002:aa7:cc11:0:b0:51e:1692:1111 with SMTP id
 q17-20020aa7cc11000000b0051e16921111mr16481791edt.3.1689068122593; Tue, 11
 Jul 2023 02:35:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230711092532.53929-1-philmd@linaro.org>
In-Reply-To: <20230711092532.53929-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Jul 2023 10:35:11 +0100
Message-ID: <CAFEAcA9f0_dYHR9AbPdZxnk3Fk5Pqcwvv94PvLXOUTxSC8p=4g@mail.gmail.com>
Subject: Re: [hotfix PATCH-for-8.1 v2] meson: Fix cross-building for RISCV host
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Tokarev <mjt@tls.msk.ru>, Alistair Francis <alistair.francis@wdc.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Tue, 11 Jul 2023 at 10:26, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> While when building on native Linux the host architecture
> is reported as "riscv32" or "riscv64", when cross-compiling
> it is detected as "riscv". Meson handles the cross-detection
> but displays a warning:
>
>   WARNING: Unknown CPU family riscv, please report this at https://github=
.com/mesonbuild/meson/issues/new

So where does the "riscv" string come from? It seems odd,
because don't we need to specify whether it's 32 or
64 bit ?

(https://github.com/mesonbuild/meson/issues/5950
got closed as "not a bug in meson, you should be using
riscv32 or riscv64 instead".)

thanks
-- PMM

