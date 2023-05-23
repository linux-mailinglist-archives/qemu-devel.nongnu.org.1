Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D0C70DD8D
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SBr-0008Mq-66; Tue, 23 May 2023 09:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1SBo-0008LB-Nd
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:36:36 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1SBj-00075N-LU
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:36:35 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3093a778089so4843002f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684848990; x=1687440990;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X+XBcj3/2UWUvrYFY+P1eQD0oLS3ZHhYCDZOQdpGzfo=;
 b=WI7Ys7Hig/d5cs7pq9c3fpBgZ3oNGL7JQopH0BjcY3Kp2b/7hX66Vdy1pf2HP6uwfB
 ErSz+2mY1B+HxjvgjyhpWXRSodczh6Zw+0BOSK++g8OLZdE4JRjWWAqFzc1PZskWgjPa
 ewDBuRrM/bjPL+WC/RK2+QikPW4Hzik2c5wRAma+NExwg3ItftKDlM8gB78b1Ic3PURY
 ajyT+OciB8apak824iaMqaG/kaSipr8wX6v4VC2yvDwW402kRbai+uJx9lMqRXVJDR2W
 1AyF63u+xrJBj60GA4qMD5bnxTBPnhcoj0NNh546KLNcsrGvFUugoy2Ip0khJNu8Utpn
 NLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684848990; x=1687440990;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X+XBcj3/2UWUvrYFY+P1eQD0oLS3ZHhYCDZOQdpGzfo=;
 b=c7HU41LNAOYGCR/G67mYFyqDyqJ0cCH/bCydf2sN+rAPXRPQcxev+q2E6dlKbtBH3n
 rXIZuyxpnZ4p3QhK1Drz3/YjO3/cZ9DFmUQwXVjt4wOOch8+tIE0IsO/p5I3HyMnX5XQ
 xupmkcQivYJ4f4PjyWBue+l+2+Wf1AsgwO2M79qAxeHEn4iUIrBmmCoGtMDINmrXiE7C
 0xmxmircTPwI995UFGq7C5dR6RqqRw1KAnb0AqqF1I4VcWu9m7kNhIrH6Y8Y2Vml8cfF
 SBQxEWXs3T8Xmfq4h76nf/OoQXdWFiZorefNS2beX+cmml5XhBmE+tUwyO5G8U6Q4uTW
 0+SA==
X-Gm-Message-State: AC+VfDyKAlrRxNm6qikO7Sychi2uYCAEjDNVrpy2t8aFryyEl70bWAnF
 yMmEt3/aSrXkG+aZ8vgAVrg3TA==
X-Google-Smtp-Source: ACHHUZ6p2M/trLp7SV3NSpKWWOGmxXKtHvOrVJRGGeBzGwhzxV02CXyH2pKWH3ohw/0fMaqRKcmTDQ==
X-Received: by 2002:adf:e8ce:0:b0:306:34d6:6dfc with SMTP id
 k14-20020adfe8ce000000b0030634d66dfcmr9787260wrn.37.1684848990081; 
 Tue, 23 May 2023 06:36:30 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o5-20020a5d62c5000000b003068f5cca8csm11129437wrv.94.2023.05.23.06.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:36:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7BB0E1FFBB;
 Tue, 23 May 2023 14:36:29 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-9-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 08/12] hw/char/pl011: Extract pl011_write_tx() from
 pl011_write()
Date: Tue, 23 May 2023 14:36:25 +0100
In-reply-to: <20230522153144.30610-9-philmd@linaro.org>
Message-ID: <87lehf41b6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

> When implementing FIFO, this code will become more complex.
> Start by factoring it out to a new pl011_write_tx() function.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

