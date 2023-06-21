Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5998B739067
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:51:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3pd-0005AB-Ow; Wed, 21 Jun 2023 15:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC3pb-00059w-53
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:49:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC3pZ-0004RS-Hz
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687376968;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GsdMr/zx34JXZ1v5mFs8a7oBOVi435yn45IQBG0bMs=;
 b=fJTEID2LjzW1IGuPw47kZn0me4oEulnLZ0E64VMJT2+5BkhIx7+cDa9DZrDJvAe3qKvUcC
 U+hlX+JaqccDrx1ILV95HVlAwXRwY6vHlMMNJjC+LKRUo31NpyXQ2hih/fPTT1EsEcZgxr
 6+ZugvVgLUx5FqgoJd1f2BacK9SISnQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-3TT0pdpHMbegnocz_MNNrA-1; Wed, 21 Jun 2023 15:49:27 -0400
X-MC-Unique: 3TT0pdpHMbegnocz_MNNrA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f9b0f64149so18888075e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 12:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687376966; x=1689968966;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1GsdMr/zx34JXZ1v5mFs8a7oBOVi435yn45IQBG0bMs=;
 b=O15WqnLRoNS6wN4iiG3STgCQy1IUcLgjdf8OqGRc5SNvDJZry69xmUZZvFPp17KARs
 kWa2VPiF8vlYV/1Geiv1lAQnwnX1K3PYS0eU/XmS6kiWF81eau8Jazp0j68fVGiral+C
 V+Y3G8FC1piaD3KuwajNzSRL5Xy9thMpipX8DWzYmKsdj/M2jEAC6mwakxHIry99xYq5
 m2LU/OdhWIeV8kd9RptljH+DQBr/XlgOYbWavuO8bFflGM6GrcH4F/By/sZNH4N4+yZG
 K6uy94B0ALS6Mu/2YzQrXXqJ95SL4ECXH5ONkYzFXbRUjR4AndwU9jPR2w4HlkqOwqVR
 d44w==
X-Gm-Message-State: AC+VfDybmXzyBvIye7f48EeERDnFk/jFbqj9QFyTiXvIRRpn1y6aOQnG
 83n+9OR85v+U64rYOk1lL+Kp3tmsVVO/xRFBkQICewVDyYy2DRSlfTNd503DRBaD+9jVUyLjENm
 WqWyB9B6JmeZ/0UI=
X-Received: by 2002:a05:600c:10d1:b0:3f7:a20a:561d with SMTP id
 l17-20020a05600c10d100b003f7a20a561dmr15314625wmd.8.1687376965947; 
 Wed, 21 Jun 2023 12:49:25 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6twwwVC1Ib5iHWiyaz+lkFowPMVyfy7GKzI6dvf81hiq0xnUYml+Ptla1hY+YnLD6Vpi7EbQ==
X-Received: by 2002:a05:600c:10d1:b0:3f7:a20a:561d with SMTP id
 l17-20020a05600c10d100b003f7a20a561dmr15314613wmd.8.1687376965582; 
 Wed, 21 Jun 2023 12:49:25 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 w21-20020a1cf615000000b003f8126bcf34sm16828865wmc.48.2023.06.21.12.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 12:49:24 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,  Markus Armbruster
 <armbru@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  "Dr.
 David Alan Gilbert" <dgilbert@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 04/11] multifd: Count the number of bytes sent correctly
