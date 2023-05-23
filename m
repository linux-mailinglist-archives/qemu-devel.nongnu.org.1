Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FBC70E0BA
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 17:40:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Tlo-0001Ps-5u; Tue, 23 May 2023 11:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1Tlh-0001Ip-6G
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:17:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1q1Tlf-0007Lc-Ky
 for qemu-devel@nongnu.org; Tue, 23 May 2023 11:17:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684855062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2zWKsYY5ZPJ6055j7aHaA7boCYcVDRDNZ31oucUAOYQ=;
 b=WjP2xiLat3+oAeQQceNaJhga2vUytJEy6TIJGmrZ/KU8CVzbixHPsfady7ocNfoZv5U1vs
 q1AS/+qtcVhxMNag171JMyI+prZY8nJ5GbebNUMGRx5c+LGr3cdJjNYg5z6zLL6I9CBO57
 xXy9tRBW/wYcTZp9qjL6ktuNdNHAalw=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-7QyzXTQiMI6SE0hO3i0qUw-1; Tue, 23 May 2023 11:17:41 -0400
X-MC-Unique: 7QyzXTQiMI6SE0hO3i0qUw-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7837efeb6a1so5934121241.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 08:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684855057; x=1687447057;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2zWKsYY5ZPJ6055j7aHaA7boCYcVDRDNZ31oucUAOYQ=;
 b=k58vu2dW0YVDa2jDGDrz3NLfUn9j1JJf+XA7VYq6g2VT0Rx8xxuYe2rpCbDe8ZuhA2
 +BVcbi6cZIxlOWcbPuLo2HnPzUkLXkpWOc2rilp3udWnEUWkCd/fIl+q4LH0+M4cd8NK
 WU/aiNQQXC4RYy5YdApowi3tMV/Z3hF1p6FedObdvIxpsirTyw2h7zgg2CorOg1+luI0
 HttzwSfzKDIDOktkGCX9wCisaimFzZcdpkn9GUoC6ClQyE4R1/VS/GbX/m1sjFKxOOMM
 +RTt+F9ZctGYoYlo36R48l+2wLzGFvu3na9/jr2JmU83sbZNvzsfv6pDoi+k0ZkzRs3K
 UhfA==
X-Gm-Message-State: AC+VfDz03/uJhJezvCm0irCTZRPFsc4wtXdsbw6A793cEOJ2qRbpI5LZ
 v6nyD04CI0fH9Uftk4rksDpHq1AJCZKHRmvvFgdRj8EcWejHtSSWYx+s6ECVTBxYbhEtE28J447
 tPoUL6+Q9TdpTf3PNVHg5+DyuO8bBRBE=
X-Received: by 2002:a67:ed51:0:b0:40e:5d46:d297 with SMTP id
 m17-20020a67ed51000000b0040e5d46d297mr4238894vsp.17.1684855057627; 
 Tue, 23 May 2023 08:17:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4cu6kJQIk9mPT/UJr/tREvkZX9ROA1YnqGqHUH2uiET1V1R04tgxkle9UA9R1v9McH5vfJrMWazq2qYRjZEzE=
X-Received: by 2002:a67:ed51:0:b0:40e:5d46:d297 with SMTP id
 m17-20020a67ed51000000b0040e5d46d297mr4238880vsp.17.1684855057364; Tue, 23
 May 2023 08:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230508141813.1086562-1-mcascell@redhat.com>
 <CAJ+F1CK2V22PMYP4PQwH+VYKhR32GKxFK5eRODE928iu3LVodA@mail.gmail.com>
 <fcf99624-9a48-6760-a28d-bb88bce6572f@linaro.org>
 <ZGx0ylB10aLWchuf@redhat.com>
 <8a9c7803-5c1c-3e68-6506-14eae205d11e@linaro.org>
 <CAA8xKjUN+Ru5h65YoTDg0trSUZg=L6iD5HF2AKNv-3wAt+ZtHg@mail.gmail.com>
 <b1f5c418-9b1a-4f38-3611-3d355e769b1b@linaro.org>
In-Reply-To: <b1f5c418-9b1a-4f38-3611-3d355e769b1b@linaro.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Tue, 23 May 2023 17:17:26 +0200
Message-ID: <CAA8xKjXb=89jPRPpOSR1G8eX6hrWgqW4+T==7NVMaNeJZNEiZA@mail.gmail.com>
Subject: Re: [PATCH] ui/cursor: incomplete check for integer overflow in
 cursor_alloc
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, 
 qemu-devel@nongnu.org, kraxel@redhat.com, jacek.halon@gmail.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
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

On Tue, May 23, 2023 at 4:07=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 23/5/23 14:57, Mauro Matteo Cascella wrote:
> > On Tue, May 23, 2023 at 10:37=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org> wrote:
> >>
> >> On 23/5/23 10:09, Daniel P. Berrang=C3=A9 wrote:
> >>> On Mon, May 22, 2023 at 08:55:02PM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> >>>> On 9/5/23 09:13, Marc-Andr=C3=A9 Lureau wrote:
> >>>>> Hi
> >>>>>
> >>>>> On Mon, May 8, 2023 at 6:21=E2=80=AFPM Mauro Matteo Cascella
> >>>>> <mcascell@redhat.com <mailto:mcascell@redhat.com>> wrote:
> >>>>>
> >>>>>       The cursor_alloc function still accepts a signed integer for =
both
> >>>>>       the cursor
> >>>>>       width and height. A specially crafted negative width/height c=
ould
> >>>>>       make datasize
> >>>>>       wrap around and cause the next allocation to be 0, potentiall=
y
> >>>>>       leading to a
> >>>>>       heap buffer overflow. Modify QEMUCursor struct and cursor_all=
oc
> >>>>>       prototype to
> >>>>>       accept unsigned ints.
> >>>>>
> >>>>>       Fixes: CVE-2023-1601
> >>>>>       Fixes: fa892e9a ("ui/cursor: fix integer overflow in cursor_a=
lloc
> >>>>>       (CVE-2021-4206)")
> >>>>>       Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com
> >>>>>       <mailto:mcascell@redhat.com>>
> >>>>>       Reported-by: Jacek Halon <jacek.halon@gmail.com
> >>>>>       <mailto:jacek.halon@gmail.com>>
> >>>>>
> >>>>>
> >>>>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com
> >>>>> <mailto:marcandre.lureau@redhat.com>>
> >>>>>
> >>>>> It looks like this is not exploitable, QXL code uses u16 types, and
> >>>>
> >>>> 0xffff * 0xffff * 4 still overflows on 32-bit host, right?
> >>>
> >>> cursor_alloc() will reject 0xffff:
> >>>
> >>>       if (width > 512 || height > 512) {
> >>>           return NULL;
> >>>       }
> >>
> >> I hadn't looked at the source file (the 'datasize' assignation
> >> made me incorrectly think it'd be use before sanitized).
> >>
> >> Still I wonder why can't we use a simple 'unsigned' type instead
> >> of a uint32_t, but I won't insist.
> >
> > I can send v2 with s/uint32_t/uint16_t/ if you think it's a relevant ch=
ange.
>
> Specifying the word size doesn't really add any (security) value IMHO.

No security benefit, I know, it just seems more reasonable given what
Gerd said about 512x512 sprites.

> I'll stop bikeshedding here.
>
> Regards,
>
> Phil.
>
--
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


