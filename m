Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8916770E1AB
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:21:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UlJ-0003z8-9H; Tue, 23 May 2023 12:21:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UlH-0003ye-5S
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:21:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UlE-0006Ou-Me
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:21:22 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-3f42d937d2eso289905e9.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684858877; x=1687450877;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+PGnqd49/MjPc3m1i3kq27zK/oDBO600uE2bXjagULQ=;
 b=igqFUzJHRgJMNgMUciFvAR0mTYQTOyxKJJXIDW07KwiLSrHgrn1Ij/vkxfQHCzFDJt
 LsNgPFFAe1UQJjzECjkHw4xywn39ieEtB01wdaT0FSyGgujytJ095u+gwNCr+d/21Dwm
 eFRLFh1FMsNqieu1jBmC59gBxmbirAtRYTpJJPh8xbghILFm6PQ+JpCJwfAWOomFoMkb
 3X7IR4MEuaAb9dFJZgwfTG2H0axLwcwgaFEXeBHZRmNNdon5vnjR6pC38yGN/sW0uuh+
 xGw7UMIN9MsZUHVTUK05qO8IRCtQ0n84N4cTuAFt5YZCZdejbMQK8enBIT54wMFaSWSN
 +A9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684858877; x=1687450877;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=+PGnqd49/MjPc3m1i3kq27zK/oDBO600uE2bXjagULQ=;
 b=E8IGjnt2QsSCPI9wl72Kbi9GUlPjIAMykLd9LzVfTaj0UXgCNSe+NPZgV+cNKsD5hb
 DpIm04Dcgwz6ZDLc8MyuFwoszvmrZYRcpwRXCDV6RnanXPF4gNe31uI9vpf6+RWpsdtT
 8NrY6izAi4feKEQCVUPZ+lc/Y3uVvoFRGqpX4dbMmedC+RKlIllAVhDwdVmPpXrf19qZ
 xIV1sZUhXFZEbFtgQJhTLgT2lYrbdOz4oonrDmXmaQn2Tth1A26gP7B51ZIfl0ol3Pog
 Dag+0QD+KZfFsBj3s5Qi3vsNGkbDjB/+g3wXumN1wINt0/zcXVkiToW4fmIO+//fGs/Q
 TCjw==
X-Gm-Message-State: AC+VfDzWnQ4bq7O3d+0QL9mQuDUcheqb6yvPONBJh30waKfBI2jYfNYk
 RRkapSb9QpkgjnszWSBhANz2GA==
X-Google-Smtp-Source: ACHHUZ501VYUb9mWscsBLQNZ2My7rVKww1FKtmZIV/mKcEW7uRelWvdrdiTsWp62S2oyg//g1+7ZEw==
X-Received: by 2002:a05:600c:2196:b0:3f6:580:b07d with SMTP id
 e22-20020a05600c219600b003f60580b07dmr4954047wme.21.1684858877062; 
 Tue, 23 May 2023 09:21:17 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 e17-20020a5d5951000000b002fefe2edb72sm11654384wri.17.2023.05.23.09.21.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:21:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A9E71FFBB;
 Tue, 23 May 2023 17:21:16 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-8-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 07/27] migration/xbzrle: Use i386 host/cpuinfo.h
Date: Tue, 23 May 2023 17:21:11 +0100
In-reply-to: <20230523134733.678646-8-richard.henderson@linaro.org>
Message-ID: <87wn0z10jn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

> Perform the function selection once, and only if CONFIG_AVX512_OPT
> is enabled.  Centralize the selection to xbzrle.c, instead of
> spreading the init across 3 files.
>
> Remove xbzrle-bench.c.  The benefit of being able to benchmark
> the different implementations is less important than not peeking
> into the internals of the implementation.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

