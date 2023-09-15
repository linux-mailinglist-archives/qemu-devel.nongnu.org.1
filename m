Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 328367A1905
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 10:39:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh4L0-0007Hy-9v; Fri, 15 Sep 2023 04:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh4Kr-0007HI-8U
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:37:58 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qh4Kp-0004Mj-FT
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 04:37:56 -0400
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5712b68dbc0so1020784eaf.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 01:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694767074; x=1695371874;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6yW9YAY0+F09Wpw7lIs3Q1PIudBAo+5u5BItTpalfA=;
 b=YDy4o3Te1tO7O/9KA2BL9x2oMgVwWZfzRTJvAkz12pGRCPEkBRXnFhxhcd1iv0i7w7
 6IU07wijmv3euOA476F3YVZIfk/Z977+qQ33SEVwoHjYKen+GIjhV3tPPkZDmgFwmzwt
 lqOJwCLInXDM8jVt4P9/ZnJ5PGvCCFSneugLUNwClKBJBvH9QV5hmSaSK+I7wLSV7Dpp
 cnYEFbJZqZ03KdYLmRyVBWz/7HBmeFtnQ61TOX/D6pP/nF7JLGhXWqAk0ruM9N2D8482
 /WaJgEDfZfXbcaRjfyEOczpL1DPS7dwGHQaIkMOwSzsG6YppM9NSTOb/GCPjdNLmV7mT
 OrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694767074; x=1695371874;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d6yW9YAY0+F09Wpw7lIs3Q1PIudBAo+5u5BItTpalfA=;
 b=KFgqlUB2KZL9Wu184IWYxgUY21sG3aD/WEO61KVKMWVuUFQJiOmYKuopLxsoQ5Xyyk
 xIxRjCvs3Iwm5ojTex9B2nD+/c6bu2PIKYo3QNQkFP47KxfAxSed3nLQ4QKnPMbjk8Ek
 frFt7RAwGuao5OyJy22bdAc4I0zNAFRqzRFovBZEEyetQ6koZ90Pz4pkDhtscdmUmUQi
 s0SaKj312lMP5zE38sYJlVPOLgZRjpiaklzpt5/aVGbcMep8OkBubIJDZfyOPOp2yP2r
 wPCHTH3RhdfhckyfsRXI2TSjTCIwwc9CCrMnyV2k4MpoLMr3w1y+UBCjWldv/EM/cwlz
 p3hA==
X-Gm-Message-State: AOJu0YyQijE2J+TZww5fZzf1BO8GP0693AQ/C4md85kT43CEG19XClFD
 i3MjD8Y+5TEv2bArZCbzWpBToJHMmVjMI+VAWTCtKA==
X-Google-Smtp-Source: AGHT+IGEi0dPBV+JF/IV+SLFGTnDHpknRMF0PNRt68J2ALCZdjGWlnmddyRijsZ8nZoZY3vIowgzPVnr3F/bGgt3QAM=
X-Received: by 2002:a05:6870:d69c:b0:1bb:75af:37b5 with SMTP id
 z28-20020a056870d69c00b001bb75af37b5mr1104828oap.10.1694767073786; Fri, 15
 Sep 2023 01:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-2-mnissler@rivosinc.com> <ZQH/1pRzHhaXbl+E@x1n>
In-Reply-To: <ZQH/1pRzHhaXbl+E@x1n>
From: Mattias Nissler <mnissler@rivosinc.com>
Date: Fri, 15 Sep 2023 10:37:43 +0200
Message-ID: <CAGNS4TYLqUogVTAxR1eBzbukp5YLDHzVJDqEwvp0sxg9dFWogw@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] softmmu: Per-AddressSpace bounce buffering
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, john.levon@nutanix.com, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, stefanha@redhat.com, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=mnissler@rivosinc.com; helo=mail-oo1-xc33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 13, 2023 at 8:30=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Sep 07, 2023 at 06:04:06AM -0700, Mattias Nissler wrote:
> > @@ -3105,6 +3105,9 @@ void address_space_init(AddressSpace *as, MemoryR=
egion *root, const char *name)
> >      as->ioeventfds =3D NULL;
> >      QTAILQ_INIT(&as->listeners);
> >      QTAILQ_INSERT_TAIL(&address_spaces, as, address_spaces_link);
> > +    as->bounce.in_use =3D false;
> > +    qemu_mutex_init(&as->map_client_list_lock);
> > +    QLIST_INIT(&as->map_client_list);
> >      as->name =3D g_strdup(name ? name : "anonymous");
> >      address_space_update_topology(as);
> >      address_space_update_ioeventfds(as);
>
> Missing the counterpart in do_address_space_destroy()?

Of course, thanks for pointing this out.

>
> Perhaps we should assert on having no one using the buffer, or on the
> client list too.

I agree it makes sense to put these assertions, but let me dig a bit
and do some experiments to see whether these hold true in practice.

>
> Thanks,
>
> --
> Peter Xu
>

