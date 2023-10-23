Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A46FC7D400F
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 21:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qv0Q2-000316-Qu; Mon, 23 Oct 2023 15:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qv0Q1-00030w-DZ
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 15:16:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qv0Pn-0002tu-MM
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 15:16:51 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-408382da7f0so30374925e9.0
 for <qemu-devel@nongnu.org>; Mon, 23 Oct 2023 12:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698088598; x=1698693398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4+GK01YeisXdjigIIDWtGw4jYotMfaJxD7ZqhVaqCWQ=;
 b=o2wy8pbW9OhVN2vvTI/9XtX/iSHUwk5M5AmuSJZ6DvQNaGhUyFoiCTDCwFaKsgB2lQ
 oE1QQTZnJtSdZ+jTbZBbO2J/6NIN1OjZ2maWnl8OkqZ7npS3tjS9oY4HLnei77BPhVZt
 M7YLGlV+A/luzkKkERZCEB62U+twhpsiel925bXbFojb6Dq3/Js1A0oColxrhD4grINS
 ggHOwNlZskAn8f23DymqHgZeNZdRk15rHhd92oA/nheAshaRxkDsbBVw+EDIkBGVtNlU
 lCc2vWQdPprQuGCboLdZ2Uyu379Qt5QJagGWg035Sm354vN4JyWhhxPLNc9aTmWGhrfj
 Dkng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698088598; x=1698693398;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4+GK01YeisXdjigIIDWtGw4jYotMfaJxD7ZqhVaqCWQ=;
 b=wvdD5AH1c1rvd8X3ejI7+gwga9tIdfHpAly8Fz1fmMp2SuVS8/sxe+Z57JzzBOIWkR
 sHhMQ8xN8JqXHs6r1z3vyyvC/8VaocYtoB0wUmwtAD/eQbrlnYKafu1zuTdkl9YUOlry
 +rM2tHjPegku9lcK/aLIIlC1DY9qTKSf4tirWuQhWOJsv8jCHsncJqvN08JNTgB8s6Oa
 vxNW2OcR1bFsc2J7fQ5YgDDi/jF/pmsWAcKWS6etpJ2LgJ5BLi9GMy4au0uMQ/w9hch/
 7H5dmHd/GqXMMKHZRvVAZNgeXZPQLRxQtxclzQnTMS60nHD/4ZWaZigKu8Exw1j0V7Vo
 dJVQ==
X-Gm-Message-State: AOJu0YzeiqU/cKPpJRsHrP6rpeBw/y/NamqP32nMeAtOo/t7+0kn5xJ6
 l4DV3Wg/W/9ZNlCRHz0zp0uZKh6RkhAcCqd+rWg=
X-Google-Smtp-Source: AGHT+IHhrhcdRsZgy4A33feBQ9H1SWtexUQ6x50hz2ghq1NplAEvyJLuJi6PSUYu6GDw/j/Y6hrsmA==
X-Received: by 2002:a05:600c:3555:b0:405:3e9a:f1e3 with SMTP id
 i21-20020a05600c355500b004053e9af1e3mr7720727wmq.11.1698088597636; 
 Mon, 23 Oct 2023 12:16:37 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c228100b0040596352951sm14616524wmf.5.2023.10.23.12.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 12:16:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C5E2C1FFBB;
 Mon, 23 Oct 2023 20:16:36 +0100 (BST)
References: <20231023180837.91785-1-titusr@google.com>
User-agent: mu4e 1.11.22; emacs 29.1.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Titus Rwantare <titusr@google.com>
Cc: qemu-arm@nongnu.org, minyard@acm.org, philmd@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/8] PMBus fixes and new functions
Date: Mon, 23 Oct 2023 20:10:47 +0100
In-reply-to: <20231023180837.91785-1-titusr@google.com>
Message-ID: <874jih40a3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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


Titus Rwantare <titusr@google.com> writes:

> This patch series contains fixes and improvements to PMBus support in QEM=
U.
>
> The following has been added:
>    - Support for block receive
>    - Support for devices with fans
>    - Support for the VCAP register for devices with onboard energy storage
>    - A bitfield struct for the vout mode register, whose bits determine t=
he formatting of several read commands in PMBus
> Fixes:
>    - String read now handles now logs an error when passed an empty string
>
> This series is in preparation for some additional sensors that exercise
> this functionality that will be incoming shortly.

You seem to have missed a number of tags from previous postings:

  https://qemu.readthedocs.io/en/master/devel/submitting-a-patch.html#prope=
r-use-of-reviewed-by-tags-can-aid-review

(although I notice we only mention Reviewed-by in the docs)

You can use a tool like b4 to apply a series and collect the tags. It
will also collect the Message-Id's which are also useful.

Once you've fixed up your tags I think as the maintainer you can submit
a pull request.

>
> Thanks
>
> Changes in v3:
>    - Added fixes to PMBus: page resets and fault clearing
>
> Changes in v2:
>    - Expanded commit descriptions
>    - Added the ADM1266 device model that uses new functions
>
> Titus Rwantare (8):
>   hw/i2c: pmbus add support for block receive
>   hw/i2c: pmbus: add vout mode bitfields
>   hw/i2c: pmbus: add fan support
>   hw/i2c: pmbus: add VCAP register
>   hw/sensor: add ADM1266 device model
>   tests/qtest: add tests for ADM1266
>   hw/i2c: pmbus: immediately clear faults on request
>   hw/i2c: pmbus: reset page register for out of range reads
>
>  hw/arm/Kconfig                |   1 +
>  hw/i2c/pmbus_device.c         | 237 +++++++++++++++++++++++++++++--
>  hw/sensor/Kconfig             |   5 +
>  hw/sensor/adm1266.c           | 254 ++++++++++++++++++++++++++++++++++
>  hw/sensor/meson.build         |   1 +
>  include/hw/i2c/pmbus_device.h |  17 +++
>  tests/qtest/adm1266-test.c    | 123 ++++++++++++++++
>  tests/qtest/max34451-test.c   |  24 ++++
>  tests/qtest/meson.build       |   1 +
>  9 files changed, 653 insertions(+), 10 deletions(-)
>  create mode 100644 hw/sensor/adm1266.c
>  create mode 100644 tests/qtest/adm1266-test.c


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

