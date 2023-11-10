Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 291A57E7A31
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 09:35:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1MyB-0002vl-3V; Fri, 10 Nov 2023 03:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1My8-0002vY-UH
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:34:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r1My6-0002NV-RY
 for qemu-devel@nongnu.org; Fri, 10 Nov 2023 03:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699605260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0c8lV/CwJUltO4mMUZwy6gRGyBsjYX+/PI24ygBMJkk=;
 b=CyqhIAJ1BFIoH08MzEzQSjD7t5bmCy/JO18NL9et75JtwrwgN2fon0q8HhU2C7YHJTyr7m
 HB45Ug4PpEnS6HjUB7zf0YHJzOnNjYj2DePiDtcXf4qQUHYY1KceAc5RavEr910/Om0i5f
 79jhH4v8lPenS7GAmLCdGsxm/TYh0Os=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-PenQMtSTMmm987m1PCE-iA-1; Fri, 10 Nov 2023 03:34:16 -0500
X-MC-Unique: PenQMtSTMmm987m1PCE-iA-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7b9b231936dso613447241.0
 for <qemu-devel@nongnu.org>; Fri, 10 Nov 2023 00:34:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699605256; x=1700210056;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0c8lV/CwJUltO4mMUZwy6gRGyBsjYX+/PI24ygBMJkk=;
 b=N3Qgim3BfPcZoTWjrAWUu9a0T7sI2WtoQrlDh41xpnmN/1OS4XZJZ25yEVwaiRWA9Z
 w7SuAuBCqlpVAN6GJDL43/dKAkIyugWNYf0VKYFS984NruaYV6UX++UAORNOe6j4RS8G
 IHIkI36JmdqvUC7TZVyRY7z2lSSjmkv4mbwQCrGEJNWhIfhJ2O4B1nC6PHl1aHJ/aar3
 HS53Asl0A3svIbT5dA5h+u5TKaEcE+glT1U/vIW7/+nA6yzHoCU8UVEL9Ed3KrucnwqG
 COA0cC8olpaCE5wOywsucUgxiXFVXaazePD/s4qcg/Lkn9gustgPwUSNEMTwArHwKf+Y
 4rgQ==
X-Gm-Message-State: AOJu0YwWq26k8fJTjSZ6QrUDOUO4Is2M0kK8qNEf7d6qHvkBaM49lbfJ
 Hx0M3Y33BzSWjrqVQMT12N0dDW5RH6y+dzaDzoglxymbZwikKD5hDhcdykFlr6L1bpWyE4bmf19
 LVyA4ojKVqip0DckWpORH/VDruj/t3AU=
X-Received: by 2002:a67:f551:0:b0:45d:96e0:c2e4 with SMTP id
 z17-20020a67f551000000b0045d96e0c2e4mr6939941vsn.18.1699605256389; 
 Fri, 10 Nov 2023 00:34:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFShh2Q2j8Dj1lQN4ljjPK0ypuEwAjDQQhjbX0Ci3ZGMeEgGUnPnfkkAVgWRR/N6kBe7Hx6rVsd+pCCtFYlzBE=
X-Received: by 2002:a67:f551:0:b0:45d:96e0:c2e4 with SMTP id
 z17-20020a67f551000000b0045d96e0c2e4mr6939928vsn.18.1699605256144; Fri, 10
 Nov 2023 00:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20231109160504.93677-2-philmd@linaro.org>
 <20231109170144.848401-1-pbonzini@redhat.com>
 <CAFn=p-aVGqK3ze3uHr0X1y07HU68pKr6TDBHDw9U1AQJV9KhQw@mail.gmail.com>
 <7ed360eb-fe8c-d77e-d151-067ecbb41cc0@eik.bme.hu>
In-Reply-To: <7ed360eb-fe8c-d77e-d151-067ecbb41cc0@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 10 Nov 2023 09:34:04 +0100
Message-ID: <CABgObfbzWz4f9TK1__PPNaorbeTeS-FArtLGf=c5m2U2U9sdnw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] buildsys: Bump minimal meson version required to
 v1.2.3
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Beraldo Leal <bleal@redhat.com>, Rene Engel <ReneEngel80@emailn.de>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 9, 2023 at 11:00=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
> So these are packaged with the source. I did not know that. Now I get wha=
t
> you mean by s/downolads/installs/ in your reply. But then this is disable=
d
> by --disable-download but actually downloading avocado isn't? Confusing.

Yes, that's mostly historical because avocado didn't use mkvenv.py.
I'll fix it.

Paolo


