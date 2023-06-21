Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 96839738A3A
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 17:57:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC0CP-0002Ha-6a; Wed, 21 Jun 2023 11:56:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC0CI-0002DR-Sf
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 11:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qC0CH-0006yx-I4
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 11:56:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687363000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pw1DWHoVOvgdsEC8A7HibeA8a80tOsGu1m6L+hqJcR0=;
 b=bV0yFhtKXni4p6idsXPtG4PwDaXPYBEmnIJvkVPyRfUwFhZuQS4UbLUVRVJtjcV4xy/hc1
 Y/ksaMZslvkY5k08GeHYwcJNGTKJdDajyjEqNQ2qdkra/D+Zi37xzo3ozHs70jehfEZyRq
 r7bjezeURIeaFformwoXBRuIXeuwmkA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-zzokA2WLOPWJ_-ghMCb3Tw-1; Wed, 21 Jun 2023 11:56:39 -0400
X-MC-Unique: zzokA2WLOPWJ_-ghMCb3Tw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f9e7a1caf2so13028411cf.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 08:56:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687362999; x=1689954999;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pw1DWHoVOvgdsEC8A7HibeA8a80tOsGu1m6L+hqJcR0=;
 b=MO7tItdzvWV+90T+RctidB2BXJZtQtdXeTUFu5+VlommxMGkDeRyVTyoGXJmB+50Tz
 3Jj1b/59vYBvz93eMF57u1zFpCTYwjKTEy3IzNvOh0OGm/YOVHND0BsC6WzPcFAKOOVn
 HKH9CGteeVxrkSeNywbRJom1MoB4/586QmKW8l2HsMhiA0YMkK6DV2+KEHo/oghdqLNf
 9nIrTHmLe5ifoB2MJgJw3rpkwtFlN+8gZD4hfzf7DspTvJgHZUxNEAwEjuLRuu2F6+gY
 LRpRsPzoWuSd/T3aHYr3VezRTAxNhOu5jC9G6W3uXmzIGwMQbyEXn3r3vVEnVTrL+vP9
 XEkw==
X-Gm-Message-State: AC+VfDz5Do5AXiNbPWxoW2Ad7waggskD3opNcWWBT6yE/SvrWYTfeqmz
 +j7pZzN4oLAkvY79XgW3XrT+f9wcg9t8WVXJxW406QddZsB4SGdFniVS4xzFqP39H+lxoArzQEO
 l4Xa0+lDPsO4ypxU=
X-Received: by 2002:a05:622a:1baa:b0:3f5:315f:5c1d with SMTP id
 bp42-20020a05622a1baa00b003f5315f5c1dmr19218677qtb.4.1687362999022; 
 Wed, 21 Jun 2023 08:56:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7N3N6Ym4MyOmdoSghZ0iuLy/0I1TOVSXdg3nmJTVGjV8DMyXa1zDo3hlkmD15TYNPAvVaUuQ==
X-Received: by 2002:a05:622a:1baa:b0:3f5:315f:5c1d with SMTP id
 bp42-20020a05622a1baa00b003f5315f5c1dmr19218660qtb.4.1687362998744; 
 Wed, 21 Jun 2023 08:56:38 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s6-20020ac85ec6000000b003e635f80e72sm2506827qtx.48.2023.06.21.08.56.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 08:56:38 -0700 (PDT)
Date: Wed, 21 Jun 2023 11:56:37 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH v1 3/4] migration/ram: Expose ramblock_is_ignored() as
 migrate_ram_is_ignored()
Message-ID: <ZJMdtbFdHkqccGQ4@x1n>
References: <20230620130354.322180-1-david@redhat.com>
 <20230620130354.322180-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230620130354.322180-4-david@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 20, 2023 at 03:03:53PM +0200, David Hildenbrand wrote:
> virtio-mem wants to know whether it should not mess with the RAMBlock
> content (e.g., discard RAM, preallocate memory) on incoming migration.
> 
> So let's expose that function as migrate_ram_is_ignored() in
> migration/misc.h
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


