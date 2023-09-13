Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEF179E29B
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 10:50:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgLZ2-0003Ap-Df; Wed, 13 Sep 2023 04:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgLZ0-00039o-IR
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:49:34 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qgLYw-0005LH-5k
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 04:49:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-401d67434daso70927925e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694594968; x=1695199768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REZc+ghyjPUJLotx1L6ZErcTqsI2gLvaH4DfxRxrERk=;
 b=p1B/RK0/H6y5RTKMKaxBr9JIzid6fHW1AkRd3kbl4AvOjxrVxHRclZPzr+OsQ0W8NA
 Rg61LOGwz9ZDF2UiNOKqDwhbxQhXsHzMJtjeOXKe2jamDfWHWfOKqHDbgoP6JmS/tI4m
 asYvJ8PpQuNJALiedR1+fZvgTVwpzmsfMvOxua3W+lRx2xLSsXuS5ZI14yET1eQfacjq
 ytxlKSrTXYVZA3gejOzj3smUJ1C2xIRg/GOwVHO1lNZvx+pCFWjvNRXd7jb9ypv/Zki9
 9fq2PHDKWJwACSpEp9/2w/+XZC7U7kGXBiIP5TPAyTBodpSfutkDxrejyb3cucgcGqKX
 37Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694594968; x=1695199768;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=REZc+ghyjPUJLotx1L6ZErcTqsI2gLvaH4DfxRxrERk=;
 b=O8eJlAEAHusPFMeKiaB4grdJpI6DkSGjV4TS5pwUZtAqBI1pEx0wobejFsJllbAMFz
 pIEAwBgO/qTOJ3UgskoHQV3qioMKX17Q9ckTR0DYMwozZ6yO5dWjSn34CGfmDYsGLPCc
 hycgGI2pdMsiCcDSN70K2LIbp+Bi+IKV1NgV9HpsW7VGWn3+/K7Yo9a/b5FJJpxv1D7s
 Zbvlhii/58x/eoDz0nmU/NM+28KAhdPAhTmd9+v1JjpkxvEIdWvqbEA/ftH2jMHDTGfO
 Zp7rurBLYvLihddf3kISkpT491yGGmaHeparBC2WOMxsjxJDYfhaePUWqSze+x0V6rZU
 /zUA==
X-Gm-Message-State: AOJu0YyAGU8gTAXXrU0uxwJEhYQYWJ25gobTEEONaQEbFt8wvVNqXRlv
 +bQSwoRvLLejIlad1jYsoKLyuQ==
X-Google-Smtp-Source: AGHT+IE0jEk0vi0lIetmBN/BNqyJkfvbvnz049UuSGen8qWn20SAJ5DDT1UZjaSv/DhyHzJp8YUjyw==
X-Received: by 2002:a05:600c:3794:b0:3fe:d71a:d84e with SMTP id
 o20-20020a05600c379400b003fed71ad84emr1595780wmr.1.1694594967944; 
 Wed, 13 Sep 2023 01:49:27 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 z7-20020a7bc7c7000000b003fef60005b5sm1390175wmk.9.2023.09.13.01.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 01:49:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 154621FFBB;
 Wed, 13 Sep 2023 09:49:27 +0100 (BST)
References: <20230912184130.3056054-1-berrange@redhat.com>
 <5cbb92ab-f8b5-4d03-5698-06d0a0b7cfda@redhat.com>
User-agent: mu4e 1.11.17; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Cc: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 qemu-arm@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>, Wainer dos Santos
 Moschetta <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH 0/4] ci: fix hang of FreeBSD CI jobs
Date: Wed, 13 Sep 2023 09:48:34 +0100
In-reply-to: <5cbb92ab-f8b5-4d03-5698-06d0a0b7cfda@redhat.com>
Message-ID: <87ledatq3s.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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


Thomas Huth <thuth@redhat.com> writes:

> On 12/09/2023 20.41, Daniel P. Berrang=C3=A9 wrote:
>> This addresses
>>    https://gitlab.com/qemu-project/qemu/-/issues/1882
>> Which turned out to be a genuine flaw which we missed during merge
>> as the patch hitting master co-incided with the FreeBSD CI job
>> having an temporary outage due to changed release image version.
>> Daniel P. Berrang=C3=A9 (4):
>>    microbit: add missing qtest_quit() call
>>    qtest: kill orphaned qtest QEMU processes on FreeBSD
>>    gitlab: make Cirrus CI timeout explicit
>>    gitlab: make Cirrus CI jobs gating
>>   .gitlab-ci.d/cirrus.yml       | 4 +++-
>>   .gitlab-ci.d/cirrus/build.yml | 2 ++
>>   tests/qtest/libqtest.c        | 7 +++++++
>>   tests/qtest/microbit-test.c   | 2 ++
>>   4 files changed, 14 insertions(+), 1 deletion(-)
>>=20
>
> Series
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
> Alex, will you pick these up or shall I take them for my next PR?

Queued to testing/next, thanks.

Do you have a patch to disable the borked avacado tests? Or maybe I
should just include Philippe's fix?

> Or Stefan, do you want to apply these directly as a CI fix?
>
>  Thomas


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

