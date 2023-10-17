Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C18F7CC422
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 15:14:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsjtc-0003G7-GG; Tue, 17 Oct 2023 09:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsjtY-0003CP-2i
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:14:00 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qsjtW-0006lf-Cd
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 09:13:59 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40684f53d11so63136175e9.1
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697548436; x=1698153236; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m1xOgGPa+5II4aHhHHq1l9iB7EhVG70BjSLwH1qE3VU=;
 b=bgf6jutCtTSeX1t1bck9INoLrb/Zj+DuCymR52qTGKxSEPpoLgsVLo0ZnUPA6v3ugp
 Qqzu1VRfaKKO8LgMle9Ijmpql36U9AGitKabDkJ1FqUxuER5e+AmADq2ajZYCxwNicOF
 nEUp0lnajDAv9ZBEwIwfyM26WuDcJynS3M5nQ7VSXF9SgVBeyORSh1drEHNYq/MqBN8g
 zdANNj0T1tStT+UmyYNenLNtz1OvGu0uBQO9WeKXNwlQxGFpxL76juKkiZFlYMduLjQK
 dY4uLj2O/hWbTRcvUg+ynRfSpY/gSUZUFX2VzQgtHQKpGqsrnj1K3ZBgUMHs5lS63ej2
 GOqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697548436; x=1698153236;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=m1xOgGPa+5II4aHhHHq1l9iB7EhVG70BjSLwH1qE3VU=;
 b=QWUPcNeeKr3D+b9qEalGDs651PyFxrRKhtHIcXGMtlO6UZH3pstWi+GS9PokzvO3CY
 lms4Zq8GiG959krPyq6IBBD8XcCdB82Fp31BBr8O+IhFvWW57OgmHcuHaY2u3u1gTjqe
 SIv/CB3i5qHsSk1e1vEXdoBiZimw1NeEyQgn0FNo7I9JruSUBz/APHDljRVVntyeGsD+
 BsuRiOctc3aQR+9iCKKYlL1WUMhjbUgwzHieyn9rJnUcYlW3OXFMm2PaQ2FbbRN96AlU
 RwL7Jcj4Qw5jbiVdaFoZQbLILIW70PiReVL58cOgtekv41Mpd/eUBxgYHpfdYlguGDfy
 eYew==
X-Gm-Message-State: AOJu0Yz0En27+iEA1QEsU+CZMM3ffTG+QbvJmbEbwgr+7x6HjiS6AWr6
 zKeLg/qj/jrQOkZ//tCnAswI2dAP8+S3m9MwoFg=
X-Google-Smtp-Source: AGHT+IHZRiKmB1QSX4S2/E1R6ombbYhX4Ia/qwpaGWc9kaIZxfiXFR4rb8njOllb2Yy8C1Cgs0b72g==
X-Received: by 2002:a05:600c:4f51:b0:405:4a78:a892 with SMTP id
 m17-20020a05600c4f5100b004054a78a892mr1789294wmq.9.1697548436045; 
 Tue, 17 Oct 2023 06:13:56 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a05600c45d300b0040648217f4fsm9901678wmo.39.2023.10.17.06.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 06:13:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2916C1FFBB;
 Tue, 17 Oct 2023 14:13:55 +0100 (BST)
References: <20230915185453.1871167-1-peter.maydell@linaro.org>
 <20230915185453.1871167-2-peter.maydell@linaro.org>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz
 <marcin.juszkiewicz@linaro.org>, Leif Lindholm
 <quic_llindhol@quicinc.com>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH 1/2] target/arm: Correct minor errors in Cortex-A710
 definition
Date: Tue, 17 Oct 2023 14:13:51 +0100
In-reply-to: <20230915185453.1871167-2-peter.maydell@linaro.org>
Message-ID: <87il75bdd8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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

> Correct a couple of minor errors in the Cortex-A710 definition:
>  * ID_AA64DFR0_EL1.DebugVer is 9 (indicating Armv8.4 debug architecture)
>  * ID_AA64ISAR1_EL1.APA is 5 (indicating more PAuth support)
>  * there is an IMPDEF CPUCFR_EL1, like that on the Neoverse-N1
>
> Fixes: e3d45c0a89576 ("target/arm: Implement cortex-a710")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

