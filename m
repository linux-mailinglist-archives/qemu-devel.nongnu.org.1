Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E960706DAE
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:11:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzJjj-0001Vm-0B; Wed, 17 May 2023 12:10:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzJjf-0001VU-L7
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzJjd-0001ih-B7
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684339829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wga205fp0ir15na8p15CXKJTd/ZgoBNvVLhEfkZNq1E=;
 b=FIe+hlVpiV6jkib0NKrvRLqb91gmR0nxv4yV6A+ZNHvfJC5KAgqD1q3H05W+Ts5iK76O8R
 h7BFuqfd2GG568dFg8lmg0ZoZ06xwNu5TBazuUjLveTinMGZ7rUhCzsLhRYdZxU9Br1C/7
 bnY6BGoKCmpBfb0ipngMb6tXIrxo/iw=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-0ZEuYi_4P8erPOnzYt-icQ-1; Wed, 17 May 2023 12:09:40 -0400
X-MC-Unique: 0ZEuYi_4P8erPOnzYt-icQ-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-61b636b5f90so1890946d6.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:08:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684339675; x=1686931675;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wga205fp0ir15na8p15CXKJTd/ZgoBNvVLhEfkZNq1E=;
 b=BLGPVfs6jNIcPGDmaL9tg312m0cvzXxWzfdBVysY9cBAmubKmRvC1IHy+L6+3JwNWq
 VyQshYjfMZToEKGTp/8wBabcwgYzKgFKCJBUGZyWvoK9jvggPUEimlI2JQYNBtn3Qb7C
 9ItDjF3l68qlCXx5KSGqJju7bv1E7lOcBtla6h/ptxVFJI7oig+jZJ79w/Wc042lbxMu
 IjQ8IDQfcqWJqf1I03+MoGV3RkamDPY5XOAWQyTHnVmJFRsfg9MiAHAzrl4C+hSGbxMj
 XRSS51wfgSlqVqvexv8MfXMX2Vv2FkwEIKCYxFZhY1fCVTifrqLoaFuW9LisfBvM/tG3
 X/gA==
X-Gm-Message-State: AC+VfDzPlYiJAGzV0iKXq2XnYjPCsSDzeXyFCpz8T37SHk72PxUnTAXs
 pAK0k+biQNHoJcEnRvD5tP6K03yZatmqTvbdrEjvNFKZKimUKifr7aBzzqdXpeGVR3eKWcGIJdB
 eFxymzL/JVJbWa8k=
X-Received: by 2002:ad4:5be3:0:b0:5f1:31eb:1f0e with SMTP id
 k3-20020ad45be3000000b005f131eb1f0emr6018160qvc.4.1684339675580; 
 Wed, 17 May 2023 09:07:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Y/5rSBc+l1jL7btpd1Ki4P7ZmcW2jTXL+B8g/VPXizUnUYkAG9sia7YUNUKtTmKyG3uh7QA==
X-Received: by 2002:ad4:5be3:0:b0:5f1:31eb:1f0e with SMTP id
 k3-20020ad45be3000000b005f131eb1f0emr6018090qvc.4.1684339675246; 
 Wed, 17 May 2023 09:07:55 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 o5-20020a0ce405000000b0062382196588sm925081qvl.108.2023.05.17.09.07.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 09:07:54 -0700 (PDT)
Date: Wed, 17 May 2023 12:07:52 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Yishai Hadas <yishaih@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Maor Gottlieb <maorg@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Tarun Gupta <targupta@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>
Subject: Re: [PATCH v2 3/7] migration: Enable precopy initial data capability
Message-ID: <ZGT72DLNTevauf9N@x1n>
References: <20230517155219.10691-1-avihaih@nvidia.com>
 <20230517155219.10691-4-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517155219.10691-4-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, May 17, 2023 at 06:52:15PM +0300, Avihai Horon wrote:
> Now that precopy initial data logic has been implemented, enable the
> capability.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/options.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 0a31921a7a..3449ce4f14 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -561,10 +561,6 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>                               "capability 'return-path'");
>              return false;
>          }
> -
> -        /* Disable this capability until it's implemented */
> -        error_setg(errp, "'precopy-initial-data' is not implemented yet");
> -        return false;
>      }

I'm always confused why we need this and not having this squashed into
patch 1 (or say, never have these lines).

The only thing it matters is when someone backports patch 1 but not
backport the rest of the patches.  But that's really, really weird already
as a backporter doing that, and I doubt its happening.

Neither should we merge patch 1 without merging follow up patches to
master, as we should just always merge the whole feature or just keep
reworking on the list.

I'd like to know if I missed something else..

PS: sorry to be late on replying to your email for previous version due to
travelling last week, I'll reply to your series instead.  Actually I was
just writting up the reply to your previous version when receiving this
one. :)

Thanks,

-- 
Peter Xu


