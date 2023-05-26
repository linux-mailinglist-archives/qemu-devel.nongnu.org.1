Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA68712CF9
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 21:01:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2cfj-0001XD-ID; Fri, 26 May 2023 15:00:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2cfZ-0001Tq-QY
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lsoaresp@redhat.com>)
 id 1q2cfX-0002fi-F6
 for qemu-devel@nongnu.org; Fri, 26 May 2023 15:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685127606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qyzN4Db3inTCmbExkbuy4Dks7GPl3EcYB405/EiUpzI=;
 b=Yn57AxviPYVvQdhMJhZu6+gRPDyrMiHlG3MVr14IW1YfcP+8y8SF46KImP7nhttgtqrYUS
 1B7yzme0yURLzKjFhYoRdP1Hcydt39jsaWHEX2Wlqei9t9hma6x3K35K5riUCEjgZljnBv
 2cjdscuTNWuMozxuzEpLvUMEaKBss18=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-df4myYNoO0OkllatyZSWVw-1; Fri, 26 May 2023 15:00:05 -0400
X-MC-Unique: df4myYNoO0OkllatyZSWVw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f6a8c3ef10so7064181cf.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 12:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685127605; x=1687719605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qyzN4Db3inTCmbExkbuy4Dks7GPl3EcYB405/EiUpzI=;
 b=bfl6yBoleDpvhHTtR73+fI9zusmmAtr5gQvJ5I37NpYxUQMA3cNvuOk/yogN9qGfHh
 yu1iqgdT3VtO/pxXWAB/EzVdTENSzW2AmtKQh0xiGY52PPSc0XCxwxt/6w+TLas2jzVX
 Tq2EPByvaaTPmZrUF3LcI6CH36PJn2PPWcd7v2b9Dc6ygCWjskt0RFC5I5kYs6eNX8QF
 B6RXf/aR6cNA2LU0NYRJAgPzJymHB3ocDJ/2AfQMocwZJsScyv7Eclo2hBaJ88lo3sfs
 FwcXr9Pory60ruICpJRlasjbyVbPu97D0lq9d1ylFz6sF/Rx3B2LQnepa3UWdpJ9wZ7Q
 A+cw==
X-Gm-Message-State: AC+VfDzHeTIFKmMrdcsxzJqkwm7dx9U0PLvVZQNJFovKEALK9/2uKNwZ
 CbAryY8FzlnKPBm7xSC1Fh70jCBRJ/dtyw2LzcYDckT99M+JeZZTgyWc/BsagguiHvkMacf2X3w
 0XY/DvcY7v0Slv6P3bvEDE8P5u2Iw29I=
X-Received: by 2002:ac8:7f0c:0:b0:3f6:b0bd:241f with SMTP id
 f12-20020ac87f0c000000b003f6b0bd241fmr2652587qtk.41.1685127604809; 
 Fri, 26 May 2023 12:00:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6B8fnDRDL/5ziZogAeCplDw4h+m0sqf3mHlWn/GGjcCyLY/vokq9BJVzIV2XYX/4YtDi0CpsZxVxcFwAi+P2g=
X-Received: by 2002:ac8:7f0c:0:b0:3f6:b0bd:241f with SMTP id
 f12-20020ac87f0c000000b003f6b0bd241fmr2652575qtk.41.1685127604581; Fri, 26
 May 2023 12:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-10-quintela@redhat.com>
 <59d1842c50010122dd5d18bff65d280d0b2d6b47.camel@redhat.com>
 <87sfbj33qn.fsf@secure.mitica>
In-Reply-To: <87sfbj33qn.fsf@secure.mitica>
From: Leonardo Bras Soares Passos <leobras@redhat.com>
Date: Fri, 26 May 2023 15:59:53 -0300
Message-ID: <CAJ6HWG5WHWyYJWkPBDDJxVYszh5VtceV3=U5_NF+TdWLU=ujDA@mail.gmail.com>
Subject: Re: [PATCH v2 09/16] migration: We don't need the field
 rate_limit_used anymore
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Greg Kurz <groug@kaod.org>, 
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, 
 Ilya Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>, 
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, qemu-block@nongnu.org, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lsoaresp@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Fri, May 26, 2023 at 5:18=E2=80=AFAM Juan Quintela <quintela@redhat.com>=
 wrote:
>
> Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> > On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> >> Since previous commit, we calculate how much data we have send with
> >> migration_transferred_bytes() so no need to maintain this counter and
> >> remember to always update it.
> >>
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> > I reviewed this one together with 8/16.
> > It makes sense for me to squash them together, but anyway:
>
> Already in tree.
>
> See explanation for the split on previous patch.
>
> The other reason for the split is that this part of the patch is trivial
> to review O:-)

:-)

>
> Later, Juan.
>
> >
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
>


