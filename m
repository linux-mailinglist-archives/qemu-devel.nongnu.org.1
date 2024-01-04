Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F5682494D
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 20:56:54 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLToG-0005o7-CO; Thu, 04 Jan 2024 14:55:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLToC-0005mA-V4
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 14:55:16 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rLTo9-0005va-IK
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 14:55:15 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2cd1232a2c7so11467371fa.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 11:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704398111; x=1705002911; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mvBvsVkuGfXlJ0tWqoFwsxssyMKtv26GHTZ/kv69p4c=;
 b=hEXZ2jiuGeBRNPvQjsbTG6XfGVdDv+Rp6C/WbYpvompy/PxdqgyEz8tTU0GaXiRWnj
 MMJIg6JzXShXoY0NP5F3GNw41lFwgmwcq/xH/+mWautmp8dVQDDE2qdqqsyOMHhto5FN
 640bGCemd44qeAmVmiys1TSvkL5Of9GYX4kV983TB82vWJd5v5fxZ6ZJ7TTt5qbeNmEV
 CJuE3CEI0EnpSnfV59ARwUE0i73A+zguNKLCgdNXghySWTPgd1hMnWL8A8djXOJg8F/Y
 QAQD7SsYLkQcpIM3iZbgYmfaYy5EKsvRkW2W5MwmWy/wrA0c5QNBFbpZQ01MPmaFBYJf
 g9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704398111; x=1705002911;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mvBvsVkuGfXlJ0tWqoFwsxssyMKtv26GHTZ/kv69p4c=;
 b=DN+gyOY149sk7nUwWV+eiMv3PAkeavHNLMoDm4RXP1OF6LLUeg6ILYL7c/5oj+btEv
 q9sS1xTl2CqhayFh2Z5kuvZmvEN900UcaqNalbUKo5TCA1Ax8Qx9gblbCWWfERwaa/jd
 ge9kj2vSw5xmoRVpYFDO3JyQ8tVWqBAVwuVVzSkaIqe8t0zg0iSJO8S3/CKpACE1gDs/
 0Zb/jR5e31LrV1Ej9rOjuAnwueiQvJSg+RhklXqzyZ1xdUM/mBktctNU2IGRG50+hCqE
 qy0OC18jvikUWh6AN6LduaozSCbFc/YCc3MIjY89oYCLX+Wv1rWn2dWiyXfFVhQ1p3Yb
 NgGw==
X-Gm-Message-State: AOJu0YzY81tPWdrSG8+fQ7FmjRbeYZzs0cTxAllbfE6g26sMRQg6zqR+
 hqdn6dyjMITWES0/rtO2i9dh4VysS6bnrUtm+oUaQ2ae0j5uXw==
X-Google-Smtp-Source: AGHT+IE74CBum4erJHc3rVETdc4g1dMLwKiLoH7B1DoP4zMmQlOFukHpNOVYmDtYHVyvGgKtl/KyE3njTCasVXta+7w=
X-Received: by 2002:a2e:b8cb:0:b0:2cd:10aa:762b with SMTP id
 s11-20020a2eb8cb000000b002cd10aa762bmr694644ljp.80.1704398111281; Thu, 04 Jan
 2024 11:55:11 -0800 (PST)
MIME-Version: 1.0
References: <20231229212346.147149-1-richard.henderson@linaro.org>
In-Reply-To: <20231229212346.147149-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jan 2024 19:54:36 +0000
Message-ID: <CAFEAcA9Huy_5Jam8AqWgotEz+6sT0fVaG=c5pOAQ4DsyKOBntA@mail.gmail.com>
Subject: Re: [PULL 00/71] Constify VMState
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x234.google.com
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

On Fri, 29 Dec 2023 at 21:24, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 7425b6277f12e82952cede1f531bfc689bf77fb1:
>
>   Merge tag 'tracing-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-12-27 05:15:32 -0500)
>
> are available in the Git repository at:
>
>   https://gitlab.com/rth7680/qemu.git tags/pull-20231230
>
> for you to fetch changes up to 2563c97f611f709b975880737a24dddc3318fa17:
>
>   docs: Constify VMstate in examples (2023-12-30 07:38:06 +1100)
>
> ----------------------------------------------------------------
> Mark VMStateField and VMStateDescription arrays const.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

