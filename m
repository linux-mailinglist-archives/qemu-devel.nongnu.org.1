Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9808A7ADD89
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 19:03:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkoyv-00071f-Kb; Mon, 25 Sep 2023 13:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkoyj-00070y-7r
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:02:37 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qkoyh-0000VE-LL
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 13:02:37 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4060b623e64so2056155e9.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 10:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695661354; x=1696266154; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r6okw1Z48GygwGrL/A+n/4XaSUBcIguRH2aT58vj3E8=;
 b=JY/IC+hDKb5rmp52+q3UIJhGR5pX2CPWJjADCU3b+j65OTR+Np+I4EE6Ftptgbbe03
 JCm1UFH8NFg/8HIBuf2DhsQVMwJ0SIjY9cLTr4cJGwfZezD94QRagGb7MI13O4bfNzLz
 ne1fvHNmI1bqGHYVZFaaauumPjxUsorMmQPPR7jiGaL+1UiS206AUtGiNOEyQ6Q9IcJZ
 A08llUO1uQHF6KptCrL2wqF92AOAqpi7XmAU3MllY3p3GCfYlR70HngSsgY7fQpyUaS+
 lzIU8QwRRXcpVIkB4hHoOZAzC2Ua6g8GcbtC4pboZsrvoyq7IBuNGDOitZFXSCTay501
 DQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695661354; x=1696266154;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=r6okw1Z48GygwGrL/A+n/4XaSUBcIguRH2aT58vj3E8=;
 b=o+Jn+WWeD2b9ZaTVSA4vPXiuB+2sChQwX7rdXQ8HX0intdQQS0GD95sLmaoGLxmFz2
 nWad9ZXjmDwVMu5HEtY9aRYEkcst1LWEZos8HjECBD9C4z0dqXMakAi+wXpe7XLo+pkg
 xk2Su7Oluxlh0ua8a9YhqAs5030taCQGEMlto5MiKmXdNKGJBOdel9pcHugL1ObAauLj
 xXVsv9GiFOFhGirE296nV+R29YCswjUwF24fextRSFQO6U2QR4zpQmOop5YFRRNyvbHG
 ycbMZRRZLMu2I8Vs1/1IegX3/4Bf7kyP74bFycNN5x+n/H28C/oCTjaJ5rtOirxazGET
 goyA==
X-Gm-Message-State: AOJu0Yz+3RGbvm64ZE8dTxrr96pyeuPE3xG8FgB/OyizIfkfWYKQO3ds
 08tKTPTLEuQ0GTWfwlKk0oMqQQ==
X-Google-Smtp-Source: AGHT+IGEZuqpaMGaY/4w538UB73rDuEBBXEgKpnvobxY6QVr/I4vp/9idaHK/F2NH7U8CGJBP8pcAA==
X-Received: by 2002:a7b:cb98:0:b0:405:89a1:7642 with SMTP id
 m24-20020a7bcb98000000b0040589a17642mr215401wmi.1.1695661354003; 
 Mon, 25 Sep 2023 10:02:34 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a05600c45c900b0040550c20cbcsm7903141wmo.24.2023.09.25.10.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 10:02:33 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3D9931FFBB;
 Mon, 25 Sep 2023 18:02:33 +0100 (BST)
References: <20230925144854.1872513-1-alex.bennee@linaro.org>
 <20230925144854.1872513-5-alex.bennee@linaro.org>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Edgar E. Iglesias <edgar.iglesias@gmail.com>
Subject: Re: [PATCH 04/31] docs: mark CRIS support as deprecated
Date: Mon, 25 Sep 2023 18:01:49 +0100
In-reply-to: <20230925144854.1872513-5-alex.bennee@linaro.org>
Message-ID: <871qemrxsm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> This might be premature but while streamling the avocado tests I
> realised the only tests we have are "check-tcg" ones. The aging
> fedora-criss-cross image works well enough for developers but can't be
> used in CI as we need supported build platforms to build QEMU.
>
> Does this mean the writing is on the wall for this architecture?
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Rabin Vincent <rabinv@axis.com>
> Cc: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

doh, I meant:

Edgar E. Iglesias <edgar.iglesias@gmail.com>

> ---
>  docs/about/deprecated.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index dc4da95329..7cfe313aa6 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -399,6 +399,17 @@ Specifying the iSCSI password in plain text on the c=
ommand line using the
>  used instead, to refer to a ``--object secret...`` instance that provides
>  a password via a file, or encrypted.
>=20=20
> +TCG CPUs
> +--------
> +
> +CRIS CPU architecture (since 8.1)
> +'''''''''''''''''''''''''''''''''
> +
> +The CRIS architecture was pulled from Linux in 4.17 and the compiler
> +is no longer packaged in any distro making it harder to run the
> +``check-tcg`` tests. Unless we can improve the testing situation there
> +is a chance the code will bitrot without anyone noticing.
> +
>  Backwards compatibility
>  -----------------------


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

