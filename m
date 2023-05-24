Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DBC70F77F
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 15:21:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1oPP-0008JQ-36; Wed, 24 May 2023 09:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oPL-0008Ig-TW
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:20:03 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1oPJ-00071x-Jl
 for qemu-devel@nongnu.org; Wed, 24 May 2023 09:20:03 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-30a8fa6e6fcso580534f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 06:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684934399; x=1687526399;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAukaMEk29u/LzrR56tJrOjXWkjkPpeu7GXa8YpbRI4=;
 b=jZEA9nLBnW8LR8z32OEc293G+RSqqAQI7GS3B787NJiBXEwGZSuUlDDIE43ArXn/Jw
 7IyeZv0mmzQ4pWqYWN97Rxy4gk1ve2sjWJA3PfuUDBmX5zFjG9NdSo7fTRGx2GW0ZpXC
 /XevH1v2iNm/aMm1MMyjVn2AOG/hLboIyN5I9mi53ixFI02fAC9c+R6DxkvoeMrNnYLY
 yvX2RI4fvrbgYcav//8QMkWI8mSpmgSjRZYiCySpVY2YqhJamly6wuWksOsZsOPwqlNq
 WT2jphjc7SVhY2C6g+kbCseuq7PZGi0GbE5XpY4KU8rzcSO1WmXDZ+OB0SEYGpUuaoij
 7d/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684934399; x=1687526399;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VAukaMEk29u/LzrR56tJrOjXWkjkPpeu7GXa8YpbRI4=;
 b=k2NzYBi9WI5XbOF2me31LMO+I6Exsx18aAPD9SApPtUCRRXVip1wn0fyqegi2Z8NxV
 5Xz6aX4lYYm18Mb0qEaEkQU27NWqiFaItBFyY7W+WLihviBm015rXslAa0Lq4cm5UEZm
 cdvSUrt9quTRPhEFHdqqQ5ITmF91cX53mWZJxY9gQjZQ5mfpkqUPYJYCId7alrP6tSkB
 +HIUv4bVSqZofN+oZbb80tqIUicF99FLB/k5zDjMWBTRALspwSGbyyPUJmnsbk364RoC
 eaAwOn4KpnciIVBaKOI52KZKAj+L4Qi9u6oDMKQtEMKgwivjIxpQR6vxjxJ2adBFAurs
 vUrg==
X-Gm-Message-State: AC+VfDyB6BoQCMmFFfzEEZUjd7IFZWJ+FcMifXIXk3wPlTZ9jFIWrcZt
 DN3VSA3FU5tXatJtsR9Fj75TKg==
X-Google-Smtp-Source: ACHHUZ7qbyDldjlGmgPQ8Tey3AAgINfV6x58Pi+6sEh4kzdJ2vJo8bAfcOtPknDDHzjqZ8Fg5j2hmQ==
X-Received: by 2002:a5d:4650:0:b0:309:36e9:5834 with SMTP id
 j16-20020a5d4650000000b0030936e95834mr13963669wrs.61.1684934399250; 
 Wed, 24 May 2023 06:19:59 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a5d58ec000000b00309257ad16csm14518377wrd.29.2023.05.24.06.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 06:19:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 719721FFBB;
 Wed, 24 May 2023 14:19:58 +0100 (BST)
References: <20230523202507.688859-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, balaton@eik.bme.hu
Subject: Re: [PATCH] target/ppc: Merge COMPUTE_CLASS and COMPUTE_FPRF
Date: Wed, 24 May 2023 14:18:34 +0100
In-reply-to: <20230523202507.688859-1-richard.henderson@linaro.org>
Message-ID: <87jzwxx3wh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> Instead of computing an artifical "class" bitmask then
> converting that to the fprf value, compute the final
> value from the start.
>
> Reorder the tests to check the most likely cases first.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

We see a slight performance boost although my baseline run was a bit
noisy:

=E2=9E=9C  # before
=F0=9F=95=9907:31:14 alex@zen:qemu.git/builds/all  (b44e6e6) (REBASING 1/2)=
 [$?] took 10m=20
=E2=9E=9C  hyperfine -w 2 "./qemu-ppc64 ~/lsrc/tests/lame.git-svn/builds/pp=
c64/frontend/lame -h pts-trondheim-3.wav pts-trondheim-3.mp3"
Benchmark 1: ./qemu-ppc64 ~/lsrc/tests/lame.git-svn/builds/ppc64/frontend/l=
ame -h pts-trondheim-3.wav pts-trondheim-3.mp3
  Time (mean =C2=B1 =CF=83):     649.858 s =C2=B1 58.351 s    [User: 649.27=
2 s, System: 0.448 s]
  Range (min =E2=80=A6 max):   616.148 s =E2=80=A6 764.585 s    10 runs

# after

hyperfine "./qemu-ppc64 ~/lsrc/tests/lame.git-svn/builds/ppc64/frontend/lam=
e -h pts-trondheim-3.wav pts-trondheim-3.mp3"
Benchmark 1: ./qemu-ppc64 ~/lsrc/tests/lame.git-svn/builds/ppc64/frontend/l=
ame -h pts-trondheim-3.wav pts-trondheim-3.mp3
  Time (mean =C2=B1 =CF=83):     599.968 s =C2=B1  8.014 s    [User: 599.65=
6 s, System: 0.181 s]
  Range (min =E2=80=A6 max):   591.171 s =E2=80=A6 615.912 s    10 runs

Anyway

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

