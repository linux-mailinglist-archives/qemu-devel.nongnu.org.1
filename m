Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0B970A8B3
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 17:14:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0OGk-0007CE-CW; Sat, 20 May 2023 11:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q0OGg-0007B9-7q
 for qemu-devel@nongnu.org; Sat, 20 May 2023 11:13:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q0OGc-00063b-JC
 for qemu-devel@nongnu.org; Sat, 20 May 2023 11:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684595589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WuIe/0ecEr5c79Oo8cM4X9T4PJOVhfHNfC6fTL1Ps18=;
 b=dawVWqrAC0MvacePUm9a5C6C1fYoZsrB2NbsL3cX866Q8RlRBq/mUGhu4CP38jrmgnrIgr
 uauH/56Jil8RBaHnH+L1OdfKCgtxsIxnt43ipMYELgJAdcDvVh7AG6OfDipi7HbyY+9PEW
 QGmX5CGR2p4rB2vVtiD0Q+S5GkE5sko=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-RyRk6GOaMRKTwA7_LxSaPw-1; Sat, 20 May 2023 11:13:07 -0400
X-MC-Unique: RyRk6GOaMRKTwA7_LxSaPw-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1ae8ed0a9dfso5502005ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 08:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684595586; x=1687187586;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WuIe/0ecEr5c79Oo8cM4X9T4PJOVhfHNfC6fTL1Ps18=;
 b=dr16BQ7Xfv3Dx5m0jGh8C1cQIWYQe+cbo+bxVuPi8oPmvc0LcC0qjI90F7+8iIViyI
 CoQV02Gb3JsAFj9YjN78tWzY8M+RvTmxmMQinj99u4saQXlXTGrfRSqvjZgDWeo5S9of
 Co8LR+RwOuubxXJVwDryY9FaO13OfB7ndrYXH8M8OOz8ZmESamZ+/Cg05gj+E7LJM4RQ
 ngOOjYKSuiW1JCOvmLePLzpd1x27aqn4f8N7VrH62ftSzkzWnSDr7x+WQATbicxvB4Cs
 8ezUvMpDnorq712yatEa7qyoa9clpZvvT8ciwvPaLHlLhRiJArpZTbqq2JqSkhrRBvS8
 hevQ==
X-Gm-Message-State: AC+VfDxsPY6z8Y6Nyc9YAvazGX5sSuplVfFySp3wFO3BjIvlZ5aFD7Io
 HqbwW0FqGumCVMZa2FWK43SHFRyKvg6oV9g/+ksAP2WRT5ojbBkxw47Slf65re0byGmtam/8pRO
 HwkI/FxAEq0o2RUI=
X-Received: by 2002:a17:902:d501:b0:1ae:2e0d:b38c with SMTP id
 b1-20020a170902d50100b001ae2e0db38cmr7013262plg.12.1684595586459; 
 Sat, 20 May 2023 08:13:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4SbcJbOFKC6eEX4rMZQhTN6IoFACTnuZmFHDac04jv76uaHZTW32dDBpaQnBAEhb6boLMR9g==
X-Received: by 2002:a17:902:d501:b0:1ae:2e0d:b38c with SMTP id
 b1-20020a170902d50100b001ae2e0db38cmr7013243plg.12.1684595586118; 
 Sat, 20 May 2023 08:13:06 -0700 (PDT)
Received: from smtpclient.apple ([115.96.105.135])
 by smtp.gmail.com with ESMTPSA id
 ik24-20020a170902ab1800b001a525705aa8sm1647506plb.136.2023.05.20.08.13.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 May 2023 08:13:05 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CABgObfZb7L3-7xrayi2X1pUOHVmsyxj5D8fLg2nTh86Fef1YvQ@mail.gmail.com>
Date: Sat, 20 May 2023 20:43:01 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <31DC243F-BA0D-48B8-9CC3-43982DDB9535@redhat.com>
References: <20230517101523-mutt-send-email-mst@kernel.org>
 <B6AD0FB1-CF05-4B4C-B58D-279422895E4D@redhat.com>
 <20230517103522-mutt-send-email-mst@kernel.org>
 <ED522229-5A71-40C2-AF2C-5D921B0B5D54@redhat.com> <87zg63m18g.fsf@linaro.org>
 <20230517112347-mutt-send-email-mst@kernel.org> <87r0rflzd4.fsf@linaro.org>
 <20230517120710-mutt-send-email-mst@kernel.org> <87ilcqnckm.fsf@linaro.org>
 <C2CC04A8-F0F1-4360-ABF0-1F8DF7768AB1@redhat.com>
 <20230518063559-mutt-send-email-mst@kernel.org>
 <d69e10b7-597d-913f-eb90-ed59b5b669f7@redhat.com>
 <CABgObfa3XqZOnSFkty8UqxibXKkqFGeQVT7Wad7YLan8zC2G=w@mail.gmail.com>
 <7D7609D5-FAE5-4110-8821-C62904585B9C@redhat.com>
 <CABgObfZb7L3-7xrayi2X1pUOHVmsyxj5D8fLg2nTh86Fef1YvQ@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



> On 20-May-2023, at 3:06 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>=20
> Il sab 20 mag 2023, 09:25 Ani Sinha <anisinha@redhat.com> ha scritto:
> 40c909f534e3f3cd2 from what I can see. It requires a full QEMU build =
in order to turn on CONFIG_IASL in bios-tables-test. At some point in =
the past, we could just install iasl and rerun the test and it would =
discover iasl in the path if CONFIG_IASL was not defined.
>=20
> So you want CONFIG_IASL to *not* have the full path if you configure =
with --iasl=3Diasl?

Iasl is *not* a mandatory tool to run that test. So we do not want any =
configure option at all. It is absolutely not needed and makes the =
entire workflow more burdensome.
=20
>=20
> Paolo
>=20
>=20
> I have proposed a patch with the title "acpi/tests/bios-tables-test: =
pass iasl path through environment variable=E2=80=9D.
> I have tested possible scenarios and it would satisfy my uneasiness. =
One thing I could not find is how to discover OS environment variable =
from meson.build. =46rom what I could gather, currently it is not =
supported. Hence, when both CONFIG_IASL is passed from the command line =
and meson discovers one of its own, the meson one would be enforced and =
not the one developer passed.
>=20
>=20


