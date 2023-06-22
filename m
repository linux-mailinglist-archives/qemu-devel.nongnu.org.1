Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F040E739CD3
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 11:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCGYX-0007VK-UK; Thu, 22 Jun 2023 05:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCGYV-0007Td-Tv
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qCGYU-0004nA-H1
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 05:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687425881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QnIQ/xapN5uMJfMUk52uv20vhhWsBLm/ASSD3EXtZUA=;
 b=T70LXO8KN15m35uLi8msFEMJVT5FkRj5Jp86ARvPfbzk+z3F4PuzUZ5CdJ3n9jKfzBIAsm
 M2uJ0kGfHGq5s9kmynrtkXSSqfvLthNyNi5Rk2YrRhcZiZ638pU2zS79Zms9fYcvR3cU78
 LRCQWajIHRCrZLFuIAgEh2kT89+mov4=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-40UdhIGKPJ-XlCj07E7TJQ-1; Thu, 22 Jun 2023 05:24:40 -0400
X-MC-Unique: 40UdhIGKPJ-XlCj07E7TJQ-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-440bc497ef7so1229321137.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 02:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687425879; x=1690017879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QnIQ/xapN5uMJfMUk52uv20vhhWsBLm/ASSD3EXtZUA=;
 b=hfsWplBe0nPtOOA50JuMOVcWVf6GjHRXuAa0d8kcegLKXpSfN23Ciz5cMFpVpISXA8
 M7y2Oy56LblTOGlW5wNJC463/OnUaCg0fYdpCTb1h+YfeNiRX4nLhgSi7pLAEObtfUyR
 RExtxjT2DAO6itRcyuGxqD1Kc1Dz/BAmnwnkKsVy3kdc0y/ntbgCFKivABtdKW1kIFqz
 wjr7MAJqgxxUMFGIrJoa6aHFsgJw2VQhZ+poWCV2AgFxwFdqCCRD5YRJNHIAZpNGtXni
 gga3J3aPXhRIx8yaVzoDLCp7jizzf8JlAX7d4xX56PXRXFcxaWxK+k/XaDhs3EeoWmkZ
 BoIQ==
X-Gm-Message-State: AC+VfDxiMxSo5de3Q+icrQ9xMZUyPSdrkNQL5Vv0FKDwYTE7iHuILcud
 biZhWbtJDh7Rfprhj37F8tDgNtqzsEHewJP91DLJSS9Mw394TeIqjR+mcS+YR6HxgL5hJB6bYK8
 6VNxCDf6C8JNrUPTvrF27tlW9MdtMwTk=
X-Received: by 2002:a67:e295:0:b0:42e:2b9f:f8f0 with SMTP id
 g21-20020a67e295000000b0042e2b9ff8f0mr8423351vsf.30.1687425879706; 
 Thu, 22 Jun 2023 02:24:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47AV+4CmtigoZtgtC5gdxPwwtW+rE2O+Y/b63DaVQqaLk+XdNy70jYjqiguhSRoRHhpA0/orVl4HG30ZbLO9I=
X-Received: by 2002:a67:e295:0:b0:42e:2b9f:f8f0 with SMTP id
 g21-20020a67e295000000b0042e2b9ff8f0mr8423345vsf.30.1687425879514; Thu, 22
 Jun 2023 02:24:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230621002121.1609612-1-jsnow@redhat.com>
 <CABgObfahSN4eQ65nu9Dy_7bkWmxfERiJ-ZEM729futMFuGWwPw@mail.gmail.com>
In-Reply-To: <CABgObfahSN4eQ65nu9Dy_7bkWmxfERiJ-ZEM729futMFuGWwPw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Jun 2023 11:24:28 +0200
Message-ID: <CABgObfYKK+eU56iP2O+O7s=dcfWxmpXrB3EuNj=CkUw-XEjSnA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/6] Switch iotests to pyvenv
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Thomas Huth <thuth@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Beraldo Leal <bleal@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, Jun 21, 2023 at 9:08=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
> Maybe patch 4 can use distlib.scripts as well to create the check script =
in the build directory? (Yes that's another mkvenv functionality...) On a p=
hone and don't have the docs at hand, so I am not sure. If not, your soluti=
on is good enough.
>
> Apart from this the only issue is the speed. IIRC having a prebuilt .whl =
would fix it, I think for Meson we observed that the slow part was building=
 the wheel. Possibilities:
>
> 1) using --no-pep517 if that also speeds it up?
>
> 2) already removing the sources to qemu.qmp since that's the plan anyway;=
 and then, if you want editability you can install the package with --user =
--editable, i.e. outside the venv

Nope, it's 3 second always and 1.5 even with the wheel.

Maybe replace qemu.qmp with a wheel and leaving PYTHONPATH for the rest?

Paolo

> Paolo
>
>>
>> John Snow (6):
>>   experiment: add mkvenv install
>>   build, tests: Add qemu in-tree packages to pyvenv at configure time.
>>   iotests: get rid of '..' in path environment output
>>   iotests: use the correct python to run linters
>>   iotests: use pyvenv/bin/python3 to launch child test processes
>>   iotests: don't add qemu.git/python to PYTHONPATH
>>
>>  configure                     | 31 +++++++++++++++++++++++++++
>>  python/scripts/mkvenv.py      | 40 +++++++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/linters.py |  2 +-
>>  tests/qemu-iotests/testenv.py | 21 ++++++++++++------
>>  4 files changed, 87 insertions(+), 7 deletions(-)
>>
>> --
>> 2.40.1
>>
>>


