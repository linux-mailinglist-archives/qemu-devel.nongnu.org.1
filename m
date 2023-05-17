Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAB3706DE4
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:17:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJp0-0003V2-QB; Wed, 17 May 2023 12:16:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzJos-0003UT-8j
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:16:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1pzJoc-0002wL-CK
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:16:05 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3f41dceb9d4so9797115e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684340148; x=1686932148;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WS8VJT7vYPa/mdAXrDXlOIwjAbEEwQLHK4ZYNP6JJc8=;
 b=Je+CG3l7pGFO5qW07NVtwb7Ol5uFuPygB5TFuogA8GhHTUij1TR1WkTdaevY4Yjk7g
 5GE5E8pN6ysvlg2fH042R0Qx3VMRf51Bz69aGP7eizg25W076GVzzAWHOBWUOcrNfDL3
 zEQoT8vKbatK9n1twOkTib+QSKWiCg9VGIMomb/MAOdb3uMtrp9zyhwWd4Ghloo5iVoL
 uQpT7g30SdT1BUovvKcmYO/9dLbzg4V303aNhyaDNNBrYzGYtbDLnwD3PcM7Sj9ZwfhZ
 EXHVSoo/YSNRSI25BVY8BIvwhhhxoTK+Pgos3BJnSg735zi5mrRPToH9VVBZurcFq2F9
 s9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684340148; x=1686932148;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WS8VJT7vYPa/mdAXrDXlOIwjAbEEwQLHK4ZYNP6JJc8=;
 b=RXnNNobTE3Tq/4tpLOdqW9XOk1Bm877vAEdG0YW79hLUGb3q/qVd3Cjw+uMtnz96Q/
 +MfV3BZOAVR7r2sO9yxwDf/Wlnia3NAi7h18kvThAGx5DDe2h5xmIpX2zVmOUVnEjOoR
 dH593jziTpf91BwI4jqwyTZH//mJ3be6JTtHGybkpC2AI7C82w3ERw0pW0KwaCMNAOv5
 fqVvgwKN4FXV6Yrd0+dNu4E1qH/EH6yIF9wurdYsjKHT+OQ2Aa7qYLi5sjQJTPmnV47j
 PzFdSCJgY7rvduXqfpOyQ9iiuzxQOrwY+yzuWgiMsFzmwVMmqzL2JE345Gnuk5+OpIwk
 D27w==
X-Gm-Message-State: AC+VfDxcFVPJPRyLvtPGRK11npTack29aP/jnokHObVVDca0dO10dl2E
 za3K8U/K0K36hW6bDBvzFQSO3vsB+qKv4z5a6hiLgg==
X-Google-Smtp-Source: ACHHUZ54sPm8mPziTyAuhz2AqjSTTIatNfoqcYAeqk5yuVsR9eTKSZFNGlEbZTx11swUHTRsER88vA==
X-Received: by 2002:adf:ef08:0:b0:306:2e04:5925 with SMTP id
 e8-20020adfef08000000b003062e045925mr1183612wro.17.1684340148160; 
 Wed, 17 May 2023 09:15:48 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 i4-20020a5d55c4000000b002ca864b807csm3546828wrw.0.2023.05.17.09.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 09:15:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4579A1FFBB;
 Wed, 17 May 2023 17:15:47 +0100 (BST)
References: <20230517120751.14679-1-anisinha@redhat.com>
 <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com>
 <87zg63m18g.fsf@linaro.org>
 <A348B8F4-4F2E-4088-839E-270EB81066F2@redhat.com>
User-agent: mu4e 1.11.6; emacs 29.0.91
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov
 <imammedo@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment
 variable for iasl location
Date: Wed, 17 May 2023 17:07:19 +0100
In-reply-to: <A348B8F4-4F2E-4088-839E-270EB81066F2@redhat.com>
Message-ID: <87mt23lyrw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


Ani Sinha <anisinha@redhat.com> writes:

>> On 17-May-2023, at 8:46 PM, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>=20
>>=20
>> Ani Sinha <anisinha@redhat.com> writes:
>>=20
>>>> On 17-May-2023, at 8:06 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>=20
>>>> On Wed, May 17, 2023 at 07:57:53PM +0530, Ani Sinha wrote:
>>>>>=20
>>>>>=20
>>>>>> On 17-May-2023, at 7:47 PM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>>>>>>=20
>>>>>> On Wed, May 17, 2023 at 05:37:51PM +0530, Ani Sinha wrote:
>>>>>>> Currently the meson based QEMU build process locates the iasl binar=
y from the
>>>>>>> current PATH and other locations [1] and uses that to set CONFIG_IA=
SL which is
>>>>>>> then used by the test.
>>>>>>>=20
>>>>>>> This has two disadvantages:
>>>>>>> - If iasl was not previously installed in the PATH, one has to inst=
all iasl
>>>>>>> and rebuild QEMU in order to pick up the iasl location. One cannot =
simply
>>>>>>> use the existing bios-tables-test binary because CONFIG_IASL is onl=
y set
>>>>>>> during the QEMU build time by meson and then bios-tables-test has t=
o be
>>>>>>> rebuilt with CONFIG_IASL set in order to use iasl.
>>=20
>> Usually we work the other way by checking at configure time and skipping
>> the feature if the prerequisites are not in place.
>
> I think this is too hard a requirement for something that is only used
> for debugging aid. If iasl is absent, no big deal. We won=E2=80=99t get n=
ice
> asl diffs but the test will fail and let the users know which blobs
> are in disagreement. For ACPI contributors and maintainers, in the
> previous incarnation, one could quickly install iasl and rerun the
> same bios-tables-test and get the asl diffs. Now we need an additional
> step of recompiling QEMU which is completely useless, confusing and
> burdensome.

That sounds like a bug in the build system - for example:

  ../../configure --disable-docs --target-list=3Daarch64-softmmu,arm-softmm=
u,aarch64-linux-user,arm-linux-user,aarch64_be-linux-user --gdb=3D$HOME/src=
/tools/binutils-gdb.git/builds/all/install/bin/gdb
  make -j9
  ... does complete build ...
  ../../configure --disable-docs --target-list=3Daarch64-softmmu,arm-softmm=
u,aarch64-linux-user,arm-linux-user,aarch64_be-linux-user
  make -j9
  ... regenerated 23 files ...

It certainly doesn't recompile all of QEMU and I'm sure some of the
header re generations the build system could be smarter about.

It's certainly not without precedent to use getenv() in tests, there are
a number of well defined cases. But if you are going to add it at least
document it docs/devel/testing.rst otherwise you will be the only person
who knows of this particular magic variable.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

