Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C0670E1CF
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 18:31:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1UvC-0001ed-5q; Tue, 23 May 2023 12:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Uv9-0001eK-Fi
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:31:35 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q1Uv8-0000Jy-2B
 for qemu-devel@nongnu.org; Tue, 23 May 2023 12:31:35 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-30a1fdde3d6so3751934f8f.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 09:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684859492; x=1687451492;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1aGVtNqvP9C+1yDUCijYeyNXZG4LCQy53hVhBNf5zbA=;
 b=AStyGlJBKjOUtR4r4BnF3zzzIcbZX1dUowBNeOpK/1e5xQDU/ztsSgKMGu2x/1lJKU
 cPNF1xQ4r1eFZXUdiFXFt52zVe0ridP0WmKBPi1CvVA2vzRBUisUTG+L1lYYtlcrDU0O
 +Ae0Jz/E+iXPF4/NgTPMT/1IwRAmaHieEh2WJpAa8dUIWOtax9D9iiWEoeoVWj9Zjqwf
 1jC8tLAW0I3wzB11HnEGFnM2e1YJteow/4S1F6qJ5Lp+PxuY5VpArsExJBGYl7yUYTZ1
 Clfp46PoleDSN8CBEeV+LOcF4RKDEREAtIkH2rKkttdaYYCLhM5gJ7Emxm0oYBFSkoBm
 9+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684859492; x=1687451492;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1aGVtNqvP9C+1yDUCijYeyNXZG4LCQy53hVhBNf5zbA=;
 b=a/+mV7vIemtP7b3+1aZqSoxJ/iB3wKmBQMEchnRiIe/lZlO3uVFCv0jv0rKaxj4eA2
 PXRL0Zovaeov/0S5gmlLqudba749eE8vqimF6TV9GfA8yi177i2PIL/XKLmtNKbzR0D2
 yEdn+hxts0YaQUCx2ZqrBDGM63oXszjvBCrnQ7vzleqL6kHiLcXbIMxwr6iKb5JH0erE
 9FLDiwTe7PlBCtJGMPS2Pjs/XU8NLUoUm6CBxl+ikOiTtzkfsOETT6UOWIGa1yU/wp7H
 tXUaA1ErdxdhyaQdG2kaBLBMbsQ+1yBetT6AYLM3EvQgaH7i5eP+UdxgT5RU2duRPZez
 V4nQ==
X-Gm-Message-State: AC+VfDyTdDuaMEOEpg9kd7zHUGCrqtqzgWq/XoOcG0qQEfkr4MyOYCk3
 WWaR1BB31W++tdVO63MZmx30hw==
X-Google-Smtp-Source: ACHHUZ5qbnsRrNuQpLFrzUrX8t4Ez/DlmguF8LP4vktLZ8L6OpOeS/YscQ5yI8k99louaVOjSuJLmQ==
X-Received: by 2002:a05:6000:11cc:b0:306:4162:ebbe with SMTP id
 i12-20020a05600011cc00b003064162ebbemr10833189wrx.49.1684859492492; 
 Tue, 23 May 2023 09:31:32 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z12-20020a5d640c000000b00307c8d6b4a0sm11554666wru.26.2023.05.23.09.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 09:31:32 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A91B51FFBB;
 Tue, 23 May 2023 17:31:31 +0100 (BST)
References: <20230523134733.678646-1-richard.henderson@linaro.org>
 <20230523134733.678646-11-richard.henderson@linaro.org>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 10/27] include/host: Split out atomic128-cas.h
Date: Tue, 23 May 2023 17:31:27 +0100
In-reply-to: <20230523134733.678646-11-richard.henderson@linaro.org>
Message-ID: <87jzwz102k.fsf@linaro.org>
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

> Separates the aarch64-specific portion into its own file.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

