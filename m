Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7457921EB
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 12:41:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdTTN-0003Jd-Qf; Tue, 05 Sep 2023 06:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdTTL-0003J8-QM
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:39:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qdTTJ-0003cj-Ng
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 06:39:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693910388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=10LXzSKjMxKDbwMKgRlGq+JQNiLiEaI6Y7ZLU5/8k38=;
 b=fWxaW+smFJ22gTfR0cXbq2txMFMO3A6bBU9P7gFW6QXQ2cN0XAFWwz0OQRxYlNfcOCLf7N
 jtEmxhUPstkaz3jAT0L493mYKKb5NuDAaWFwKKDiswAEbUU1p384S85RlonP8SSErTiLI2
 hvMqPm6uHw4KhvMwMjwXhTWkYkgPVyo=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-Lw-JU-siMd6-RIs2YsVu4g-1; Tue, 05 Sep 2023 06:39:46 -0400
X-MC-Unique: Lw-JU-siMd6-RIs2YsVu4g-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7a28090eb26so861156241.1
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 03:39:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693910386; x=1694515186;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=10LXzSKjMxKDbwMKgRlGq+JQNiLiEaI6Y7ZLU5/8k38=;
 b=KU2DdYiPrGRj6VJnljSLVBcCtxBFAQvaPAvwQtW8rmuhzyKEHuBMp9KMHTbZ4CnZxi
 eGYX4dToDfx3cKVFf354ybkd84A432Mmda4hF2b3o4kZ7IiKFoP4LdqMqCqDUURiLTNE
 fUj3R+qT8RC6T/d1V0l9jk5kKPn+7yq+3GKnEz5OR4mzmiPrFBXY9Szs+F6RDdPXIEsh
 9FpvDjr6OPeB7DMB43xbd3cD+oV+WKCY9LvbsfDKq2lnts9VSwlUcJJJG9wV9Tj07laY
 cPdwf1E8tJUWue2fsek//KwkwqUw5nSdb+o37GiSmpFAGmE51sq+WrmFaNpAQfdN/aSG
 QZxg==
X-Gm-Message-State: AOJu0YwTeNzo28M2A7VfDhL6U/yX+trDLA2MsP4xlNknShp1YDO8kaYc
 FZF1cq3LA/wUkjEyioPz3Sp4TqkTV9dOzBuwe9FMslffQpXDz5JPQP/geLCxn68hmgvVFgr32g7
 QWSji1GOh0TsNh0CiUsB/LLkLQ7dPdHQ=
X-Received: by 2002:a05:6102:2823:b0:44d:4160:4f8a with SMTP id
 ba3-20020a056102282300b0044d41604f8amr11421571vsb.12.1693910386033; 
 Tue, 05 Sep 2023 03:39:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECzgZJet6MLpzURmw3x5Q5LWJPxZ/dAuwsXVRVRVLpwzVa172wcM7msx0Xay1jMq3pmH9xiECJGNLb60NBwOw=
X-Received: by 2002:a05:6102:2823:b0:44d:4160:4f8a with SMTP id
 ba3-20020a056102282300b0044d41604f8amr11421561vsb.12.1693910385779; Tue, 05
 Sep 2023 03:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <eac059f4-72e2-d1fe-27b2-9657d1777e45@ventanamicro.com>
In-Reply-To: <eac059f4-72e2-d1fe-27b2-9657d1777e45@ventanamicro.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 5 Sep 2023 12:39:33 +0200
Message-ID: <CABgObfYPYH=78UV3gk1m7xv8_=F7KwVxyj9J=uHZ8fCAA6FHmA@mail.gmail.com>
Subject: Re: 'check-avocado' fails after c03f57fd5b ("Revert "tests: Use
 separate ...")
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 1, 2023 at 4:36=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> FWIW I am unable to run 'check-avocado' after commit c03f57fd5b ("Revert =
"tests: Use
> separate virtual environment for avocado"). The error being thrown:
>
> [20/20] Generating docs/QEMU man pages with a custom command
>    VENVPIP install -e /home/danielhb/work/test/qemu/python/
> /home/danielhb/work/test/qemu/build/pyvenv/bin/python3 -B python/scripts/=
mkvenv.py ensuregroup --online /home/danielhb/work/test/qemu/pythondeps.tom=
l avocado
> mkvenv: checking for avocado-framework(>=3D88.1, <93.0)
> mkvenv: checking for pycdlib>=3D1.11.0
>    AVOCADO tests/avocado
> /home/danielhb/work/test/qemu/build/pyvenv/bin/python3: No module named a=
vocado.__main__; 'avocado' is a package and cannot be directly executed
> make: *** [/home/danielhb/work/test/qemu/tests/Makefile.include:139: chec=
k-avocado] Error 1

Can you run it with "V=3D1" and also "cat
/home/danielhb/work/test/qemu/build/pyvenv/bin/avocado" please?

Thanks,

Paolo


