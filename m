Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D8B7CF90E
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:34:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSDx-0004AO-4t; Thu, 19 Oct 2023 08:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtSDf-0003re-Pz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:33:50 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtSDd-0007c4-3H
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:33:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40806e4106dso4451045e9.1
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697718819; x=1698323619; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5N5G6CTWWgXx9YQWh8eHZ7Lc36YIu3ZOBocH5VZzGCw=;
 b=Lic4lUB+wDCGtivGDe+G2++/og4b4EnR7nKmwUpY+e53kUkenSJ7LfhvQTgcbpcRX4
 eFEX1mccXr1rSNe2zm33qHyxphj+sgEYMz9cO4GlgCKxG19Kcj1PFCrbIV8W3K3PLlSo
 DE/zS0kdlNYexkTit2lNwDaHCmQ4RKb8JxzTCeDJOUpGCK1qzgZBwIgwRSFkmUivlOuw
 SuWhhNBTdrrNbLsrO1Ay7zWAhXvQWJJr8FaMIz+0uspRfNvJx0R8GNtKJ3JZUqirkL4k
 EJZE1xnmbwjtc26MxpKRuZX+exKtZ4JxpUJF1MmlBCPHzwMh8n/PUH0j/nmseoBLKPqg
 zp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697718819; x=1698323619;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5N5G6CTWWgXx9YQWh8eHZ7Lc36YIu3ZOBocH5VZzGCw=;
 b=brzVsNik//SVY8YigU+6C5H7lnaJC1pFnV2Q9FBfpcAcoluWEe8PBfgxAjBAS/aW4M
 w6xB7zFvjMXTjAAFNgC11jt9xGrgV+TMU0dO3kI8aZFXtJmV6ngMcTZHb5rLBUTPlNux
 sFXc770ndcaULcpgru9G3/GHgwZX2VFsLsez3ekjThiu/q4v81R8R5dCi/Q7JihLkAbD
 ZTZoOki5jjeBCmpezTMZgGGbSEul/SdTmg375EC4SQtMDjTbuLq327khrS2XqYeI7v86
 tmeLN2mtZL18IHfucI+4oOkiY45HXyHRGxQ/PqxuEn50g6IIbnt7o77OI2GJ5qCM9FYg
 0PiA==
X-Gm-Message-State: AOJu0YyfLV+cACac9AoEzHzp4w2OEyXifLody19hEIQE0aAusfN/w99+
 lCTBOXSzEkuRHGuKz0C2oAjBLsG7HZTSTJlD8VQ=
X-Google-Smtp-Source: AGHT+IEY82qojseTRdwdfLgRyJ0v21PoLrRdJSi6jL8E38McgC/gxITN/pvdbiQnUrMexivXw+9l/Q==
X-Received: by 2002:a05:600c:2343:b0:401:b92f:eec5 with SMTP id
 3-20020a05600c234300b00401b92feec5mr1707681wmq.9.1697718819408; 
 Thu, 19 Oct 2023 05:33:39 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 s5-20020a5d69c5000000b0032db8cccd3asm4365317wrw.114.2023.10.19.05.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:33:39 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B2DCD1FFBB;
 Thu, 19 Oct 2023 13:33:38 +0100 (BST)
References: <20231016062300.160160-1-pbonzini@redhat.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/docker: avoid invalid escape in Python string
Date: Thu, 19 Oct 2023 13:33:33 +0100
In-reply-to: <20231016062300.160160-1-pbonzini@redhat.com>
Message-ID: <8734y6aj19.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> This is an error in Python 3.12; fix it by using a raw string literal.
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