In-Reply-To: <CALophutb+J2Qqa-msbY_aW+sz-OPW-XoQQLfCVfEXLfcaWa8xQ@mail.gmail.com>
 (Chuang Xu's message of "Fri, 16 Jun 2023 03:53:10 -0500")
References: <20230130080956.3047-1-quintela@redhat.com>
 <20230130080956.3047-5-quintela@redhat.com>
 <CALophutb+J2Qqa-msbY_aW+sz-OPW-XoQQLfCVfEXLfcaWa8xQ@mail.gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 21:49:24 +0200
Message-ID: <87bkh8a94r.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Chuang Xu <xuchuangxclwt@bytedance.com> wrote:
> Hi,Juan,
>
> On 2023/1/30 =E4=B8=8B=E5=8D=884:09, Juan Quintela wrote:
>> Current code asumes that all pages are whole.  That is not true for
>> example for compression already.  Fix it for creating a new field
>> ->sent_bytes that includes it.
>>
>> All ram_counters are used only from the migration thread, so we have
>> two options:
>> - put a mutex and fill everything when we sent it (not only
>>    ram_counters, also qemu_file->xfer_bytes).
>> - Create a local variable that implements how much has been sent
>>    through each channel.  And when we push another packet, we "add" the
>>    previous stats.
>>
>> I choose two due to less changes overall.  On the previous code we
>> increase transferred and then we sent.  Current code goes the other
>> way around.  It sents the data, and after the fact, it updates the
>> counters.  Notice that each channel can have a maximum of half a
>> megabyte of data without counting, so it is not very important.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>   migration/multifd.h | 2 ++
>>   migration/multifd.c | 6 ++++--
>>   2 files changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/multifd.h b/migration/multifd.h
>> index e2802a9ce2..36f899c56f 100644
>> --- a/migration/multifd.h
>> +++ b/migration/multifd.h
>> @@ -102,6 +102,8 @@ typedef struct {
>>       uint32_t flags;
>>       /* global number of generated multifd packets */
>>       uint64_t packet_num;
>> +    /* How many bytes have we sent on the last packet */
>> +    uint64_t sent_bytes;
>>       /* thread has work to do */
>>       int pending_job;
>>       /* array of pages to sent.
>> diff --git a/migration/multifd.c b/migration/multifd.c
>> index 61cafe4c76..cd26b2fda9 100644
>> --- a/migration/multifd.c
>> +++ b/migration/multifd.c
>> @@ -394,7 +394,6 @@ static int multifd_send_pages(QEMUFile *f)
>>       static int next_channel;
>>       MultiFDSendParams *p =3D NULL; /* make happy gcc */
>>       MultiFDPages_t *pages =3D multifd_send_state->pages;
>> -    uint64_t transferred;
>>
>>       if (qatomic_read(&multifd_send_state->exiting)) {
>>           return -1;
>> @@ -429,7 +428,8 @@ static int multifd_send_pages(QEMUFile *f)
>>       p->packet_num =3D multifd_send_state->packet_num++;
>>       multifd_send_state->pages =3D p->pages;
>>       p->pages =3D pages;
>> -    transferred =3D ((uint64_t) pages->num) * p->page_size + p->packet_=
len;
>> +    uint64_t transferred =3D p->sent_bytes;
>> +    p->sent_bytes =3D 0;
>>       qemu_file_acct_rate_limit(f, transferred);
>>       qemu_mutex_unlock(&p->mutex);
>>       stat64_add(&ram_atomic_counters.multifd_bytes, transferred);
>> @@ -719,6 +719,8 @@ static void *multifd_send_thread(void *opaque)
>>               }
>>
>>               qemu_mutex_lock(&p->mutex);
>> +            p->sent_bytes +=3D p->packet_len;
>> +            p->sent_bytes +=3D p->next_packet_size;
>
> Consider a scenario where some normal pages are transmitted in the first =
round,
> followed by several consecutive rounds of zero pages. When zero pages
> are transmitted,
> next_packet_size of first round is still incorrectly added to
> sent_bytes. If we set a rate
> limiting for dirty page transmission, the transmission performance of
> multi zero check
> will degrade.
>
> Maybe we should set next_packet_size to 0 in multifd_send_pages()?

See my series of migration atomic counters O:-)

You are right with your comments, that is the reason why it took me so
many patches to fix it properly.

After the last serie on the list that set_bytes variable don't exist
anymore and I just do (with atomic operations):

multifd_bytes +=3D size_of_write_just_done;

And no more sheanigans.

Thanks, Juan.


