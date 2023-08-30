Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 374BB78D6CB
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 17:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbMjd-00065V-Qx; Wed, 30 Aug 2023 11:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMjb-00065N-US
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:03:55 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qbMjZ-0003Fm-Qx
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 11:03:55 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4018af1038cso54036755e9.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693407832; x=1694012632; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tr7KHQ0KuRc94CntpN5NG/B9TtzzNLRQr/cNb5nEOUQ=;
 b=WLvLVrCU24WqLDgke9dTg6xMvpWKdBwik6zoTLfqbFi4pmp+i1aXsQG+VSxHxZKU8L
 YbMCMLXSRx7kfV/UT04lplGpC+doPzjifTiYw1ZdfU7ecMj4+a07dIkJsdIZUZ5Vji/b
 iasI+kQRufJiNIFULrWFQ4m5PDMOEU0dHNwKdlGrRRotRZ4z9UOf5UDXyP8T8asgp6Pr
 t42PKiyNuBc23yheE2ciLZfhY0GkkhnZkHnU9y/gZRB8qTdl24msJw4zLXvVWmPXYbuH
 Vpz7ZWZx8qqd4k63hnCZWLVuZrJg2nGPwPzJn3d2Lvm5JqeuOOFj7TOPI8vxZBprqjFL
 Q0pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693407832; x=1694012632;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Tr7KHQ0KuRc94CntpN5NG/B9TtzzNLRQr/cNb5nEOUQ=;
 b=I5orgFQZyvIeNKUmHse0+LVeyVMNibQPbT8QDijnGPPBiw4pztmS+A4P3DckjJTUlz
 jYqn+CZogIQmVDx4RCTSImZmYF8hbdr0nO7eP5+ka9ZBb+y8DYFlgDpkw4MjeBSmTIfT
 mhNNN05NhzcczOO6fkunu0yzv03JVrZRI7wPvpnxEJbWC+YG9jPwVWZs1tW5UUmhmO/H
 9+2n/hZyFmX3iHNg57/P71wQPuM4IPzRcaajNXNZxqIFftKqQsQy7enltb+tsGSWgDaU
 VSYJhpOtONzf0nJg4xaOOTnJ8bdnOf07/jJKOxrEgheDMFhAoJ4v4L03+xwXjlJOy/sf
 XIGg==
X-Gm-Message-State: AOJu0YzkWqu6T703Bw6S9Yr0eht2zpv97uGlWi/RbnRocrC5qhUg10PX
 WrebzLiB8VJcBctwjaexdMrvyw==
X-Google-Smtp-Source: AGHT+IFz/25NDWeggi1rbHJVXYJQrewUguwMtJAgYBG/7jPEHdpfJWH6a2vLhSMHO2qmULo6OI1zTg==
X-Received: by 2002:a05:600c:2116:b0:3fe:d1b9:7ea9 with SMTP id
 u22-20020a05600c211600b003fed1b97ea9mr2128165wml.36.1693407832184; 
 Wed, 30 Aug 2023 08:03:52 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o9-20020a05600c510900b003fbe791a0e8sm2669016wms.0.2023.08.30.08.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 08:03:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 86B791FFBB;
 Wed, 30 Aug 2023 16:03:51 +0100 (BST)
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
 <20230818033648.8326-21-akihiko.odaki@daynix.com>
User-agent: mu4e 1.11.16; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-?=
 =?utf-8?Q?Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH RESEND v5 20/26] gdbstub: Remove gdb_has_xml variable
Date: Wed, 30 Aug 2023 16:02:50 +0100
In-reply-to: <20230818033648.8326-21-akihiko.odaki@daynix.com>
Message-ID: <87il8wr2qw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
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


Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> GDB has XML support since 6.7 which was released in 2007.
> It's time to remove support for old GDB versions without XML support.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

In principle I'm fine with this but should we not catch GDB's which
don't send qXfer:features:read earlier?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

