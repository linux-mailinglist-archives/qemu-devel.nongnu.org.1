Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D842710646
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 09:28:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q25OE-0000Zy-Se; Thu, 25 May 2023 03:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q25OC-0000ZX-9C
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q25OA-0008UC-OW
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684999678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jf/gsglPlZxL1VBwdoWfD8TnuRon3trtX8scRIJHjfY=;
 b=jCDBcwDkirAPlhxHCVmU3XCZkm5rQFx0S0LoJbBfOwXkOI6Q4dbXoRDcznctB1smePct93
 sf00VfAppA4KwjpZCFlCFsp/EJJ4pbnduY6A6GWzYsAfYtYchttHv6CLkEhfTnDqlcamZC
 FYZZVxjlXxAd8PIn1X/gACNPuOBz590=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-_1MzmIDtNG23FIAxFcrb1w-1; Thu, 25 May 2023 03:27:56 -0400
X-MC-Unique: _1MzmIDtNG23FIAxFcrb1w-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3921c061696so545671b6e.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 00:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684999676; x=1687591676;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jf/gsglPlZxL1VBwdoWfD8TnuRon3trtX8scRIJHjfY=;
 b=AyZp0N6Y1Gnf2ZbWI1QlY0QxMrU6c8Cp+kJ7yA31yCoeOpRKGLGgGR98iH3lRjtsBf
 aHGtvdsA33rJdYr920yV32G/EB35GAaWDkLVAOZ8gLArXxhpcNm1FDPr9R33+KRJIXKS
 I4RPuBfg716eVi38IDEMPrm/URwcrmbs/9knnJ5uoVY5m8aEWfuivwfUNBi/kspkUgVV
 qI0xQMPGYFjxoKqzEjuOCJKK7X+y1x+djyOKcPza6lj4bvQuBrOccSzMvsVcVVCS7Ax0
 HCCCZfzxTQTYvuNnmwIlMVxsKeNttSt8cfhheG5CFe9miRurjGCgjeUORFjsGZq6fmZy
 7HCA==
X-Gm-Message-State: AC+VfDwQN/mEsIQbyFAXEcl5YKnnGFZjs5AHcRCFTs6ssFgesD+5ac8f
 e5dyBwHGPIaclZNzbkpLTz/2D6P5X7dnvq+mosIc6XreliAIAwjgQtGOpi1ZDIV+LmInYBLzRWw
 jNeHL9cWxOtO3JpI=
X-Received: by 2002:a05:6808:288d:b0:38d:f50b:38f7 with SMTP id
 eu13-20020a056808288d00b0038df50b38f7mr9487513oib.4.1684999675840; 
 Thu, 25 May 2023 00:27:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4ML/dPMxz1yFT2QNIa+m/Rr0dpyEEhuI0QheGPI2ZJhctwlmhhw1Ngfu0EkrkFT7XnnxjhuA==
X-Received: by 2002:a05:6808:288d:b0:38d:f50b:38f7 with SMTP id
 eu13-20020a056808288d00b0038df50b38f7mr9487506oib.4.1684999675617; 
 Thu, 25 May 2023 00:27:55 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 az14-20020a056808164e00b0038c06ae307asm212119oib.52.2023.05.25.00.27.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:27:55 -0700 (PDT)
Message-ID: <fefc5edd966aebae901c6371f07bc357767dab7f.camel@redhat.com>
Subject: Re: [PATCH v2 13/16] migration/rdma: Don't use imaginary transfers
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
Date: Thu, 25 May 2023 04:27:49 -0300
In-Reply-To: <20230515195709.63843-14-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-14-quintela@redhat.com>
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

On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
> RDMA protocol is completely asynchronous, so in qemu_rdma_save_page()
> they "invent" that a byte has been transferred.  And then they call
> qemu_file_credit_transfer() and ram_transferred_add() with that byte.
> Just remove that calls as nothing has been sent.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/qemu-file.c | 5 +----
>  migration/ram.c       | 1 -
>  2 files changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index acc282654a..23a21e2331 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -346,13 +346,10 @@ size_t ram_control_save_page(QEMUFile *f, ram_addr_=
t block_offset,
> =20
>          if (ret !=3D RAM_SAVE_CONTROL_DELAYED &&
>              ret !=3D RAM_SAVE_CONTROL_NOT_SUPP) {
> -            if (bytes_sent && *bytes_sent > 0) {
> -                qemu_file_credit_transfer(f, *bytes_sent);
> -            } else if (ret < 0) {
> +            if (ret < 0) {
>                  qemu_file_set_error(f, ret);
>              }
>          }
> -
>          return ret;
>      }
> =20
> diff --git a/migration/ram.c b/migration/ram.c
> index 67ed49b387..2d3927a15f 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1184,7 +1184,6 @@ static bool control_save_page(PageSearchStatus *pss=
, RAMBlock *block,
>      }
> =20
>      if (bytes_xmit) {
> -        ram_transferred_add(bytes_xmit);
>          *pages =3D 1;
>      }
> =20

Reviewed-by: Leonardo Bras <leobras@redhat.com>


