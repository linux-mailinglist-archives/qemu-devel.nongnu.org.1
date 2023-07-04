Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D25747310
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:44:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgJn-0007zi-KH; Tue, 04 Jul 2023 09:43:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGgJl-0007yG-OP
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:43:45 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qGgJk-000576-1c
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:43:45 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3141fa31c2bso5468509f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688478222; x=1691070222;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tluc9qV+EJ5ace5BuDPJfoePU1IrYsKfrn7TnVACHKM=;
 b=ewTl5TdD/deOBpLANnOLyZMydh+jrN8ROqt2igh1Ms8jlIWa+NJ3KPx/c7LOv0upFr
 /IY5/yY3HTmJ4CXOfeJDinyvD+g6L8OPenOmnlVIZCmNTiuX3A6xW10oKNl5L0I2SVuq
 OZWvtoNjfkkne3ezUA9pRd/Kg0LPw+ay97oli2kKamkJJgIio9biBCnCW6JdfkInTYtp
 ewWHpx7ZRceSXNk+gZzQnUAOU7ilzSDQe5/42H9AIzXfv8n/f6+K14iM9hmYMEq4REil
 U018wn+OVlPFVeROMthL7/0A/XpZG8BNwGe2lboionAhPEdfeLqrZwsBw51pvw6E5PvR
 WOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688478222; x=1691070222;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tluc9qV+EJ5ace5BuDPJfoePU1IrYsKfrn7TnVACHKM=;
 b=djg368m7sV/SIiAqFNL4PpMCJqaEHkcD2ViHofG2tMJfD5bwd0S7hagxVnad5QmZSB
 Z0/M9DqJNvSLMgv6JbFxRZ9WqswLVefIAIeVS0J9ns7NVwMVLFa2HgB19WsAbhbKgsA2
 RZYMmkER/bvhq7YZn6Y21eSzpTQ+EJUikxILx6LEuU5lnSda8lvkucRrrRHioIoOzVCa
 vRewRdZUMNfD0V2opuHmnS2XhEcbH5t/V6BYOgnDT1tRnOLLJ1grGX1R8K50QHNTU4lf
 fl64IHMCsJoEomg+jW9ABfb2NH6VJDu4saL7Wcyh6BHI05GKPI48Z8nTKc7JZ4XYdh+h
 0wHw==
X-Gm-Message-State: ABy/qLauikwGzCz5Z5jBuOaEnc+O3dcSAs35HWnh/cjsxODkV13u08Bg
 bulV42XjEybSKhpwnJI+xnT9yw==
X-Google-Smtp-Source: APBJJlEGKM4dEPpkQDkJDidh2bV8TPf8itY9p64+vSlSKzt2kwFBClBActGE8TwsPa07xPRfk+phBw==
X-Received: by 2002:a5d:4c8c:0:b0:314:1230:29b0 with SMTP id
 z12-20020a5d4c8c000000b00314123029b0mr12535399wrs.52.1688478222663; 
 Tue, 04 Jul 2023 06:43:42 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 q18-20020a1ce912000000b003fbd9e390e1sm6039315wmc.47.2023.07.04.06.43.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 06:43:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D86061FFBB;
 Tue,  4 Jul 2023 14:43:41 +0100 (BST)
References: <20230628110905.38125-1-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.8; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Strahinja Jankovic
 <strahinja.p.jankovic@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Beniamino Galvani <b.galvani@gmail.com>,
 qemu-arm@nongnu.org
Subject: Re: [PATCH] hw: arm: allwinner-sramc: Set class_size
Date: Tue, 04 Jul 2023 14:43:35 +0100
In-reply-to: <20230628110905.38125-1-akihiko.odaki@daynix.com>
Message-ID: <871qhnhjw2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> AwSRAMCClass is larger than SysBusDeviceClass so the class size must be
> advertised accordingly.
>
> Fixes: 05def917e1 ("hw: arm: allwinner-sramc: Add SRAM Controller support=
 for R40")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

