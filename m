Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E5814E80
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Dec 2023 18:25:01 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rEBue-0004kT-Pk; Fri, 15 Dec 2023 12:23:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rEBud-0004hP-7R
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:23:47 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rEBub-0005NH-O1
 for qemu-devel@nongnu.org; Fri, 15 Dec 2023 12:23:46 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40c236624edso9669505e9.1
 for <qemu-devel@nongnu.org>; Fri, 15 Dec 2023 09:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702661024; x=1703265824; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x7CqrzOT9s+6m9j4ZpH6+UmgxKnXnvpdeOM2h3jJXI0=;
 b=NC0rzC48yP7S3vNaaJM56N3K5rRThzlcx8ATxSKwVEgIlR2PIOPJmvgQj6XpGL+f2r
 wm3t00C+J84yINmz4byv5nHpAdq0nDx94dbulBqhfmdXFaf50h3vQ6osMx4T0P0xddPa
 a1FQmAqwXa9vewlyLO7gp23VUmgXSKME1LtsuvYnQICJ9qAKpEGBW8iPSjeDc2360NUn
 P0HbI/Yok9J3Yhcu3Mtf6+qGo+sgVINcWnIbULMXNW9t8yPtUwqZtxiB8g/xecAvDLCA
 LYtGrTm7lkYxt8bcCubfOSSozrsp0eWTTu+YS0MMCmCMbpjQPpboTIK6+Y6BG8bCRMTB
 vZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702661024; x=1703265824;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x7CqrzOT9s+6m9j4ZpH6+UmgxKnXnvpdeOM2h3jJXI0=;
 b=gI77mUxjZKh580ddhv/iwJkmQuV+PAUxpsCl+ZJ254tRLc5dvVRVkeLwiI/tnUF4QU
 a6UFsq7pXJwVtgFbFQ0rnGAfVLWl10ux7Uvwl87CL3+iLm3wwHml5zNG2ZaICV2gjFlE
 kpVsA8wD58I5IVoJtg2zO+9mxQKNqsBgHF31CByJ4xD8c5iyTm/GsO8RDYCN1j2vxoWj
 a/4dXZmdqe4+htuoBoIXERtHFH0V/mUm2X7sQBp3jWw7rvTiHeRuK/NSw42PkzefPVhk
 qkMIP4WV34SzQ8aNeVkIDWe8Zv1KpfxAmmR7su7xD5vu7bmGXdRtl6nSXSLSq7x9qZX+
 WERg==
X-Gm-Message-State: AOJu0Yyzr120i0OWdqBxby0KXTevDVenBXGMeyvbeiJH1KAlxujcgjPZ
 1FKthxNqLmWkMonSL0e/TbFHcA==
X-Google-Smtp-Source: AGHT+IGpcv9bLIDFR6F1q4xJ/k8QzT9ejXClm7Zivg6IS+TPFTrwWSRqJgFMzFoVsfL1wL+WNj0xAg==
X-Received: by 2002:a05:600c:45cd:b0:40c:271a:e7f7 with SMTP id
 s13-20020a05600c45cd00b0040c271ae7f7mr5673410wmo.145.1702661024051; 
 Fri, 15 Dec 2023 09:23:44 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 u17-20020a05600c19d100b0040c440f9393sm22209836wmq.42.2023.12.15.09.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 09:23:43 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F0AB5F878;
 Fri, 15 Dec 2023 17:23:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,  Cleber Rosa
 <crosa@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH] tests/avocado: Add a test for a little-endian
 microblaze machine
In-Reply-To: <20231215161851.71508-1-thuth@redhat.com> (Thomas Huth's message
 of "Fri, 15 Dec 2023 17:18:51 +0100")
References: <20231215161851.71508-1-thuth@redhat.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Fri, 15 Dec 2023 17:23:43 +0000
Message-ID: <87y1dv7528.fsf@draig.linaro.org>
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

> We've already got a test for a big endian microblaze machine, but so
> far we lack one for a little endian machine. Now that the QEMU advent
> calendar featured such an image, we can test the little endian mode,
> too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to testing/next, thanks.

I'll clean up the gitlab tests to restore the two variants now. Sorry
about the temporary drop of coverage.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

