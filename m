Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E3A7E3914
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 11:26:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0JGX-0006jG-El; Tue, 07 Nov 2023 05:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0JGU-0006dp-JT
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:24:58 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1r0JGQ-0005Li-1M
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 05:24:58 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so47326395e9.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 02:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699352692; x=1699957492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GInYU+a471jFy9YHr5yaV8k5tH981lem8wwS+q0VfyE=;
 b=W3z9brAW8wzP3vaNj7VFqUYiuE36xj/exPkOc8ZWYq8JGowriLqF9zR+aTqwnm5stq
 sjKV35YvhCoodLAe+Lx1/VJrjdGsSqb4WLA2cYP06jmpiI9S7wjpIRtPFGghQsbO4LBn
 iJ0f5GCLPVLiSIc2W9/a0dTcBSMOIuexMIDldKKzL8dfod9VlscQlYHPlo5ua/IdUXsj
 sr9i3nF5BrbW8JV84VlWLWvT1L4uKV3NXD4nbLPvgo+G5h83K396FmBRGuFTcadTKyRq
 ToR9Si5q3CvXaV7m6mF0X1NFZF7ulo4kj4ttkw8ut7ikBELhDY1GZXOiY3GAQv/JXVYO
 6yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699352692; x=1699957492;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GInYU+a471jFy9YHr5yaV8k5tH981lem8wwS+q0VfyE=;
 b=RhPa3maaF9ABNuxjSU1Pt7pQCA04JOfvjiIqt7vtlBqfuPWzFn/Z858KJDhsJvBhfP
 1/J9NTB3/KzV8maSEw/o5vmqlXjgapkxRU89QTj488k/jXwlc0a4k1NOQ4SCaeF8uh4m
 qThbYSnDohxNJk7FRjOv/Z3fPejUHVgGGXLnxOurTK1sv6SvdlpHy9VHxYhxw4tDPqju
 3fPRasJylsTPHchQ1t265fw9p3Y/1+Ljhj3zNuyra0RRVM12vvGnAYwdRBlQlxaXJVKM
 qgQwX+KXTTWIDdlHK2oagWYLmn0dIXMPFahl9co5NnoDnS9Do6hnV2vE9IdjXn9Mh1JV
 qQ7g==
X-Gm-Message-State: AOJu0Yyhy591AMZQNUGGSmroJ7vI2MWVtL8Mu+Qj7rRp0jmnESw+zCTI
 caq5ZJprY4E3Fc+qEU5y2+vO+Q==
X-Google-Smtp-Source: AGHT+IHr33KgC8suokQMrsHXhXWcdCLOGw/LSSeaN3viLNw02DlwgN6wNIgIG98Wyq+SWVm0+n/Z6g==
X-Received: by 2002:a05:600c:19c8:b0:401:be5a:989 with SMTP id
 u8-20020a05600c19c800b00401be5a0989mr1896154wmq.23.1699352692359; 
 Tue, 07 Nov 2023 02:24:52 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 je3-20020a05600c1f8300b004083bc9ac90sm15280611wmb.24.2023.11.07.02.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 02:24:52 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7F7485F790;
 Tue,  7 Nov 2023 10:24:51 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Laurent Vivier <laurent@vivier.eu>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,  Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,  John Snow
 <jsnow@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Chris
 Wulff <crwulff@gmail.com>,  Marek Vasut <marex@denx.de>,  Richard
 Henderson <richard.henderson@linaro.org>,  Akihiko Odaki
 <akihiko.odaki@daynix.com>
Subject: Re: [PATCH 08/22] gdbstub: Add num_regs member to GDBFeature
In-Reply-To: <3bf96059-44a8-4af3-9b0b-c9f070cd498b@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 7 Nov 2023 11:07:11
 +0100 (15 minutes, 33 seconds ago)")
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-9-alex.bennee@linaro.org>
 <3bf96059-44a8-4af3-9b0b-c9f070cd498b@linaro.org>
User-Agent: mu4e 1.11.24; emacs 29.1
Date: Tue, 07 Nov 2023 10:24:51 +0000
Message-ID: <878r797te4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Alex,
>
> On 6/11/23 19:50, Alex Benn=C3=A9e wrote:
>> From: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Currently the number of registers exposed to GDB is written as magic
>> numbers in code. Derive the number of registers GDB actually see from
>> XML files to replace the magic numbers in code later.
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231025093128.33116-2-akihiko.odaki@daynix.com>
>
> Something in your workflow is odd, you should keep this Message-Id,
>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231103195956.1998255-9-alex.bennee@linaro.org>
>
> and not propagate this one, IMO.

Why not - it tracks all the review stuff. I explicitly keep on
Message-Id per domain so we see the original posting and the last time
it was posted (which you can then follow the chain of reviews from
there).

If we want to have an explicit policy on which Message-Id's to keep then
we should document it.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

