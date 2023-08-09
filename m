Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33035776632
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTmkf-00013r-HZ; Wed, 09 Aug 2023 13:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTmkd-00013j-A5
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:13:39 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTmkb-0007PP-3W
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:13:39 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fe2fb9b4d7so59775285e9.1
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691601215; x=1692206015;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wmElX9MpG8bUZFaRa7BhKKdCjdXsSsJy8kbSIQnis50=;
 b=tIKywO2lnji0oBSY7lzpX/95twaLnYFv1RNxC68mtpPQC1ii95+X0GvD8iFbHR5ACq
 9buWuuFexZEQ4vIGT7yGLFjD76Zz0tiKX/9j61RfV19VDPStICNz+rUNYIOWmKmJd0kW
 B4QaTFy8sgnVWiQ7iiuhO6G4kLJx/9YRb557T/53QLxwqCpJs6Sa6Kh5brIjdI0JxTWa
 b4yjyIc7o/eYVwaVkm5nhdCd2wm9Tp2Ko2Mpus94XsmE0h1WxsEvkhWNPEkrPFM00stz
 77infLhQeYyrAGQtinrwleraxan91WAdfD4qJYIEj22Bry5APcj7DOUFZQYRUlExLiOC
 CSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691601215; x=1692206015;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wmElX9MpG8bUZFaRa7BhKKdCjdXsSsJy8kbSIQnis50=;
 b=T7uRzaI1L7ebU9pGUtVDyVoNJyaL1wqtfGQsK/rA1j14kbq7AmbRE96LofNuMRJbZB
 J58egsTRtmsGnJZln9hbuZT32HKCfFhw40yibOPDqCqlKL10ER6GpGPO0vRLMhIWF7Ai
 dC71FsoEu2NXOjZ5OdHua2sqN5WqpuDA9CKvDrqHf3sPpA2vCIbdWgLMwEQxv1LUI6Az
 hxS2bPPLiIGUqYaYcx1SQ11/pmshSog3tIIW1O6uoxU6404sjB+I1L4UHrHUoi4bbEU3
 7yy29kG/JI1qpqkc0P8LIKrij+i/kFhNaoWi+WPy8kqfht5JqRqNpkVX9ClPNhbJf8X8
 w35A==
X-Gm-Message-State: AOJu0YxcT/7JiVWbZKFLeMrLUGTMFD53q5VFJlSW+JkDmud57hd/wZsQ
 c+JOwDCVABIzzbcQB3cUoHZNpSRVF9VAx/Uv95Q=
X-Google-Smtp-Source: AGHT+IG5bglGaX22xMfBAuxQKYEun/w0KWDvsudV2o8bXZ1tXoPX3f8cJSltL1PTXbsf/CEb725BGA==
X-Received: by 2002:a05:600c:299:b0:3fa:99d6:47a4 with SMTP id
 25-20020a05600c029900b003fa99d647a4mr2650465wmk.22.1691601215417; 
 Wed, 09 Aug 2023 10:13:35 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 ay40-20020a05600c1e2800b003fe29dc0ff2sm2617746wmb.21.2023.08.09.10.13.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:13:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9C30E1FFBB;
 Wed,  9 Aug 2023 18:13:34 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-11-fufuyqqqqqq@gmail.com>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yeqi Fu <fufuyqqqqqq@gmail.com>
Cc: richard.henderson@linaro.org, qemu-devel@nongnu.org
Subject: Re: [RFC v4 10/11] tests/tcg/multiarch: Add nativecall.c test
Date: Wed, 09 Aug 2023 18:12:53 +0100
In-reply-to: <20230808141739.3110740-11-fufuyqqqqqq@gmail.com>
Message-ID: <874jl83zr5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


Yeqi Fu <fufuyqqqqqq@gmail.com> writes:

> Introduce a new test for native calls to ensure their functionality.
> The process involves cross-compiling the test cases, building them
> as dynamically linked binaries, and running these binaries which
> necessitates the addition of the appropriate interpreter prefix.
>
> Signed-off-by: Yeqi Fu <fufuyqqqqqq@gmail.com>
> ---
>  tests/tcg/multiarch/Makefile.target     | 17 +++++
>  tests/tcg/multiarch/native/nativecall.c | 98 +++++++++++++++++++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 tests/tcg/multiarch/native/nativecall.c
>
> diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Ma=
kefile.target
> index 43bddeaf21..5231df34ba 100644
> --- a/tests/tcg/multiarch/Makefile.target
> +++ b/tests/tcg/multiarch/Makefile.target
> @@ -138,5 +138,22 @@ run-plugin-semiconsole-with-%:
>  TESTS +=3D semihosting semiconsole
>  endif
>=20=20
> +nativecall: native/nativecall.c
> +	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(filter-out -static,$(LDFLAGS=
))
> +
> +ifneq ($(LD_PREFIX),)
> +ifneq ($(wildcard $(LIBNATIVE)),)
> +run-nativecall: nativecall
> +	$(call run-test,$<, $(QEMU) -L $(LD_PREFIX) --native-bypass $(LIBNATIVE=
) $<, "nativecall")
> +else
> +run-nativecall: nativecall
> +	$(call skip-test, $<, "no native library found")
> +endif
> +else
> +run-nativecall: nativecall
> +	$(call skip-test, $<, "no elf interpreter prefix found")
> +endif
> +EXTRA_RUNS +=3D run-nativecall
> +

Or indeed just expand VPATH and use TESTS instead of EXTRA_RUNS (which
is for additional configurations of tests):

modified   tests/tcg/multiarch/Makefile.target
@@ -138,13 +138,18 @@ run-plugin-semiconsole-with-%:
 TESTS +=3D semihosting semiconsole
 endif
=20
-nativecall: native/nativecall.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(filter-out -static,$(LDFLAGS))
-
 ifneq ($(LD_PREFIX),)
 ifneq ($(wildcard $(LIBNATIVE)),)
+VPATH +=3D $(MULTIARCH_SRC)/native
+
+nativecall: nativecall.c
+	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(filter-out -static,$(LDFLAGS))
+
 run-nativecall: nativecall
-	$(call run-test,$<, $(QEMU) -L $(LD_PREFIX) --native-bypass $(LIBNATIVE) =
$<, "nativecall")
+	$(call run-test,$<, $(QEMU) -L $(LD_PREFIX) --native-bypass
+	$(LIBNATIVE) $<, "nativecall")
+
+TESTS +=3D nativecall
 else
 run-nativecall: nativecall
 	$(call skip-test, $<, "no native library found")
@@ -153,7 +158,6 @@ else
 run-nativecall: nativecall
 	$(call skip-test, $<, "no elf interpreter prefix found")
 endif
-EXTRA_RUNS +=3D run-nativecall

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

