Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC5D706E70
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 18:41:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKCw-0001ez-Rp; Wed, 17 May 2023 12:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzKCv-0001d6-4c
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1pzKCt-0007UU-Pk
 for qemu-devel@nongnu.org; Wed, 17 May 2023 12:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684341655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7+CNgP9PtBpPAFOh6idegCwzX2ZxEShwYQboA9RQYdU=;
 b=D4wYmHf/qchwzLKh8mYYKUvyBHDVAmJXztUqd561H7h4t9toIJBVUuVnAJRI+Swgy+5OIV
 ZE/yjdadXnhgwrm0aVkHiB1PFQLXUIdXuXv7Q6yCjX4ZJb+5ppKVJUK74H+T0lMpfT6EOh
 cJTc/cxfM/tZ6fNCkkV8um5taB7n6e0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-JfZ7MnMEOW6J-FLqztGJRQ-1; Wed, 17 May 2023 12:40:54 -0400
X-MC-Unique: JfZ7MnMEOW6J-FLqztGJRQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7592c8fe630so2065885a.0
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 09:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684341652; x=1686933652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7+CNgP9PtBpPAFOh6idegCwzX2ZxEShwYQboA9RQYdU=;
 b=FztBv6Z12F4LuncF0rt4kqQtm2xryShsq/Ca5Z6Uq1oXrzn9Mgsar3lLFl2B8vPR4/
 457/N8qKcrzZeHvBWGzd8QhpYApKXlRPrEWCPtKwIeb7dHbViXA4GP+dVkLXYmtKNrlE
 XFzsox4aXmUwaObu8kBSZBpH6S6kpOGwBcI7F1vLuV63txV7dskDd0Y1c/kfT9Yd5gou
 arMgHUwhWsZNZgAz7JmNY47lzXuhyR8i1gWUaDnqVxxDb21O261EyaKHnU29AlnUxsUJ
 A7C7m/57iBv0+85ZWBJPwMS9guMJVCOTDfZEFKZMP2SlaB480FOOs+cgIAV+t+88NLJK
 an6Q==
X-Gm-Message-State: AC+VfDwSv4k1ZbsBWN1WUlOddw1+D9I7JRsGFlupfMmEceSJvdaJdC9m
 If4DOAbTlw2EAhKVPE+X+9AA2oncbjl647EVC/phTY+8WqCveeggEn6/rn+rbS3Pv15jw7HpDVI
 F6pPIriJb9+ba1XE=
X-Received: by 2002:a05:622a:4c7:b0:3ef:4839:2632 with SMTP id
 q7-20020a05622a04c700b003ef48392632mr6591940qtx.0.1684341652647; 
 Wed, 17 May 2023 09:40:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5x3TnszqpBRLUz/V+IiHedee+SAmvM4bu9fSEZUnv8lH/ftSyiiQlH5Yv0j0qEVYGwYTSawA==
X-Received: by 2002:a05:622a:4c7:b0:3ef:4839:2632 with SMTP id
 q7-20020a05622a04c700b003ef48392632mr6591899qtx.0.1684341652398; 
 Wed, 17 May 2023 09:40:52 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 s2-20020ac85ec2000000b003e635f80e72sm5213923qtx.48.2023.05.17.09.40.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 May 2023 09:40:51 -0700 (PDT)
Date: Wed, 17 May 2023 12:40:50 -0400
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
Subject: Re: [PATCH v2 4/7] tests: Add migration precopy initial data
 capability test
Message-ID: <ZGUDkhwYBUjQ+IyW@x1n>
References: <20230517155219.10691-1-avihaih@nvidia.com>
 <20230517155219.10691-5-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230517155219.10691-5-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 17, 2023 at 06:52:16PM +0300, Avihai Horon wrote:
> Add migration precopy initial data capability test. The test runs
> without migration users that support this capability, but is still
> useful to make sure it didn't break anything.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

It's a pity that there seems to have no easy way to test the RP msg and
notifications into the qtest..  Besides the cap name it looks all fine:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


