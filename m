Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FC370E179
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UbU-0005Y0-So; Tue, 23 May 2023 12:11:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UbD-0005Ur-Bw
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:11:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UbB-0003jZ-RB
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:10:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3f60e536250so4815315e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684858255; x=1687450255;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a0lM2sXvgJNd+c2UYDjD9VhabccgUjPID3s9R/eArYQ=;
 b=C1uRX1kVNjAk+ihYN2mYYoerEh9257gv5KaQP1rIGMlZcbNsm1mITWF0Mk9NawvjHW
 gO+yvyWhDl+ljWpG6K8vB138kanl77Xb6GY2N2HjqG8p9wlGvnCanu9OBMAwoM9yeTSB
 GAW5uvZbsvlohvjqg6DTr7WrAMemIoPkJiDw/zmvzPe098Pkf4rjC19t0IGL6YRhxwiR
 VEfrLXwsrLKOzZiJUjBlQBGITVTpsZQTUsK2/1kCVSgoHLVj/JpJiWTYNE0yXV/Cwj0b
 bzFiUpYJz65O3RxSiswdAu1wgTOQ4W+/4l3PjvtO7RRyW9DpZSNAG0Y3tEUTdWDUWrg0
 aNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684858255; x=1687450255;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a0lM2sXvgJNd+c2UYDjD9VhabccgUjPID3s9R/eArYQ=;
 b=B7DMIihqV59ZY8ZpGX1oXBR9PDmHWxbvbHTmZVwvrtqG2GoryGZKwuEo4rPwjzAKWt
 L+IjtmDqA/nZZx31AlGHQ6szCqDB/Z584ZDcuap3Bewl1GQ9GPUc1c9ktA4yAsjwBzJv
 lJGM+Zk9fnLicMmUhpcUZiC4DfaFjcdLrDQijRj1aA733yd8R2qU2AeUFGF62Jclv2Dz
 +rILVQ/jLUxIax/BAnenBm1nUqaIynPvGlaYLtx7ivhVJJNfSxMfYdgwAaRrnp3wfa4N
 ElIXBA0qUR+C2DoyrOmrL3JUYNez9V6C30+mY1GYJmQ2oW59kyvILExrJ0l4lqd1I6Jk
 pXZQ==
X-Gm-Message-State: AC+VfDyjkF6a8AdBTSbuos5rNOTqm0/emo3xHSH+Hk7UdJmTuN02enHa
 1vw8R9nfEAWuYNWylmAP0JZgoQ==
X-Google-Smtp-Source: ACHHUZ64/sdTr7+MEjNpWMqBHjfmtlKIaExvZy9NVAFCCU4G5yFHYL5NV1pVcUAZBIKvvROKModWvA==
X-Received: by 2002:adf:f952:0:b0:30a:9577:ca9b with SMTP id
 q18-20020adff952000000b0030a9577ca9bmr3462782wrr.9.1684858255490; 
 Tue, 23 May 2023 09:10:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 m7-20020a5d56c7000000b0030630120e56sm11457837wrw.57.2023.05.23.09.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:10:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B1AE51FFBB;
 Tue, 23 May 2023 17:10:54 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-2-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 01/27] util: Introduce host-specific cpuinfo.h
Date: Tue, 23 May 2023 17:10:50 +0100
In-reply-to: <20230523134733.678646-2-richard.henderson@linaro.org>
Message-ID: <87mt1v2fld.fsf@linaro.org>
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


Richard Henderson <richard.henderson@linaro.org> writes:

> The entire contents of the header is host-specific, but the
> existence of such a header is not, which could prevent some
> host specific ifdefs at the top of the file for the include.
>
> Add host/include/{arch,generic} to the project arguments.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

