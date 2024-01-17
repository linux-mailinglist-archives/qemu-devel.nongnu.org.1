Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 761D68309B5
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:27:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7oD-0003uc-2N; Wed, 17 Jan 2024 10:26:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQ7oA-0003tO-LI
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:26:26 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQ7o9-0008NV-3i
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:26:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-337bcaef29eso1361616f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705505183; x=1706109983; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9sZuZNZixd83qBqP/EhPmyPRXKx4M/FRfRi5JIVAMI=;
 b=FK1shmNL/BB1iWL9JmWWMHFkkcmcBMOcS8JP0AU6p+FJ1+BxqPvPfEjGao1A5qtdGZ
 m2BeAMNt0KSXjRV7GkNg4x3xNK2y/DxDje5gt7OEDFd4G4u6xF9GhbuNRsJNpM4SKT94
 yBzH3Jx95OSyxhB2l5fPT4+Ag0l8k6YZnFalVoj/d800TVb7Cr3EAhm7E6ooQYKW45k9
 0I1REAP/X13RLyovvfd+6Bys7lsLh1XiwhtQEzzJhs5fU5UxQB9hnV36rrwme7j6SQ4y
 KNjii7m4AMAHkDb/hBWuTefoFmXAiKxM/1CqyFqO5juVHUAd4s+CQK98FQ3XoRbwqQGb
 u4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705505183; x=1706109983;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f9sZuZNZixd83qBqP/EhPmyPRXKx4M/FRfRi5JIVAMI=;
 b=BuTRp6Op1RygNtRA0MXQzZusYNV3ff8ldG8aLeGCAU6gZWSBgiE19gQ9xpzM0OEsvg
 PZcAVtAxkOD8Wc2V6NqRBuTJx0VOaOTJFadp15hk3A7+XvGBwVSCHZL6z0wDnMbxIGsL
 I/mB3z/2FJzdG8JTvENdO4w0i4Wo3Up3TYa2cVIy5CA2aoAVycdsTyS8YQSmKg91PEJ4
 e3pGBfI8gpC/8IyvDIEAhXKfflJgATvE1ZGdeEEDKz7lEpcvQrRbYTsXyY0Al9WEHnhE
 OcjrZBFJJ//V5y0BshLIvpuPInC5bYokE7Qu+81EzcSbAnU8KjuAQgoJarim23d8jMSK
 v1fA==
X-Gm-Message-State: AOJu0Yw5WIGRzu7qyDoWlmDfREV8pEwBPrMSrsyqMt9+erLaYI5KHWfl
 2dY7LtrVZ+HlK+VhVKdYz84pMW7HjBW2Tg==
X-Google-Smtp-Source: AGHT+IEabofyh+CNpXGB0aDkc2IsaffY0Ey8NLyqHOFiAtriKCDGYjF0yi4x+Zgl6zW+PHV3ZP1eKQ==
X-Received: by 2002:a5d:624e:0:b0:337:6529:6cf6 with SMTP id
 m14-20020a5d624e000000b0033765296cf6mr4479684wrv.88.1705505183703; 
 Wed, 17 Jan 2024 07:26:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 i18-20020adfb652000000b00337bd545d7bsm1913552wre.21.2024.01.17.07.26.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:26:23 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DBEA05F8D8;
 Wed, 17 Jan 2024 15:26:22 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  John Snow
 <jsnow@redhat.com>,  Kyle Evans <kevans@freebsd.org>,  Reinoud Zandijk
 <reinoud@netbsd.org>,  Gerd Hoffmann <kraxel@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>,  Warner Losh <imp@bsdimp.com>,
 Ryo ONODERA <ryoon@netbsd.org>,  Thomas Huth <thuth@redhat.com>,  Beraldo
 Leal <bleal@redhat.com>
Subject: Re: [PATCH v2] tests/vm/netbsd: Remove missing py311-expat package
In-Reply-To: <20240117140746.23511-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 17 Jan 2024 15:07:46
 +0100")
References: <20240117140746.23511-1-philmd@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 17 Jan 2024 15:26:22 +0000
Message-ID: <8734uwhtgh.fsf@draig.linaro.org>
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Since the pkgsrc-2023Q3 release [*], the py-expat package has been
> merged into the base 'python' package:

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

