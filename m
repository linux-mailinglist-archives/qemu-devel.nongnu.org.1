Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45C82C0E3
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 14:29:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOHZr-0006fZ-Sg; Fri, 12 Jan 2024 08:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOHZo-0006fK-MA
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:28:01 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rOHZf-0005cp-D4
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 08:27:56 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3377d45c178so1888245f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 05:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705066069; x=1705670869; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=plNAQkB65EP9bzG0TWAbIuw7wWaAcyGlXG0SevoRbhI=;
 b=Bhc0wYEEw3uH1IwBes/qLExcAE42tozQa2qVkngiemXeF3arqbJqsVqtCYTSnLRfqR
 CVGUG95FgiBjMq1iGVhkPebenfZfFeHIdALIYik+o64neaSFjihBK03geO3Rx78MZMa2
 Qf2DslreXQI7kG2xR98v5NSDyonCns1xK5MYyqPo1DDhuDR+EhwQ/RvUdYB3lxgcnzMT
 TUDMhZ+CZ1BgLqg10mmQOjR4vavPJj3izf04ugg8nMcdEaMmEnNN6iydrkQkRxrDjibd
 XV72Og2wZ+ZWaDncseOOE92+h1OglcLlIhAP74rXB85ZM3lXm2zSQ4AI+D5SWeA8bRAO
 SKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705066069; x=1705670869;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=plNAQkB65EP9bzG0TWAbIuw7wWaAcyGlXG0SevoRbhI=;
 b=Uh7m/brPXqo9jUv72uEGcTte34+nQPT+yJrWSQUHn/EXwxe0Er7mBicZC10f0fM1vI
 A2J8xod9P1BJAv+lIoHtSmCd43uhE7rF1wwX9dRROyl2R2pqaTL2kl+dokPdbLht/oTu
 ZneTMCmOEQeARa3VnRdCeLfj7/Bq2iLr5BaXN/XjXSAQaly7Fx0fUH41zhJ8Wp0UjXNS
 0NHsrh51RY0E3KCyiiOMHerTCwrBDUNaHbpRlZ8aQRTg2WIfmWr97U77gplFfSOKZnKk
 mj5ptZzmQalFx4kEsQoGTZTqOZpzMnN9h6um7ZwxXBo7x0f/zl44W8ezg2axlHzOMCGK
 1jrw==
X-Gm-Message-State: AOJu0YyT/+iGCJa9SbPoYJ57E0iAOtCxr1CueXPM3Aqt6KvtMYj6at7I
 xCal/fFF/AFgo86Vv5eTHuUw8u7XSDF4YQ==
X-Google-Smtp-Source: AGHT+IFbivMXNt8PpYsaBQ8YrcD3WRaFoiRDJelJyuhj75PUD5gLQq0a3yxxfcd/3WNpjk0r+V32yg==
X-Received: by 2002:adf:f104:0:b0:336:69ee:1950 with SMTP id
 r4-20020adff104000000b0033669ee1950mr685361wro.120.1705066069194; 
 Fri, 12 Jan 2024 05:27:49 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q2-20020a056000136200b003373fe3d345sm3884243wrz.65.2024.01.12.05.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 05:27:48 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6D2A15F760;
 Fri, 12 Jan 2024 13:27:48 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Pavel
 Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,  Pavel Dovgalyuk
 <pavel.dovgaluk@ispras.ru>,  Paolo Bonzini <pbonzini@redhat.com>,  Cleber
 Rosa <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>
Subject: Re: [PULL 13/13] tests/avocado: remove skips from replay_kernel
In-Reply-To: <bef35657-d490-4db5-ad52-daba13c8234e@redhat.com> (Thomas Huth's
 message of "Thu, 11 Jan 2024 18:19:20 +0100")
References: <20240108151352.2199097-1-alex.bennee@linaro.org>
 <20240108151352.2199097-14-alex.bennee@linaro.org>
 <bef35657-d490-4db5-ad52-daba13c8234e@redhat.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Fri, 12 Jan 2024 13:27:48 +0000
Message-ID: <87bk9qel63.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x429.google.com
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

Thomas Huth <thuth@redhat.com> writes:

> On 08/01/2024 16.13, Alex Benn=C3=A9e wrote:
>> With the latest fixes for #2010 and #2013 these tests look pretty
>> stable now. Of course the only way to be really sure is to run it in
>> the CI infrastructure and see what breaks.
>> Acked-by: Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Message-Id: <20231211091346.14616-14-alex.bennee@linaro.org>
>
> The replay tests seem still to be very flaky, I'm now getting:
>
>  https://gitlab.com/thuth/qemu/-/jobs/5910241580#L227
>  https://gitlab.com/thuth/qemu/-/jobs/5910241593#L396
>
> I'd suggest to revert this patch to disable them in the CI again.

I did but on reconsideration I'm only partially reverting for the x86_64
bits as everything else looks stable (unless you have more examples).

I've raised a new bug to cover it:

    https://gitlab.com/qemu-project/qemu/-/issues/2094

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

