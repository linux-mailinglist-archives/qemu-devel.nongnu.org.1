Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E0C785A2C
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 16:15:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYocx-0002y6-Bt; Wed, 23 Aug 2023 10:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYocH-0002Gh-Q9
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:13:50 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qYocG-00086u-9b
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 10:13:49 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3179ed1dfbbso5142782f8f.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692800026; x=1693404826;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtgSJyYHVZdit42TVhGOM+9HQMEfY6ul5cvMvgaD4Y4=;
 b=DiNxwpC+PSjULGloFPYrylGd+8lrQ03Tem27TO7KmB2eV1yDB4LoYTy+bErjYstuXd
 y5evS2wDTxwxrCN1lKaWKBTbRz69MTnRpVmryh3hfCaa2676dLR5QTmUSR9vDV9QcaMF
 1B00zRO93eRqZ1wsUCULE30XKikmxwsDU9siRw8NXUsJjpPp/U14dvo2FQtKLd8xwIXk
 kQr3dqOpTAbk2IbjgQFgQxs9cVeBhu/Vtce+B9RC8hhf556EfuZlokk8cE/UMAjgrX+o
 /rJT7Kfq/QqfGCBRqI+uaxCqIaBgCI9Mj6A6MgNM8JcsYu+Ex9J+FyRWo2DvOPwtI+3W
 MkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692800026; x=1693404826;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:to:from:user-agent:references:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtgSJyYHVZdit42TVhGOM+9HQMEfY6ul5cvMvgaD4Y4=;
 b=L+9owSx4OH6amQsb4XvR4eCWQgmzMp7HRWN0Eu1JAQDEq7oV8N/YGxnBhv1l7Ugh+p
 GSN881m7/CJ+z4NUIdU8EQ2bquWm90KKscGmhUMTw7r+kHwh/Asi+HLuFGTwwpqCbcMi
 LovyXLHou1zpDn4Eem1x7/SXoTn6XVAS0tnMXa8jyeOPNdzbPyMN/0sF7bIC+9KeIMwD
 w2YjOaVPeotX0hJBsIELhZWo35H5QKfMBvBNvAIjdfB2H1LqsOQkr5G8oclyC3dcAqvz
 GYWTQN/3AAJAUOKZEGDG7mdpcjH/C5pYB8zpokCs/ZUjxycfiUDdwQddMl8DOwdrgHzC
 JLmA==
X-Gm-Message-State: AOJu0YxmhqHmdVptKpCYDKESRlp4XB3dAbPrgngfaJASmcYibuFr5WLI
 K90e5P5s7mjbS4tDidznQaNz3HpDgbXcmr8WVM4=
X-Google-Smtp-Source: AGHT+IEW1STHlvKhn1Ncmcg3LzArDPVui6QSJkvq6DIKF7GIjf1Ze8ps00TulwOn1QZJrQHH18x7lQ==
X-Received: by 2002:adf:fed1:0:b0:319:7421:fde with SMTP id
 q17-20020adffed1000000b0031974210fdemr10111399wrs.32.1692800026161; 
 Wed, 23 Aug 2023 07:13:46 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a5d4d43000000b00319779ee691sm19128224wru.28.2023.08.23.07.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:13:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6AACA1FFBB;
 Wed, 23 Aug 2023 15:13:45 +0100 (BST)
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-20-mjt@tls.msk.ru>
User-agent: mu4e 1.11.14; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: Re: [PATCH 21/24] scripts/: spelling fixes
Date: Wed, 23 Aug 2023 15:13:42 +0100
In-reply-to: <20230823065335.1919380-20-mjt@tls.msk.ru>
Message-ID: <87il95hmna.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
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


Michael Tokarev <mjt@tls.msk.ru> writes:

> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

