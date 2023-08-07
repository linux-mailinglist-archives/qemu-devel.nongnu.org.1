Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D7771DDF
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 12:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSxME-0001pp-Bx; Mon, 07 Aug 2023 06:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qSxM7-0001pZ-Sr
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 06:20:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qSxM5-0002RQ-Qd
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 06:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691403652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMAdsWykZ/EpMQPlZRWke+SKdDATzUw0SAMAYx/BDHU=;
 b=IbZhbEqp0FZx0BfI3qaeXYy5lLVYHiij9tlSM1k6GG5xfOwdASmQOMWcde7tkdc3FOCs/q
 trPVRnNLjQhFT0Xa3vaifAWeBRInlp8xRf8IbriYvI7mFbX69aP4Wnr5G6giCDAFYYtfI9
 YTEWkbj7hkvzc02Gh+iia3cJDF2wJK8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-XBdoQxZpO0SUts5JexUh2A-1; Mon, 07 Aug 2023 06:20:51 -0400
X-MC-Unique: XBdoQxZpO0SUts5JexUh2A-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4fe356c71d6so4139657e87.1
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 03:20:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691403649; x=1692008449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZMAdsWykZ/EpMQPlZRWke+SKdDATzUw0SAMAYx/BDHU=;
 b=PV1tA3vwf8v/uhBoWJl8RK1dM2iKOacXSmGLRPiI6GP2NtrQzAE+EvQH0fWxrMRZXm
 fBmHzMwCEMsppca82dGVf0V5NCCQFEjX/XSnRhFVlLKvsvvmJvFREuRHwsSlX1QodEKR
 fDeN0eIICiXORr23aeKXeDy9Hu6jtG1N0y7uWoTYyVAPJWalRpzEYE+lGe7xn9olB6PI
 xMqPG/qiLe/Tm5gME9poD8Q0pEz26Ago4ozsot4kXAQ8AgsxxeZMul2Z2wMssYyWrjZP
 DeI2PQGG93Oxy7TxFtmX6inY+inbSGEiaz4z3DFywDENEPBOB/JYoL/R9g2j7bz5j+D6
 czGw==
X-Gm-Message-State: AOJu0YycnyUXZkRd5VvqLGfK2o4iNd9wuYTA+zo1Uufjx/eI82+XAJ87
 mieLKDCAzAfcqDyGZelEbEkKdlq8XlQ2BdRUPCLMxMUe0bami66flf15Y/6p25bLTki3k5urD7o
 5WlgVVKJ6ERmSRoM=
X-Received: by 2002:a05:6512:2809:b0:4fb:9129:705b with SMTP id
 cf9-20020a056512280900b004fb9129705bmr6585241lfb.6.1691403649552; 
 Mon, 07 Aug 2023 03:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg2Kpn6LAmYwDnagsb3o4Rg45hvn4Uv85AjbCHYDqQ/ur+uvtmRxfYCkVZtab+VyvP9vFHdg==
X-Received: by 2002:a05:6512:2809:b0:4fb:9129:705b with SMTP id
 cf9-20020a056512280900b004fb9129705bmr6585225lfb.6.1691403649165; 
 Mon, 07 Aug 2023 03:20:49 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 l13-20020a1709065a8d00b00982a352f078sm2323891ejq.124.2023.08.07.03.20.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 03:20:48 -0700 (PDT)
Date: Mon, 7 Aug 2023 12:20:47 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org, "Michael S.
 Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 06/11] tpm_crb: move ACPI table building to device
 interface
Message-ID: <20230807122047.7323ad35@imammedo.users.ipa.redhat.com>
In-Reply-To: <dc4fa093-3940-8fe8-057b-789243648765@linux.ibm.com>
References: <20230714070931.23476-1-j@getutm.app>
 <20230714070931.23476-7-j@getutm.app>
 <c3e07358-0d07-ffdc-6dbf-aab763ef92be@linux.ibm.com>
 <20230717154249.3b11f50a@imammedo.users.ipa.redhat.com>
 <CA+E+eSB4KkTP7mkMm4VWb6DE3nhSOOB7O9ibtusAW4KKjqQakg@mail.gmail.com>
 <dc4fa093-3940-8fe8-057b-789243648765@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, 1 Aug 2023 15:38:32 -0400
Stefan Berger <stefanb@linux.ibm.com> wrote:

> On 7/31/23 23:02, Joelle van Dyne wrote:
> > On Mon, Jul 17, 2023 at 6:42=E2=80=AFAM Igor Mammedov <imammedo@redhat.=
com> wrote: =20
> >>
> >> On Fri, 14 Jul 2023 13:21:33 -0400
> >> Stefan Berger <stefanb@linux.ibm.com> wrote:
> >> =20
> >>> On 7/14/23 03:09, Joelle van Dyne wrote: =20
> >>>> This logic is similar to TPM TIS ISA device. Since TPM CRB can only
> >>>> support TPM 2.0 backends, we check for this in realize.
> >>>>
> >>>> Signed-off-by: Joelle van Dyne <j@getutm.app> =20
> >>>
> >>> This patch changes the order of in which the ACPI table elements are =
created but doesn't matter and also doesn't seem to upset ACPI test cases f=
rom what I saw: =20
> >>
> >> it seems we do have tests for TIS only (which I added when I was refac=
toring it to TYPE_ACPI_DEV_AML_IF)
> >> perhaps add a test for CRB before this patch a follow process describe=
d in bios-tables-test.c
> >> for updating expected blob =20
> > I read the file and looked at the commits for TIS tests but I'm not
> > sure I understand how it works. At what point do I specify that the
> > CRB device should be created for the test? =20
>=20
> For me it would be a bit of trial an error as well. So here's my best gue=
ss:
[...]
> Then you run the tests again then it should create those files with the A=
CPI data and you copy them
> to their destination (like in ca745d2277496464b54fd832c15c45d0227325bb) a=
nd remove the changes from
> tests/qtest/bios-tables-test-allowed-diff.h and that becomes your 3rd pat=
ch. Once you run the tests
> again with the 3rd patch there should be no more complaints about ACPI re=
lated changes.

ACPI tables update procedure as described bios-tables-test.c looks more or =
less
reasonable to me (heavily biased view) for someone else to follow. It shoul=
dn't
be 'trial an error'. If something is unclear in the process, lets improve
description (while your mind is still not poisoned by knowledge how it work=
s).=20

Here is latest patches that one can use as a model for changing ACPI tables.
45d9d318c8 tests: acpi: x86: whitelist expected blobs
44d975ef34 x86: acpi: workaround Windows not handling name references in Pa=
ckage properly
6e510855a9 tests: acpi: x86: update expected blobs

> Since CRB ACPI tests are not enabled right now you can add these patches =
somewhere in the middle of
> the series or also at the end.
>=20
>=20
> I hope this helps.
>=20
>     Stefan
>=20


