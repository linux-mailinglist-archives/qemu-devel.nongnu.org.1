Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCDD7B7FDB
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 14:53:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1MM-0006hE-M4; Wed, 04 Oct 2023 08:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qo1M9-0006OW-3C
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:52:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qo1M6-0008Es-Sf
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 08:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696423918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qGdglon1Zs+pnb5l/RnG/GPzbCq6NT0L0EIyzzkONb4=;
 b=UEw2y5MSyRdfiQHmY0tWqOFmGRyQhr5IebMqjH9RL1txjZPmfcoitH1D7k6ISHJb86bauB
 f8GzepKzG5nA3CfqJHLhhTCUZM4fz1n33Q4/MtzdsXEO9qTYfDSURNFxLV1f0ZkBsDwG/F
 cXYlY4bOKBN28bflq1vQaGFKGNcQbQ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-428-SYfxNPnWOk2Yg479xHpmvw-1; Wed, 04 Oct 2023 08:51:46 -0400
X-MC-Unique: SYfxNPnWOk2Yg479xHpmvw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32172e3679bso1519949f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 05:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696423905; x=1697028705;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qGdglon1Zs+pnb5l/RnG/GPzbCq6NT0L0EIyzzkONb4=;
 b=gSKrw9Pd33IGjlVh+bROZ+4DJc/MjijtbOrZm2S5uJN/Bn/kV0E0JYO29LKVb/iFC9
 /hx6L3m1a8boyWY7Dz88/yC0QbSj+KZ6gZ8b+BwlUJwJDFIhtdCSJncrkz3yMaKP5BTq
 RQHcAT+tBn2WRze0xkEIQoqOJ3JUZGoEU7Ednnlw/hGF6GEOKoPVV6YpT9ZoivayRlE5
 OzcQFf0TSHElvlcqg2z6v3n9KnO9GQRKwk7Haiy5DDoC/zBn+xQmFYJSaQK85tvZA0Ou
 5alPghoZ93Xh0WWm02fLIFcThn+EJBI3MGmuWz7GjtlODQL2vaaftDyGDg/Cn3tFlgo6
 M8BA==
X-Gm-Message-State: AOJu0Yw3N8Xy8ZLNsmq3ioU7bGGLBlFp2ep4J7LYEcTH5BmP3eaQFwCt
 C2Mfd9qLth+0SOA3T436vecmsMppDlO9IliiKAqiiG6T4JAubEs+6fvmZgkXAu7BMGUrqbtO6Q/
 O05LwnL+8agh7ujg=
X-Received: by 2002:a5d:630c:0:b0:31f:fa6a:936e with SMTP id
 i12-20020a5d630c000000b0031ffa6a936emr2076354wru.17.1696423905651; 
 Wed, 04 Oct 2023 05:51:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrTPs9+fN1lfdMLKE7q5AAsPHBzgxhRHCHdN5ZoQ4fS5XsOO3735sEdM6r1n4ycPczTSPVlg==
X-Received: by 2002:a5d:630c:0:b0:31f:fa6a:936e with SMTP id
 i12-20020a5d630c000000b0031ffa6a936emr2076338wru.17.1696423905342; 
 Wed, 04 Oct 2023 05:51:45 -0700 (PDT)
Received: from redhat.com ([2a02:14f:173:37ff:87f3:445a:631e:51a5])
 by smtp.gmail.com with ESMTPSA id
 l16-20020a7bc450000000b0040536dcec17sm1463388wmi.27.2023.10.04.05.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 05:51:44 -0700 (PDT)
Date: Wed, 4 Oct 2023 08:51:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/virtio/vhost: Silence compiler warnings in vhost code
 when using -Wshadow
Message-ID: <20231004085134-mutt-send-email-mst@kernel.org>
References: <20231004114809.105672-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004114809.105672-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Wed, Oct 04, 2023 at 01:48:09PM +0200, Thomas Huth wrote:
> Rename a variable in vhost_dev_sync_region() and remove a superfluous
> declaration in vhost_commit() to make this code compilable with "-Wshadow".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>


> ---
>  hw/virtio/vhost.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index e2f6ffb446..9cfac40fde 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -66,12 +66,12 @@ static void vhost_dev_sync_region(struct vhost_dev *dev,
>                                    uint64_t mfirst, uint64_t mlast,
>                                    uint64_t rfirst, uint64_t rlast)
>  {
> -    vhost_log_chunk_t *log = dev->log->log;
> +    vhost_log_chunk_t *dev_log = dev->log->log;
>  
>      uint64_t start = MAX(mfirst, rfirst);
>      uint64_t end = MIN(mlast, rlast);
> -    vhost_log_chunk_t *from = log + start / VHOST_LOG_CHUNK;
> -    vhost_log_chunk_t *to = log + end / VHOST_LOG_CHUNK + 1;
> +    vhost_log_chunk_t *from = dev_log + start / VHOST_LOG_CHUNK;
> +    vhost_log_chunk_t *to = dev_log + end / VHOST_LOG_CHUNK + 1;
>      uint64_t addr = QEMU_ALIGN_DOWN(start, VHOST_LOG_CHUNK);
>  
>      if (end < start) {
> @@ -549,7 +549,7 @@ static void vhost_commit(MemoryListener *listener)
>          changed = true;
>      } else {
>          /* Same size, lets check the contents */
> -        for (int i = 0; i < n_old_sections; i++) {
> +        for (i = 0; i < n_old_sections; i++) {
>              if (!MemoryRegionSection_eq(&old_sections[i],
>                                          &dev->mem_sections[i])) {
>                  changed = true;
> -- 
> 2.41.0


