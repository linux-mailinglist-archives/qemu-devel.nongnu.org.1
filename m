Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ACF7197FC
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:59:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4f4v-0003jv-Qs; Thu, 01 Jun 2023 05:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4f4s-0003ix-2I
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:58:43 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1q4f4q-0007aV-Iy
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:58:41 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3f6e72a1464so6330405e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685613519; x=1688205519;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t9fUA5Qr05oyVdMGrNkNFiNMyb/8hs+zWOhpUPoWbFA=;
 b=YuARdQ28V9Cm3efz7Wf8ownCwN0aSOpMLuW6a+Wa6fa9tINUV1z4+e2IQUIy6H6ip0
 UeDNT053H24k/Tk1oBUDxjxWvRpcx69pfHO6VfooGEKhLxyivJciHAQiceZyna2KthCj
 7OWPv739HbkQ2RJ3Hiythh5YO3d1RNoeVdSguTgO2MdRq7gajSogsLoq0iTTJk2nGeuw
 jRab8LAeVejfijQ3ep9kmZyhGfaUfh5LUG1BIjRkUNzlhI9SOH9wQY5Uozwm0G3sREOw
 dLpyFUya9MYJNo3yY8IBg91ppgJWdK3MfNhQe42FtJNdEWWPnekqC85VKsBR1OOEeEyW
 eIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685613519; x=1688205519;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=t9fUA5Qr05oyVdMGrNkNFiNMyb/8hs+zWOhpUPoWbFA=;
 b=f8zkvQgVt8Z/uKCUcKT3Qow0JTZH+879CHKMk66wpwG9vtgdL+agIV5H5ssEPohyLT
 kKABvbQNr3HIQ/GS+K3sYc9HlsS9nBeWTgn/71HdKG9MbX6gYMIbPClgj6SI8p7ENAZL
 zrLc6hgx0J0OobtMXlUwIvxmIv121P+EgkPW50QSJJkcVE+EjLOHK0aLbyYNj6CDzos/
 KE0EygHVFu+4m2v0aibDvNn1iKW/HJ4zMIiyPfBvAvGHFPGYQxzOozVps20cmw70Gs2m
 4TQP7v+7RgGHQMfAZVke5LqU0ZuPeJFbYwzNvGytYpTUyH7SOyE2TLnZpd6Ree+CDMQm
 VR0w==
X-Gm-Message-State: AC+VfDwD97h7GiyaAyHItuHl989GOMHXwPMO6882XlCNMg10cMZ4Av6F
 WfscNIHHB18erS1Jn+y+XYwFlA==
X-Google-Smtp-Source: ACHHUZ4KE676W7S72B6/wJCMfT2cq0nIe6zbJo2tBYxsXuIoQUm32rg7BJNTXA0PBbXiRAgOa9aCMw==
X-Received: by 2002:a7b:ce06:0:b0:3f6:be1:b8d9 with SMTP id
 m6-20020a7bce06000000b003f60be1b8d9mr1552764wmc.6.1685613518806; 
 Thu, 01 Jun 2023 02:58:38 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o13-20020a5d474d000000b0030af54c5f33sm8320406wrs.113.2023.06.01.02.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 02:58:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EDF221FFBB;
 Thu,  1 Jun 2023 10:58:37 +0100 (BST)
References: <cover.1685528076.git.eskultet@redhat.com>
 <c9b00e573a7a80fc6ce5c68595382f5c916a9195.1685528076.git.eskultet@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Erik Skultety <eskultet@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Wainer dos Santos Moschetta
 <wainersm@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 2/2] tests: lcitool: refresh: Bump container versions
Date: Thu, 01 Jun 2023 10:58:01 +0100
In-reply-to: <c9b00e573a7a80fc6ce5c68595382f5c916a9195.1685528076.git.eskultet@redhat.com>
Message-ID: <87fs7bbj1u.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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


Erik Skultety <eskultet@redhat.com> writes:

> Alpine 3.16 -> 3.18
> Fedora 37 -> 38
>
> Signed-off-by: Erik Skultety <eskultet@redhat.com>

I've cherry picked this (minus alpine) into testing/next as I've got a
slightly newer lcitool refresh patch in my tree already.

Thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

