Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1941C70DD7B
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:32:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1S6u-0004YZ-Q5; Tue, 23 May 2023 09:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1S6o-0004QW-E0
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:31:26 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1S6k-00060D-C3
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:31:25 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f607059b4eso14709765e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684848681; x=1687440681;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/KBsUqWNdjivhE+3jdUjdUH7nTc0sJdE9VJvA7rvNM=;
 b=qG3nT0zImh3j/HWnut0aJhATYpD43LMqAJ4DJC1MrSlg30Wy2Tff93TNd3bG86KRSW
 4zH+h6SxKys1c6IwAr1eZ4KufXmTgwm6SAZD4mFM1TXHAqFdz8+DkfdFnxc/UJbFPZBI
 kbO5vlhZ/n4Rk4LB541fStzV96RmP4b5tdGjH5Y6JVryyxv9v+DlYEhLUss1q59puhaI
 NYp0Py640BdkQl+tAtXTQqWguPsnev9SEvG/fSUi5OrecVQfBhpEsGKGEn0fz/HRyApd
 ATGWH6DT5khZEoKpY7siVAXBYrq68SE2RdzZAS7qKxlZ37psaPEVPMUL6y8ymQY9hUlp
 gwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684848681; x=1687440681;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=H/KBsUqWNdjivhE+3jdUjdUH7nTc0sJdE9VJvA7rvNM=;
 b=hvlJxgSHhrFKf//2qXld7dZ79DrnfYn7ml8+h0yzNFjshKQ7JFAjumbjVg6p3ym/1R
 Qk3/Empj27Xt+LOGUGFoa7mjAfaFXHiWjaZim41QZxQPsU/ISpv+aNA0qijSPbo5Wqp8
 GwwONBjSuGpg/YJBhvNH4W6Icq9x+2NME2WNTtUZE+en7gPQThRcxkgetSnhU774TlK3
 iQAGiOd6LJPDxKYuh/GYyqtrExIRwgy+AFaXXJax86dGhBWAxwXjPnbp2bE9Ukc6IOTC
 NXelu8hC/rFghIiTzfrUziTwO1rPbml9syClt8x7rvPyxA5miZRfWXFL8QnCKP8ItiRK
 FL9A==
X-Gm-Message-State: AC+VfDyktdnxaDiGYwWi1L01V7QVaBCehTuj744Hqnylbwh94vk7l4yp
 kzCCouz3GZC2v9Z3vAORfoqCW3c1HCf+bAPlbgiRbw==
X-Google-Smtp-Source: ACHHUZ5jv1Rd00qwcQvmxPCYq7ueEW51nTxb3Q2n0bwvVzH4Ut2L9JfjN6hf22WPhlM7Qj7fLtVniw==
X-Received: by 2002:a1c:7215:0:b0:3f6:1a3:4cee with SMTP id
 n21-20020a1c7215000000b003f601a34ceemr6399620wmc.14.1684848680718; 
 Tue, 23 May 2023 06:31:20 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a1cc909000000b003f180d5b145sm11764735wmb.40.2023.05.23.06.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:31:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D6CAD1FFBB;
 Tue, 23 May 2023 14:31:19 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-5-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 04/12] hw/char/pl011: Display register name in trace events
Date: Tue, 23 May 2023 14:31:15 +0100
In-reply-to: <20230522153144.30610-5-philmd@linaro.org>
Message-ID: <87353n5g48.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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


Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> To avoid knowing the register addresses by heart,
> display their name along in the trace events.
>
> Since the MMIO region is 4K wide (0x1000 bytes),
> displaying the address with 3 digits is enough,
> so reduce the address format.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

