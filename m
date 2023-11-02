Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C68EB7DF9B1
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 19:13:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qycBw-0007wR-Jc; Thu, 02 Nov 2023 14:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qycBt-0007w0-Sz
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:13:14 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qycBs-0000jz-9H
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 14:13:13 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-408002b5b9fso8793695e9.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698948790; x=1699553590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VbzoZRMPnFqJQwQjMoT8LX8hpxP19pA0nJzGBiYdEsA=;
 b=gju1IiNDwyjrXJMWYNyCYcKsS5Sm+LUfCCPEJCURbrw9retkUH0Redx8Rzb/4S7kUG
 qDWwN8qRvrJ6Bm+62/OsRjhSd7BNqMHfgMLWlicScdpYsYhEshkrAIc8XIA/0Ze6mPOE
 H+b2jcr51BZpIgX1m6K+SblDpXT4ZtbtLVq9n1BZabh0V01V8vk1A4+ulu5Nxft15mYC
 YhxnCF8ATGowju/enA81/AHbC+uzbQyW3+lyfQmIyXGIfc/tp16Js2AmsCUfw+rqhKQv
 XbqkkXgrQd/2kdLvLIO1AdZgUO0Ov2NxaLrB+8kdOU5ofGixmI0sovXdn+NptJ4uMeXO
 b7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698948790; x=1699553590;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbzoZRMPnFqJQwQjMoT8LX8hpxP19pA0nJzGBiYdEsA=;
 b=dYvbt6+sjO44oVoEeQHvoFZRwjLRsQluCDh+UaypnyaJVCvrbVhGM9C27NupXcY2nl
 xGyQBdguQurYw1H707KGfErAqnK9V3lWaUURiNqD6Qn8rm853V/UiUz7rLKmqenVTX/+
 G0i+EB0fbHGbXZUv+fXoYiSSraaAwd42sxpeqpXiELVf7d7+gkw6r+nF+SBW2vFs1GaB
 k+oXeTedbkfA6+Skm6siKCwF1k+BjMesbDxZ1J4qGOU79LUMKnuMmysZRehnXtF5XTac
 nhHjxI6NN2B3I2+CQh7yGPUL/XJ6inECBN+ATnr9551CBgkaQJC3AaXQzZ/DbJXqnt8j
 xOcQ==
X-Gm-Message-State: AOJu0Yxl5jRaxQCqm4y2kf0+lIDsiE0ixuPYmEWlvXNv4RKAAv9BRmMO
 UG7xidCpPkWWkolv8+07svAVHg==
X-Google-Smtp-Source: AGHT+IHpLg1xnpvSe9HefCSNJXHAGZ1+wxb+08gccjgLD8Ev4YxK67KlO8iiiwYH4m6Y/Br0EuyrqA==
X-Received: by 2002:a05:600c:5204:b0:408:3f61:cb4f with SMTP id
 fb4-20020a05600c520400b004083f61cb4fmr14980718wmb.23.1698948790372; 
 Thu, 02 Nov 2023 11:13:10 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 l41-20020a05600c08a900b0040588d85b3asm3589666wmp.15.2023.11.02.11.13.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 11:13:10 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB34E656E4;
 Thu,  2 Nov 2023 18:13:09 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg Manning <gmanning@rapitasystems.com>
Cc: qemu-devel@nongnu.org,   luoyonggang@gmail.com,
 richard.henderson@linaro.org,   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 3/4] plugins: disable lockstep plugin on windows
In-Reply-To: <20231102172053.17692-4-gmanning@rapitasystems.com> (Greg
 Manning's message of "Thu, 2 Nov 2023 17:19:46 +0000")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Thu, 02 Nov 2023 18:13:09 +0000
Message-ID: <87v8ak2fd6.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

> The lockstep plugin uses unix sockets and would require a different
> communication mechanism to work on Windows.
>
> Signed-off-by: Greg Manning <gmanning@rapitasystems.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

