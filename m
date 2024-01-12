Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C5782BF15
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 12:13:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOFTd-0003JO-2p; Fri, 12 Jan 2024 06:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOFTb-0003JB-30
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:13:27 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rOFTZ-0004wN-Db
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 06:13:26 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-558c781d311so656655a12.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 03:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705058003; x=1705662803; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=031CNBoypdWESU8yfvqe4miHmAa3XoHv/87g96e00SI=;
 b=M/jkRuSJRDbBLmYDmaGl8/9x+riPsHoVDb3WmSQbEj7V19PwQ3nmkLO/vxeFvDPJSW
 bM2iO8PeXa6LMb1MM/gx4mr5W/W0vA78foSbg9yxTdNoP6Zxx6Wk3VrWSm9OfXGu0dBF
 U0GcLKqxlSNNo/1CiKIRF5k1ResdHP15sdPGkESyV6gyT+6x85yPN05cuO7CoDKR2eBY
 ssxh0gHu82Gevub8v0DSakU/EP6vIveuXDPdQPaZzTrgHCnomw7wgE/yuTampSfgKAMR
 rJsB+OqxMgNoJ2cln99FO5HTsiPfOqiMv+1FHS1sO5/aXq21YQGUmEHz5baY0700UwIk
 HgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705058003; x=1705662803;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=031CNBoypdWESU8yfvqe4miHmAa3XoHv/87g96e00SI=;
 b=tarxNPLy7aI+1tRiNk3AU97yXLkFF88ZUlGokxSXmH7YOcJLljSV1z6d9aqfKMZNgJ
 aVvaYO5eTmNvUAB/gnOiUrHPEb6mO9zOMzHSRHmPzAy6K6u3FeF38/6dVCLxSXj9DWQ5
 9OHd4Sq6d173ESL+SEpqVKKRb8r82PnlF/KQrD2dR6zqX/k+6QCxm/4gEVDrwShoMOTV
 SHnKT+k8IH79qtbqw74enm0r6s5dim9FRHahNcSYIYXvVFD/kv1674S1gu1xS3ADAwLB
 ShRT69PjkmYkx3xIVxEGF9P7hCSCWSLh0u2DmAZzQx+2NuS1d7EOdln5pOwZ9xuT66k4
 ui2A==
X-Gm-Message-State: AOJu0Ywy31pz7/m3mOcxnKGsX4VLHbnuFx2OmgVNpAm258LiH4B50YRJ
 9Lyy+a0CvjZobE+CAqvcV8HnqkMa/gfh1JSez76BHP5VGxnmdw==
X-Google-Smtp-Source: AGHT+IFqm76crucw1xH8IZk+67QRcHbqjqNH4EmiQOES1ilRrJ+AXagnACuI6AhgBQmINhWcnivkuglhVLlEzyUinpg=
X-Received: by 2002:aa7:c584:0:b0:558:d85b:b445 with SMTP id
 g4-20020aa7c584000000b00558d85bb445mr290268edq.77.1705058003237; Fri, 12 Jan
 2024 03:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20240112110435.3801068-1-alex.bennee@linaro.org>
 <20240112110435.3801068-23-alex.bennee@linaro.org>
In-Reply-To: <20240112110435.3801068-23-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2024 11:13:11 +0000
Message-ID: <CAFEAcA8p6S-6bYXO9w2eBP=UTy0vYbBOrgaoscOE=xv3K0z-PA@mail.gmail.com>
Subject: Re: [PULL 22/22] Revert "tests/avocado: remove skips from
 replay_kernel"
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Paolo Bonzini <pbonzini@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
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

On Fri, 12 Jan 2024 at 11:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> This reverts commit c2ef5ee89d76f0ab77c4dd6a1c9eeed4d35d20ed.
>
> While the fixes for #2010 and #2013 have improved things locally it
> seems GitLab still continues to be flaky.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> diff --git a/tests/avocado/replay_kernel.py b/tests/avocado/replay_kernel=
.py
> index 6fdcbd6ac3d..1eaa36444cb 100644
> --- a/tests/avocado/replay_kernel.py
> +++ b/tests/avocado/replay_kernel.py
> @@ -98,10 +98,13 @@ def test_i386_pc(self):
>
>          self.run_rr(kernel_path, kernel_command_line, console_pattern, s=
hift=3D5)
>
> +    # See https://gitlab.com/qemu-project/qemu/-/issues/2010
> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test sometimes gets=
 stuck')
>      def test_x86_64_pc(self):
>          """
>          :avocado: tags=3Darch:x86_64
>          :avocado: tags=3Dmachine:pc
> +        :avocado: tags=3Dflaky
>          """
>          kernel_url =3D ('https://archives.fedoraproject.org/pub/archive/=
fedora'
>                        '/linux/releases/29/Everything/x86_64/os/images/px=
eboot'
> @@ -132,6 +135,8 @@ def test_mips_malta(self):
>
>          self.run_rr(kernel_path, kernel_command_line, console_pattern, s=
hift=3D5)
>
> +    # See https://gitlab.com/qemu-project/qemu/-/issues/2013
> +    @skipUnless(os.getenv('QEMU_TEST_FLAKY_TESTS'), 'Test is unstable on=
 GitLab')
>      def test_mips64el_malta(self):
>          """
>          This test requires the ar tool to extract "data.tar.gz" from

These gitlab issues are both currently closed -- if we think the
problem is still present and are re-introducing the skip lines,
we should re-open the issues, I think.


thanks
-- PMM

