Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ED882D35C
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:33:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDjG-0008Vv-NC; Sun, 14 Jan 2024 22:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDjF-0008Vb-Aa
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rPDjD-0006b6-SY
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705289615;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r4Ftgn3X/NnEMcQP/Wn5Ig1h9yNUYvEeX2BWfADg2iM=;
 b=RkSNBp9A0iF2wJeeL/qM2Q0zrftF9c0MQS8tVAPd132uM8xOEZjYF7b547CY0OWWvHHiXR
 vR5/YWJc/WZQ3CoZV1mp8hAwdT2VCN11bg/STvBTIoDvYZsvDSPpQVxSlV5OdyMUsBDrFp
 CPnMAViZ/3qzyn3ThFRAig73dVbMeDM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-BqLXzQthMuWcZfNfLbhw4w-1; Sun, 14 Jan 2024 22:33:28 -0500
X-MC-Unique: BqLXzQthMuWcZfNfLbhw4w-1
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3bbc40771a9so9987385b6e.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:33:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705289607; x=1705894407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r4Ftgn3X/NnEMcQP/Wn5Ig1h9yNUYvEeX2BWfADg2iM=;
 b=JUhrBDRxHelkbMMD3q5F+19cztP6FaDPij7lYjsdyaYcSeRibOIMtU4stN9LTjqrVu
 boNsy4/LgsWfV7+kZE6Wi/iucvUqNtT291wudAC5Nz/OqrDVgJXYHBdfo7PuSIETTK8Q
 APj/LTyqXdeH8VCFMP+BdfQH0dYjo7kDvmzxnJIw5ShMAsV2MTB/krMKJ1FTF4c1HtNT
 btvmU1oXvz/hRVKR9o/b6RgTS+49ILpSFGnemD3mKb7nB57XGJhGUGXfBR/DIsPN8XB/
 koCRWE5DGk04b/9Gh5J1xKIC46oKp+sByrWQKYEeNK3WPUkAKQ6cH1YVvd5jWFVb0o9c
 2wnA==
X-Gm-Message-State: AOJu0Yy4IHhMPXBL/koac8Ar5Lv9owKIxFO7QZoG4HA318A367X4fuy+
 mzpM+c7q/9DwjZCCGOpcYzldZ0PxmRIOWiFslxX1kw4PyKDu5p6q44oBkUZ+ge0/QluvxZDCtpn
 s+hchqiiocFwWMccQzw2jPCx+AIwDmt4YNnsBAzc=
X-Received: by 2002:a05:6808:3991:b0:3bd:726d:33b5 with SMTP id
 gq17-20020a056808399100b003bd726d33b5mr3889883oib.63.1705289607484; 
 Sun, 14 Jan 2024 19:33:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERplm4AQ7XajplE6lfl+lrbjRu96xbTDAiX+kXksdOa3PH818SiPxcQsIK8QyyesHgZ89NYhBeb57qc4bT85Y=
X-Received: by 2002:a05:6808:3991:b0:3bd:726d:33b5 with SMTP id
 gq17-20020a056808399100b003bd726d33b5mr3889869oib.63.1705289607313; Sun, 14
 Jan 2024 19:33:27 -0800 (PST)
MIME-Version: 1.0
References: <1701970793-6865-1-git-send-email-si-wei.liu@oracle.com>
 <1701970793-6865-31-git-send-email-si-wei.liu@oracle.com>
In-Reply-To: <1701970793-6865-31-git-send-email-si-wei.liu@oracle.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Jan 2024 11:33:16 +0800
Message-ID: <CACGkMEtS3cE8S7Tz5XLzNcw-9bCZp-iwoWNRFYLbAsEEe52njQ@mail.gmail.com>
Subject: Re: [PATCH 30/40] vdpa: batch map/unmap op per svq pair basis
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: eperezma@redhat.com, mst@redhat.com, dtatulea@nvidia.com, 
 leiyang@redhat.com, yin31149@gmail.com, boris.ostrovsky@oracle.com, 
 jonah.palmer@oracle.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Dec 8, 2023 at 2:51=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> w=
rote:
>
> Coalesce multiple map or unmap operations to just one
> so that all mapping setup or teardown can occur in a
> single DMA batch.
>
> Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks


