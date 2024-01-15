Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9AC82D85E
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:33:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPLCt-000670-0g; Mon, 15 Jan 2024 06:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPLCq-00062K-Dv
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:32:40 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rPLCo-0007lM-N0
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:32:40 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40e60e135a7so34188735e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 03:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705318356; x=1705923156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0o3O04pYwMl6J1t3gh9OBxi35KzLBuzIdEtQ6XnqUII=;
 b=vKfIRgIVQnhRFP1s0C9Kei7/URMIdHFPsnypyZRRgAD7Pf1oDlFVV8rvW5LtrlgFbz
 RktKJrpI7ZR/d6KorUgbOLb6oUr/WUQmT+FgF0pYpUv98Bb8mXE+fCNnqJTjtoKS/EYj
 AuUmzD/0x+qwq8ReWey7k8EpWKoD/WAF93HOS6V+/MSoPoVnzh3Jg19ylxtnHyKW6BIS
 w9wDvFRyinsiHomu0i/elyJ5SJ1J7xwQKOqtObmAkDcYKnSlDKP7Wv3VNttC4Mu865g2
 H7MhJyuFSwFNFgtSC9MQf/oJkygfulutM7Absev9Knog5BIlsgsZFmwL5OQvTrV+9wnk
 cT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705318356; x=1705923156;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0o3O04pYwMl6J1t3gh9OBxi35KzLBuzIdEtQ6XnqUII=;
 b=k4OCOWygYXbk08g9FjXcd5ywWX34257+UIWA2JEBMYvHBkeXgOCNTVMG2IjzCFmunE
 1fnHZ6vZWDftjH//ouzh1iHJHm4Y1V5J5GIUs2L9k4W5d+C7D7e1yi1FPZSazV4X0Pyv
 BO6x+HU9Tq6+LAc0D7OJtkrf/hsXvIzSOdPDf4FLsMx7pi9wGJLqWPFUrMOLHlqbapmG
 SwSjRVEJC+wCnoK74SIhPT39vUzc/jwLc0+kJTL7fAYJzO8Wu7gxdvUSyuTSS64xwpt7
 vcEkkjGJjuXzfqyQqXUeKVlwBJ62PCiG6DPSfV9CPHWmY+VJ9NyqW07r3o4zn9eyosIi
 pwYQ==
X-Gm-Message-State: AOJu0YwNEIQvRDqx//ElcneAknU4TQYiRTk5Nw294IHRBE3uoFDYXutX
 R+bKuSHamVfT5MgsmVlt0Zp53MzOv7uiurXGOI9XHHWA6+Q=
X-Google-Smtp-Source: AGHT+IEtszHuYuPTt7KtJjREpPRUz9VLLqvD2QB4lb+8UeQt9qT5yrs+rWNWg2EqTD/cHXxOAqSQqA==
X-Received: by 2002:a05:600c:3ba1:b0:40e:50f8:9abf with SMTP id
 n33-20020a05600c3ba100b0040e50f89abfmr2627365wms.92.1705318356353; 
 Mon, 15 Jan 2024 03:32:36 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c459300b0040e42391a12sm15483372wmo.13.2024.01.15.03.32.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 03:32:36 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A906E5F756;
 Mon, 15 Jan 2024 11:32:35 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Tyrone Ting <kfting@nuvoton.com>,  Hao Wu
 <wuhaotsh@google.com>,  qemu-arm@nongnu.org
Subject: Re: [PATCH] tests/qtest/npcm7xx_watchdog_timer: Only test the
 corner cases by default
In-Reply-To: <20240115070223.30178-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 15 Jan 2024 08:02:23 +0100")
References: <20240115070223.30178-1-thuth@redhat.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 15 Jan 2024 11:32:35 +0000
Message-ID: <87r0iikf1o.fsf@draig.linaro.org>
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

Thomas Huth <thuth@redhat.com> writes:

> The test_prescaler() part in the npcm7xx_watchdog_timer test is quite
> repetive, testing all possible combinations of the WTCLK and WTIS
> bitfields. Since each test spins up a new instance of QEMU, this is
> rather an expensive test, especially on loaded host systems.

I'm not against the change but I do not my home machine runs these tests
in:

  1/1 qemu:qtest+qtest-arm / qtest-arm/npcm7xx_timer-test        OK        =
      0.18s   180 subtests passed

so I do wonder how the system load can cause such a dramatic increase
for a comparatively simple test.

> For the normal quick test mode, it should be sufficient to test the
> corner settings of these fields (i.e. 0 and 3), so we can speed up
> this test in the default mode quite a bit.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/qtest/npcm7xx_watchdog_timer-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tests/qtest/npcm7xx_watchdog_timer-test.c b/tests/qtest/npcm=
7xx_watchdog_timer-test.c
> index 4773a673b2..981b853c99 100644
> --- a/tests/qtest/npcm7xx_watchdog_timer-test.c
> +++ b/tests/qtest/npcm7xx_watchdog_timer-test.c
> @@ -172,9 +172,10 @@ static void test_reset_action(gconstpointer watchdog)
>  static void test_prescaler(gconstpointer watchdog)
>  {
>      const Watchdog *wd =3D watchdog;
> +    int inc =3D g_test_quick() ? 3 : 1;
>=20=20
> -    for (int wtclk =3D 0; wtclk < 4; ++wtclk) {
> -        for (int wtis =3D 0; wtis < 4; ++wtis) {
> +    for (int wtclk =3D 0; wtclk < 4; wtclk +=3D inc) {
> +        for (int wtis =3D 0; wtis < 4; wtis +=3D inc) {
>              QTestState *qts =3D qtest_init("-machine quanta-gsj");
>=20=20
>              qtest_irq_intercept_in(qts, "/machine/soc/a9mpcore/gic");

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

