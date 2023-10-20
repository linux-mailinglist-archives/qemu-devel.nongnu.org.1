Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E11497D0FFB
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 14:56:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtp2l-0005sP-Cf; Fri, 20 Oct 2023 08:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtp2i-0005me-45
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:55:56 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtp2g-0002Ko-It
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 08:55:55 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4083f61312eso6424675e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 05:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697806553; x=1698411353; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CX4U+uk7SDNCHYIVuyqb9/SPEskI3t8eK5YtSxuAUyw=;
 b=pfXNd0exOBlKxe1Q7/v4clcgT/M9VegN4le+g5acRZRVFlFNCot96rfckoEalUPXZU
 pLeZWqo1YCaXJdG/tFLb93whhZ0U1akgFjwWXodmZSoQlKo/5F4Ad4t78/F1ggXXk2fH
 vBmEK6HDGuhjrxJwwo3S6yM/8OLJMiiOTIGPo/M/r05KmEkDuA2cgqcTkIVmKJzAoqFh
 dhYO47i4Ke7R4w1/PrZ6QI7LAcGy+3qIfEtM8WrFXZf4jSL8mIzQAXqTo1Ofn4ciJ836
 d+r3emY/xxrtzs/VQdhadfdjjt7QzXkniiNTVbYLzLS2BzzAwUl14ObZPdYYxHMqJm+o
 ivEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697806553; x=1698411353;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CX4U+uk7SDNCHYIVuyqb9/SPEskI3t8eK5YtSxuAUyw=;
 b=GWHDzVcqvN9plG4Hs9HcyS7fxzF6ivyUoJITtHO1VsZW8/D//pVOjxi2G4jUzNXQ4M
 DgtBe8gf2jWwL5Uhs9VMzIG/HA76zXcr8lleP6GzK1oHK0XMKENbcwM4QugyiKU+t/hm
 NeD5k71Jp4i4YTm/PLduDHeEqus2gKZnBPyqAkN2kh54nmlHWx5t6UJqWiED4p0RaUp2
 TFNvJpvfhigmM8jnbcD6mA0rxiPFG8zhoWtFp9IR075BMmcvPfiexR1cCug4rZZNWuqn
 J4254I7TgKl0CzIWVjoJHl3YG+cUuBDHB6JePmkt7ZKIExMfAod6KNFqbmG20CG3VDtF
 40Ng==
X-Gm-Message-State: AOJu0Yz9H6+qkgupCu0uJtrnWSQWVPNfsEP1CTnCUBU0YMcOVU/qOZai
 8kNnv5rhQKr6mrt4CHhIqjQJtw==
X-Google-Smtp-Source: AGHT+IH53KkF8XvbedvTQIoE2UN2tt4ieUPon6/afuuLpd3gj2fN1FTADrX9pJTW28DgkD0WJXYJHw==
X-Received: by 2002:a05:600c:5128:b0:405:3a3d:6f53 with SMTP id
 o40-20020a05600c512800b004053a3d6f53mr1427777wms.3.1697806552846; 
 Fri, 20 Oct 2023 05:55:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 l8-20020a05600c1d0800b0040531f5c51asm2149013wms.5.2023.10.20.05.55.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 05:55:52 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CEE2E1FFBB;
 Fri, 20 Oct 2023 13:55:51 +0100 (BST)
References: <03d81c56bfc3d08224e4106efca5949d8894cfa5.1697801632.git.quic_mathbern@quicinc.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Cc: qemu-devel@nongnu.org, bcain@quicinc.com, qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2] semihosting: fix memleak at semihosting_arg_fallback
Date: Fri, 20 Oct 2023 13:55:42 +0100
In-reply-to: <03d81c56bfc3d08224e4106efca5949d8894cfa5.1697801632.git.quic_mathbern@quicinc.com>
Message-ID: <87zg0d78rs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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


Matheus Tavares Bernardino <quic_mathbern@quicinc.com> writes:

> We duplicate "cmd" as strtok may modify its argument, but we forgot
> to free it later. Furthermore, add_semihosting_arg doesn't take
> responsibility for this memory either (it strdup's the argument).
>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Queued to semihosting/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

