Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E57217DF9A8
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 19:12:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qycAY-0006QN-GP; Thu, 02 Nov 2023 14:11:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qycAV-0006Pj-61
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:11:47 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qycAT-0000UC-1X
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:11:46 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so1485728e87.1
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698948703; x=1699553503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=su5H7A/56srXJ4ShkNC+89xcvXIbfaRfI0EsnGpyZIk=;
 b=kb9CQi6q8kfrIqoAPuFf/kg2Ky7x0L3FcYQ3klbl2TfU6WuQHe54l9FZXih/vrS4Z+
 8axcBfG6OXbXM15cvvsdgM1HzgG5PcLcbhM5HwQ39Nt3mauNwrjrey1r3pa1rYs4+tyz
 ov4IkVDGeS8zU9hHUf/I2fyHZplPgZquP0efYm2lFmI8Olj1mr6bnx9dTm1LAm1uYJsb
 enOJj1Mwa9b8Z5najoYKB+iDx5MLgPsZccAJINEe62G/aVtVFxETTqLIetG+ugRnzdNm
 jXsV+TzObcOOpB3ZAOK63YoK0ycEvuThAUw7RMearvfZ2S7oOXtwuZZfriZDl7Y8hou3
 Skkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698948703; x=1699553503;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=su5H7A/56srXJ4ShkNC+89xcvXIbfaRfI0EsnGpyZIk=;
 b=WQhcCmHV6mqXHlRI/t3tHR2xgJRnkroYtyAv/pQwnhqGSb8gMLer93jmED0XXNGpns
 E8kns+4F0UUh9LsBwNXm/auB4YJYU5KOWnu3Npdc4Wk9USNw0JlR1zgsmweq97464h6+
 2Z3XjeFV0oZyYfTujwYt/uTt5SWUaOptCkGLniSvj7hGpgOZbDNQsw8ZxssHk2/h+G49
 BTFJoWf9BNOImhfdafTeYnyloC6T8NzxpWQ6gJfJPiwwn9Li4e4ajalNImwHVDHJqMWD
 jGO2Xt4mRILJRu0His3grpQ4LqmRlxrfY2ehXon0BF6xPxa5Dp7CXKQDYKl+rvFPhZGG
 t84Q==
X-Gm-Message-State: AOJu0Yyrnca6Hh8F/v7kpLLyRE+m3gPXCBzMuAc9G4vEwEYk1GV31xtn
 lIzf6FxEbEvq3LrW6w5GYqSY8Q==
X-Google-Smtp-Source: AGHT+IHhKaMCNnkKZKwdIvvFlBJeBOy+MbI78WrlDIfOTR6KVOsdsfag8cz8YnXMZbZLwarpBQzBAQ==
X-Received: by 2002:a19:501c:0:b0:509:4a02:49f6 with SMTP id
 e28-20020a19501c000000b005094a0249f6mr1894129lfb.34.1698948703265; 
 Thu, 02 Nov 2023 11:11:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 er10-20020a05600c84ca00b00405bbfd5d16sm246555wmb.7.2023.11.02.11.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 11:11:42 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 98BD5656E4;
 Thu,  2 Nov 2023 18:11:42 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg Manning <gmanning@rapitasystems.com>
Cc: qemu-devel@nongnu.org,   luoyonggang@gmail.com,
 richard.henderson@linaro.org,   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/4] plugins: make test/example plugins work on windows
In-Reply-To: <20231102172053.17692-3-gmanning@rapitasystems.com> (Greg
 Manning's message of "Thu, 2 Nov 2023 17:19:45 +0000")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Thu, 02 Nov 2023 18:11:42 +0000
Message-ID: <871qd83u01.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12c.google.com
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

Greg Manning <gmanning@rapitasystems.com> writes:

> Generate a qemu_plugin_api.lib delay import lib on windows, for
> windows qemu plugins to link against.
>
> Implement an example dll load fail hook to link up the API functions
> correctly when a plugin is loaded on windows.
>
> Update the build scripts for the test and example plugins to use these
> things.
>
> Signed-off-by: Greg Manning <gmanning@rapitasystems.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

