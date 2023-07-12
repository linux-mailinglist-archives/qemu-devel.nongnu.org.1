Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF8A750BB6
	for <lists+qemu-devel@lfdr.de>; Wed, 12 Jul 2023 17:04:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJbMx-0000Yn-30; Wed, 12 Jul 2023 11:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJbMv-0000XM-4a
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 11:03:05 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qJbMq-0007y6-Ar
 for qemu-devel@nongnu.org; Wed, 12 Jul 2023 11:03:04 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51fe084cf3cso935546a12.1
 for <qemu-devel@nongnu.org>; Wed, 12 Jul 2023 08:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689174177; x=1691766177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8iUONhbWcRDUE1bYgxoBV1UynIYzWQ5Oyi0O89ST/jI=;
 b=miDKBvfuim1LKN76kku3Gs2VZ8A2A/4/r1m/onBNrVmPb8iuNpUAg0MSEK71GGvcMz
 Em4rFYO5EygZw97R7L7a8YlzTIejJGFaLDNipqi5t0bEaRYpwoIK0zpoYAvg26ZKM1O+
 S2JX4WsY59nL7RUJe5Z7WEOBBQCyDQ9x9KLoedExUZiEzJMaXlZdAIB7pPWJRPAm7SaD
 bgg7QJaug3bN4kEE21tjJH+s2rL3EhdE+MOa6DyoD2uFprEl/hajRVXtayo/0z6V1E/D
 tMANJLUvAdY1s285eNy7MxBf1fuGrZZUeiHyRZcM6puiD2/Xyy6AFkBJ/Cr3XI0XOml2
 mibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689174177; x=1691766177;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8iUONhbWcRDUE1bYgxoBV1UynIYzWQ5Oyi0O89ST/jI=;
 b=GT7q91JVAfTbhMV9kuvvtiEunwgT0CJZZaTJx+hCR0r3t1b3bGO0a+TLBuBWJpb9jL
 vpNI7o5fW8F4TMaCMBX8qiyrhwO5HyarTXMFvGbQvRSHckgQrYZx3Asd+swtTQ2t+HqS
 oL8cc44giRtLY1+OXNhEbLP7bs8BK3Ue4FsxMH5nxO2jOpGiBLDpE/8nsm6SCk7H4fuu
 1w3G+uvOetA7dSd7DdJWVZ6lqK7KFk+pg6S3Nkmcz5B/Vz1fU5N/MevgYR/DSfOBMOnn
 lTpuA/ADEHLqG7FGkZKjmvnWV/juWMueu5Sfx0F/Fx2t60uNtxU6zK3/yuE3H8Kns+9w
 vebA==
X-Gm-Message-State: ABy/qLawq6HpdrCEBCpntprbTto7MMkAgXaj5mZU56+GlAUUynw+dQR0
 IomqkvDVYsmSDMgHG3ehTLU5ED5JIHQz5j50MrAkpw==
X-Google-Smtp-Source: APBJJlFebVJIy6mRGeHcidKF9FB11pggHk5oIt+HByKr6/zPNfXgQ2/cgLJMRXr8eJQiPO/rTUbdibK3r+/hEQmvDuo=
X-Received: by 2002:aa7:d30c:0:b0:51e:52bd:68c8 with SMTP id
 p12-20020aa7d30c000000b0051e52bd68c8mr11937656edq.14.1689174177535; Wed, 12
 Jul 2023 08:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230609083316.24629-1-hreitz@redhat.com>
 <20230711202321.GB154686@fedora>
 <d4459ee1-bdea-bff0-ab99-b38de004c2a7@redhat.com>
 <20230712141535.GA215287@fedora>
 <ee1afad7-daef-1217-fc2f-bd540f71e420@redhat.com>
In-Reply-To: <ee1afad7-daef-1217-fc2f-bd540f71e420@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Jul 2023 16:02:46 +0100
Message-ID: <CAFEAcA_dr_g-7MgLFqAiYh3v2TSeo7vCDR62n9OadUAEmYoRdA@mail.gmail.com>
Subject: Re: [PATCH] block: Fix pad_request's request restriction
To: Hanna Czenczek <hreitz@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Wed, 12 Jul 2023 at 15:50, Hanna Czenczek <hreitz@redhat.com> wrote:
> There was and is no fix for the Coverity warning.  I have mentioned that
> warning because the question as to why the code uses
> bdrv_check_qiov_request() came in the context of discussing it
> (https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg01809.html).
>
> I=E2=80=99m not planning on fixing the Coverity warning in the code. `ass=
ert(x
> <=3D SIZE_MAX)` to me is an absolutely reasonable piece of code, even if
> always true (on some platforms), in fact, I find it a good thing if
> asserted conditions are always true, not least because then the compiler
> can optimize them out.  I don=E2=80=99t think we should make it more comp=
licated
> to make Coverity happier.

Yep, I agree on that -- Coverity is bad about asserts and other
conditions that are there for one particular config or host
setup and only happen to be always-true on the config it scans with.
The simplest thing is to mark them as false-positives.

-- PMM

