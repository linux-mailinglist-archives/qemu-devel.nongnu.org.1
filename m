Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06D709DA8
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 19:14:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q03fg-0001Yh-LG; Fri, 19 May 2023 13:13:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q03fe-0001YB-37
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:13:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q03fc-0007Fa-Eb
 for qemu-devel@nongnu.org; Fri, 19 May 2023 13:13:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684516415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0txiS8fhV5a6QvydQ29+HWYchHBBihIsm9ao7q2q74=;
 b=HkRWAPtRwANOPx5tXzRVm1yAxv7CvwnXsmdTJ0Sro/jTHkW4a8DMn566xPLRL8rH37gXmH
 eJvQYHTa2fWr/nZxUHbQSLnI4JSF26e3A5sbEdsaiVcssgVeyNRh1TnovUYxigrCGay0Vj
 XxJE726CY0u3BOVtgCemeIPhEos0Q/I=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-gPjjX-A0MFOklhuo1piowg-1; Fri, 19 May 2023 13:13:33 -0400
X-MC-Unique: gPjjX-A0MFOklhuo1piowg-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-772cb9bedeaso1098894241.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 10:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684516413; x=1687108413;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0txiS8fhV5a6QvydQ29+HWYchHBBihIsm9ao7q2q74=;
 b=jpT1oyUj3t8H99wTeeJRuVRAzCduoUxrw6OfdKyclZgDq8xwB0ynlkFl51I+VEOFEQ
 9HhitR2If5rf08iRGvGJS0wlzdkp2J+D7HvC24RQu2YjmI6rZoWAqsV31dq7CKz5xbE5
 Ms8an/zJY6nzATnCyXu0Qmo5bJtNbw+JoImWNEbJisO1FbwAD++ALNfn1ObgnkxfhvIS
 kWq/zfRpnpLcBzPyg3O2hYJwUmpVRa7hm8tSj7hexXcoNhQPxkATpROkYh0OJee9/QI1
 mLPY9at2Yl5eqknU+TBuGz2dD9VoY48dipYKs8fv8e1xCzT932r/Y2JWRAMYIxofhMoI
 F05w==
X-Gm-Message-State: AC+VfDwxjZW91pjdurbyAzxvNObbUZ9xAdZv3wZab9HJoX0hX84Y6/XX
 TlceSVgVAlATFWrJcFBjCa1fXJFifBojtX9p9L4Z/jO4Jc+s/Ey3PQ9nWgnZIiU5/FDlSZaCCwl
 2Q3vLtkzZdU9rAyPiGB8s6r/HrqpcCR8=
X-Received: by 2002:a1f:5c50:0:b0:435:b4a5:d3c0 with SMTP id
 q77-20020a1f5c50000000b00435b4a5d3c0mr1275868vkb.10.1684516413052; 
 Fri, 19 May 2023 10:13:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KOb+T06C/8IGN2TI1+b2T/u5DoEFa2P1B9d5jz1Owzr4XwLNPMFyglMGn9wi63TPslWC7FAv2ktgBw9EEm50=
X-Received: by 2002:a1f:5c50:0:b0:435:b4a5:d3c0 with SMTP id
 q77-20020a1f5c50000000b00435b4a5d3c0mr1275862vkb.10.1684516412797; Fri, 19
 May 2023 10:13:32 -0700 (PDT)
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
In-Reply-To: <d69e10b7-597d-913f-eb90-ed59b5b669f7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 19 May 2023 19:13:21 +0200
Message-ID: <CABgObfa3XqZOnSFkty8UqxibXKkqFGeQVT7Wad7YLan8zC2G=w@mail.gmail.com>
Subject: Re: [PATCH] acpi/tests/bios-tables-test: add an environment variable
 for iasl location
To: Ani Sinha <anisinha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

On Thu, May 18, 2023 at 1:02=E2=80=AFPM Ani Sinha <anisinha@redhat.com> wro=
te:
> > Can we split this variable out to config-test.h maybe?
> > Then you can reconfigure with a different iasl and QEMU
> > will not be rebuilt, just the tests.
>
> TBH, it looks more and more like our previous approach was simple and
> better before we started tying iasl to meson.

What was the previous one? Can you point to the commit that complicated thi=
ngs?

Paolo


