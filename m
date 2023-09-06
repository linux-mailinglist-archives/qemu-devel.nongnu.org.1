Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B42C479414B
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 18:18:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdvDJ-0007V5-Cx; Wed, 06 Sep 2023 12:17:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qdvD2-0007Ui-Bp
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 12:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qdvCz-0008Gl-T0
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 12:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694017008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rsEg56Y7g0ZWrtk6ILoQcNoLxp715oHi2yY7/071YoA=;
 b=WdSADVtwNmTO5j/ivjwBAYZLe6yW7/VcVrgbUVuijkkbpoPaxOx+pr6IPvs7VEY+Fdr2eO
 AD0tu0n7ryOjxVZ0VCY8J4GJ9zawIWsAZDKzR6XWglogGEAJpOOs17D1Ftq6x/FQngdxc1
 rM8zbwsuVkVttodYb7fUDk6pdZ3uKTE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-NFUry7KsOB63kz19PVmWww-1; Wed, 06 Sep 2023 12:16:45 -0400
X-MC-Unique: NFUry7KsOB63kz19PVmWww-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401c19fc097so300215e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 09:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694017004; x=1694621804;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rsEg56Y7g0ZWrtk6ILoQcNoLxp715oHi2yY7/071YoA=;
 b=ZehPzbb3k4cR+5kAzSFOEtUfzyu1EcbQy0RmnN4O+/qKFGH1sVbCrKTpzvAoFjjvj6
 BbyT+/T8UddHorLuPCMPvt8migAY2TnjoPC83QPfYqifcd4biirrVmEZMM98sQ0bfirq
 uCL5vxqNOUQWsmVUUXfKyhenZ35gCUxDJgCkVa2Mw12pwoUMsVStiAPbsycHDteS4yqq
 lpv/RszqfxzIs5s3Jo1L36n6rUt2LE9j0+6gr/mctwxCXuSHq3KMdXO/ld+CQmhi+hoz
 86mQBWws5YBSNyO2IRRBakWMI9I51li4SO19fYpMNr0AjzL3RcqN0j28E+5yS3+G2Ezk
 ECYg==
X-Gm-Message-State: AOJu0YxT7NpYiKX+30619x3c8Nl/k49Kd2oNBJ2MxO1/FkdIvS5tUpPv
 +/zk4keWq5Q3tuAqE0SCtPyXtqlJxR7DGnEJtVY85ClJrC/+6XfcaQgKhjYkpVYAeIJv7FDQnZp
 ykYJflv5OwNlOazc=
X-Received: by 2002:a1c:6a07:0:b0:3f9:b748:ff37 with SMTP id
 f7-20020a1c6a07000000b003f9b748ff37mr2460150wmc.20.1694017004773; 
 Wed, 06 Sep 2023 09:16:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG85n5ipqEArHhPyIRjMVqAlwIoVTiI21nVLfE5x7vgEsUHni491zJo4mx5F2nKVhEQK18uSw==
X-Received: by 2002:a1c:6a07:0:b0:3f9:b748:ff37 with SMTP id
 f7-20020a1c6a07000000b003f9b748ff37mr2460135wmc.20.1694017004393; 
 Wed, 06 Sep 2023 09:16:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a05600c0b4f00b003fee6f027c7sm23197892wmr.19.2023.09.06.09.16.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 09:16:43 -0700 (PDT)
Message-ID: <819d69f1-b212-e84e-6b6c-ec9178b6fdf2@redhat.com>
Date: Wed, 6 Sep 2023 18:16:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 3/6] migration: Move more initializations to
 migrate_init()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Yanghang Liu <yanghliu@redhat.com>
References: <20230906150853.22176-1-avihaih@nvidia.com>
 <20230906150853.22176-4-avihaih@nvidia.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230906150853.22176-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/6/23 17:08, Avihai Horon wrote:
> Initialization of mig_stats, compression_counters and VFIO bytes
> transferred is hard-coded in migration code path and snapshot code path.
> 
> Make the code cleaner by initializing them in migrate_init().
> 
> Suggested-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   migration/migration.c | 14 +++++++-------
>   migration/savevm.c    |  3 ---
>   2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 92866a8f49..ce01a3ba6a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1425,6 +1425,13 @@ void migrate_init(MigrationState *s)
>       s->iteration_initial_bytes = 0;
>       s->threshold_size = 0;
>       s->switchover_acked = false;
> +    /*
> +     * set mig_stats compression_counters memory to zero for a
> +     * new migration
> +     */
> +    memset(&mig_stats, 0, sizeof(mig_stats));
> +    memset(&compression_counters, 0, sizeof(compression_counters));
> +    migration_reset_vfio_bytes_transferred();
>   }
>   
>   int migrate_add_blocker_internal(Error *reason, Error **errp)
> @@ -1635,13 +1642,6 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
>       }
>   
>       migrate_init(s);
> -    /*
> -     * set mig_stats compression_counters memory to zero for a
> -     * new migration
> -     */
> -    memset(&mig_stats, 0, sizeof(mig_stats));
> -    memset(&compression_counters, 0, sizeof(compression_counters));
> -    migration_reset_vfio_bytes_transferred();
>   
>       return true;
>   }
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 5bf8b59a7d..e14efeced0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1620,9 +1620,6 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>       }
>   
>       migrate_init(ms);
> -    memset(&mig_stats, 0, sizeof(mig_stats));
> -    memset(&compression_counters, 0, sizeof(compression_counters));
> -    migration_reset_vfio_bytes_transferred();
>       ms->to_dst_file = f;
>   
>       qemu_mutex_unlock_iothread();


