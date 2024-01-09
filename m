Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D12FD8287FB
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 15:24:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rND1S-0005Dq-EJ; Tue, 09 Jan 2024 09:24:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rND1L-0005DP-OP
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:24:01 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rND1J-00082K-Ch
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 09:23:58 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50eabfac2b7so3229356e87.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704810235; x=1705415035; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7gG+cG2LMuLX0hPwpMyYsINdqzqHAoG/5cITpG0YJqE=;
 b=nJeIJHgBAzXSK0d/sH+53OJIQ4/ndoa4mUG/SrPhXx51nZcatUun2m18R4M1UltcR3
 U6RpBGTGi/R4xDpmETwOHeckBBAhFlNTdlx9tbl1y/8Jtjl/0cTgBao56GdqVs6RhO0Z
 MbWrlzAqTMweJCUtBMa4flcTbXGDh3SlNlGn9trUOJJkPWfEBlB7Gxt2KDFwdOEhjoER
 zymJtUJW3/iDF8/1vdMRdYnhORiKsuwamvubRXp39odXx7cW7DS/9MUuhTRnhvuHMbQV
 ayVHrG7dTQJbz1++bxXzMGk2f/MEmu1ZUA6GyeaBvd4UhxkNGyvnVTD/wQwa74cAno1+
 Y0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704810235; x=1705415035;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7gG+cG2LMuLX0hPwpMyYsINdqzqHAoG/5cITpG0YJqE=;
 b=eazlQgxIHvKl9VIEklpWA/NavJEMYiS/DfX2iFU2t5iUNbpQpIlVhjsGg1qN7Ip2DR
 8yhZqkq49MQcmyty81aVJ6qddtJWmp6MMKjf7eM0+e9w1IjZDj3xelGjTCA4NiNRWxW5
 aG6QPEq1ZxHehRIy/N7BCtWjJoL3Z0QhZo5g9DUqiaoi9QXNQbPT9mGe3gN+UKzFzUPZ
 L8cht3n7pogSiZoDxex9/LiYNLQGuNR3IJcJiR8IpotnuHUrS1XgV9+LvT/7j5hrTpKA
 bAPMQB3+c/ix+QB8L9+E9zmDXSOVwHnN9+AX2M1sxuQnZ7LGaQP7M+ox7bY47WjXJQkx
 WpcQ==
X-Gm-Message-State: AOJu0Yw0f5ZZUHLtsFhMswNHxgNQaQEzrKFXeHsoHhT3Ne3mOKBF49Qr
 1+ou14QHP1HKD4pyugqJZX6ngnvgEI/5XIzXLXToM5Ti2zCNog==
X-Google-Smtp-Source: AGHT+IG3UP8RYe3d4WIDIOzHDaMljdFaal3sF59yupNeUZZph9nOW48eSv45kwLx7z2NI13BOceYVEdrsiCwlGsRUG8=
X-Received: by 2002:a05:6512:3c96:b0:50e:73a1:f514 with SMTP id
 h22-20020a0565123c9600b0050e73a1f514mr3131174lfv.9.1704810235181; Tue, 09 Jan
 2024 06:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
In-Reply-To: <20240108151352.2199097-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2024 14:23:43 +0000
Message-ID: <CAFEAcA-ETd9nuLB83ZgD9XBG5zMNTxhzQ8Jfg8Cfe9teTBq_+g@mail.gmail.com>
Subject: Re: [PULL 00/13] replay fixes for replay_kernel
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x134.google.com
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

On Mon, 8 Jan 2024 at 15:14, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> The following changes since commit 0c1eccd368af8805ec0fb11e6cf25d0684d373=
28:
>
>   Merge tag 'hw-cpus-20240105' of https://github.com/philmd/qemu into sta=
ging (2024-01-05 16:08:58 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-replay-fixes-080124-1
>
> for you to fetch changes up to c2ef5ee89d76f0ab77c4dd6a1c9eeed4d35d20ed:
>
>   tests/avocado: remove skips from replay_kernel (2024-01-08 13:59:06 +00=
00)
>
> ----------------------------------------------------------------
> Record/replay fixes for replay_kernel tests
>
>   - add a 32 bit x86 replay test case
>   - fix some typos
>   - use modern snapshot setting for tests
>   - update replay_dump for current ABI
>   - remove stale replay variables
>   - improve kdoc for ReplayState
>   - introduce common error path for replay
>   - always fully drain chardevs when in replay
>   - catch unexpected waitio on playback
>   - remove flaky tags from replay_kernel tests



Applied to target-arm.next, thanks.

-- PMM

