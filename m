Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2467071064A
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 09:30:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q25Po-0001Q8-30; Thu, 25 May 2023 03:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q25PN-0001Nn-Sd
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leobras@redhat.com>)
 id 1q25PM-0000Mk-3k
 for qemu-devel@nongnu.org; Thu, 25 May 2023 03:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684999751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/QQSOP5sPK8TYKmD6XBxl778+HjDmn1HTgYLB8EtXk=;
 b=dTlWLrC8MfjaRqnMsdinUo6YQt0zLxHXRn1YC5d8b8nj5+zf8KOTazDiKTDJ5BDmmXxf3T
 oA2Cm8HCM0wZch0PnAt2Z3cegX0qmqfbb4n9r+Cxngy7G9mDcFnmFxrutv9jXamYxYtQ+Q
 91Ytn6DeRkvUt31Mcl0fgtlmaPmeITI=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-bawgd9vfO4GoRrTXGTW8GQ-1; Thu, 25 May 2023 03:29:09 -0400
X-MC-Unique: bawgd9vfO4GoRrTXGTW8GQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-19e86e4cc2cso1101370fac.3
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 00:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684999749; x=1687591749;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a/QQSOP5sPK8TYKmD6XBxl778+HjDmn1HTgYLB8EtXk=;
 b=cgiEiIfyM6GaZQjxQtWxskRLarqmYEWEQ3R7tjhF4bcV4uak8VBYJ2rllDX4XfqLIq
 /ttgm9jOtpRetXWNfb9RGixMZE/fniXNB03rUgbtFe+OOzu1Rc7hXZI9ZFM0ED1JxNKl
 UDE8DP5lsvyM06AQeLZx4WbItjEPyGalHzK81ajCw5Jdu8uyc+yDCIG6nf0N37b+7sCx
 vLPRy+TxH5vRL3SFVbLnyjafwV8H7TgK+HokYuE6HxRl8t2cvrYeEwVYwiWouHhHuvqM
 bXAMUsgiwEkTzHVO9+zA3W3wo6+pDlP91eoHF0xPLyF5pteBNiT/6FzlIqkokdwEpPQa
 0REQ==
X-Gm-Message-State: AC+VfDxvyciQpZgV8plC8x9bNGM3qJC40pEF6+PUB1KSNIwNrJe+x43C
 vVTwQGF0OnzrcGfknPlExrA0IaMi3UrZ0BNCkFZn4vB6NYzpsSR/T2uIfA0ABir8aHrY3QHo4r1
 6zQqq6gHdEqfTlTw=
X-Received: by 2002:a05:6870:3404:b0:196:27ad:510c with SMTP id
 g4-20020a056870340400b0019627ad510cmr1331589oah.41.1684999748864; 
 Thu, 25 May 2023 00:29:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7dqVkhwXfd6A8qrMXXxrzEzWTVR1x3uTMtvHQZUs8xd6mqTIDYADUL8IMyIF3NlRJhjbL8sg==
X-Received: by 2002:a05:6870:3404:b0:196:27ad:510c with SMTP id
 g4-20020a056870340400b0019627ad510cmr1331581oah.41.1684999748620; 
 Thu, 25 May 2023 00:29:08 -0700 (PDT)
Received: from ?IPv6:2804:1b3:a803:7f0c:32e1:e970:713a:f05b?
 ([2804:1b3:a803:7f0c:32e1:e970:713a:f05b])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a056871054300b0017aafd12843sm375005oal.32.2023.05.25.00.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:29:08 -0700 (PDT)
Message-ID: <532a07c9bd105c95fa107cf56a8b680278750028.camel@redhat.com>
Subject: Re: [PATCH v2 14/16] migration: Remove unused
 qemu_file_credit_transfer()
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
Date: Thu, 25 May 2023 04:29:02 -0300
In-Reply-To: <20230515195709.63843-15-quintela@redhat.com>
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-15-quintela@redhat.com>
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
> After this change, nothing abuses QEMUFile to account for data
> transferrefd during migration.
>=20
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/qemu-file.h | 8 --------
>  migration/qemu-file.c | 5 -----
>  2 files changed, 13 deletions(-)
>=20
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index e649718492..37f42315c7 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -122,14 +122,6 @@ bool qemu_file_buffer_empty(QEMUFile *file);
>   */
>  int coroutine_mixed_fn qemu_peek_byte(QEMUFile *f, int offset);
>  void qemu_file_skip(QEMUFile *f, int size);
> -/*
> - * qemu_file_credit_transfer:
> - *
> - * Report on a number of bytes that have been transferred
> - * out of band from the main file object I/O methods. This
> - * accounting information tracks the total migration traffic.
> - */
> -void qemu_file_credit_transfer(QEMUFile *f, size_t size);
>  int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
>  int qemu_file_get_error_obj_any(QEMUFile *f1, QEMUFile *f2, Error **errp=
);
>  void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index 23a21e2331..72e130631d 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -411,11 +411,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(Q=
EMUFile *f)
>      return len;
>  }
> =20
> -void qemu_file_credit_transfer(QEMUFile *f, size_t size)
> -{
> -    f->total_transferred +=3D size;
> -}
> -
>  /** Closes the file
>   *
>   * Returns negative error value if any error happened on previous operat=
ions or


Reviewed-by: Leonardo Bras <leobras@redhat.com>


