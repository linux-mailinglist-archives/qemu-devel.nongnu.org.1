Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8967AB4F0
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:42:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiIM-0008AS-U2; Fri, 22 Sep 2023 11:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qjiIK-00089p-AK
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qjiII-0002m6-QM
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397333;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vUA1nRalfY9M4ETL09k6n2NzMXfoRTg8q5yj/tahJP8=;
 b=HNhDBT8mWkot3iC5Z0GIiStQShWMwM+4AP/zzPy5JFQxuSCkMfDDn634d3KP38j/FrAPGJ
 y1/UBDV8HHinuk2O3wc7J15mOVOe5P+PpwbNY5Non7Ucjv4ykrQ3z0QhFp1UoKCE1jR5Vm
 e/nCVH1GW1inrUfdX3WdlyIG/6FQ9T0=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-E3eQdMKANPaV6CdkS2vIlQ-1; Fri, 22 Sep 2023 11:42:12 -0400
X-MC-Unique: E3eQdMKANPaV6CdkS2vIlQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1d6919e74c6so203086fac.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397331; x=1696002131;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vUA1nRalfY9M4ETL09k6n2NzMXfoRTg8q5yj/tahJP8=;
 b=AJ5BkxUzt1/huQiQC72dXmGJPp99bitWiK50agTgtu5Wljv++XZ5i201juKraMK//I
 9YFt2fpZ05GltClCr2AyRcsQusUZps5l986bH8/hCBgK6KqoOtTmkDCwKJS1WaJrwpXU
 ptt8HCYe2wTw/Ynovt7cWZmk4vBxy3bSFRzCVjWMZfJS9ZNfR1IzEJ7+j20QUdQbkozm
 VbXAqdTVvYZM5zqbbSS/t13e9vw5uGWR1KRlwpySsiR3R9Eg7HqxzVxM4TrRHAShVfmj
 uPEZ7R/i3jLAc4GxG0QTNjyySo2xqf9ztgC079gJMtYNkfR5XgpvER/Wq1klm0QzMeRe
 /UtQ==
X-Gm-Message-State: AOJu0Yydlh8If+aLp9g65It1C7R7OoGv5zDdSQJFhmpgZiAmhc73cjks
 pYWTNeuGw8cSGVSgMr5dGl9ChNwn0kS01s2NqolRbLyNQ0j6WYnVggB7yTw5UmnCJ4MDKrWyWJx
 Ah9f8pzRYQ+NDzoI=
X-Received: by 2002:a05:6870:6128:b0:1bf:9fa2:bfa3 with SMTP id
 s40-20020a056870612800b001bf9fa2bfa3mr8849828oae.1.1695397331414; 
 Fri, 22 Sep 2023 08:42:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR1yV1SC0Mjug6saA4AQd0lOJuLZNn0nANV1LEyyq79PPSqjefhd0jEIsthxXGrFhYUraNvw==
X-Received: by 2002:a05:6870:6128:b0:1bf:9fa2:bfa3 with SMTP id
 s40-20020a056870612800b001bf9fa2bfa3mr8849809oae.1.1695397331077; 
 Fri, 22 Sep 2023 08:42:11 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j17-20020a0cf311000000b0065635a05e64sm1516984qvl.20.2023.09.22.08.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:10 -0700 (PDT)
Date: Fri, 22 Sep 2023 11:42:08 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: quintela@redhat.com, leobras@redhat.com, qemu-devel@nongnu.org,
 Li Zhijian <lizhijian@cn.fujitsu.com>
Subject: Re: [PATCH 1/2] migration: Fix rdma migration failed
Message-ID: <ZQ210LoAWDIJ5l9J@x1n>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920090412.726725-1-lizhijian@fujitsu.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 20, 2023 at 05:04:11PM +0800, Li Zhijian wrote:
> From: Li Zhijian <lizhijian@cn.fujitsu.com>
> 
> Destination will fail with:
> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
> 
> migrate with RDMA is different from tcp. RDMA has its own control
> message, and all traffic between RDMA_CONTROL_REGISTER_REQUEST and
> RDMA_CONTROL_REGISTER_FINISHED should not be disturbed.
> 
> find_dirty_block() will be called during RDMA_CONTROL_REGISTER_REQUEST
> and RDMA_CONTROL_REGISTER_FINISHED, it will send a extra traffic to
> destination and cause migration to fail.
> 
> Since there's no existing subroutine to indicate whether it's migrated
> by RDMA or not, and RDMA is not compatible with multifd, we use
> migrate_multifd() here.
> 
> Fixes: 294e5a4034 ("multifd: Only flush once each full round of memory")
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  migration/ram.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 9040d66e61..89ae28e21a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1399,7 +1399,8 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (!migrate_multifd_flush_after_each_section()) {
> +            if (migrate_multifd() &&
> +                !migrate_multifd_flush_after_each_section()) {
>                  QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
>                  int ret = multifd_send_sync_main(f);
>                  if (ret < 0) {
> -- 
> 2.31.1
> 

Maybe better to put that check at the entry of
migrate_multifd_flush_after_each_section()?

I also hope that some day there's no multifd function called in generic
migration code paths..

-- 
Peter Xu


