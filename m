Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC99710D43
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 15:32:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2B32-00060k-BT; Thu, 25 May 2023 09:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2B2z-0005xs-IE
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:30:29 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q2B2w-0005bd-Uz
 for qemu-devel@nongnu.org; Thu, 25 May 2023 09:30:29 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-3f60dfc6028so6410095e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685021422; x=1687613422;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M4NVaH1I1SDDO7W9ZP+TE6ENVGpVqTJ+VENTvRysd7U=;
 b=HDnKaEyi01524mdkY5cm9Pd0ektbsPVUQMF00b32LgNQQKS4sR9rN+kq7zoXco1QNR
 u7qPvRSvZqhA/yx0EHObrwp4hvlIejzR1JVNUJdmSbtEZ2O5peDAQicE3bH1H8CuQFR4
 CQbRg0+niD1P8sLUmrTfEIMrlvXDJWtXpM4UKIv5/RehPkpI6EJo+KUFA/d3cViLKS++
 Hwf7bNN2fxuhYJnfhSjbI5TrYvGdu2iP26qnUWQKTCVI/5tpUCyhCdRasxwMyLU8kIjA
 Mipeqo5Tif4GPSWNJHaL1O+jG5xY2ZSTdyzbNfrdXYn9Fuu2CS27Tqw5MftEf7TYZOWG
 Remw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685021422; x=1687613422;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M4NVaH1I1SDDO7W9ZP+TE6ENVGpVqTJ+VENTvRysd7U=;
 b=dFXuLTZ47caZBQdO3SvVdvKzkiysmgAHsFOtoV4Ojq77Jls5zUAZAkEVVRRG2bqY8/
 LzaxHMsXCW5GTbQu7RjemNtyY+RbBTGy3jm86sQdVw2ZjWmFYXrULqC6aBMfUNZzLBr4
 WHN1S9NIgMyPPLLCDk57D+q7rdmicTo/E/JUsVrxsqBnQ1v+rAB/2cYY+lh3GwOnYI6s
 PVVquUhKu4lVH0tlgFLLaEqBjSavScKaxXmZc5VpABDL0RFQ5/urXXC+u87hobl+7U9s
 nm0LAqyHjErhd1QriB4TWgzvmMOes38c16yPhKXYEqefkigg5p2qLyb1dOCe92qsZinz
 0cHw==
X-Gm-Message-State: AC+VfDwHeYkIFdGdvU7RhHnwC6ZVRX3kB2Juc4m69roz3ZoMkM2+tyeh
 yp0Ph2abk36D53ykksi0/WyOqRf0Ii30oE7bIqi9tA==
X-Google-Smtp-Source: ACHHUZ6+DvIWFuZfYfc5f1truVyIqXYjE7OxTB4JYndhsqgujPEjbtPRhjqswTzvSSF5HLN8uIy4jA==
X-Received: by 2002:a7b:cd0d:0:b0:3f6:6f17:f4be with SMTP id
 f13-20020a7bcd0d000000b003f66f17f4bemr2629763wmj.7.1685021422485; 
 Thu, 25 May 2023 06:30:22 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a1c7703000000b003f17eaae2c9sm2152010wmi.1.2023.05.25.06.30.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 06:30:22 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A7F9D1FFBB;
 Thu, 25 May 2023 14:30:21 +0100 (BST)
References: <20230525102844.209240-1-pbonzini@redhat.com>
 <20230525102844.209240-2-pbonzini@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jsnow@redhat.com
Subject: Re: [PATCH 1/3] tests/docker: simplify HOST_ARCH definition
Date: Thu, 25 May 2023 14:30:16 +0100
In-reply-to: <20230525102844.209240-2-pbonzini@redhat.com>
Message-ID: <87v8ggtu6q.fsf@linaro.org>
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


Paolo Bonzini <pbonzini@redhat.com> writes:

> ARCH is always empty, so just define HOST_ARCH as the result of uname.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

