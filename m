Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D85ED7BAF00
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 00:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoXDu-0006zf-EY; Thu, 05 Oct 2023 18:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoXDs-0006zX-E2
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 18:53:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qoXDq-0006f4-LC
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 18:53:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696546413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8NYzpTuQO8F++7Ns28j0NWkE5L9debtnUpbpSEICQg=;
 b=U2xJFyUJ3MmvGJ3JoaHzS+0z8P+eAxkSyIivBgYMqw7AdDK5MYo3Oqin8QFMI4ugb8UP2x
 FLGMTqgB1Z+sWC4dH6AmxZQb0VEYrCHHRcdU/rDi3ZLU15vDYffELq3XBe943I0wgWm4hR
 4pj2IqLRFYWvPpGl/EAgmOiPm2UqDpQ=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-Ai14sKLNMTud-LqB3Cv0Qg-1; Thu, 05 Oct 2023 18:53:32 -0400
X-MC-Unique: Ai14sKLNMTud-LqB3Cv0Qg-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7a8709084a0so618135241.2
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 15:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696546407; x=1697151207;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8NYzpTuQO8F++7Ns28j0NWkE5L9debtnUpbpSEICQg=;
 b=pUHdFodzRRai6tX1yI+kn7OYh9UUoUW1on5e4ELkUFPyUpkq1ke5aS3Nx60e/tObGd
 oSxjfS58AJLfqsTJ5W0/Y3sc7JuC4zMYJpsG6B2dJCdDXEvnivVKKb2a/AMqp1RkkZlp
 KJ1BTL00eE8fjZdgdhqKCsCU8Gye3x2ma69ifvZ8NeGQ/KqP508LSDUp76adSIx1c4ou
 1sWhAo/Rsip0NsqBLXrXcZ2LDb2aQUgBRWuChyTut2JAhD/HY3f0nC1sjzu1ByqZxzua
 /bAcD3p7b4jiBr+qeBj9zvvE3FJZ6ReMo3Wf+2oWYoxxtQnVZkFs3m02wI4nRWDpQNlL
 7oYw==
X-Gm-Message-State: AOJu0Yx62sqiR4FP+pfHBwxTAssgvbh3UV8rekBXqU22VAlEnatTYNuQ
 KePvL1CjfIex4GeYLlDVZ0CYU3kQVrImfAqBVHmJKzZJsoMLDtM5gwUCRyULPfUaH19j6R5+8Sz
 zoa/4P8/KmJX6cuiUsu5vG0i1fsHiY3g=
X-Received: by 2002:a67:d099:0:b0:44d:5053:11ce with SMTP id
 s25-20020a67d099000000b0044d505311cemr6192181vsi.19.1696546407368; 
 Thu, 05 Oct 2023 15:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9MOH6NVf37KrHkCbRBHKcBwXONCo9RdatN+HicNRVsXPSughzsTUMrFvvy4N+HcVtP0FESlENZtMkjJmv1Ts=
X-Received: by 2002:a67:d099:0:b0:44d:5053:11ce with SMTP id
 s25-20020a67d099000000b0044d505311cemr6192174vsi.19.1696546407128; Thu, 05
 Oct 2023 15:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231005140326.332830-1-vsementsov@yandex-team.ru>
In-Reply-To: <20231005140326.332830-1-vsementsov@yandex-team.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 6 Oct 2023 00:53:15 +0200
Message-ID: <CABgObfbpt3ci2Wu8pVzdWgG2Y1PfkWPy73aC8VRgLSVvLLFF5w@mail.gmail.com>
Subject: Re: [PATCH v2] coverity: physmem: use simple assertions instead of
 modelling
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, david@redhat.com, 
 peterx@redhat.com, peter.maydell@linaro.org, yc-core@yandex-team.ru
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

On Thu, Oct 5, 2023 at 4:04=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
> +            /*
> +             * Assure Coverity (and ourselves) that we are not going to =
OVERRUN
> +             * the buffer by following ldn_he_p().
> +             */
> +            assert((l =3D=3D 1 && len >=3D 1) ||
> +                   (l =3D=3D 2 && len >=3D 2) ||
> +                   (l =3D=3D 4 && len >=3D 4) ||
> +                   (l =3D=3D 8 && len >=3D 8));

I'll queue it shortly, but perhaps you can try if assert(l <=3D len) is eno=
ugh?

Alternatively I can try applying the patch on top of the tree that we
test with, and see how things go.

Paolo

>              val =3D ldn_he_p(buf, l);
>              result |=3D memory_region_dispatch_write(mr, addr1, val,
>                                                     size_memop(l), attrs)=
;
> @@ -2784,6 +2793,15 @@ MemTxResult flatview_read_continue(FlatView *fv, h=
waddr addr,
>              l =3D memory_access_size(mr, l, addr1);
>              result |=3D memory_region_dispatch_read(mr, addr1, &val,
>                                                    size_memop(l), attrs);
> +
> +            /*
> +             * Assure Coverity (and ourselves) that we are not going to =
OVERRUN
> +             * the buffer by following stn_he_p().
> +             */
> +            assert((l =3D=3D 1 && len >=3D 1) ||
> +                   (l =3D=3D 2 && len >=3D 2) ||
> +                   (l =3D=3D 4 && len >=3D 4) ||
> +                   (l =3D=3D 8 && len >=3D 8));
>              stn_he_p(buf, l, val);
>          } else {
>              /* RAM case */
> --
> 2.34.1
>


