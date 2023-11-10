Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33FB47E7BC7
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 12:21:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1PXM-0006ml-08; Fri, 10 Nov 2023 06:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r1PXJ-0006mG-SK
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:18:53 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r1PXI-0003lS-8E
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 06:18:53 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso3069147a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 03:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699615131; x=1700219931; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BCR61QE4ydIgYeiOrwA+nOrMj2JOoVhgp8U+Sjs5I1s=;
 b=lVBtbGLVYzpN5R7wZDdmbqBRJp9GFeJIo4V5ozGTMHsqUfPtCWqCCzeDW+Y2jVGEew
 i47VN6EEPmW20FIwtqAyUl8AMVuFwvIWU/MpKCbPHzMJuS3xWVdp1rTsHEGafd4gxLF2
 bOzgKOnch5zUIALTpOx8JFnBEm9l2eDtIKsdu+39Z4/zAppfjIIqyWhRZz3MbYRU5buF
 1MQWO1TIOMQaSDZ0kxbBpgXllriEYGIgdtQ04lx3HnDhR3VPXJGyNgW3msotlQPRB+W+
 CYcZxiKsYlQGhoXsBCovV6He6VIJxOi4FuFreJzIE63OsRyNXhyRdNe8pT3hoPwNi9tI
 K4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699615131; x=1700219931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BCR61QE4ydIgYeiOrwA+nOrMj2JOoVhgp8U+Sjs5I1s=;
 b=gMx6YTJCkHvOz+BDVRQNnIa6ZQcJ6QHisIo7gz5u91VvkAOSh/9YnxfihT7/ElGYMF
 LSuKW4s5GB8e53UEV14P4crFAfwqMiAEUXNQ3cU4b5q6Nk3dTG0rCPsk67839BtBV034
 7Kr1C3CZkuRNwgC7ro/bWuOj9pDPx1sHKbtVy/ZkOnrYkswgjE2eB8Y9aQJMrAVjj5Rm
 bdE56Z04lWjswcQTb3PwTzNYKie5iGQtmJRXkhiKEHH99kS55Wp/TBUCS1apGB8fTc59
 2ofndgynL4ON5624WI1W05k4Ohk8+oTjoCES75Um/X+HU9hp0okB6MDShYDFV6MfV5Ys
 qVNQ==
X-Gm-Message-State: AOJu0Yy+YiaOPpSjvG1+BENgvG2A7o3y1WSmjJYCrsi+ZMcmYKjMTgwS
 25wefa9JPZQiMlvHe2Z3WrBp+deQ8lokYvUUtXZkQA==
X-Google-Smtp-Source: AGHT+IHUWoZbJd6rMLMHFEnFtKhh78QPIvyJHZGIlAJheilVAg278mdz1QIUQ1612BzZxTAsaJXdNiDyKhdftNqrY04=
X-Received: by 2002:a50:aadd:0:b0:53b:9948:cc1f with SMTP id
 r29-20020a50aadd000000b0053b9948cc1fmr6710655edc.12.1699615130691; Fri, 10
 Nov 2023 03:18:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699606819.git.manos.pitsidianakis@linaro.org>
 <4b040fc18cb0e563e92ce084ca18b89a050a8aaa.1699606819.git.manos.pitsidianakis@linaro.org>
 <CAFEAcA80sv6ewJ+LoROn-9ooEyLGQwiqYpL3=fqrK7gA0oZG-A@mail.gmail.com>
 <3wmne.fhuf28sb5yfg@linaro.org>
In-Reply-To: <3wmne.fhuf28sb5yfg@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Nov 2023 11:18:39 +0000
Message-ID: <CAFEAcA-mSBgLuGLp4Tzaq0L78PtsxF19CVfmkJwaM8pHfwv7wg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Add warn_unused_result attr to AUD_register_card
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 10 Nov 2023 at 11:02, Manos Pitsidianakis
<manos.pitsidianakis@linaro.org> wrote:
>
> On Fri, 10 Nov 2023 12:21, Peter Maydell <peter.maydell@linaro.org> wrote:
> >This kind of thing is why Coverity's unused-result warning has a
> >lot of false positives. We shouldn't introduce extra code like
> >this to work around the fact that the tooling doesn't understand
> >our error-handling convention (i.e. error_fatal, and the way
> >that some functions report errors both via the return value and
> >also via the Error** argument).
>
> I respect that :). But I personally believe that clinging to C's
> inadequacies, instead of preventing bugs statically just because it adds
> some lines of code, is misguided. Proper code should strive to make bugs
> impossible in the first place.

I generally agree. The problem here really is that we've ended
up with this odd API convention that reports errors in two
ways. In an ideal world we'd tidy up our APIs to report errors
exactly in one way (presumably via the Error).

-- PMM

