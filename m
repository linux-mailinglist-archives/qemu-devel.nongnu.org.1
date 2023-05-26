Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC7171221D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:22:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Sho-00024B-N4; Fri, 26 May 2023 04:21:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2Shm-00023u-SZ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2Shl-0007bI-9g
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:21:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685089304;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LSSobErFxS5FdIYdst8Bpj77G9xTUxHrjPAepyg5lOE=;
 b=EEYpcw5dl0DSq/0teCMxezavuRyfWohqEvy7kQFeHA2NYfB8pNlVopXc5cymO/79jbahkK
 w5uFa1oVl4Ri8a4vyQ9gLExqnfezOrD6ImVloMdmNImSuYMFKf/vu+Gp8BsmsEi7bfYO1a
 6ia/pAtda77QfYmqd3DDW9E3MmHCZAM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-D_Vy2ZwhMOSSCr2eq8zjQg-1; Fri, 26 May 2023 04:21:43 -0400
X-MC-Unique: D_Vy2ZwhMOSSCr2eq8zjQg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f603fed174so3481765e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 01:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685089302; x=1687681302;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LSSobErFxS5FdIYdst8Bpj77G9xTUxHrjPAepyg5lOE=;
 b=RUd9cPZw3Z5yqxOEokYzbFTH+BGV2QvAzjL9VVWPq42r5RXtpIMhiNSKCSrBJ/TBTt
 nwJ95jVzzbQIvLug2u7y2jv89WtOoE6MILU8HhPDrQz23FIeaUB7xMHk/d/+bGVmXchK
 Pd/XW5i05hpevWe//9/QjfbNeCEZtshw5Bp397jplpZGwoqu4d+6VmRXsWN5NZ7KgQ/g
 M5kUVfamtkqAxo0q1TPWaP/ooZoktvXQQ3PwGnIbZtlVYTVbGMUpdzAU65m69YdMUr/e
 v5EHKxeuc6L86M8poCZR/+RRUpIaBSqsw6NhUGAgHEeX8OrkURGtqW/dR6jHMvEGIKF8
 JE+Q==
X-Gm-Message-State: AC+VfDxOdxeiHRisK2/TetWvQ2lIyARFt++jB7OyfkNQcH5rICs58IrJ
 J2lNisl2o7ZOXO9EzSeJ2vRlJcMn5pMphJuSUxoQjKNCApN1RzqnIZN2dVJcN79antuVucYnD/g
 QC0YDO21gKSmOER4=
X-Received: by 2002:adf:dccc:0:b0:309:509f:a7ef with SMTP id
 x12-20020adfdccc000000b00309509fa7efmr746949wrm.67.1685089301859; 
 Fri, 26 May 2023 01:21:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7qvwIEe2mN9uYQd2LNAhJxlRw/Q5AhFjiMuj3AHvNpq7WOOOavLXZVKSv8GqqoFgyxZUmoFA==
X-Received: by 2002:adf:dccc:0:b0:309:509f:a7ef with SMTP id
 x12-20020adfdccc000000b00309509fa7efmr746929wrm.67.1685089301578; 
 Fri, 26 May 2023 01:21:41 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 s17-20020a5d69d1000000b00304adbeeabbsm4328254wrw.99.2023.05.26.01.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 01:21:40 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Leonardo =?utf-8?Q?Br=C3=A1s?= <leobras@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Greg Kurz
 <groug@kaod.org>,  qemu-s390x@nongnu.org,  Fam Zheng <fam@euphon.net>,
 Ilya Leoshkevich <iii@linux.ibm.com>,  Halil Pasic <pasic@linux.ibm.com>,
 John Snow <jsnow@redhat.com>,  qemu-ppc@nongnu.org,  Daniel Henrique
 Barboza <danielhb413@gmail.com>,  Harsh Prateek Bora
 <harshpb@linux.ibm.com>,  Christian Borntraeger
 <borntraeger@linux.ibm.com>,  Richard Henderson
 <richard.henderson@linaro.org>,  David Gibson
 <david@gibson.dropbear.id.au>,  David Hildenbrand <david@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,  Eric Farman
 <farman@linux.ibm.com>,  qemu-block@nongnu.org,  =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@kaod.org>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>
