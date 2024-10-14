Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D9E99CCAC
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Oct 2024 16:23:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0Lxq-00052W-VQ; Mon, 14 Oct 2024 10:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Lxe-00051D-Gh
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:22:16 -0400
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t0Lxd-0001iA-0i
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 10:22:14 -0400
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2fb58980711so4462831fa.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 07:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728915729; x=1729520529; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x7GETirBdYyPvkQiRgoRWo5OYM5llh8/PEjqqq4D8Ck=;
 b=xo5MiuocxMXSJC8iAyshXbR2OgDkntXuH2PXkJI6AXdeDt9zeBNBpRX0pgq2g1DzMJ
 ZxosjkaYc2hHTYGQRTeaqvA9832IjgfYgbWLriealMAGtO7ivbCQ4w2JzMJrlrtLXWlU
 6KWf6gEBnT+bI1yVVrRFPfABBOPQDHU1gIfDgMlp3IRS4I72ubPi+9Sur29qyuDY1h9n
 ZngzSdnQzdhzbYFPmbKnmmrx6GdcS0SgPPANHkfeGTfwjQQ+Y/sSb0KnKrHl59CAIaGD
 8wfC4Vh20oIXXHrTauRG5A9rdGJ63I/Mgr+eCJy8JhQii11JR2hDqtpR6ANBzIADqb5z
 cM6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728915729; x=1729520529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x7GETirBdYyPvkQiRgoRWo5OYM5llh8/PEjqqq4D8Ck=;
 b=bwKfW1sv8Xf+TUQrV38NEMXg6MhNmCA+oZhi8tFsq/nFpkkKQKK/y2HXQN9KT0fSHk
 dx+frHmNt+GqX0CBky+DxlnZRkhHfVaGzRjnCX4eLzY3B5w9raYoTh4cr21UJqJfDxrn
 Z8mGV3DnmRHXxpP26HaQpqi9zrw4cSYu6nEQzGkwFneQdlYBookg9b+cQ/zdlzK9V17E
 lnyx7hPExIuju5aNPUe+WDbchU3NoLPoSPM1Cg7BsYvB3748nlltWiEo6us3fytRvCzc
 PECaKuljItxh78dGtIE8M+blowd3rzzKeK9s31AEh1Vf/5gtcFpRmnJdwYPcrFjznjad
 zskQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQ8n2pNrk0lmK/GJY9r59tCTmT5nBY2KFaR2TF/glzOkuP6K3fltdD9HNf/qlfNFROxFMLDLTFcKiy@nongnu.org
X-Gm-Message-State: AOJu0YwSDQyhXbBrwY8XogYQLt9HoHzoQ9fHeW2+sScySG2M/Zq9iGoc
 GhcIRv0qZYlmEbJu2BCLRQ9TsMRj2d/5q4pu46WVvivgLSJ51huR302gjivnw0tKLshqEzdL+y0
 paO+61fDi5+3xVONTAACodwDGKRy5Bqiwh3NVrQ==
X-Google-Smtp-Source: AGHT+IEUNSznxQQaH+EES4LB0m1TEyCXV8XL8fMZ8BKN4ZKYnTkXOSIhMgC9m3U0RhgGdgrsPj3Q7Yoz1tEMgrcXuE4=
X-Received: by 2002:a05:651c:210c:b0:2fa:cf5b:1e96 with SMTP id
 38308e7fff4ca-2fb325d8b65mr49934101fa.0.1728915728940; Mon, 14 Oct 2024
 07:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20241012-dma-v2-1-6afddf5f3c8d@daynix.com>
In-Reply-To: <20241012-dma-v2-1-6afddf5f3c8d@daynix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2024 15:21:58 +0100
Message-ID: <CAFEAcA8kyEGx63dAv52ekGG8t+BZQ5r4qdLz4Zri80c=Mhr5RQ@mail.gmail.com>
Subject: Re: [PATCH v2] dma: Fix function names in documentation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Sat, 12 Oct 2024 at 07:50, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>
> Ensure the function names match.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>



Applied to target-arm.next, thanks.

-- PMM

