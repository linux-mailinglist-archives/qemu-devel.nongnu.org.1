Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 908427D56B7
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 17:41:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJWW-00021i-60; Tue, 24 Oct 2023 11:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvJW7-0001vU-Uh
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:40:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qvJW2-0007Vb-DR
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:40:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698162021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nfnK6KCAMm5eCKhpzjePkW5k2ntuJtG9C3FrsfCKWIQ=;
 b=UGJ2yecBGE/7xxehQsLlC2Sw0Dejc5BR6fsJoxHPPxSu6yy93IisyFrkx2WCotlifel+vK
 78WlboDUAapLJtZwPKRSm/BqIGxapIQnBmhsvtnYeDl/opm4YJepyjm9ko/ZE2rEBlYhEH
 VEZS2f19bPgj+7xm0FoE66CuJPZPAKw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-PEgXCVLZO3ycWA19HR-ZGA-1; Tue, 24 Oct 2023 11:40:15 -0400
X-MC-Unique: PEgXCVLZO3ycWA19HR-ZGA-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-3b3e1c828a4so7103460b6e.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698162013; x=1698766813;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nfnK6KCAMm5eCKhpzjePkW5k2ntuJtG9C3FrsfCKWIQ=;
 b=WAdIG+oPe82jz1uEZAM/aZoHmIU5hrDV75sp7vgt+/L4LuxbhVMfHWTGSYgYfXJSOK
 DxTmrpS413norZTNb4Tg0LxhUqGaUev0e1nnz33jzsXzO0PqRhCaIqD4ogD4r3k2f90l
 q2R45CMxYW8IApxTVj7lHF/5ve/J9cSMRU0IGnkj4uFZZq/xy7Mavb7lH9ECAzFWdflc
 hnrdC5jaBp2NUM4CeiFRgIekMM+RIBbkEZMtcwbEFZVIPMNFGoyDFZv6sYjOCIFtNbCd
 6cMYC63scarnVw/eNMeUSHCybTi4+SRy40bHbRxQ05Ib69BuS+ljS/hWf+nQSjLHJj75
 MDzg==
X-Gm-Message-State: AOJu0YwKGvVIEJ0yfe/AWovSqaE+1nmVptoLuWDrVHgbEQoQUrhwLXRU
 bLAydyUxxNdhiGycim4+ABr+iD43cK1wMFE6jSB+NfexUZkp76HOTjlAQjBMnwCf1JXOkvp637x
 bo1mSStV9Uy4vt1o=
X-Received: by 2002:a54:4113:0:b0:3ab:8431:8037 with SMTP id
 l19-20020a544113000000b003ab84318037mr14011486oic.32.1698162013747; 
 Tue, 24 Oct 2023 08:40:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHS6/LhHcR94lx46Wpci9wpYRZ5jECwkRSWLzUg89JR9Bkk9jHdtBCFT8RTeeK6+TVm/LTGUg==
X-Received: by 2002:a54:4113:0:b0:3ab:8431:8037 with SMTP id
 l19-20020a544113000000b003ab84318037mr14011470oic.32.1698162013504; 
 Tue, 24 Oct 2023 08:40:13 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-176-238.web.vodafone.de.
 [109.43.176.238]) by smtp.gmail.com with ESMTPSA id
 u13-20020a0ced2d000000b0065b2167fd63sm3648703qvq.65.2023.10.24.08.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 08:40:13 -0700 (PDT)
Message-ID: <d4624b9a-ca5c-4576-b86e-a5290de7a81e@redhat.com>
Date: Tue, 24 Oct 2023 17:40:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] migration: Stop migration immediately in RDMA error paths
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Zhijian Li <lizhijian@fujitsu.com>, Markus Armbruster
 <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
References: <20231024153313.500783-1-peterx@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20231024153313.500783-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/10/2023 17.33, Peter Xu wrote:
> In multiple places, RDMA errors are handled in a strange way, where it only
> sets qemu_file_set_error() but not stop the migration immediately.
> 
> It's not obvious what will happen later if there is already an error.  Make
> all such failures stop migration immediately.
> 
> Cc: Zhijian Li (Fujitsu) <lizhijian@fujitsu.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> This patch is based on Thomas's patch:
> 
> [PATCH v2] migration/ram: Fix compilation with -Wshadow=local
> https://lore.kernel.org/r/20231024092220.55305-1-thuth@redhat.com
> 
> Above patch should have been queued by both Markus and Juan.
> ---
>   migration/ram.c | 11 +++++++----
>   1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 212add4481..28cb2deffb 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3034,11 +3034,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>       ret = rdma_registration_start(f, RAM_CONTROL_SETUP);
>       if (ret < 0) {
>           qemu_file_set_error(f, ret);
> +        return ret;
>       }
>   
>       ret = rdma_registration_stop(f, RAM_CONTROL_SETUP);
>       if (ret < 0) {
>           qemu_file_set_error(f, ret);
> +        return ret;
>       }
>   
>       migration_ops = g_malloc0(sizeof(MigrationOps));
> @@ -3104,6 +3106,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>           ret = rdma_registration_start(f, RAM_CONTROL_ROUND);
>           if (ret < 0) {
>               qemu_file_set_error(f, ret);
> +            goto out;
>           }
>   
>           t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> @@ -3208,8 +3211,6 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>       rs->last_stage = !migration_in_colo_state();
>   
>       WITH_RCU_READ_LOCK_GUARD() {
> -        int rdma_reg_ret;
> -
>           if (!migration_in_postcopy()) {
>               migration_bitmap_sync_precopy(rs, true);
>           }
> @@ -3217,6 +3218,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>           ret = rdma_registration_start(f, RAM_CONTROL_FINISH);
>           if (ret < 0) {
>               qemu_file_set_error(f, ret);
> +            break;
>           }
>   
>           /* try transferring iterative blocks of memory */
> @@ -3240,9 +3242,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>   
>           ram_flush_compressed_data(rs);
>   
> -        rdma_reg_ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> -        if (rdma_reg_ret < 0) {
> +        ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> +        if (ret < 0) {
>               qemu_file_set_error(f, rdma_reg_ret);

I think you have to replace rdma_reg_ret here with ret again?

  Thomas


> +            break;
>           }
>       }
>   


