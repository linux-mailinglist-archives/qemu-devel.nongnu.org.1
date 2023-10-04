Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A12D77B8625
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:11:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5Oa-0007nB-66; Wed, 04 Oct 2023 13:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo5OY-0007cJ-2Z
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo5OW-00006H-JT
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696439444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9r+gQVvZYS98OAMmP5sI5zVSvuFtgmQ+4Q5oDeLqURo=;
 b=Q9XArDpMLXBREm/k4cl1KtplhrfoZ8S4QPGcCAmTxLh63gFm+zbfwP+vX9IW/1vSZr9w5P
 iaiLHq7y7nWa8Zt/Smaun5TNWCf+RgWHa2MaUlLiycEl0bRu7fUjtQUu5tDu723gvPuNFF
 CzZKrg7c1rfIEJA1j46mOeqed92lvhM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-n_jPQJhbPMy_420RIRz30A-1; Wed, 04 Oct 2023 13:10:27 -0400
X-MC-Unique: n_jPQJhbPMy_420RIRz30A-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-774292de453so939585a.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696439427; x=1697044227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9r+gQVvZYS98OAMmP5sI5zVSvuFtgmQ+4Q5oDeLqURo=;
 b=jL92hW+VcCdyOEYn0ZPpABrR6CizisJJk+IX4uU6caKmkXdCgVb5Mpo3a1XD/VdVKy
 2T6UI1FwlcimBONu+nz7vtelCE1WooGDqVVgLrl7KouMaWcHhLQxffXume2zCwN5l+Ep
 e2qD6SqNYP0EIcskH6tUSg7nq4D0OtC2OODmzruRM/hdVjMSn2E44Xj50fK9iqLB+NDu
 l/SzDEc9bJlAEx1k7HsgbgIH4/grYpct/iuJvV1atKw+c7LrONnB6ujCrhXI/B5gDuFv
 tn1qBog2USIS/A2z/awgX8WfaMQI4Ctp5WFmvxIBO91jpNPrMg+U2Yh9Njfp7V0s3Txa
 zVEg==
X-Gm-Message-State: AOJu0YzTwzd1Iw+JgdugGTKG7CGtmsBqSkYoHGwfvjGb3YHDTVeQrAf7
 9Iy4OUQjrCzATiD4qihnvWR0OBwQIFrEfkfsSTkCJijVrvUNb5xb1j7nBMJWy5FytBl0TWf4p7O
 ITgj9Z4ek9thXWRo=
X-Received: by 2002:a05:620a:171f:b0:76f:2529:c06a with SMTP id
 az31-20020a05620a171f00b0076f2529c06amr3310233qkb.7.1696439426904; 
 Wed, 04 Oct 2023 10:10:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFeBzx+aUetjhbDyAfOiA6X1o6sRcIlmZXYaImd/NT7QsZMSnGJ/mKzpOPt+i78aHS6FdNSQ==
X-Received: by 2002:a05:620a:171f:b0:76f:2529:c06a with SMTP id
 az31-20020a05620a171f00b0076f2529c06amr3310217qkb.7.1696439426610; 
 Wed, 04 Oct 2023 10:10:26 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 g27-20020a05620a13db00b00770f3e5618esm1399697qkl.101.2023.10.04.10.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 10:10:26 -0700 (PDT)
Date: Wed, 4 Oct 2023 13:10:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
Subject: Re: [PATCH 4/5] migration: Provide QMP access to downtime stats
Message-ID: <ZR2cgcj//sAjzOav@x1n>
References: <20230926161841.98464-1-joao.m.martins@oracle.com>
 <20230926161841.98464-5-joao.m.martins@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926161841.98464-5-joao.m.martins@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, Joao,

On Tue, Sep 26, 2023 at 05:18:40PM +0100, Joao Martins wrote:
> Deliver the downtime breakdown also via `query-migrate`
> to allow users to understand what their downtime value
> represents.

I agree downtime is an area we definitely need to improve.. however do we
need to make it part of qapi?  Or do we need them mostly for debugging
purpose?

Any introduction of motivation of this work, especially on exporting the
values to the mgmt apps?

> 
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  qapi/migration.json   | 22 ++++++++++++++++++++++
>  migration/migration.c | 14 ++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 2d91fbcb22ff..088e1b2bf440 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -217,6 +217,27 @@
>    'data': [ 'start', 'stop', 'precopy-iterable', 'precopy-noniterable',
>              'resume-return-path' ] }
>  
> +##
> +# @DowntimeStats:
> +#
> +# Detailed migration downtime statistics.
> +#
> +# @stop: Time taken to stop the VM during switchover.
> +#
> +# @precopy: Time taken to save all precopy state during switchover.
> +#
> +# @precopy-iterable: Time taken to save all precopy iterable state.
> +#
> +# @precopy-noniterable: Time taken to save all precopy non iterable state.
> +#
> +# @resume-return-path: Time taken to resume if return path is enabled,
> +#                      otherwise zero.

All these fields will more or less duplicate the ones in the other
MigrationDowntime just introduced.

We suffer from duplicated fields for migration parameters, proof shows that
dropping the duplication is normally harder..  I'm trying to dedup the
existing Migration*Parameter* objects and still in progress, so even if we
want to expose downtime in qapi I hope we can expose only one and single
object.

IIUC we can already do that by keeping DowntimeStats, keeing an object in
MigrationState, and just drop MigrationDowntime?

Thanks,

-- 
Peter Xu


