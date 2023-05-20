Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B8170A624
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 09:26:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0GyV-0000ur-9b; Sat, 20 May 2023 03:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q0GyR-0000uZ-Pe
 for qemu-devel@nongnu.org; Sat, 20 May 2023 03:25:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1q0GyQ-000623-CU
 for qemu-devel@nongnu.org; Sat, 20 May 2023 03:25:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684567553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvmyQTicTPBwY4qQHyQIrewW5dI6t1q4/0Ia7WAKUZc=;
 b=Iij1F3QVwCfSANv0XMXOTx8LKtENIi2uH7NEL6kmuGJdDskmhVBkY10k4y9hjOHFCvXY7J
 1mZEpnl6250xsVB+HTyn/He4NYc7Z7mtY7fkHgMaIvr4dHLoVNFeN9sdntNsnDHjhOKowd
 7PO59i4irRPqY8cW6ovusly9ExYSf5I=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-vejbLzkJOoqzUZduMbs1rw-1; Sat, 20 May 2023 03:25:51 -0400
X-MC-Unique: vejbLzkJOoqzUZduMbs1rw-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-64d2f088dc2so1876906b3a.3
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 00:25:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684567550; x=1687159550;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tvmyQTicTPBwY4qQHyQIrewW5dI6t1q4/0Ia7WAKUZc=;
 b=gKyxs7K7hIRx30F06f8fB0cLhdO/4yG840GpimfNbp+WFj8kisNhWZmFV1q0lDk1pp
 y0GQfrbVQWH4BPhOiFw66NEEciEdzZfYrX0ooOHZdtV0vk8Pkm+sX3lZjnyszOzCCIHJ
 iIKOVLMF/cF2g7GLaPnBTe477ihcXicTecG8FKqpp0snCF62XX6sJLSWs3bIEFgjv0o5
 nLELj7zrWikOa0y7zGOxKceTrDWGhwaPIZrPqf5O6aCQ3mZR8O9FAz5AIhlnjJX6HDMO
 BerSIzjhR76G5SOmj7K52YWQXreFEyrG5hycLNR1yHq2reECYEueqjqLDbK2muSIV2Ra
 +idw==
X-Gm-Message-State: AC+VfDz4JKxYxslU9GsuNWmkOGbW2lW5C4pv9/7SJCYw/ZmlrveBedd+
 hN5F+5ZGHK1ZzNFvZ2gfOyJNYhwsdSQh0VqpH+Fevwu/t7eiQazsz96guTpBiCwz2RPVVPemK4t
 fvgfIsDJ8CsxemT6kiyYu6s8=
X-Received: by 2002:a05:6a00:16cd:b0:644:ad29:fd5a with SMTP id
 l13-20020a056a0016cd00b00644ad29fd5amr6469886pfc.21.1684567550542; 
 Sat, 20 May 2023 00:25:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7XUsDalXJzTT9MNmh8xuT+vlNDMKAdCoIgjX/l47EL2tgaSl+DDOKNqBYECeSLm8ywbU2qLg==
X-Received: by 2002:a05:6a00:16cd:b0:644:ad29:fd5a with SMTP id
 l13-20020a056a0016cd00b00644ad29fd5amr6469865pfc.21.1684567550246; 
 Sat, 20 May 2023 00:25:50 -0700 (PDT)
Received: from smtpclient.apple ([115.96.105.135])
 by smtp.gmail.com with ESMTPSA id
 k25-20020aa792d9000000b00649ac17779csm686690pfa.160.2023.05.20.00.25.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 May 2023 00:25:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <CABgObfa3XqZOnSFkty8UqxibXKkqFGeQVT7Wad7YLan8zC2G=w@mail.gmail.com>
Date: Sat, 20 May 2023 12:55:46 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7D7609D5-FAE5-4110-8821-C62904585B9C@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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



> On 19-May-2023, at 10:43 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>=20
> On Thu, May 18, 2023 at 1:02=E2=80=AFPM Ani Sinha =
<anisinha@redhat.com> wrote:
>>> Can we split this variable out to config-test.h maybe?
>>> Then you can reconfigure with a different iasl and QEMU
>>> will not be rebuilt, just the tests.
>>=20
>> TBH, it looks more and more like our previous approach was simple and
>> better before we started tying iasl to meson.
>=20
> What was the previous one? Can you point to the commit that =
complicated things?

40c909f534e3f3cd2 from what I can see. It requires a full QEMU build in =
order to turn on CONFIG_IASL in bios-tables-test. At some point in the =
past, we could just install iasl and rerun the test and it would =
discover iasl in the path if CONFIG_IASL was not defined.

I have proposed a patch with the title "acpi/tests/bios-tables-test: =
pass iasl path through environment variable=E2=80=9D.
I have tested possible scenarios and it would satisfy my uneasiness. One =
thing I could not find is how to discover OS environment variable from =
meson.build. =46rom what I could gather, currently it is not supported. =
Hence, when both CONFIG_IASL is passed from the command line and meson =
discovers one of its own, the meson one would be enforced and not the =
one developer passed.



