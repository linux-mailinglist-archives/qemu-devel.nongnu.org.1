Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7281580EEEC
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 15:37:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD3sC-00047n-NX; Tue, 12 Dec 2023 09:36:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD3sA-00047V-Jx
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 09:36:34 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD3s9-0007as-2m
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 09:36:34 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54f4b31494fso8713980a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 06:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702391790; x=1702996590; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jfu+d5q+ATVBjZRGtGSVS6+3GtIPGgV5XHh9rm3Ob0M=;
 b=I+jL7Sxoqu4zUe2jK8Dkj6/6SfO5/Cx3Xw3X7TGwh3qfVm0CZDxmAo/xkmuLC4HCvW
 NXelxxLCa//yhOFoEsYWATPQDjx3hxmNUBrW/ZEwU9D+OW8AgwKdmeRkaROibtee+abG
 1d2spkLkchWXl2mSJVz4RCg2ljhOgiHBGgY6hbTdrKuth5NRlzyfrRZNyoHS6LpI8pi8
 EOq+i3S8QpjM5m4wUHx0eop837nYe3vlGdTe9P7IWO+9ab4tbh99D7gzzrhvlfNVuyC5
 j+r87RJNzIxaZnBUreEPsEn+GCc8WcKO+UxGKDbqtEEXUqU4EynyerpwNx0a8vRgdzZj
 rrmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702391790; x=1702996590;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jfu+d5q+ATVBjZRGtGSVS6+3GtIPGgV5XHh9rm3Ob0M=;
 b=xRGHVIshEqHAw0k7ZqX4oS5HW+vXm5aZrpCjNNZPqr76Tg8m2SCbmtFKmYZTeTNAiv
 EHMGPuRSLxO0YqPx2/RP954uxFhETUMw4bqwDQS1UEuFIpzaSXjc6lxnmq4cW6rtB98d
 8FAuLroCQ5liuOYek9miGmZVpP3VQO9RApY5TN90gfivONH8X5RVxqIR9EQoiz4psbUn
 nq/+50JaKRJ4sVlP7ch/4v5b7Z1cxQ4aZOM+ZrSdPNuq+cwgV8MHsPVVtd0rzMH2lY7t
 vtcpKYPOyHT6PZ3xaX9qKiRz6clGF0sF9Y7m6EV/7/O3gr0xVQ7KtXTrZW2/UVRYB0J+
 4Krg==
X-Gm-Message-State: AOJu0YyYpjN2cSqXYIWba4G81SwPVnH7ecxHQcdW2Hm1hQ6dft/XApih
 rnubKEdm2VasuHlECmj0ysj1l6RI+yWaU0CT6uU9nA==
X-Google-Smtp-Source: AGHT+IGhq9e48cyEEjI8jFQhQfihQASqsNz1kSvcg0h9SepYEIBOPXeynJFJJItwP/dGfKFoACADRfw1c/HXJuBVdNo=
X-Received: by 2002:a50:d652:0:b0:551:cf4a:7956 with SMTP id
 c18-20020a50d652000000b00551cf4a7956mr393108edj.19.1702391790190; Tue, 12 Dec
 2023 06:36:30 -0800 (PST)
MIME-Version: 1.0
References: <277e21fc78b75ec459efc7f5fde628a0222c63b0.1701989261.git.m.a.young@durham.ac.uk>
 <ZXLg_YCHM-P6drQV@redhat.com>
 <alpine.DEB.2.22.394.2312081422490.1703076@ubuntu-linux-20-04-desktop>
 <8be72952-88b6-4c74-b696-fecfa8313c96@perard>
In-Reply-To: <8be72952-88b6-4c74-b696-fecfa8313c96@perard>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 14:36:19 +0000
Message-ID: <CAFEAcA_1cKWJbjbhnX3A0kjzf_qp7A2rVqPZFHo21dVLb9DutQ@mail.gmail.com>
Subject: Re: [PATCH] fix qemu build with xen-4.18.0
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Vikram Garhwal <vikram.garhwal@amd.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Michael Young <m.a.young@durham.ac.uk>, qemu-devel@nongnu.org, 
 xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 12 Dec 2023 at 14:20, Anthony PERARD <anthony.perard@citrix.com> wrote:
> Building qemu with something like:
>     ./configure --enable-xen --cpu=x86_64
> used to work. Can we fix that? It still works with v8.1.0.
> At least, it works on x86, I never really try to build qemu for arm.
> Notice that there's no "--target-list" on the configure command line.
> I don't know if --cpu is useful here.

You should almost never need to specify --cpu : configure
will work out your host CPU architecture by looking at what
the host compiler defines.

thanks
-- PMM

