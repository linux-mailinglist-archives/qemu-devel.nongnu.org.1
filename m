Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B44273BB85
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 17:22:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCibN-0001Xz-8J; Fri, 23 Jun 2023 11:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCibH-0001XP-Nd
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:21:29 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCibF-00080O-Tq
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 11:21:27 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3112f5ab0b1so779735f8f.0
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 08:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687533683; x=1690125683;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOX63d3oObdwY98NYnhBG3ZVbO7+TSQosF8pFWUfsRo=;
 b=gqUGEe5rm6uiRJANIpIE2/rx+0Tq9xIsGgg1knSFWpKdxRnhw+V8gm/yy3BDLlKt5L
 VfMfx62rPlKJTlki9DIFoQk5wX6PCkjEhtYJYhr3NhY0rrEZCnbfAuZHHZHPiuayamm8
 LhXpiXCm1PTZbeRCLMsjVXMKxEZTOkyRaTvYt7PtYMem8NoPenH2jfBAwJDk+yN1j0pi
 2mY0TyIhbChUsmbIwrc3h2S8DJekczgifem79wBgD+OV6kue6REac8qJkwCyKFq75/FH
 0vOPwOHCmQP2zBE+yaxsHYsK3lbkPAaDo2xqfPz0kBYEm2ihZfZRhzY78pJwc0mTnAnx
 9N9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687533683; x=1690125683;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LOX63d3oObdwY98NYnhBG3ZVbO7+TSQosF8pFWUfsRo=;
 b=NIHd2CqwqtoItcuymJryDLDxLRBeypodNPZTlebpPVJmhrcU89suyjo6QMS9B5uCXM
 jv4ToWGG1HbqbXngVAVIbjCUSY0QlboVp9JQYW8fUUjnA0b/a8zoQ01J9dgeIY2/3si3
 B7YeIcBnK44ETmmUt6yV0AzUGUdLOlMwkley4FVV9qe0syfRE1pOcoFqOjjihWk4S8Fx
 VjR+BDaZdr2iOm4HSi+/qCq972RJx3vlVmML59ASj+HKE7HkT29eypGwjwC/XGYkUYWw
 zHP6+mzrIGR5VPUy3MXW6S+nka4j20QCk/Ofu6q1JWY3DvCgReoueZ5pUSxkm5DRQaqr
 8nlg==
X-Gm-Message-State: AC+VfDzf7I0HyKi61R3gBgHxspOdPWjzk5Ri/o45vJqTV95xhDOSrJIY
 IwmiCZwoMlHTqG1Hn1Zn24rbsg==
X-Google-Smtp-Source: ACHHUZ7EOjwJeimEERhMlHVNkHIpFbW1YFJVjDp/h9d+sJcAut4i3Fni422xgLugYZkZoLpfDZY54w==
X-Received: by 2002:a5d:6844:0:b0:30f:c22f:e901 with SMTP id
 o4-20020a5d6844000000b0030fc22fe901mr13842302wrw.26.1687533683410; 
 Fri, 23 Jun 2023 08:21:23 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u6-20020adff886000000b0031130b9b173sm9755338wrp.34.2023.06.23.08.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jun 2023 08:21:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8E3A31FFBB;
 Fri, 23 Jun 2023 16:21:22 +0100 (BST)
References: <20230620162024.1132013-1-peter.maydell@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH] pc-bios/keymaps: Use the official xkb name for Arabic
 layout, not the legacy synonym
Date: Fri, 23 Jun 2023 16:21:15 +0100
In-reply-to: <20230620162024.1132013-1-peter.maydell@linaro.org>
Message-ID: <87352ifbm5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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


Peter Maydell <peter.maydell@linaro.org> writes:

> The xkb official name for the Arabic keyboard layout is 'ara'.
> However xkb has for at least the past 15 years also permitted it to
> be named via the legacy synonym 'ar'.  In xkeyboard-config 2.39 this
> synoynm was removed, which breaks compilation of QEMU:

Queued to maintainer/june-2023-omnibus, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

