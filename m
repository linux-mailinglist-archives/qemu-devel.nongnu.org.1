Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF2C970D0C1
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 03:58:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1HHa-0004er-GY; Mon, 22 May 2023 21:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q1HHX-0004du-UX
 for qemu-devel@nongnu.org; Mon, 22 May 2023 21:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q1HHV-00036o-Gg
 for qemu-devel@nongnu.org; Mon, 22 May 2023 21:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684807065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ob+b2mzF7S2HKWQmTTiCXFzb5gjz3bQyCXYogo0Pepo=;
 b=GENH9o2x7FpOek1+C4CtIIGyPp03yYSieHCb1DoJu/DPXS1mkMmUpjv9gqkU8zFDwBGbeO
 aK2LGX78m/SALvphZlE796OKxHOwe5JoqE3TS8X4JzagqN4AmHdo0ed2Bwzz7bRtUYOSeW
 6cByzI2UT1WZdeVzt2+gfm5UdlfzqLM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-XMHI8TNKMOG2cGnl2tspkw-1; Mon, 22 May 2023 21:57:42 -0400
X-MC-Unique: XMHI8TNKMOG2cGnl2tspkw-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-397f54a554aso2409322b6e.2
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 18:57:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684807061; x=1687399061;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ob+b2mzF7S2HKWQmTTiCXFzb5gjz3bQyCXYogo0Pepo=;
 b=RqxWSFnr3MBjjV+/hR0h1hYh1PMvIl1fzb6YoPWd1ENmgCarXgJP9b4xv51JwXHKUu
 u5yj4NKHUMxhlnCYHfuzADPoDOuAtODbhFzN0gpAMBkaO2VKCBWMhfO2y+P2d40TyoPV
 GLdmLFEcxfPJzDGiCw0AiIxgUEgxPpUficSvlkEFxay7y6D0M71YVLCHdOPVMgEGoHNd
 shb0Gwy7VjKoG3FWjc2AYL9Em8HokazvIAQm9M9d88fRMA7rdaVGg+jePbYbGfbnCTel
 HgBOYbieKAdfWOd3OsMJ1ombYejMtJdUDXKb/FOxkgLHRhyWVWX9loeY5EoixBRM04eH
 iNMA==
X-Gm-Message-State: AC+VfDz7o5d/STVXtFtW53gFWEaOXndFU9dfGINYbSJ2xrasTZkeR/TM
 ZKu6R8M9E4Q+kTdKs6cv2nZOBG0gnexk11hAEtsvM27CKyetqNh0YWSh4F9BayfrBWAbUqhfvYu
 iy/niBBIJkAX01Lc=
X-Received: by 2002:aca:91a:0:b0:38e:19e0:8864 with SMTP id
 26-20020aca091a000000b0038e19e08864mr5773355oij.27.1684807061584; 
 Mon, 22 May 2023 18:57:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65bf+T8surQLod/J5KU3Erio+JlCCrlX93JBtI+EGRKq8N0277idK5i64OInq2M8KcoaN3Nw==
X-Received: by 2002:aca:91a:0:b0:38e:19e0:8864 with SMTP id
 26-20020aca091a000000b0038e19e08864mr5773332oij.27.1684807061369; 
 Mon, 22 May 2023 18:57:41 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 j8-20020a4adf48000000b0051134f333d3sm2927064oou.16.2023.05.22.18.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 18:57:40 -0700 (PDT)
Message-ID: <ed4955433ff488a4e9c08f50e0a4a9813ba0665f.camel@redhat.com>
Subject: Re: [PATCH v2 01/16] migration: Don't use INT64_MAX for unlimited rate
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, quintela@redhat.com,
 David Edmondson <david.edmondson@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Greg Kurz
 <groug@kaod.org>, qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, John
 Snow <jsnow@redhat.com>,  qemu-ppc@nongnu.org, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Date: Mon, 22 May 2023 22:57:33 -0300
In-Reply-To: <ee1979b4-1a64-607d-8fbd-4bfd9c5b317b@kaod.org>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-2-quintela@redhat.com> <m2fs7w4p0u.fsf@oracle.com>
 <874jocy6gb.fsf@secure.mitica>
 <ee1979b4-1a64-607d-8fbd-4bfd9c5b317b@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leobras@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
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

On Tue, 2023-05-16 at 14:47 +0200, C=C3=A9dric Le Goater wrote:
> On 5/16/23 11:24, Juan Quintela wrote:
> > David Edmondson <david.edmondson@oracle.com> wrote:
> > > Juan Quintela <quintela@redhat.com> writes:
> > >=20
> > > > Define and use RATE_LIMIT_MAX instead.
> > >=20
> > > Suggest "RATE_LIMIT_MAX_NONE".
> >=20
> > Then even better
> >=20
> > RATE_LIMIT_DISABLED?
>=20
> I'd vote for RATE_LIMIT_DISABLED.

Me too.

>=20
> > RATE_LIMIT_NONE?
> >=20
> > Using MAX and NONE at the same time looks strange.
>=20
> Cheers,
>=20
> C.
>=20

Reviewed-by: Leonardo Bras <leobras@redhat.com>


