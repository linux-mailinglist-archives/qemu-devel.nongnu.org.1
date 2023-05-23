Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D40A70E178
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:11:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ube-0005gq-95; Tue, 23 May 2023 12:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UbT-0005dm-Js
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:11:16 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UbS-0003lQ-6h
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:11:15 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3093a778089so4994891f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684858269; x=1687450269;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5tgYPIb7b7DSQ4qATbtlyXKryNyEf6VacMqe6reYyI=;
 b=sxQQ33lNejfe7K4R6gCCTE2L+612djdJHaS8U2FOX60pvcs/32rp2WGrg+Q8mCKLoD
 RJtghlek1XqBbrzCJxI44uRmhptRYWu1NtjnljBTpSFAJOp+Snr985GBrhJTW1zO/9Hb
 PqhQE+efArEo74b3LEiXWcsu6PyDJMT7iWLrA1VRSZNg+6wJyNZlBjBklKeKHGvUU6Ch
 7EUgHDq4jgJD4UtuN/7a72NG3iqoFW5stFRpbAcEBLCqpZIE3EDSZPJIVLKH0qR1j1bt
 KCsP2TZZh+wXfZzbFZHNsECKiaklX0w9hprQi19JXNRge2Lo2hOR8ta8E2nvNZ19Q9Q0
 TFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684858269; x=1687450269;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y5tgYPIb7b7DSQ4qATbtlyXKryNyEf6VacMqe6reYyI=;
 b=MjVlRZG1ebl2Uo/+g0QJMh0GlaKSrXmeZcSQKX7L2NZGS8iImGyvtd4qkdSVtdmLMn
 j4gPyHBVQVORFtcgeX2Uc5NHRSOSMt04WJf7fKmyfFHSxCEpqIpOP0nbK87Oxo97o9xs
 tQmlRpM3SqogOpRxxYAP4iCv0DVh4pLA3De+DkS1PaKmSol/FCS7EidKkiIKZKdQIjB6
 rP8SRa1uP4upCD7CKIJWOSkEplX9oRkeU92TNuiO2AMjNnTAyUXE+5HVioPQvAyatGlT
 YaMQ/0uVLxD8ePxN+pib2iy2YNWp4Po2TyrSJwZMiSMR1ZFDcmSpX9dGomvBdGh3Uqs9
 8NQQ==
X-Gm-Message-State: AC+VfDxhvB8XdZKTz+6u2Vg8brrxRSlc5PYaDXBjKYnZS8YNvXB5lpdZ
 4KiTeV4AgWpOz97DoVsMVCWnCQ==
X-Google-Smtp-Source: ACHHUZ7gYN+a9Iuc/Jf0dbeT99LiCofvs4xlIKcip2eja3WdJimcHe+j+3cx1vInii0AVfRxz8jrrg==
X-Received: by 2002:a5d:6144:0:b0:307:9d2a:fd35 with SMTP id
 y4-20020a5d6144000000b003079d2afd35mr11232236wrt.53.1684858268970; 
 Tue, 23 May 2023 09:11:08 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a9-20020a5d5709000000b0030922ba6d0csm11432759wrv.45.2023.05.23.09.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:11:08 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5A21E1FFBB;
 Tue, 23 May 2023 17:11:08 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-3-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 02/27] util: Add cpuinfo-i386.c
Date: Tue, 23 May 2023 17:10:58 +0100
In-reply-to: <20230523134733.678646-3-richard.henderson@linaro.org>
Message-ID: <87ilcj2fkz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

> Add cpuinfo.h for i386 and x86_64, and the initialization
> for that in util/.  Populate that with a slightly altered
> copy of the tcg host probing code.  Other uses of cpuid.h
> will be adjusted one patch at a time.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

with MAINTAINERS entry:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

