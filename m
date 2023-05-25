Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5607B7105F3
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 09:07:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q253S-0002if-4K; Thu, 25 May 2023 03:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q253P-0002i5-LH
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:06:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q253N-0004EC-4T
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684998388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M30ZW2lTnLbj3uwcVeap9HNNNDnQqWewk8SRB11xcsc=;
 b=IVJ5skorLqKnlq+t3fJkHBQmbK2sAdtd1qmuDlDIpXUfLsRtxkwt10APmK+7GP/AtxYqFN
 twBUKGgWvu8BczaqgzRf+xM6Stk7MPwPPMF0/cXLcMBFtfPVx9R6KqzppIqma9mTV+kkSn
 Tn3lk9vL+nOsQklU0WJ2EvrtRq9MrWA=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-ZXU-DfyeMrKNh5c4_dTeMA-1; Thu, 25 May 2023 03:06:26 -0400
X-MC-Unique: ZXU-DfyeMrKNh5c4_dTeMA-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-397f99331a2so1301292b6e.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 00:06:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684998386; x=1687590386;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M30ZW2lTnLbj3uwcVeap9HNNNDnQqWewk8SRB11xcsc=;
 b=eYfHsTELv9Jkc/HkeJoatEY67cYKnxloDg1rvBVlTlCaq6uuF66gcMVlEqQirUSNOE
 tPfD+wuwry15wq2fH2RzbF0MDdYXeXbuYfQGL+koQiP/pIQdtRax1Wdvw80cQYCm3ZrS
 kPjvzGDAurNgS8okP0F//gXiifpHfAOC5PFug4ZIFWANspEpDwkgPMedKfHLLJ0KRiSi
 0vB9nbb+dtKxr6AL9rzZfVW5+96B6bP0Ea1c321vT/cvlCeivkufs9pTSUQkJqq2xeI3
 u3GP0KOKi81fmdQjD+IGVzf0vClE2+Ro4oF3YpEsptI3rf0bR8ZCPAnLXoN9ZFhdfC9c
 CS+w==
X-Gm-Message-State: AC+VfDxL4d/VHbaD30rglbJMlbfPT3dRQh2SI+8YuysDVi+ci8k2PbsG
 IyAEVcHmjvaOWg1OAMkAEyBnWfoDoNNbJZO6ZJuuI3mHv7ZgPRe+gshwga/qH9dS8y10MPGPCE8
 zknhhKq9R0ToIRwE=
X-Received: by 2002:aca:120a:0:b0:398:1151:a42b with SMTP id
 10-20020aca120a000000b003981151a42bmr5101714ois.20.1684998385797; 
 Thu, 25 May 2023 00:06:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ65OhuKQ9Lz6Wr9vb9Os+TYcb+dO0y034sbl8OEAC6nPDQe3lfRWvoAyqoYpFUg+OxvNVLj0g==
X-Received: by 2002:aca:120a:0:b0:398:1151:a42b with SMTP id
 10-20020aca120a000000b003981151a42bmr5101708ois.20.1684998385587; 
 Thu, 25 May 2023 00:06:25 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 l26-20020a056820031a00b005421d52de9csm123961ooe.45.2023.05.25.00.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:06:25 -0700 (PDT)
Message-ID: <493d1da7afefe08c91ab1993fcbb614cd9cb9c49.camel@redhat.com>
Subject: Re: [PATCH v2 11/16] migration/RDMA: It is accounting for
 zero/normal pages in two places
From: Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras@redhat.com>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Greg Kurz <groug@kaod.org>, 
 qemu-s390x@nongnu.org, Fam Zheng <fam@euphon.net>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, John Snow
 <jsnow@redhat.com>, qemu-ppc@nongnu.org, Daniel Henrique Barboza
 <danielhb413@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 David Hildenbrand <david@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-block@nongnu.org,  =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,  Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Date: Thu, 25 May 2023 04:06:19 -0300
In-Reply-To: <20230515195709.63843-12-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-12-quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leobras@redhat.com;
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

On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> Remove the one in control_save_page().
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/ram.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/migration/ram.c b/migration/ram.c
> index a706edecc0..67ed49b387 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1191,13 +1191,6 @@ static bool control_save_page(PageSearchStatus *ps=
s, RAMBlock *block,
>      if (ret =3D=3D RAM_SAVE_CONTROL_DELAYED) {
>          return true;
>      }
> -
> -    if (bytes_xmit > 0) {
> -        stat64_add(&mig_stats.normal_pages, 1);
> -    } else if (bytes_xmit =3D=3D 0) {
> -        stat64_add(&mig_stats.zero_pages, 1);
> -    }
> -
>      return true;
>  }
> =20


ram_save_target_page_legacy() calls both control_save_page() and
save_zero_page() which increment zero-pages.

It also calls ram_save_page() which increments normal-pages.

Reviewed-by: Leonardo Bras <leobras@redhat.com>


