Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6E67FDA36
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 15:46:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8LoC-0002gw-8q; Wed, 29 Nov 2023 09:45:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8Lo9-0002gU-E9
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:44:57 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r8Lo6-0005MM-Nx
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 09:44:57 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-332e42469f0so4458930f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 06:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701269092; x=1701873892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TypTFfi6+Cwnet15wQqaXygFCbQFjpdOm1v91aLTFZY=;
 b=Q0l1k8LkM7Ug5P0nSPULlcAzukBut5SNtD6uQrHqIhnVA+WRzSWBEvopnKsnleum1a
 ztxcOeV/7zqZXQ+WKDNNg+65d3B3B+dYVJyey95xdZUJu2/nj4kR5jZIDpRia1bFeYb5
 EKEHZWBQYndbSCOqAB8yY+RDc2nQMsERAyDtK2eKEFowiRXUSbZsGXmvWP46YTHIfDJS
 p8dywKZUAP7PbUta5sWWwWXfxd5/S0GiCl8PaPoSvG94tvPADINH3UJeEotiRsALmAK6
 hIOmYlkM+PgtkIYRCMIz2G3ei08mRnjziHsZeEojDL7CBzi4jcKUVA/adWfjMvswqcJ3
 13rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701269092; x=1701873892;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TypTFfi6+Cwnet15wQqaXygFCbQFjpdOm1v91aLTFZY=;
 b=HAz+KbIr4Nam1YPonKkObPKgBI4mkRVAJFCCIZlB/R4yJVIe33gz2zqsvGq+FalvvM
 71KBsF6cnixtyDAGc6Ooj3voD6tDg3OFtfzwmeHFyAa4MkkwOnGZoPUCfXwHFQ6FJ9oe
 Uf4TptZ3dh5VszwK42omsakhIva/WQlYKGKyrff9T3U7CZN5Wcf8CIXVtmbG50iY2aUG
 L5emuplUh2gBZ+6Vk+P7YkvHzcxOZQn7IXilxg6r1D9+kUkPEG2pyB73NHFonaWJCWHT
 4onTsT0SCIqXRGt+2yt56g/p0ltKYfBCgmBLwiTGTWvGKtOgqSLRBHXnFFgwqwJBjn2w
 kiYw==
X-Gm-Message-State: AOJu0Yxki5ug+VM73PGi8AJE9lzU6EXcXtKE0ufbrJRzG+hCa/xgepZz
 5XtyZSiuJJ/zeidoJGh5ZMls6w==
X-Google-Smtp-Source: AGHT+IFvIP7KtByjwZ9Zv1L1pieWwcn2HdPqx2eADoo9L6yyHFZ3VL1JXDrN2YjKXK6rCbdSNLXA3A==
X-Received: by 2002:a05:6000:b06:b0:332:ffcc:861c with SMTP id
 dj6-20020a0560000b0600b00332ffcc861cmr6751557wrb.29.1701269092056; 
 Wed, 29 Nov 2023 06:44:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l10-20020a5d674a000000b00332eef1ca7asm13336052wrw.80.2023.11.29.06.44.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Nov 2023 06:44:51 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 333215F7AF;
 Wed, 29 Nov 2023 14:44:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Nicolas Eder <nicolas.eder@lauterbach.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Christian Boenig" <christian.boenig@lauterbach.com>
Subject: Re: [PATCH v3 00/20] first version of mcdstub
In-Reply-To: <20231107130323.4126-1-nicolas.eder@lauterbach.com> (Nicolas
 Eder's message of "Tue, 7 Nov 2023 14:03:03 +0100")
References: <20231107130323.4126-1-nicolas.eder@lauterbach.com>
User-Agent: mu4e 1.11.25; emacs 29.1
Date: Wed, 29 Nov 2023 14:44:51 +0000
Message-ID: <87a5qwbov0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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

Nicolas Eder <nicolas.eder@lauterbach.com> writes:

> SUMMARY
> =3D=3D=3D=3D=3D=3D=3D
>
> This patch-set introduces the first version of the mcdstub.
> The mcdstub is a debug interface, which enables debugging QEMU
> using the MCD (Multi-Core Debug) API.
> The mcdstub uses TCP to communicate with the host debug software. However,
> because MCD is merely an API, the TCP communication is not part of
> the MCD spec but specific to this project.
>
> To translate between the MCD API and the TCP data stream coming from the =
mcdstub,
> the host has to use a shared library (.dll/.so).
> Such a shared library will be available soon Lauterbach's open source site
> and will be linked to from inside this project in a future patch.

Do you have a timeline for this? Its impossible to test without some
sort of open implementation of the library.

> The MCD API itself can be downloaded here: https://repo.lauterbach.com/sp=
rint_mcd_api_v1_0.zip
>
> QUICK START
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Attention: MCD is currently only supported for qemu-system-arm !
>
> Three components are required to Debug QEMU via MCD:
>
> 1. qemu-system-arm (built with this patch series applied).
> 2. MCD shared library (translates between the MCD API and TCP data).
> 3. Host debugging software with support for the MCD API (e.g.
> Lauterbach TRACE32).

We will need some sort of basic implementation to exercise the API as I
assume TRACE32 is a paid for binary.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

