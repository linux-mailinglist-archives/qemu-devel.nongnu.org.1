Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822273A563
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 17:51:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCMaZ-00011t-Bl; Thu, 22 Jun 2023 11:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCMaL-00011S-0h
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:51:01 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qCMaJ-0003X9-A7
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 11:51:00 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-4f004cc54f4so10086058e87.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 08:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687449056; x=1690041056;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S70hy7hnAxt29XEEJxeHBbBUW/HBjwefMHzH1X/OuoM=;
 b=OViS8HoHrCy/3ikHBeU8EXZoAJldn8iWd0xzFy67+IWDifGDFKmqqBnPgRXeuf8gON
 4equAwxLMmU32vhvGjCPB2qDPJxSKLL0AH7u1m+e1x7kP2LgybFxLyUAt+rPoSm81R3O
 /O7AlRCDF3yP78Z8K+xbiRJlbF6ErYmVBAbG8OHLS7nT5aVjckyDaXeN/zdEL/UX6Wxg
 U3h6qDe53dDZ3f8PWBjfHXuw/GLm6okjrWiXoS3AV1Vj9RDAjG4qNMNCohqLGassW9s5
 8acN8OV679eFODwyqy9gnd9uVX9VuZ2Wo1lPfnrkLiMYd16t2CGVtr38CQz852s1RBhc
 Uzag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687449056; x=1690041056;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S70hy7hnAxt29XEEJxeHBbBUW/HBjwefMHzH1X/OuoM=;
 b=H43uwe7CuiyOoN498rR7Se2mmq2rV35dwTOZZZXSa2xbcQleYxX7uqQ0j2uNaJ3tsY
 cJetu9j5gZY8/2mE7u3zFJ1SGBgRCCZujNWtN5nVE/IbCJOv6dw/Tzv2bS/NJrGEXFkw
 gqAW75Mr/rcdsnvkfRVkz31aQE3ssL3a/owQD6TNbfnB+SNwMUG1Q5Lo2jWTVDYcblN8
 nBMeyN1i0LcV3Dm4cIfL7Ip9p/QTsTysLRPfxK8V8/DMiKTRsSaw2UD7iedSq1Lk9z16
 YaGYzMtmTQB3wuGT1ySqDXCvEa49ZKbniboCvttXs46mv2POLNijH2m65aOfSXq/u72h
 U7dg==
X-Gm-Message-State: AC+VfDz7/Bl2Qs+BAuj/hjyzjOqdURQQoZXJ+vsJaVqtHlnPdUEo8F/f
 a3i3VrlR6BHUIzNb6J5TMewllQ==
X-Google-Smtp-Source: ACHHUZ7aDgsy7MdYaTdncMvfh42wEg205v2HqOlFl7i8dGqmdFH7OLVVhF8tFzK9AbHMsZBJqhx5eA==
X-Received: by 2002:ac2:4f13:0:b0:4f9:6b06:129e with SMTP id
 k19-20020ac24f13000000b004f96b06129emr502192lfr.65.1687449055650; 
 Thu, 22 Jun 2023 08:50:55 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a5d69ca000000b003047ea78b42sm7304533wrw.43.2023.06.22.08.50.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 08:50:55 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A4EB51FFBB;
 Thu, 22 Jun 2023 16:50:54 +0100 (BST)
References: <20230622143046.1578160-1-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] docs/system/arm: Document FEAT_RME
Date: Thu, 22 Jun 2023 16:50:49 +0100
In-reply-to: <20230622143046.1578160-1-richard.henderson@linaro.org>
Message-ID: <87r0q3fqch.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12d.google.com
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

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

