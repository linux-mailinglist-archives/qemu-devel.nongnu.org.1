Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFCD7DCD8C
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 14:09:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxoUs-0006nB-B6; Tue, 31 Oct 2023 09:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxoUq-0006n0-OU
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:09:28 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qxoUp-0007d0-4e
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 09:09:28 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-53e751aeb3cso9216828a12.2
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 06:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698757765; x=1699362565; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhHN4ID3mL9x6F/VrSEK0l9VtzLlBTfPIT4aymTT+U0=;
 b=qY5ZECtorULf3nPdsVN/kBjEXerWAJgZirNf27OqwVWBa1hO0+ZgsD6EdQiG9raAAy
 uSv4E6+CPOWoxj2C1H46pWGkO4YG3L3+Fh0vysqGUIdV6B6espBdHId8M4TwDmvjVxgg
 J4bfcyswkzB5GcOA8IQGT0rd8oHzWAEJ2xgLFjz49WicYVGWDu83d24AUAO7GTukE7gW
 eWYK2lerawNK9PP6Q0VdChtMR3qFKaZTDjJqgzzCy+TKwoGB9Jrt87QJwprdAyvUrMRG
 WlDCKdJJm6HhPuZxwEoOW5z67LSfMG8NBCAX++U1dmQSUF2YPRcS1I5hrPX184Im5JxW
 VWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698757765; x=1699362565;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AhHN4ID3mL9x6F/VrSEK0l9VtzLlBTfPIT4aymTT+U0=;
 b=bFIhLeYLEdWW5zRQASHJieThWBDAvsP1cqTgbYm5Jvvycyd15XjtiAb5r9IKM2fNLh
 JUM4Tzw7mz/r6KVF47Dg4WeU0yRMh9+ZR8anddyZhcgm9qJnE9j33Z+t9nZgtZ98U4TW
 Si4tvg93RaT1IErFoV3hqg4AqR71y67oeH/aV1rAGNhxHGOTSZPRnrramjLqwbMwpWDh
 DnxAQQF7t74EnRX65B9TOZvz74j9yv4snh5GmD5Mu7TsmMkxOpVwXhSK9XeNbKQRXWWm
 ToVAJ64+PAU2Zk29X4VOeBrRbN7M7Mtmb/mLl/cHWxRwkgFt+CIH+qTL4wFpfy40l7wu
 lYdw==
X-Gm-Message-State: AOJu0YyicSu52u4a/WchcJywAYFs+/GzwAGtoa50zPkuc2fm5D7XlLmY
 2V+MZHA1IyqdkehkR9MbzPyBYAQyEffOrl67QOCywA==
X-Google-Smtp-Source: AGHT+IE2WwANpf582XP3Y75t2QCOPTUOrT+jL13zw3lNmw5B+jUBmZg9BKXBsv9KTqfEsC9i815Zfb9hXZ2wAkB2ud8=
X-Received: by 2002:aa7:d3d7:0:b0:53f:381a:a25f with SMTP id
 o23-20020aa7d3d7000000b0053f381aa25fmr10392937edr.23.1698757765618; Tue, 31
 Oct 2023 06:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <87cfa6e91ba9608c5f4cd0841987925d@mail.emailn.de>
In-Reply-To: <87cfa6e91ba9608c5f4cd0841987925d@mail.emailn.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Oct 2023 13:09:14 +0000
Message-ID: <CAFEAcA_XHAzghLNgoKnUvJR97KQQk=QHFKQ3fNBLJHt5EC19gg@mail.gmail.com>
Subject: Re: qemu master git source can not compile under macOS Sonoma 14.1
To: Rene Engel <ReneEngel80@emailn.de>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Tue, 31 Oct 2023 at 12:49, Rene Engel <ReneEngel80@emailn.de> wrote:
> For days I've been trying to compile qemu master git 8.1.50 from the curr=
ent qemu sources under MacOs Sonoma, which fails. Older sources can be comp=
iled without any problems, there seems to be a problem with Meson in the la=
st source, version 0.63.3 is always tried to be used. Meson 1.2.3 is instal=
led on my system via Homebrew.
>
> I have already described the problem here:
>
> https://gitlab.com/qemu-project/qemu/-/issues/1939

Paolo, this looks like one for you ? Should we really be
using some older version of meson than the system one?
Do we need to fix this by saying "on macos $whatever,
minimum meson requirement is XYZ?".

thanks
-- PMM

