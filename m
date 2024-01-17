Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E4E83093D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 16:10:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ7YO-0002gX-RN; Wed, 17 Jan 2024 10:10:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQ7YG-0002bp-IZ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:10:01 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rQ7YF-0004r1-56
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 10:10:00 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40e800461baso24539005e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 07:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705504197; x=1706108997; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjpTEO30YSAwRS6cFIcdHejN2BvqfNQ1b9bTtZT2C/s=;
 b=V3rEjEH2X8vNDX3BtT7+YaGTjpc29utVVv7cuEmNfNGplxLMBS05QbU21KYxraNciG
 P+gFmyRjzySTj/QG9zfM2uHxf6U1JAzTcEA6n9IJ3Mu38hrqfu+R/CKv8d+e0l/qgy9G
 juMd4oFaOpLdYDwSnwC3nY2V7jM2tVtPNxlQgsFMkpBK+2mSLrvi5Q24yttF7qpQD0WY
 GFwy3wBCciWeIVmJse4TFDhm82LkTZ4l7PlJ3oPqdJReX6tjKS2s0AioI+z7AyzgMUsk
 YVr4PDbnMSke3SEFrIqsTzqqP82LOMBisbp/0eQ+5lnKrUZLSfeKNz5q4kVbpOJ4iDSX
 Xwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705504197; x=1706108997;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cjpTEO30YSAwRS6cFIcdHejN2BvqfNQ1b9bTtZT2C/s=;
 b=IPwIJQnHDBN/gkLI5O0t17XaKsYoarc6QBAV9sWKAmG16Lat8arVzWmowuFSe4NcHc
 PobwH6tRO6QFGv8tpWl3pEFDlKt7CRv0wrn3YOSfaFaKk5CJmgGUO0bl4HucUJ06BbYR
 j0wWy1T7DmbvvM+nkcsB5zZ4koIStWjYyCEV9tEIIoxI5oafjj8feDBskrXJPjzKJZpI
 WAa5Qqz7LaHWN5jPeBaqMTPXnZ/kcpT+9uERGr0ji61fXLaHZWIo3c0yGpzUDw4YJfcF
 mI0HYtmCinGhznGYoM+JtqBTbiGnXO8ETge51I1Txo58+moMncbVRuNSSXvEI4TsEBoI
 vNMg==
X-Gm-Message-State: AOJu0YwIRlEk0GIK8nIIV7mWiwZQxuaiTNcd8EeDb0hOgeBmTUtj0k4K
 zNstOxcAcFg1pAJYKDEnzGs12ROWGKi9kA==
X-Google-Smtp-Source: AGHT+IE2HyEspr3pV4e0/1WiqzNc1fbVP4JR2ruY9hUEZM4hDgXu0um9EL/ZnL0BGY8s3lS3phvlCA==
X-Received: by 2002:a05:600c:81b:b0:40e:6a1e:c58e with SMTP id
 k27-20020a05600c081b00b0040e6a1ec58emr2361095wmp.220.1705504197395; 
 Wed, 17 Jan 2024 07:09:57 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 g7-20020a7bc4c7000000b0040d5c58c41dsm22176665wmk.24.2024.01.17.07.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 07:09:57 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9DD4B5F79E;
 Wed, 17 Jan 2024 15:09:56 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: John Snow <jsnow@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Beraldo Leal
 <bleal@redhat.com>,  Warner Losh <imp@bsdimp.com>,  Ryo ONODERA
 <ryoon@netbsd.org>,  Kyle Evans <kevans@freebsd.org>,  Reinoud Zandijk
 <reinoud@netbsd.org>,  Gerd Hoffmann <kraxel@redhat.com>,  Wainer dos
 Santos Moschetta <wainersm@redhat.com>
Subject: Re: [RFC PATCH] tests/vm/netbsd: Remove missing py311-expat package
In-Reply-To: <20240117112407.22462-1-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 17 Jan 2024 12:24:07
 +0100")
References: <20240117112407.22462-1-philmd@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Wed, 17 Jan 2024 15:09:56 +0000
Message-ID: <87h6jchu7v.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x335.google.com
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

> Per commits a9dbde71da ("mkvenv: add better error message for
> broken or missing ensurepip") and 1dee66c693 ("tests/vm: add
> py310-expat to NetBSD"), we need py-expat to use ensurepip.

Queued to testing/next, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

