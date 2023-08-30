Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E534F78D6CA
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:02:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMiF-0005El-NL; Wed, 30 Aug 2023 11:02:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMiB-0005E7-6J
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:02:29 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMi8-0002ti-RX
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:02:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40061928e5aso54059275e9.3
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407743; x=1694012543; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p196gr26G1t24hZUNnGp85YtE5tVoTZxdjKKYXNPwqQ=;
 b=T1zA5J7aShtG2KRQPcAFQUuiITtb21WOGk2JYGbc9jpIZneDZ0xFWvz6srQBOJllze
 twfx+8OluyJDA6U4tRvzh2PJ3dvKCJGSRVWduv8N/62JAUXXibJSlFn6ZPyQIk8aROil
 sfhKjj6THdCJy3cA3BJPtKlBkl6w0h6s+slDwhTmW2XMzzwZpGcO4wyVZM5GKT+keZdt
 ZM4DmiF22GpWI2iHLj0iTwdcEitLQLi7d3oGfSFT/FUbk1Hj10i9x956aMAYeqA5C2XI
 giYu3S+SvdE1k9fAaB2mu07jvqC9ZZ/C7O+5kBSMtHBVteehwzi+WJJu4hV2Fxowjkqo
 zx8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407743; x=1694012543;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p196gr26G1t24hZUNnGp85YtE5tVoTZxdjKKYXNPwqQ=;
 b=BoZcdGhGOqp+wf5VcCizyuxINHV76s7NyZip83v59KMxaGgJaBTgVCqow6Ah9UG0LW
 h/TaweahA5PQ3xg8PUlgyub/mZP/790kvqRxPs1QKDhz0TyuoKUUlcWB8YFaN9vvLsW2
 EQj9XpObzAnamj6VP+0NLl76SFoISIn1klT+chatENnNEUiO1Rt7IdygKbZ8z3IOo7he
 SMphDB/R45BxJqiXOgZmIIzGDWaokuoBHi0PbFpfGPfWFAeZmEoh54XdGntktevr+11Z
 9yk+92/YvTtkjiNkRqlev2mljbhs/i8uPEHgvm6OJarlf21DsIXsazU8nRCfO61Pwb4A
 QhYQ==
X-Gm-Message-State: AOJu0YwbQBE6dJPUfi1mI48WgNcjOvlKasmjGNRKAT0SVD1kM8U1zUg1
 d2WvZPTSVI0DIcdBk6TWKUANUGlrqyyx0TF+TuY=
X-Google-Smtp-Source: AGHT+IFfVbhT38Q31GmX/R2oP2kvug6eXMmRS4JNexhPkZog5FO9wdmA8DUwS0xbhMH3ppV93vtC+A==
X-Received: by 2002:a7b:c454:0:b0:3fe:4e4e:bedb with SMTP id
 l20-20020a7bc454000000b003fe4e4ebedbmr2206492wmi.4.1693407743173; 
 Wed, 30 Aug 2023 08:02:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 f11-20020a7bcd0b000000b003fedcd02e2asm2539785wmj.35.2023.08.30.08.02.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:02:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 460E71FFBB;
 Wed, 30 Aug 2023 16:02:22 +0100 (BST)
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
 <20230818033648.8326-19-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Peter Maydell
 <peter.maydell@linaro.org>, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH RESEND v5 18/26] target/arm: Remove references to
 gdb_has_xml
Date: Wed, 30 Aug 2023 16:02:17 +0100
In-reply-to: <20230818033648.8326-19-akihiko.odaki@daynix.com>
Message-ID: <87msy8r2td.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> GDB has XML support since 6.7 which was released in 2007.
> It's time to remove support for old GDB versions without XML support.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

