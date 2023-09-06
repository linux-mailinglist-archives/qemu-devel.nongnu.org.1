Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AC979401F
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:18:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qduIG-0002Pi-ET; Wed, 06 Sep 2023 11:18:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qduIE-0002P9-1t
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:18:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qduIC-0005Te-0E
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694013487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C1dhm3KdQokglUf4I4epdFoh1BtZoaPlAhPa714b83A=;
 b=Uye7uiD93kCHxxt2rK90oIKAxAtqs6d/Aq0P87bWnT1kk3cjuUEtF3bGY+5On/rvJ75Yld
 Sg/qwoVU1UoSqVdm9yLjBbJ2fokRFM7/PHH/8oNPX1fVRp8K8CFrjZo4/GNHVYo/2ks8p7
 C7yN7Hy0fzwF4rxxXkose1YV90uAQcw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-qzSsvyvTPESq7p0QLpVrWA-1; Wed, 06 Sep 2023 11:18:05 -0400
X-MC-Unique: qzSsvyvTPESq7p0QLpVrWA-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76f0d1c4045so56435385a.1
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 08:18:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694013485; x=1694618285;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1dhm3KdQokglUf4I4epdFoh1BtZoaPlAhPa714b83A=;
 b=bMrFtzLIW9WtC3tH5r+TkuILfBsvmJrjsb4c79NkmsXcTl2919Ojs78RCcy9V0wI3W
 At+fQoXYzLOxdujGCpWb12t9FTwDfZEPs9PIkYAPW4GUeHylXY44eNlvSyb79nqdwiyU
 TaR5oUBfkP9AwrLbACSbSpZZRJMbsXdHkABXeIJhoY+atcyzmiUViQuBS69DqDrPdxI3
 AGX7l1x0o3ozwvIeQskNpZLQgFWWXx5wxnpv20tMJe//Do8HIjjVEnxjMGGbXV2KqvHK
 kXIfaVk/Hyc/LgTNQ/WVaPu7O68GNIfxFLgtNUbrn5e9AiLVr87bFQL+VLF9LQLd1Vk0
 Tz+w==
X-Gm-Message-State: AOJu0YzbvIxPmiJJU/N2G9mwHylzJFHrVMez0DPxUVuFu++cX9FU6EL7
 SJmRDDnUeTFpMDz2JCTtj17ZEZzuwpJpqoJIuAo4O5lLCwiGBbUGeEEF1F8WLijeP4K2FlpuUg8
 boRMmCt8+UfzsjUk=
X-Received: by 2002:a05:620a:190c:b0:76c:f408:6ba6 with SMTP id
 bj12-20020a05620a190c00b0076cf4086ba6mr18746499qkb.2.1694013484931; 
 Wed, 06 Sep 2023 08:18:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLVJnNmfzbJE8HDBPbDWysUpr/KjdKpfzTs6B5fxU60Ml3vAJ8QkQHPuFiu5dzqzU7kzE6uw==
X-Received: by 2002:a05:620a:190c:b0:76c:f408:6ba6 with SMTP id
 bj12-20020a05620a190c00b0076cf4086ba6mr18746480qkb.2.1694013484602; 
 Wed, 06 Sep 2023 08:18:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 y21-20020a37e315000000b0076827ce13f6sm5032141qki.10.2023.09.06.08.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 08:18:04 -0700 (PDT)
Date: Wed, 6 Sep 2023 11:18:03 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: Re: [PATCH v3 5/6] vfio/migration: Block VFIO migration with
 postcopy migration
Message-ID: <ZPiYK+56KW4ldJxn@x1n>
References: <20230906150853.22176-1-avihaih@nvidia.com>
 <20230906150853.22176-6-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230906150853.22176-6-avihaih@nvidia.com>
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

On Wed, Sep 06, 2023 at 06:08:52PM +0300, Avihai Horon wrote:
> VFIO migration is not compatible with postcopy migration. A VFIO device
> in the destination can't handle page faults for pages that have not been
> sent yet.
> 
> Doing such migration will cause the VM to crash in the destination:
> 
> qemu-system-x86_64: VFIO_MAP_DMA failed: Bad address
> qemu-system-x86_64: vfio_dma_map(0x55a28c7659d0, 0xc0000, 0xb000, 0x7f1b11a00000) = -14 (Bad address)
> qemu: hardware error: vfio: DMA mapping failed, unable to continue
> 
> To prevent this, block VFIO migration with postcopy migration.
> 
> Reported-by: Yanghang Liu <yanghliu@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Tested-by: Yanghang Liu <yanghliu@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


