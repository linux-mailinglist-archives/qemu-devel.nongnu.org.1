Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5957474A3
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:59:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhUg-0003nr-RH; Tue, 04 Jul 2023 10:59:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGhUf-0003nT-3q
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:59:05 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGhUd-00055V-7F
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:59:04 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso43498255e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482742; x=1691074742;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOFTVVbYINH5dFWj55CBLAk9q2FfffnSPGFaJ5nn1mc=;
 b=dbiMAaSpt/xOpvZNdCLLeG3v7iZ9eMjOYBIxgnW2dr5L9STmO6wu7f/Fpz4ASJf5ih
 3gIrjKm/HsmLKxwpeSI5arlP29N9X3Y1ddzuP5sEsP1NxnlyydLjYoeELDHz1iBgpRvO
 AMyAGyFq7ZCsgHk2qU5mHTzet/rWO6DMsgHuTlVwnmErOOeyl5wcIJOL+pg8MRJWC/N9
 rYnANuY57GFRr4GfYnp7tN9v1cV6kceVgfPJw56MUu6AdpHQPzbzJDCppw2Du0FoO4ZI
 q66HTI9kFcA0VZYPLxwrni7szFpFTJh7jrzFx492e/Flz+6oP6uX796konNOCtk0hPUA
 qvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482742; x=1691074742;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iOFTVVbYINH5dFWj55CBLAk9q2FfffnSPGFaJ5nn1mc=;
 b=XzaRoqGwWLt3hJ+H4VJca9GAdBI9esKs/rKJU5r4w45DbZXJHOjR3iPG3KySviIQ89
 oYxmVRRejyQa4o3NIL4k0MLwH/zI/gypK0b5u/i/IybGLLXJ9hGgQKhnTMzYsgzXik4E
 yf/WyfpkzkWTfNIxAjqOzDNRnCrIYfCKrFwc+PFs4ZhNz2sZZYYA4txThxu3/3EdxFGN
 Tw3c6JXPWoaE7effXCQ11mKSyPrqYpj4l8aC6msknC+qtiJrAjCeW/8SQitk4Z6YtBFM
 AaYZcVb0c10EUWJtuAM/bBdnyLr6fAdqC6idwHF2Y559QBRb0PflcQkkqCgwWHV84w5S
 I49A==
X-Gm-Message-State: AC+VfDwwUOx72G8pLB4S8UGnXJAJ06f2ocMrq6zXGBvsiPlQ8pJSuH70
 chOMycXuR5Z+7dHlunAwK1n32TpnfpBpvtts1Z4=
X-Google-Smtp-Source: ACHHUZ4wdeRuj70TvUx+M1AQ9mDG5J4SQULYeuEeq5OYeHgOXSzycjU2xIb4M1sPsKdQ/7eH7F8jtw==
X-Received: by 2002:a05:600c:2253:b0:3fb:a5b3:4f02 with SMTP id
 a19-20020a05600c225300b003fba5b34f02mr10719470wmm.36.1688482741782; 
 Tue, 04 Jul 2023 07:59:01 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a5d6092000000b003143be36d99sm3429053wrt.58.2023.07.04.07.59.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 07:59:01 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F41131FFBB;
 Tue,  4 Jul 2023 15:59:00 +0100 (BST)
References: <20230704130647.2842917-1-peter.maydell@linaro.org>
 <20230704130647.2842917-3-peter.maydell@linaro.org>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Subject: Re: [PATCH 2/2] target/arm: Define neoverse-v1
Date: Tue, 04 Jul 2023 15:58:54 +0100
In-reply-to: <20230704130647.2842917-3-peter.maydell@linaro.org>
Message-ID: <87sfa3g1u3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> Now that we have implemented support for FEAT_LSE2, we can define
> a CPU model for the Neoverse-V1, and enable it for the virt and
> sbsa-ref boards.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

