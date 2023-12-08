Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7003680A00B
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 10:55:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBXYX-0004YQ-Uw; Fri, 08 Dec 2023 04:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBXYU-0004XB-MC
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:53:59 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rBXYT-0002q6-3b
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 04:53:58 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40b5155e154so22575655e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 01:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702029235; x=1702634035; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0ELGUhAy/igS5kZdXJsHK8JqU0OG8UxLp8HJlefHQs=;
 b=A9QldCYs6vpFcruP+Zp+OlxBo/hZ7JQl0ELyOwVIRy0Sw1d5CrseyT5Po6JTivVzfi
 t9R4EOhN+7CdTu+GyPFiR5NiVQ7KUlxIXGqHojIi8xfob5T8lVbqnpTEMjAumDZlflja
 +jbsF/HfDSk3sTVyWzbwO1WtwOLczV/X9pnok1H9BOnbS4rHRQiwgDqQV6jdkt+8Y8UQ
 x2zlcOxpUFGclw38PCH26M8Mzc7DqzFfAZeAHuUC16i9+5uwQnbx86P9Sz9Tm1B2A0PN
 TeV1fAW3+ZpRA51EYwd/iBOEM9LmhPeYQJ6SfDTAu4cxvOVYvCpXWWOyABV9+TU+iTx3
 qNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702029235; x=1702634035;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I0ELGUhAy/igS5kZdXJsHK8JqU0OG8UxLp8HJlefHQs=;
 b=aSW7iz7B8IbOtHHLS9aA+kQLxe+y42+IyjbZ+Z3iehhhRrzXoTyrU2y10HYmmOABi1
 QGOybXMtx6LpEtHeNu1fcKuhDS6DHJVbHnmqmmW10BHMyTPGOBewAzI0JQqInk7XO5od
 sMMsL7WeSlLivnQhu9p6r4r+0bl2+MIjO5hHRlCskVFLq9+TIEwjwcEdtkgJbWUi98w8
 t3GxcSepjTxzf0eXTtNAm2USFnnE87qD520aWd5hV4xOca7pnzOtD0ptjhLdj1cA7oGp
 qviZh2QrjhSDYtWAIPWJiCSXuypcllCy9eBDxpk2lLBKIWHC7gaxWqNdwe9JAyTei5V8
 o+yw==
X-Gm-Message-State: AOJu0YxyPKXYYPfWPV74dTCH+E91smBBsSGvN44T1suQ45adVK7gjQKT
 PPLg815rJhfB7s3zG0JR7rvDig==
X-Google-Smtp-Source: AGHT+IEq2qAdOSLa3EUo2FUbY3ib8qqQx2MuAH8OBGCT6k6MnwpnFV6aPwsXHh1oZRTnSdtB1AwnFg==
X-Received: by 2002:a05:600c:4ca5:b0:40c:2630:1743 with SMTP id
 g37-20020a05600c4ca500b0040c26301743mr1639857wmp.84.1702029235348; 
 Fri, 08 Dec 2023 01:53:55 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 b5-20020a5d4d85000000b003333521a1cesm1647636wru.57.2023.12.08.01.53.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 01:53:55 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AC22C5FB61;
 Fri,  8 Dec 2023 09:53:54 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Laurent Vivier <laurent@vivier.eu>,  Peter Xu
 <peterx@redhat.com>,  David Hildenbrand <david@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v3 3/4] accel/tcg: Remove #ifdef TARGET_I386 from perf.c
In-Reply-To: <20231208003754.3688038-4-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Fri, 8 Dec 2023 01:35:35 +0100")
References: <20231208003754.3688038-1-iii@linux.ibm.com>
 <20231208003754.3688038-4-iii@linux.ibm.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Fri, 08 Dec 2023 09:53:54 +0000
Message-ID: <87edfxxbnx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> Preparation for moving perf.c to tcg/.
>
> This affects only profiling guest code, which has code in a non-0 based
> segment, e.g., 16-bit code, which is not particularly important.

I have no objection to removing the wart. Is it worth adding a note:: to
tcg.rst to say that profiles of 16-bit x64 code will be junk?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  accel/tcg/perf.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/accel/tcg/perf.c b/accel/tcg/perf.c
> index ba75c1bbe45..68a46b1b524 100644
> --- a/accel/tcg/perf.c
> +++ b/accel/tcg/perf.c
> @@ -337,10 +337,6 @@ void perf_report_code(uint64_t guest_pc, Translation=
Block *tb,
>          q[insn].address =3D gen_insn_data[insn * start_words + 0];
>          if (tb_cflags(tb) & CF_PCREL) {
>              q[insn].address |=3D (guest_pc & qemu_target_page_mask());
> -        } else {
> -#if defined(TARGET_I386)
> -            q[insn].address -=3D tb->cs_base;
> -#endif
>          }
>          q[insn].flags =3D DEBUGINFO_SYMBOL | (jitdump ? DEBUGINFO_LINE :=
 0);
>      }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

