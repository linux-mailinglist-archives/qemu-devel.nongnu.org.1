Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D919F70A6C2
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 11:38:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0J1O-0008BD-OL; Sat, 20 May 2023 05:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0J1M-0008B3-Ic
 for qemu-devel@nongnu.org; Sat, 20 May 2023 05:37:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q0J1K-0004jH-LL
 for qemu-devel@nongnu.org; Sat, 20 May 2023 05:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684575421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eHldxrqo61KX3TlPRgI7eW5RCbItJVC3TIvRiuwqKvI=;
 b=Ztf0r7GEZpiPKINiZpHjpGjBvsItI/f8to6STexdwpvUiL5hy2+AL8cwNPnD85DJO2x5YV
 Jjztlpam279idkZQ05pJMeA6omKiLHCu3NGE70oeZUDStA9xwHa6H7DzPjz6+JBrRcd8Az
 1+N/EFd/y12VNmEMJGKJp0NpQPetho4=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-Oo4LQa0MNqywRYJ7zQw37A-1; Sat, 20 May 2023 05:36:58 -0400
X-MC-Unique: Oo4LQa0MNqywRYJ7zQw37A-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-456edcd3990so685980e0c.0
 for <qemu-devel@nongnu.org>; Sat, 20 May 2023 02:36:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684575417; x=1687167417;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eHldxrqo61KX3TlPRgI7eW5RCbItJVC3TIvRiuwqKvI=;
 b=lfqFOb4aboter5IAxBFvl3hrrPoy/XrLs9FMov7TNSzRVrwEBiu3AUz/P/rqwP15Mu
 cR+IokkA+WQHxg++EYrIEPwRaE4gPGEdzSsuStohYOqWgVM0lr5/qFe9Y5Ha3oy2qzZZ
 bOfQr1LI6a9UuTI9Pv/SFD3A7e6dxlzJ3fUw6kEjNmI4xPYjA5adjBiDcGwPYHq5frwh
 eDHR4BGUKOLI3hfyFxY+VWIH6T8BpXF2h/QSs4LjQ89VN7xvExqdha1PVxrRW4LFP2aH
 RiTrj3B5guJ3EIb+9w3QGdNhO8TYQFfLGuAsfBkr79snIMWlpBe1fQZIEJdYQtSAapTY
 DuWg==
X-Gm-Message-State: AC+VfDwSNPywTy3i15B3Zwt6+KU9LLDZMkLWMBbMnNxsC1DxBu3aLZi1
 ZJJq+cc9vRdmFtqQ79tOPKpzn6pSFyQWCsMwmbEWJjs49xGy4aATA+28SFp4JRkFJ4GEs1kFKxR
 tkj4Q6YTba4CnzThrgDyi8pWx1geqf54=
X-Received: by 2002:a1f:5f90:0:b0:453:8a02:8d9 with SMTP id
 t138-20020a1f5f90000000b004538a0208d9mr1560998vkb.11.1684575417467; 
 Sat, 20 May 2023 02:36:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wuCfoFNjudOIHrrx9tzMS+8O2ScrqOoztcvRwpqQY9gIggKfcDYKXmOMNnUyMSKaGzuShcLtrsnBJbcJ2psI=
X-Received: by 2002:a1f:5f90:0:b0:453:8a02:8d9 with SMTP id
 t138-20020a1f5f90000000b004538a0208d9mr1560995vkb.11.1684575417198; Sat, 20
 May 2023 02:36:57 -0700 (PDT)
MIME-Version: 1.0
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
In-Reply-To: <7D7609D5-FAE5-4110-8821-C62904585B9C@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 20 May 2023 11:36:45 +0200
Message-ID: <CABgObfZb7L3-7xrayi2X1pUOHVmsyxj5D8fLg2nTh86Fef1YvQ@mail.gmail.com>
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000057038905fc1cc727"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--00000000000057038905fc1cc727
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il sab 20 mag 2023, 09:25 Ani Sinha <anisinha@redhat.com> ha scritto:

> 40c909f534e3f3cd2 from what I can see. It requires a full QEMU build in
> order to turn on CONFIG_IASL in bios-tables-test. At some point in the
> past, we could just install iasl and rerun the test and it would discover
> iasl in the path if CONFIG_IASL was not defined.
>

So you want CONFIG_IASL to *not* have the full path if you configure with
--iasl=3Diasl?

Paolo


> I have proposed a patch with the title "acpi/tests/bios-tables-test: pass
> iasl path through environment variable=E2=80=9D.
> I have tested possible scenarios and it would satisfy my uneasiness. One
> thing I could not find is how to discover OS environment variable from
> meson.build. From what I could gather, currently it is not supported.
> Hence, when both CONFIG_IASL is passed from the command line and meson
> discovers one of its own, the meson one would be enforced and not the one
> developer passed.
>
>
>

--00000000000057038905fc1cc727
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 20 mag 2023, 09:25 Ani Sinha &lt;<a href=3D"mai=
lto:anisinha@redhat.com">anisinha@redhat.com</a>&gt; ha scritto:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">40c909f534e3f3cd2 from what I can see. It req=
uires a full QEMU build in order to turn on CONFIG_IASL in bios-tables-test=
. At some point in the past, we could just install iasl and rerun the test =
and it would discover iasl in the path if CONFIG_IASL was not defined.<br><=
/blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">So yo=
u want CONFIG_IASL to *not* have the full path if you configure with --iasl=
=3Diasl?</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex">
<br>
I have proposed a patch with the title &quot;acpi/tests/bios-tables-test: p=
ass iasl path through environment variable=E2=80=9D.<br>
I have tested possible scenarios and it would satisfy my uneasiness. One th=
ing I could not find is how to discover OS environment variable from meson.=
build. From what I could gather, currently it is not supported. Hence, when=
 both CONFIG_IASL is passed from the command line and meson discovers one o=
f its own, the meson one would be enforced and not the one developer passed=
.<br>
<br>
<br>
</blockquote></div></div></div>

--00000000000057038905fc1cc727--