Subject: Re: [PATCH v2 15/16] migration/rdma: Simplify the function that
 saves a page
In-Reply-To: <b0d83669673a8335fb83992fbf6706091d4d1cb3.camel@redhat.com>
 ("Leonardo =?utf-8?Q?Br=C3=A1s=22's?= message of "Thu, 25 May 2023 05:10:56
 -0300")
References: <20230515195709.63843-1-quintela@redhat.com>
 <20230515195709.63843-16-quintela@redhat.com>
 <b0d83669673a8335fb83992fbf6706091d4d1cb3.camel@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 10:21:40 +0200
Message-ID: <87o7m733l7.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Leonardo Br=C3=A1s <leobras@redhat.com> wrote:
> On Mon, 2023-05-15 at 21:57 +0200, Juan Quintela wrote:
>> When we sent a page through QEMUFile hooks (RDMA) there are three
>> posiblities:
>> - We are not using RDMA. return RAM_SAVE_CONTROL_DELAYED and
>>   control_save_page() returns false to let anything else to proceed.
>> - There is one error but we are using RDMA.  Then we return a negative
>>   value, control_save_page() needs to return true.
>> - Everything goes well and RDMA start the sent of the page
>>   asynchronously.  It returns RAM_SAVE_CONTROL_DELAYED and we need to
>>   return 1 for ram_save_page_legacy.
>>=20
>> Clear?
>>=20
>> I know, I know, the interfaz is as bad as it gets.  I think that now
>> it is a bit clearer, but this needs to be done some other way.
>
> interface?

Yeap.  I used the Spanish spelling, that, you know, in English is wrong O:-)

Thanks.
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index 416dec00a2..12d3c23fdc 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -3239,13 +3239,12 @@ qio_channel_rdma_shutdown(QIOChannel *ioc,
>>   *
>>   *    @size : Number of bytes to transfer
>>   *
>> - *    @bytes_sent : User-specificed pointer to indicate how many bytes =
were
>> + *    @pages_sent : User-specificed pointer to indicate how many pages =
were
>>   *                  sent. Usually, this will not be more than a few byt=
es of
>>   *                  the protocol because most transfers are sent asynch=
ronously.
>>   */
>
> There is new doc to pages_sent but the parameter is not added to the sign=
ature
> bellow. Am I missing something?

Good catch.

I redid this patch several times.  And it appears that I forgot some leftov=
ers.

>
>> -static size_t qemu_rdma_save_page(QEMUFile *f,
>> -                                  ram_addr_t block_offset, ram_addr_t o=
ffset,
>> -                                  size_t size, uint64_t *bytes_sent)
>> +static int qemu_rdma_save_page(QEMUFile *f, ram_addr_t block_offset,
>> +                               ram_addr_t offset, size_t size)
>>  {
>>      QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
>>      RDMAContext *rdma;
>> @@ -3277,18 +3276,6 @@ static size_t qemu_rdma_save_page(QEMUFile *f,
>>          goto err;
>>      }
>>=20=20
>> -    /*
>> -     * We always return 1 bytes because the RDMA
>> -     * protocol is completely asynchronous. We do not yet know
>> -     * whether an  identified chunk is zero or not because we're
>> -     * waiting for other pages to potentially be merged with
>> -     * the current chunk. So, we have to call qemu_update_position()
>> -     * later on when the actual write occurs.
>> -     */
>> -    if (bytes_sent) {
>> -        *bytes_sent =3D 1;
>> -    }
>> -
>>      /*
>>       * Drain the Completion Queue if possible, but do not block,
>>       * just poll.
>
> Oh, so this one complements 13/16.=20
> Since it doesn't do imaginary transfers anymore, there is no need to use
> bytes_sent pointer to keep track of them anymore.
>
> Other than the pages_sent above that I couldn't understand:
> Reviewed-by: Leonardo Bras <leobras@redhat.com>

Dropping that bit.

Thanks.


