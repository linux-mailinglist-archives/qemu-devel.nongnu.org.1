Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 122FF74584E
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 11:26:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGFoi-0006LA-4n; Mon, 03 Jul 2023 05:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGFoa-0006Ki-If
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:25:48 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGFoY-0005My-Sx
 for qemu-devel@nongnu.org; Mon, 03 Jul 2023 05:25:48 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2b6a084a34cso61576881fa.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jul 2023 02:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688376345; x=1690968345;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlvNkcT1Fv7otW5oPcjYpSpjdnCtGWLIn/+rhiyiGFA=;
 b=OJ6y9pw/J9bKOLZ317NWMfhQ3r5R8Rjd8HheNk9vL4EOlUU0LnC+Y5qrsob6qwbKVu
 i43lA5JjuqDQL/+xB1d+uepIFrTHtRM9juABZNHD2dycFb/ICrEdwfmuC6gGwIi4a/n4
 srDCgE4NiINrDJ3ycYccOX7xdmb2iEWpOK0Muxzt8bBVsmKvqkgPvnTWXXMd/6S2SX0W
 LAr+3XPlxAzc8P1yrQlGTzqXw/hHbeklztH5DbOc5UYbbktLLZ2sUGdhF88LkFLSRfCH
 CVWOU92nFXmvVuXMF7UACjK5TSCb3zhaHsX2B3qHZFJ71lszdr/XDUBAmMgyAMYQ80zn
 G7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688376345; x=1690968345;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FlvNkcT1Fv7otW5oPcjYpSpjdnCtGWLIn/+rhiyiGFA=;
 b=i+qD459Tj00SHPgcSbsXfOBU40PzFjpKVE9Qrr3hta/Plq6kshP/2J28HwmBb/6M3t
 tQKfZ3aMtpePCwC5Aot+/MGhNXbusoSRqQbLAmmrFxgVTfL+aH7qb5K8w59qhscu9DzG
 tzPNoebDq0c7EOUfu23z5hVUTl6x6b07yFDK7Wj/FF4n4BuGveJPcjLWuwWm23A7jATl
 LkYZYPNlVcbnCVi8l2QZyMLoW7Lfvd8oLFf21LZQiD5w4dOl5sZbUc/uhMSAQMJph0HV
 CUltKpqCS82jQ2jL9DM2IbYP5eNBSCzGXtbfWCULh6ZF6HNgvYclWoV7cHgAuKBsS2iH
 nHPw==
X-Gm-Message-State: ABy/qLaYvXfij1dcLqxRaEBSmt42u+msjA7Ws4C0omxn2j37h+4Aawj4
 wF6UsfTJF8RB0N4u6F31XF2AubwomI847AhW6m0=
X-Google-Smtp-Source: APBJJlHFoerghNYXtRe2nAl3QlIYaLCv41UX+gxYcrXweQVmznkhG3n0lU4acmuZu3M6LotmbEALXw==
X-Received: by 2002:a2e:88ce:0:b0:2b6:bb87:501d with SMTP id
 a14-20020a2e88ce000000b002b6bb87501dmr6245186ljk.3.1688376345221; 
 Mon, 03 Jul 2023 02:25:45 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f10-20020a7bcd0a000000b003fa99969e61sm20751219wmj.45.2023.07.03.02.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jul 2023 02:25:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 990B21FFBB;
 Mon,  3 Jul 2023 10:25:44 +0100 (BST)
References: <20230630132159.376995-1-richard.henderson@linaro.org>
 <20230630132159.376995-5-richard.henderson@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: mjt@tls.msk.ru, laurent@vivier.eu, qemu-devel@nongnu.org
Subject: Re: [PATCH 04/24] linux-user: Split TARGET_MAP_* out of syscall_defs.h
Date: Mon, 03 Jul 2023 10:25:40 +0100
In-reply-to: <20230630132159.376995-5-richard.henderson@linaro.org>
Message-ID: <87fs65jqhz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22b.google.com
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

> Move the values into the per-target target_mman.h headers
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

