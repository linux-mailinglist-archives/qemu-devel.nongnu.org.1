Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC31786F01
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 14:27:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ9Pm-0006sg-L9; Thu, 24 Aug 2023 08:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ9Pk-0006sI-MF
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 08:26:16 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qZ9Pi-0008Jf-Gs
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 08:26:16 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-525bd0b2b48so8679842a12.0
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 05:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692879973; x=1693484773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQN0eW78L8WQuK3pLTXgbMsoof+AfXGkD26dkj5/jr8=;
 b=etNZLLbh2vp/Y6eW1IKmycsmtrXSsHSUTRf5OnNeKXpbRKaD4+YM1CLs23Ij93PGoG
 cmZ8nJZowL4UI3mqaQSuhSsfygJMqZgV5k/YU+rXhW/SBNBMQoAjvSFC+3N6+pwHSqC/
 JXdlg1boJEc3YFwrQtKM5sw4m94c94Rwbln43jdoXShyZvKlk0hlPC5C7YvTMJWDUjZY
 dCSYreurXReZyDL59riwqhmVhoFq9+7tGtxlTRa2dkZUG9ToO+ntcMf1yfdzE82zTK+p
 n3nSj+Sxdwl3vh/drBTX1kfLzGMAdXn4l6eg/2H7APT/qd2m5pEo859ECZGxBs/rS3Da
 c4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692879973; x=1693484773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQN0eW78L8WQuK3pLTXgbMsoof+AfXGkD26dkj5/jr8=;
 b=fGeK/a/18ZX0qv6TogXBqbFRWuOWOJQzcH59e9uvxD5FuCU8LFCXhkBMGpvQ0KFcib
 A5XcqC0o6SAFZlDMNpUkYDirFw/y3xIe2aVB+seAY0VRB8m73nCg7ljvefTmzN37lvZ0
 0zjmDWejfamB/xuXdmYbV2nMYqhxCmZJoXRz2U16C9OB5uqcx7Kef5LfYYe2FnRmHdZF
 f7zfwh2YGbFD5+6VYsQ2rRwGAepHa7Iwrugrh9+bJGVh0YEOQtJca4HH/XGdWOSq6OYu
 zmkYA/ajE1OfWF9yUqGPQyUFqWBMWZ3JNpuGf8rNpRZ30oRY0gTnZK1mkG4OkO5m6dpf
 uhaA==
X-Gm-Message-State: AOJu0YxFPgT+C3RIh/oBscDnmfbfHUA/mE/4nsvAYeTYSHkZSfPWseHQ
 nI04f+48ws4j5VGlnA3XAWar9enB4d+k3mRu8ANtgyKuVs/Y65BW
X-Google-Smtp-Source: AGHT+IFYJDD+2+BMTI7dS7uvWEXrGCiEtHcFoMJXxEckgr+JelZWxLv1bz6GpSi9LXciw3yxFndFmI2r8gvEP86l9XA=
X-Received: by 2002:a05:6402:398:b0:525:7091:124c with SMTP id
 o24-20020a056402039800b005257091124cmr12205524edv.19.1692879972778; Thu, 24
 Aug 2023 05:26:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-15-mjt@tls.msk.ru>
 <056b2e32-4443-bdb8-a9f4-5b08a5ef2b52@linaro.org>
In-Reply-To: <056b2e32-4443-bdb8-a9f4-5b08a5ef2b52@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Aug 2023 13:26:01 +0100
Message-ID: <CAFEAcA-=UQoGZxzMGa3kTaUSfmR9qfF4a3kh6x2wQOegN_EO5g@mail.gmail.com>
Subject: Re: [PATCH 16/24] hw/display: spelling fixes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Thu, 24 Aug 2023 at 11:13, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 23/8/23 08:53, Michael Tokarev wrote:
> > Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> > ---
> >   hw/display/bochs-display.c | 2 +-
> >   hw/display/qxl.c           | 2 +-
> >   hw/display/ssd0303.c       | 2 +-
> >   hw/display/ssd0323.c       | 2 +-
> >   hw/display/xlnx_dp.c       | 2 +-
> >   5 files changed, 5 insertions(+), 5 deletions(-)
>
> >       /*
> > -     * Get some data from the DPDMA and compute these datas.
> > +     * Get some data from the DPDMA and compute these data.
> >        * Then wait for QEMU's audio subsystem to call this callback.
> >        */
>
> TIL 'data' is plural, thanks!

It *can* be the plural of 'datum', but 'data' is also a
"mass noun" (the same way that 'butter' is always 'butter'
and not '1 butter, 2 butters'). The OED has quotes for
the mass-noun sense back as far as 1702, and in a computing
context it is overwhelmingly the common use. Use of it in
the plural in a comment in code is probably a mistake.

I agree with mjt that it's unclear what was actually
intended by this comment. My guess from the code is
something like:

   /*
    * Get the individual left and right audio streams from
    * the DPDMA, and fill the output buffer with the
    * combined stereo audio data adjusted by the volume
    * controls.
    * QEMU's audio subsystem will call this callback
    * repeatedly; we return it the data from the output
    * buffer until it is emptied, and then we will read
    * data from the DPDMA again.
    */

and the following comment should be
  /* Don't get more data until we've emptied the buffer */

(or deleted as redundant with the expanded comment above.)

-- PMM

