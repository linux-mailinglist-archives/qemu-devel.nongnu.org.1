Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9CC70E1D4
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:33:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Uwb-0004OS-M4; Tue, 23 May 2023 12:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UwW-00047o-Im
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:33:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1UwU-0000av-5d
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:32:59 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3f603d4bc5bso377935e9.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859575; x=1687451575;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kc+Kqt10FuMpLv78HyxPbRzPMZUd2IxdpAKygSRyYkc=;
 b=HeZYuQiARI8Ao4nBshSVpCa8hxhjttnYQBoy2ZRq+utRRaca0zLemeO0LVShZo8PfZ
 udhe2FcJJJvRUxv4xy02mhzoYjLHApxJt5tdhD92e0ULejjryWjh+Kus1w92imggKpKY
 9p5OzJC4Wz/KpF1lxxXnMnBZiRnbOCeAt4m+0WmJn+TeS6SxBoGld/HEQCQFOtmXi2n2
 EwlF8k1ziYhz//2YmNYnjJEMz2LNFMKG/JQr7oQEAfTl7NC2QCl7/Rl6kEk4hHSsA+sX
 IC/GW2/HUHHVTCZHapNO5XrJiUhVr7G9y7t25hJ2eAj/u9HAswTUIvAV+O4lHf2VKSFt
 pQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859575; x=1687451575;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Kc+Kqt10FuMpLv78HyxPbRzPMZUd2IxdpAKygSRyYkc=;
 b=ecHck+vu8TSoELXw6hpXrI/u9oOn1X5ZzwOSNCW/IbMGSBEWBEYmxbqUNoafr5LuF8
 oxf9+dbvb9BcKrEITS1/HBOr+Bom4k49XT7DFTa8dynC0WW0nvcJgnsKQIpQ4WaC7Zs1
 NaMMuBaq5fyQT1xxUyVx46M7Y0/wmV7YqRZlmKPfJO5anok5hG9LRGpT9LRqQBI5Fpnw
 g5/KAhQ0LHuFT3ldSNYQ4e9t0ta1GTVKLG3PCpk9p9Whop+nK2MxgOgXZUsibolpBF6v
 DL8J/vvS8oh3PzTMUtAR5uKH/thY0YmzOxssJ0/NCuddcrL5rixtJVURhpUTyhjBlvQ1
 pCTA==
X-Gm-Message-State: AC+VfDzkUYqc70QvV5jBG39x6KmsxuVfcrS0XTzueBtdoXMPs0Fjvb6z
 YTBtCLp5/61kilLb1Oc7zyzn7w==
X-Google-Smtp-Source: ACHHUZ648Rvs5xCO2438gO9NaCUSllba5pwlaSPgr8V0G0XS+EdDMJSvttkDrUEIu0XQAXsMDLMJAw==
X-Received: by 2002:a1c:ed0c:0:b0:3f4:2506:3d58 with SMTP id
 l12-20020a1ced0c000000b003f425063d58mr9848760wmh.23.1684859575400; 
 Tue, 23 May 2023 09:32:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 r14-20020adfce8e000000b00306c5900c10sm11697890wrn.9.2023.05.23.09.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:32:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D03321FFBB;
 Tue, 23 May 2023 17:32:54 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-13-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 12/27] meson: Fix detect atomic128 support with
 optimization
Date: Tue, 23 May 2023 17:32:50 +0100
In-reply-to: <20230523134733.678646-13-richard.henderson@linaro.org>
Message-ID: <87bkib1009.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

> Silly typo: sizeof(16) !=3D 16.
>
> Fixes: e61f1efeb730 ("meson: Detect atomic128 support with optimization")
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

