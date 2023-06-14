Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D8D7302EC
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 17:09:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9S68-0007f8-NL; Wed, 14 Jun 2023 11:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9S67-0007eh-9e
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:07:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q9S64-00015r-Gd
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 11:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686755263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RKKe453kAJrG+QS/ujv1eKoVCPR8A21rK9epL+S0kt4=;
 b=Z6kncb9ZCDYgTNzDw4KddsBb3knQ9GEO4ONGt1EDyH5ipgAO+MeyI2XbKyl+IMDAxPitC8
 V9mhVRto1U+Z+WAzZQft3NQ0CIZF6PIetHHW9XMczxqRN9E/wHZu6URXEPWhb20A/DSYoL
 b9Zaxa7/Ywz+yUcxef6jSKzpPEY7N78=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-LmM98cf5PG-BFYQe6YiBzA-1; Wed, 14 Jun 2023 11:07:42 -0400
X-MC-Unique: LmM98cf5PG-BFYQe6YiBzA-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-62f6c47e89cso2081796d6.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 08:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686755261; x=1689347261;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RKKe453kAJrG+QS/ujv1eKoVCPR8A21rK9epL+S0kt4=;
 b=devk2v2t4YSsapapmSek0AtSYjoB3z1AqI2Sossn1Rxh0ja2IoDQomE6vKHqAfgmuC
 aMklDpP7ZvnkKoK5MADzO5wNm9Te56k567vlyhpdsOSStkI6cMv54zuerXzBwwb1bVzp
 hYP40LqDHMxa+P57C14tHDupnMMnIe6XSQ3e7ByuW+zsOBdKizsc8zQEWahLkOayZjn0
 uEn93fknsrkAhMyK9y/caQ8lrQwz64Oq2df0H+eGHozE6o3yVh+BIJE0+rtjTLdJH96z
 sSF98rt/PJOZLGRQqjFYo3I2VsgS6aKPRLt/A3EDsoS/TW5CtyvL00FcGGYsuk40NCnk
 aPww==
X-Gm-Message-State: AC+VfDxm27LAjoSpMUG6oZIcmcgq+OeR/AYsjzUhgsoZQV83Sf8eW/DI
 ZsyDB+/0v6RBKqV5WjymSBDdpDgAgKhuT0mOPlOozWjk7Hc71PVNar9Ylafty9H1LY6W1hLxMfS
 4N3kcDVStPFvhQ3qGHZUmOew=
X-Received: by 2002:ad4:5bca:0:b0:5ed:c96e:ca4a with SMTP id
 t10-20020ad45bca000000b005edc96eca4amr18561823qvt.1.1686755261357; 
 Wed, 14 Jun 2023 08:07:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Plj+Gl02Tv3vXzMZnupQDJAYWccBnn3DXZfHuIWZNxVRvCqVSmH7DGGbxS6Iai/M6qOLVaA==
X-Received: by 2002:ad4:5bca:0:b0:5ed:c96e:ca4a with SMTP id
 t10-20020ad45bca000000b005edc96eca4amr18561806qvt.1.1686755261026; 
 Wed, 14 Jun 2023 08:07:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c19-20020a0cf2d3000000b0062ded562c53sm149545qvm.37.2023.06.14.08.07.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 08:07:40 -0700 (PDT)
Date: Wed, 14 Jun 2023 11:07:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Fiona Ebner <f.ebner@proxmox.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 16/20] migration/rdma: Split qemu_fopen_rdma() into
 input/output functions
Message-ID: <ZInXtXhl7gF+nMDJ@x1n>
References: <20230530183941.7223-1-quintela@redhat.com>
 <20230530183941.7223-17-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530183941.7223-17-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, May 30, 2023 at 08:39:37PM +0200, Juan Quintela wrote:
> This is how everything else in QEMUFile is structured.
> As a bonus they are three less lines of code.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  migration/rdma.c | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 3ef35fc635..606837bd45 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -4046,25 +4046,22 @@ static void qio_channel_rdma_register_types(void)
>  
>  type_init(qio_channel_rdma_register_types);
>  
> -static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma, const char *mode)
> +static QEMUFile *rdma_new_input(RDMAContext *rdma)
>  {
> -    QIOChannelRDMA *rioc;
> +    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
> +    rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
> +    rioc->rdmain = rdma;
> +    rioc->rdmaout = rdma->return_path;
>  
> -    if (qemu_file_mode_is_not_valid(mode)) {

We can also drop this function together.  If with that:

Reviewed-by: Peter Xu <peterx@redhat.com>

> -        return NULL;
> -    }
> +    return rioc->file;
> +}
>  
> -    rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
> -
> -    if (mode[0] == 'w') {
> -        rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
> -        rioc->rdmaout = rdma;
> -        rioc->rdmain = rdma->return_path;
> -    } else {
> -        rioc->file = qemu_file_new_input(QIO_CHANNEL(rioc));
> -        rioc->rdmain = rdma;
> -        rioc->rdmaout = rdma->return_path;
> -    }
> +static QEMUFile *rdma_new_output(RDMAContext *rdma)
> +{
> +    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
> +    rioc->file = qemu_file_new_output(QIO_CHANNEL(rioc));
> +    rioc->rdmaout = rdma;
> +    rioc->rdmain = rdma->return_path;
>  
>      return rioc->file;
>  }
> @@ -4090,9 +4087,9 @@ static void rdma_accept_incoming_migration(void *opaque)
>          return;
>      }
>  
> -    f = qemu_fopen_rdma(rdma, "rb");
> +    f = rdma_new_input(rdma);
>      if (f == NULL) {
> -        fprintf(stderr, "RDMA ERROR: could not qemu_fopen_rdma\n");
> +        fprintf(stderr, "RDMA ERROR: could not open RDMA for input\n");
>          qemu_rdma_cleanup(rdma);
>          return;
>      }
> @@ -4217,7 +4214,7 @@ void rdma_start_outgoing_migration(void *opaque,
>      trace_rdma_start_outgoing_migration_after_rdma_connect();
>  
>      s->rdma_migration = true;
> -    s->to_dst_file = qemu_fopen_rdma(rdma, "wb");
> +    s->to_dst_file = rdma_new_output(rdma);
>      migrate_fd_connect(s, NULL);
>      return;
>  return_path_err:
> -- 
> 2.40.1
> 

-- 
Peter Xu


