Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DC7441A8
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 19:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFILv-0006Tk-Ey; Fri, 30 Jun 2023 13:56:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFILt-0006Tb-At
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:56:13 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qFILr-0005bV-Qr
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 13:56:13 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-3fbac8b01b3so18937835e9.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 10:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688147770; x=1690739770;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LB5CmSucznQ4hHogOSx1qNWJWYk/WX3MUEuFuJicVA=;
 b=xHwPg//ft12l7r1IL6EdiPHEFPgnJZ8pnmx+jDI2Hn9PbUqgAqvNpGdKmHIINXMjmZ
 F4X8LmppooRxP3zL+sa2hYrLnYjeSsEt9vhVDMcyMDWS0mL9c66KvfniYv34Mf+mFdFx
 pTvKzXk88U/UwpbbCVexxrq1hLPU0XZZDk3N9BAQeq0Rxap+1NFL56FB+jAPs69ZAaI2
 vdwsm/ysE25SZWQgbW+lvHUq8qL5n+V7NYLHVU4EK7uFLWkT4EMkUkdsa7GRB0sj8QeS
 xuftah5UY+5tIwmseIZUwaoRbmEjBon9yJRDdW+K61bYI48LnQNwdhFBjdIPhQilvbhF
 PG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688147770; x=1690739770;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0LB5CmSucznQ4hHogOSx1qNWJWYk/WX3MUEuFuJicVA=;
 b=Q3jzL239uEaB/EqAqbRDD3YFLk3K7RvITSfekRF6Q5w73YohiRx7l/8xJQp0KT75gM
 MY9kgcD2qHD7tIxPcPMnBDAfZVos3udEX3A6UtLTkcgLE6ZHtWGUFCKnJnG984TAFC4e
 4pfVRB6d0OPNaeQ7iw7vsAxy7gHJIbrP8CmIsCXs7OAV9egd7ifoNM9+l0Kr08SuKx4U
 Otz3naOrVrCV4qOcuzY7BHmtxQo2OCEdWMGz/JZtC47Rw7+I+/2KxoDQz68ObXUOipWO
 yFN9abJ6UFQeXU2RlAbQRDpR/g1RlPPu+bZV4GyKTJqBXHr5apDIVu2wb0BDbc+5t7bu
 fvrw==
X-Gm-Message-State: AC+VfDx0ogjl8zzFDmyczc8y4leXXdivphpNGVh75qu4dkFIlXQS8KNq
 pM+WaN4YVT2IjhsvMKQ7x6J1dg==
X-Google-Smtp-Source: ACHHUZ4Iqd1iCm4F8dJFYzkt/zlReh78q7EEG8DXt/0leH9YyR33iDG7E+RN+56uRoFWNMrY10Gxbw==
X-Received: by 2002:a05:600c:4f8a:b0:3fa:821e:1fb5 with SMTP id
 n10-20020a05600c4f8a00b003fa821e1fb5mr8639026wmq.5.1688147769776; 
 Fri, 30 Jun 2023 10:56:09 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a056000104100b0031402a910edsm9454216wrx.86.2023.06.30.10.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 10:56:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F2D2D1FFBB;
 Fri, 30 Jun 2023 18:56:08 +0100 (BST)
References: <20230630161604.446394-1-thuth@redhat.com>
User-agent: mu4e 1.11.7; emacs 29.0.92
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qianfan <qianfanguijin@163.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>, Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: Re: [PATCH] tests/avocado: Make the test_arm_bpim2u_gmac test more
 reliable
Date: Fri, 30 Jun 2023 18:56:01 +0100
In-reply-to: <20230630161604.446394-1-thuth@redhat.com>
Message-ID: <87ttuox29z.fsf@linaro.org>
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


Thomas Huth <thuth@redhat.com> writes:

> The test_arm_bpim2u_gmac test sometimes fails (ca. 1 out of 20 runs
> here) since the disk shows up as /dev/mmcblk1 instead of /dev/mmcblk0
> in some runs. No matter of the name in /dev, the major:minor encoding
> seems always to be the same, so we can fix this issue by using the
> correct major:minor hex number in the "root=3D" parameter instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


Queued to maintainer/june-2023-omnibus, thanks.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

