Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC4470FE85
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 21:26:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1u6g-00032d-EP; Wed, 24 May 2023 15:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1u6e-00032Q-A5
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:25:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1u6b-0002dG-0e
 for qemu-devel@nongnu.org; Wed, 24 May 2023 15:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684956303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I+m/OM+TYIEtVrUo8X1Hex5TlIAW2CUc6zfsIrecAKc=;
 b=PNjNrvkyfly1EhtE+xiutp5E/RLmPXgAQGvMS4MDfRA9hdoncuOr95CFfzHvy/KXCXzmoS
 enP+vUjRIiWuf+XLxHABb95Utpz/+adXyt/DP021kyGz1pM26nBpZbMx57+qFL7oa84XrK
 Zlm/EpA0vckEpEMgs92ZV1Bj1Oj5RIs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-pGQ8taRCNVWpqv_-TU2zuQ-1; Wed, 24 May 2023 15:25:01 -0400
X-MC-Unique: pGQ8taRCNVWpqv_-TU2zuQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-74faf5008bbso29397285a.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 12:25:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684956301; x=1687548301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I+m/OM+TYIEtVrUo8X1Hex5TlIAW2CUc6zfsIrecAKc=;
 b=QP2Bofnl+EYOE73R7vU7YIB/nxl051pCnmG1HmnGQ/7kBNWXQNgWO3Hhos6ek2WJeA
 AWx8qHuasa/djSi/zgMAre3bxDtufdLw9VAi8Q2/cCLl/7AbQwGiOQW6bEvpYjgsJTiM
 BTobM/CFaA7PMABRD0sHT3nMv5Qfbp6rDfvlKxxckQoavKja5nnY4/VieX1IwR1eLi3J
 3DS6q5vDE4oZ6+/ay0YO9OGgnEmhtdphg9U7W18JDAuCxnZDuOF5/glSYesYyhS2CpQu
 rlwj7a+Kfk2dhtOffulW3XnzsKqBoXqGXUEJYcaxyJ7k7MJ2gvailHWFFgANxCRE43fC
 jzhQ==
X-Gm-Message-State: AC+VfDwRRFcHifjFDtDmY1K8mqDw1HWuIkdshEXxw22X641Tz/1u0OE5
 zqNhgtWvb5doiAdBJ5vTUQO/fmO8OYeuuTY9CEe7cjoxkcetZWIppPm+rmf07s6e+iYxcCRTmjU
 a2ORkdmbM03BkZCE=
X-Received: by 2002:a05:622a:18a4:b0:3f5:315f:5c1d with SMTP id
 v36-20020a05622a18a400b003f5315f5c1dmr29745183qtc.4.1684956301312; 
 Wed, 24 May 2023 12:25:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4L6LWY/jaoVuGF0JcrjEDV1yUFU6ZdPR3xPUA7CeMpeSELBWojyUz/CB03A3kHqm0ZAKJeIg==
X-Received: by 2002:a05:622a:18a4:b0:3f5:315f:5c1d with SMTP id
 v36-20020a05622a18a400b003f5315f5c1dmr29745141qtc.4.1684956301053; 
 Wed, 24 May 2023 12:25:01 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 l16-20020ac84a90000000b003f543cbb698sm3948439qtq.23.2023.05.24.12.24.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 12:25:00 -0700 (PDT)
Date: Wed, 24 May 2023 15:24:58 -0400
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
Subject: Re: [PATCH v3 1/7] migration: Add switchover ack capability
Message-ID: <ZG5kismf3h0X3cAh@x1n>
References: <20230521151808.24804-1-avihaih@nvidia.com>
 <20230521151808.24804-2-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230521151808.24804-2-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Sun, May 21, 2023 at 06:18:02PM +0300, Avihai Horon wrote:
> Migration downtime estimation is calculated based on bandwidth and
> remaining migration data. This assumes that loading of migration data in
> the destination takes a negligible amount of time and that downtime
> depends only on network speed.
> 
> While this may be true for RAM, it's not necessarily true for other
> migration users. For example, loading the data of a VFIO device in the
> destination might require from the device to allocate resources, prepare
> internal data structures and so on. These operations can take a
> significant amount of time which can increase migration downtime.
> 
> This patch adds a new capability "switchover ack" that prevents the
> source from stopping the VM and completing the migration until an ACK
> is received from the destination that it's OK to do so.
> 
> This can be used by migrated devices in various ways to reduce downtime.
> For example, a device can send initial precopy metadata to pre-allocate
> resources in the destination and use this capability to make sure that
> the pre-allocation is completed before the source VM is stopped, so it
> will have full effect.
> 
> This new capability relies on the return path capability to communicate
> from the destination back to the source.
> 
> The actual implementation of the capability will be added in the
> following patches.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


