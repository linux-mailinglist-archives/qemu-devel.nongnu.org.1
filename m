Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A51597249C4
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 19:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6a7A-00018O-Fa; Tue, 06 Jun 2023 13:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q6a78-00016r-2W
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 13:04:58 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q6a76-0004Pl-0F
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 13:04:57 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3f6ef9a928fso53361435e9.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686071093; x=1688663093;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1PQu8yBWC4SxYhaTE+RaFa9hC0oDcg7zPVjOJIm8LU=;
 b=NtJsIpZBltWYAF6OWUWF+zLKHeeji5D389PJNNE2XkHFvOZjogZlt1SiOPfZh8Aq1c
 g2i4SQQnePFLrhL0OONnUwd3WmS0svA4ET2oJ77Qzgu7qH4kRLKdeGdNMMze80OyuJ/g
 GZS7z+5l/VGqS3J1sPNihdHGDsBuzEneZ9mzaevG3x7PJo043RXj0DTQpTtsPcLlMo88
 CriR+HN1h4BymEOtirTITbcsnmEa0aqbAHjSZEhT77CjthQgBIcSj1f254HVdxWx/xUS
 IKIfhTMR7yBieRzUx3aAD/PeV5ajKOYEzg7Z/YBQuUg+dfcwly/gY7FKK9XWjv+yfhbR
 kLgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686071093; x=1688663093;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F1PQu8yBWC4SxYhaTE+RaFa9hC0oDcg7zPVjOJIm8LU=;
 b=ApvAAKmjlkrcjYsV7zhKCEYtSHtqZpP3+ZN3sqF/CFMFUIaye0bbjKKZNelt14r4h+
 TKec4/BOItMLqebkPiOPZnVomfDcxbsbIt4P9nDPbyIdM5n29f6cVRVLguI2dHpXd2tG
 FrCjtgfeNjkER2ncN4D5yoJThzS1Xk20FPur38P/o5xjoGXqGN7i278bH8oSpIQD4y6i
 Omp3CG8o20ki5pHZY1dAdLL9umQcfqJ1OIzMJ7vnWFCBTcsxuk15LIRgEHx2cFOO4FOX
 rZr1+000KwD2ddLOyJHHskuZIxY4Y8pcLwhZQJzDrmV8CI6dPDYsFW2Of8ua6aCWdUsE
 NDzw==
X-Gm-Message-State: AC+VfDzaukkbRXbGMamB6HcQloRjUxFF0jHcrsJ9czG77gyj+PlSp/JT
 jMWUzvfDwOFizuc6hjwUbMfr2g==
X-Google-Smtp-Source: ACHHUZ4u43HSfH7UzZ+ruD7T5CX8I4KnyMrjqLYuD6K/tigGk8LQMC1dtz+hFa55zynvnhSPhCGuNQ==
X-Received: by 2002:a05:600c:2181:b0:3f7:2a13:9621 with SMTP id
 e1-20020a05600c218100b003f72a139621mr2273768wme.40.1686071092954; 
 Tue, 06 Jun 2023 10:04:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 y5-20020adfd085000000b003095bd71159sm13284995wrh.7.2023.06.06.10.04.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 10:04:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 24E3D1FFBB;
 Tue,  6 Jun 2023 18:04:52 +0100 (BST)
References: <20230606141252.95032-1-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 0/5] misc: Enforce .[ch].inc extension for re-included
 .c/.h files
Date: Tue, 06 Jun 2023 18:02:14 +0100
In-reply-to: <20230606141252.95032-1-philmd@linaro.org>
Message-ID: <87sfb4h68b.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, SUSPICIOUS_RECIPS=2.51,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Follow the convention to use the .inc extension for .c/.h files
> re-included, as docummented in Coding Style since commit 6a0057aa22:
>
>     If you do use template header files they should be named with
>     the ``.c.inc`` or ``.h.inc`` suffix to make it clear they are
>     being included for expansion.
>
> Most of the codebase already uses this extension:
>
>   $ git ls-files | fgrep .inc | wc -l
>        155

Ahh prescient as I've just added this hack to the loc tool I'm using:

  modified   src/lib.rs
  @@ -338,7 +338,7 @@ pub fn lang_from_ext(filepath: &str) -> Lang {
           "at" =3D> AmbientTalk,
           "awk" =3D> Awk,
           "bat" | "btm" | "cmd" =3D> Batch,
  -        "c" | "ec" | "pgc" =3D> C,
  +        "c" | "ec" | "pgc" | "inc" =3D> C,
           "cc" | "cpp" | "cxx" | "c++" | "pcc" =3D> Cpp,
           "cfc" =3D> ColdFusionScript,
           "cmake" =3D> CMake,

while gathering loc stats for the project.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

