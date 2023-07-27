Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F6376581F
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:57:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2uJ-0005kF-7d; Thu, 27 Jul 2023 11:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qP2u7-0005jw-Ca
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:27:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qP2u5-0007xB-Mi
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690471668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ugmq0Ruyl255MDNBooduGPt+G6eHR1r7x3267U28RT4=;
 b=XoOS/QQJ1+pkMKf6wBPNXS/aHi6pcyDppYfwGHkL135TpwsebMwnS+Fc08SzGsxBd9uN+0
 C2Z2snz/jQOceWIfAZ1j43c9JhGYZ+MIJyMfUy0eA8W42QgCvMWBdnL1u6DJPk7WIwEGH6
 BYt840yQJLicJHRyC8gQIHAl3Qv/4MQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-fpFyigBIMq-aKrga_F5FCQ-1; Thu, 27 Jul 2023 11:27:46 -0400
X-MC-Unique: fpFyigBIMq-aKrga_F5FCQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5225a8f625dso717109a12.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690471665; x=1691076465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ugmq0Ruyl255MDNBooduGPt+G6eHR1r7x3267U28RT4=;
 b=NCxaThc3x2Gl8mUl8bhAPDFQMRHzvtu3yxxc+khy+b2OKOmgqX4S389xdx6nXyXRd4
 pZBeUHrrJtIGSUKR4aXebVfLfn/vkKvENSCIlNDaarmEuYBb7fCLuBywy8u9jzdgtQ4r
 yCnz0ZXAyyboZLkUUfPMPQuX93CdzIk6HK+L06Yk9/EQGTD/5LLZ8q3GEwD5sKE2HsaW
 VlR+S7CAQGYmcy9ug7D+oE/IN3/J2bHTaO2WiK5t1uJbxjFLDVqcoegXG4MOWcc9QGdq
 MnOrD4lmLyepGHXmf5Of4i4uPGpHhBzOkPEVieJniaacR6khsmoS5TEAbbm6MZOQx/S1
 GyOQ==
X-Gm-Message-State: ABy/qLbBwCoVqXZrLKX5z0TPjzW/pRWbBi0c/jC8VZOtn7es7AI1R2/t
 mIt3YLdqAMKTOgC7500OC+9fetS5vKtonxSR03BTUtX5fiQdGho7t4k03jsx42v6m4+RFJ6hEC6
 +MD7RxfsX1lLAums=
X-Received: by 2002:aa7:d842:0:b0:522:806b:8f4a with SMTP id
 f2-20020aa7d842000000b00522806b8f4amr1917393eds.32.1690471665521; 
 Thu, 27 Jul 2023 08:27:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHdjE4oKoAyfg3mRXLg7uY59xCrd0VWm9m3FGKMma9+LbDnmpkt+wwLehRP+acsf+lLqMVFVw==
X-Received: by 2002:aa7:d842:0:b0:522:806b:8f4a with SMTP id
 f2-20020aa7d842000000b00522806b8f4amr1917376eds.32.1690471665175; 
 Thu, 27 Jul 2023 08:27:45 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a056402050400b0051e22660835sm777654edv.46.2023.07.27.08.27.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 08:27:44 -0700 (PDT)
Message-ID: <7cb8aa1d-7f65-cc15-4d9c-b195e464f8c3@redhat.com>
Date: Thu, 27 Jul 2023 17:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] block-jobs: flush target at the end of .run()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jsnow@redhat.com,
 den@openvz.org, Evanzhang@archeros.com,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230725174008.1147467-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 25.07.23 19:40, Vladimir Sementsov-Ogievskiy wrote:
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Actually block job is not completed without this final flush. It's
> rather unexpected to have broken target when job was successfully
> completed long ago and now we fail to flush or process just
> crashed/killed.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   block/backup.c               |  7 +++++--
>   block/commit.c               |  2 +-
>   block/mirror.c               |  4 ++++
>   block/stream.c               |  7 ++++++-
>   blockjob.c                   | 18 ++++++++++++++++++
>   include/block/blockjob_int.h | 11 +++++++++++
>   6 files changed, 45 insertions(+), 4 deletions(-)

Yes, that’s a good change.

[...]

> diff --git a/block/stream.c b/block/stream.c
> index e522bbdec5..f7e8b35e94 100644
> --- a/block/stream.c
> +++ b/block/stream.c

[...]

> @@ -207,6 +207,11 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
>           }
>       }
>   
> +    ret = block_job_final_target_flush(&s->common, s->target_bs);
> +    if (error == 0) {
> +        error = ret;
> +    }

In all other jobs, this function is invoked only if the job was 
successful, but here it’s called unconditionally.  I don’t mind one way 
or the other, but I think it should be consistent.  (Mainly just because 
inconsistency makes me wonder whether there’s an undocumented reason for 
it.)

> +
>       /* Do not remove the backing file if an error was there but ignored. */
>       return error;
>   }
> diff --git a/blockjob.c b/blockjob.c
> index 25fe8e625d..313e586b0d 100644
> --- a/blockjob.c
> +++ b/blockjob.c
> @@ -611,3 +611,21 @@ AioContext *block_job_get_aio_context(BlockJob *job)
>       GLOBAL_STATE_CODE();
>       return job->job.aio_context;
>   }
> +
> +int coroutine_fn
> +block_job_final_target_flush(BlockJob *job, BlockDriverState *target_bs)
> +{
> +    int ret;
> +

Should we mark this as IO_CODE()?

> +    WITH_GRAPH_RDLOCK_GUARD() {
> +        ret = bdrv_co_flush(target_bs);
> +    }
> +
> +    if (ret < 0 && !block_job_is_internal(job)) {
> +        qapi_event_send_block_job_error(job->job.id,
> +                                        IO_OPERATION_TYPE_WRITE,
> +                                        BLOCK_ERROR_ACTION_REPORT);
> +    }

Would it make sense to rely on block_job_error_action() instead?  If so, 
should we use the on-target-error setting?

I have no informed opinion on this, but I think using 
block_job_error_action() does come to mind, so if we consciously decide 
against it, that’s probably worth a comment, too.

Hanna

> +
> +    return ret;
> +}


