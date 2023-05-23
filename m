Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 463D270E1FC
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:40:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1V3m-0003r0-6a; Tue, 23 May 2023 12:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V3c-0003nX-3x
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:40:20 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1V3a-0002rp-BS
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:40:19 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-309550263e0so5152701f8f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684860016; x=1687452016;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DNvyqlxCX/6C679g7Q9CdG24jeAA89JZYm0U665yJ8o=;
 b=wfxD/O30gztARzRqrxMyGTdSqYnmAMDYUgIH1bm10AJRgenlXLEU0yrk+pMB/iusq4
 JhqxhlFuoGEDagyBWZqiNSgFBUMKVtwlCGZEwVldSyMKq5+Sjk6cTW6Z15ecIeOkS1ch
 1ThUuq3JhqR2078OTvvKH1YQZ4ydIU8uuEkii3+7okT6edjO/6Jv1cQJuqBJEvsJtGr3
 aXShgSL3yoJw0G4woRAx+7Pug+ngN5f19jVlDsOmL/oyn7IBTIhMP3BcDtHnzhjKWLbE
 BZw8pPC41BJXidTzlS+bjgKR7ffir4LNAe+yfkUTVpI3SxfppQ65wWbyG0KrljTtTr/L
 5XqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684860016; x=1687452016;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DNvyqlxCX/6C679g7Q9CdG24jeAA89JZYm0U665yJ8o=;
 b=lsOU1b5pXgCO1v6wHxT1bD5n788W5jy6Hg5mhfxEyP5EQZStvhs88wiqHSPY+X6OrK
 h4MSugQ70e/bCne9t6Ikf5u6SM2vpCUQS6mGphngSDGr7UyCZuJkR5n7ytZU8Q7pnRXV
 IQead2OFXO24VyCmdr01mxkuna4o2ajtaPSf1zjurzTUwvHMImSfXASyxKMdjuVN9Pq+
 4rwR6dTkkfFfp34QhwakUToWNWBffAL8/mumu7fUPHScRRTf8CqvRMw4zx42AVSEdZZE
 gkQSTb/6X3i+GCZ2qWZ7Dw1Z6ECJj06Br+k5m1A2SxnoIbMIQPgRJvEyJIrvtEAJUjFw
 t+uA==
X-Gm-Message-State: AC+VfDxML7x5sEEZi70HJo/XDZY0fOwXc+cABTVraqJvP/mzzNLD6mZR
 k68GG04q/AbM+E3gIBysTxGZTRuTK87mM2bI7zCyng==
X-Google-Smtp-Source: ACHHUZ7qOkA8cGIv81mZLRFEfLKwri8hkYlmxiB5yHDMW5YB96gZA9PzS6AMc2tpee4wqU2T9As9DA==
X-Received: by 2002:adf:eec2:0:b0:2f8:3225:2bc2 with SMTP id
 a2-20020adfeec2000000b002f832252bc2mr10597069wrp.41.1684860016617; 
 Tue, 23 May 2023 09:40:16 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a5d4483000000b003062b57ffd1sm11642875wrq.50.2023.05.23.09.40.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:40:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E5D0E1FFBB;
 Tue, 23 May 2023 17:40:15 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-17-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 16/27] accel/tcg: Unify cpu_{ld,st}*_{be,le}_mmu
Date: Tue, 23 May 2023 17:40:11 +0100
In-reply-to: <20230523134733.678646-17-richard.henderson@linaro.org>
Message-ID: <87y1lfypao.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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


Richard Henderson <richard.henderson@linaro.org> writes:

> With the current structure of cputlb.c, there is no difference
> between the little-endian and big-endian entry points, aside
> from the assert.  Unify the pairs of functions.
>
> The only use of the functions with explicit endianness was in
> target/sparc64, and that was only to satisfy the assert: the
> correct endianness is already built into memop.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

