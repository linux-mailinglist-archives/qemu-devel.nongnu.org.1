Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6A770DDA8
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 15:40:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1SF1-0003Fo-Vk; Tue, 23 May 2023 09:39:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1SEy-0003Dp-8G
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:39:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1SEw-0007in-8X
 for qemu-devel@nongnu.org; Tue, 23 May 2023 09:39:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f423521b10so48420105e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684849189; x=1687441189;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4TY7vPzImGww0PV8kNTOJyfd+UVSfELtTsz9BYkxDBE=;
 b=Mmz1OV7bTMmmJtykBsRpDNjvD/5J2X9exvsKw7o4x7//zGAgo1ZmDvSxkzonnI8v25
 jnP4lfmZ9jKpmSazxF9SF2VTkyW7sUoSIEqNu7NWEafwJYTRIrEIgeJkuFeEDWB+iQq+
 7zAjvaUzZbspiMG/tUo7O5i2hFkgM+a+Bh48nVoTFOG0rpzfd54lQC6/V/egZITvwPpn
 YcFg8DCbXboaUxLo7WB03uU4HchOBddIcK68r8XcyV71XArcaTbXLUHtm7edVsjxgM9L
 WAy29cJg+dZ5bRCTydQWQIIZXXIfcKjRBm4y37v5vxqPG+hdbKp2XNRsnn5LCEB00K4k
 3yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684849189; x=1687441189;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4TY7vPzImGww0PV8kNTOJyfd+UVSfELtTsz9BYkxDBE=;
 b=N20cXRpL4q2gGIObA+swFxQiylYWiGLN4EkI5fzWc4Pu34vLoCZfa8twOPEUjteBSk
 FiJ3w+BEO6Z9gAZURxIulS6eAYCGnbVXwCr7YdVrJk1oLW05bTRcXzNZ/Qbe4Ez2H3ge
 1T7O0ckx4Fq/yKXTX4YppUQCfx7sAbmiCENXICQ/UsAIYourWsCtLx7+P56ZsigchJr5
 gjd8vkxHwJFUGIAK+Fk2uPd6B4D7nArB0sBoUgEorzNDWTxQjoKV4z3KnvIxH+Da67js
 qMc7nCKcD03sddyYquu3NQ6qKbJ/rol2lE8j0l5QXIRGeWohKo2f/DYcCTKtH3HYbjvs
 Edrw==
X-Gm-Message-State: AC+VfDy/iaGETAtgLuw5VEisHK+Zwd1Z5wtDmOdVihs0cJQrPRwrb0tx
 lW/4obAxFXMlHeLUEHi3AkBQfQ==
X-Google-Smtp-Source: ACHHUZ45tHekeDGMVGXcUcrC4CDwC4ZgCj84Sv27z6W/I7NL+XithYt2iekxy8W2GE+JKxJYgR8Y8A==
X-Received: by 2002:a7b:c5da:0:b0:3f6:770:fafd with SMTP id
 n26-20020a7bc5da000000b003f60770fafdmr3626357wmk.7.1684849188705; 
 Tue, 23 May 2023 06:39:48 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 g3-20020a7bc4c3000000b003f427687ba7sm11712679wmk.41.2023.05.23.06.39.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 06:39:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 043DD1FFBB;
 Tue, 23 May 2023 14:39:48 +0100 (BST)
References: <20230522153144.30610-1-philmd@linaro.org>
 <20230522153144.30610-12-philmd@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Evgeny Iakovlev <eiakovlev@linux.microsoft.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 11/12] hw/char/pl011: Rename RX FIFO methods
Date: Tue, 23 May 2023 14:39:43 +0100
In-reply-to: <20230522153144.30610-12-philmd@linaro.org>
Message-ID: <878rdf415n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

> In preparation of having a TX FIFO, rename the RX FIFO methods.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

