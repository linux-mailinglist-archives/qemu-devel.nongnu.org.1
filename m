Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 326987B0244
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:59:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlSFV-0006l9-2W; Wed, 27 Sep 2023 06:58:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qlSFR-0006kR-BG
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:58:29 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qlSFN-0000L6-Gs
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:58:27 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-405e48d8cfdso46396065e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 03:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695812303; x=1696417103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y7LqZLuY+gdVnzpvjeNl6ztNU0y3PMY6W4eCLsTWsmg=;
 b=YvaD2okKimwd7RgHRRcgu+LUcWied3fABcfqCw3HlK4GTRRWqr4Abll6g7AaG6Q2Yh
 NOOPMmIwlJY8eFuB8gyqNlbNKotBNhZfLgKRmEG4fV/30uhXjT2H5tjZKoEiIYtleiGa
 5ikfY86+7BBjQI1lraXEHBMoCpi25pQTSi9rFEyxGla40LaDEM8wT31uizPcYGw1+8RN
 rMBRQaVieF/60+MAHUGU62YVLPPvFO+qZ57T4X9BZLfyB55ngaxl7X5y4EhohN+CLX8z
 AXcYBnfcmi+qyCPgw4V/iT3JnInZbk3lP1e+IPw6lsQRUNs2yVxLTnRqCmG+IkNxujCC
 rTxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695812303; x=1696417103;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y7LqZLuY+gdVnzpvjeNl6ztNU0y3PMY6W4eCLsTWsmg=;
 b=OdzTzR5z2roBI62P9ZAEin4jrjWPoXfASfkm1BxtvCaI3GJAtzN4IL0iZnfwxGzaql
 y+CQ0tQ7w66pdIt+bKOCvBGPW8VhCLC0eDV5ro5+K6OCsabbWOSoscy1Iz8h3KM2S1v4
 9bqJadP+oSOA1NuFtx7Mbzk8eTFi8aZmXF7tl/TYEseNtanOCAQbFNtNqy5A6ioHvC7Q
 /isYc7CNfNSTuS1gGMlV4pF7LM4R6awZqIuG1H57RTHvX0G+fV5mj8ZEm2akrDnnAOf+
 x6LN04oiwjJA+x4M0FmhbWIztcwWuYZlxbkpgiRxle8j/EEiPPu3DxWYlY0yhBiE0zFK
 xUNA==
X-Gm-Message-State: AOJu0Yxzoeb9JOgMfRiEYF8AHvYWPCbJ8z6+geV7ZQU+FpM0LX1xRecW
 2hl6tI8cJgrVv5zREVoaRH2Nfw==
X-Google-Smtp-Source: AGHT+IGuuE9LNm5KtF4xS1WjlBD5yreFIeEbZJwYwQc2XKuwnDR4S1N8f4kiVxmJYD3rEXFvE5+M8A==
X-Received: by 2002:a7b:cc07:0:b0:3fc:7eb:1119 with SMTP id
 f7-20020a7bcc07000000b003fc07eb1119mr1605711wmh.15.1695812303212; 
 Wed, 27 Sep 2023 03:58:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a05600c464300b0040536dcec17sm16523256wmo.27.2023.09.27.03.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 03:58:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 724461FFBB;
 Wed, 27 Sep 2023 11:58:22 +0100 (BST)
References: <20230927101853.39288-1-peter.maydell@linaro.org>
User-agent: mu4e 1.11.20; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH] target/arm: Permit T32 LDM with single register
Date: Wed, 27 Sep 2023 11:58:16 +0100
In-reply-to: <20230927101853.39288-1-peter.maydell@linaro.org>
Message-ID: <878r8rrigh.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> For the Thumb T32 encoding of LDM, if only a single register is
> specified in the register list this instruction is UNPREDICTABLE,
> with the following choices:
>  * instruction UNDEFs
>  * instruction is a NOP
>  * instruction loads a single register
>  * instruction loads an unspecified set of registers
>
> Currently we choose to UNDEF (a behaviour chosen in commit
> 4b222545dbf30 in 2019; previously we treated it as "load the
> specified single register").
>
> Unfortunately there is real world code out there (which shipped in at
> least Android 11, 12 and 13) which incorrectly uses this
> UNPREDICTABLE insn on the assumption that it does a single register
> load, which is (presumably) what it happens to do on real hardware,
> and is also what it does on the equivalent A32 encoding.
>
> Revert to the pre-4b222545dbf30 behaviour of not UNDEFing
> for this T32 encoding.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1799
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

