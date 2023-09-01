Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1E790026
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 17:51:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc6P6-00081q-0u; Fri, 01 Sep 2023 11:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qc6P4-00081i-Gi
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 11:49:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qc6P2-0006ug-EF
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 11:49:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693583383;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lk2tOer5KRsjxsoDDqxKrAc85w2V968MNfvwVD/hcy0=;
 b=Om+jN7kEq0vBO/GakHcodpj4VolgHjubOKA4UVLHb+MNxIX6YrEtuKahwIprK63RVYGTCM
 aBG20mYYkB/gj0uFYVQ+NHy+YW3CmUjKYHTuLO8yMo/K0hdqwEFNREp6ubGXti24g1xBKq
 YSbI7Th4sdvSJugKJHWF9qB53NRXv78=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-oeaOs1_EPYy2E0YFs4GrGA-1; Fri, 01 Sep 2023 11:49:41 -0400
X-MC-Unique: oeaOs1_EPYy2E0YFs4GrGA-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6b9ef9c2268so417571a34.1
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 08:49:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693583381; x=1694188181;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lk2tOer5KRsjxsoDDqxKrAc85w2V968MNfvwVD/hcy0=;
 b=aui3JXHyfV0sFM5wvbleShfMC8sYHZKjguo9RTeoXV1FWA8DHLo2ZokR4o5lqAT0BM
 DAl2aVU2le4MQ1Xd5YyOEgxByNoXIfMR7/dklnEU4GaTZJCjBQjzvyMh5foS91PYyGRj
 bFxr5i6vjZJjmj5W4lnnDzI3sd5rOZR5Nj4Zf14DEOXuCoYkWgAxFW9VugsVI6g5XX28
 tW6xXSvJefRtAd2n1ddsDJQFmZs1MCl4ZBV1MHcOdbxDtuLlxf6x9WVUSSsxNqVT57oO
 KCat7fH39yh0PWOGVpg7GbZMTxHZ/g9vndTxcLWiwkLU2yLmWWk5pYDQcUdt6rLmKbNF
 zLbA==
X-Gm-Message-State: AOJu0Yz6WBrDTMYS0BCZBz2LhMq/+L56a2AX6pMGVHy8LbIUWxS6ohMi
 5zKvmXol9PsgpewtFseiIrzNTt+/PXBNOcEwrEHckh22kQAgK+60o6iN5MbrGljSSBJDaGqkY8F
 SK84DjQWwtGxm2RE=
X-Received: by 2002:a05:6830:4694:b0:6b7:36af:1937 with SMTP id
 ay20-20020a056830469400b006b736af1937mr3164890otb.0.1693583380858; 
 Fri, 01 Sep 2023 08:49:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkbdXOHvjoQYJsNJOrN9s2ij7vRQkpj7kojLLuXuLXsXNkpP7f8uM8xadSqGgoDZk4glny8A==
X-Received: by 2002:a05:6830:4694:b0:6b7:36af:1937 with SMTP id
 ay20-20020a056830469400b006b736af1937mr3164870otb.0.1693583380588; 
 Fri, 01 Sep 2023 08:49:40 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c6-20020ae9e206000000b00767e98535b7sm1478498qkc.67.2023.09.01.08.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 08:49:40 -0700 (PDT)
Date: Fri, 1 Sep 2023 11:49:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: Re: [PATCH v2 3/5] migration: Add .save_prepare() handler to struct
 SaveVMHandlers
Message-ID: <ZPIIEYhcwPJLg2Lj@x1n>
References: <20230831125702.11263-1-avihaih@nvidia.com>
 <20230831125702.11263-4-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831125702.11263-4-avihaih@nvidia.com>
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

On Thu, Aug 31, 2023 at 03:57:00PM +0300, Avihai Horon wrote:
> Add a new .save_prepare() handler to struct SaveVMHandlers. This handler
> is called early, even before migration starts, and can be used by
> devices to perform early checks.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Shouldn't be hard to unify the two call sites for qmp migrate and save
snapshot, but we can leave that for later:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu


