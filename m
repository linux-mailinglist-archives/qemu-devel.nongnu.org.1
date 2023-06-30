Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BADAF7434AF
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 08:02:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF7Cn-0002oe-Bf; Fri, 30 Jun 2023 02:02:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qF7Cj-0002oD-BQ
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:02:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qF7Ch-0006uK-Fx
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 02:02:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688104918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5ZH4/zAX6d+e6ztGju7QL1i48bXrIAGAjU3nV+EzeI4=;
 b=ZBWwrhF72hHxdnhz3Z/ynNcKn0CgtuAp3ikAtFPTzilLC0jbZjUUcc7k0Y2DvuvU81vBZw
 FTRw9EDicw7jWvNwOHJoervHfaT4sjCGhuAMGxTumgSd1TDIAQdXyZFpGVNTexoNeY6Xi+
 G9cv5OUsfrQQjgqCp+rDuZ2gKyAQgJo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-3zY8CAk2OKWNenZAdJW9_A-1; Fri, 30 Jun 2023 02:01:56 -0400
X-MC-Unique: 3zY8CAk2OKWNenZAdJW9_A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313f3c115eeso671474f8f.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 23:01:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688104916; x=1690696916;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ZH4/zAX6d+e6ztGju7QL1i48bXrIAGAjU3nV+EzeI4=;
 b=UkS9R7+k5kdWLDytZ3p83spZXg8kB3Wxb53w9BGPBiqW0puKCa81kPaajjJq+rsYdj
 i1O1sszCMvYYWSfG91yEtwD5hslnPmkh49FcUh1VwjxkgDahKGpLzG2aI4mNvPN2RAsX
 TMbDFG9xumF2nbvWAYLh0vfEkNzrKKOktSitmCDKxD1iVK8T2VX8Da/+F8fw6mfcGjYe
 RglkE9vgBkfKJkuKfheLmXwVhmVwjVGMp962ExDtH4IW4sWIzd0zhFJgCcQWQIBrb/o7
 YbD7NrASNRB4TlRTlZDjdgQ+s1RU3NJAFyyGMxOTvsQCHm/qf34xcyv5n8A7uonb9qW3
 /h2g==
X-Gm-Message-State: AC+VfDyraTtt35ZLRRIGu0OgmEQwhtGTe9w5nsTJgMPNDbkc/CCAyGZC
 hKYjtlapJ5GmhPy1g1hM8QxwKSCBLBMML0wL1TYrSmPkxadJ3ODqPPhtBuJ/UNfp3qiXUWhznXT
 W0vriCJw4u2J14Y4=
X-Received: by 2002:a05:6000:104d:b0:314:2c4:9fea with SMTP id
 c13-20020a056000104d00b0031402c49feamr5501973wrx.29.1688104915791; 
 Thu, 29 Jun 2023 23:01:55 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52q4kSYacxYGz3JrSv6ECkci3OiNBBnYEAmQ0CG9F3WkTLlqAV9U03mx/XmptCysvveC86HQ==
X-Received: by 2002:a05:6000:104d:b0:314:2c4:9fea with SMTP id
 c13-20020a056000104d00b0031402c49feamr5501952wrx.29.1688104915398; 
 Thu, 29 Jun 2023 23:01:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 i18-20020adff312000000b0030fb4b55c13sm2273001wro.96.2023.06.29.23.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 23:01:54 -0700 (PDT)
Message-ID: <fb6cb0b6-4de2-2104-56f4-eb400d7c70b2@redhat.com>
Date: Fri, 30 Jun 2023 08:01:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 0/5] VFIO migration related refactor and bug fix
Content-Language: en-US
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, joao.m.martins@oracle.com,
 avihaih@nvidia.com, chao.p.peng@intel.com
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20230629084042.86502-1-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.093, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/29/23 10:40, Zhenzhong Duan wrote:
> Hello,
> 
> PATCH5 refactors the VFIO migration blocker related code based on
> suggestions from Joao and Cedric, so that code is simpler and
> "Migration disabled" printed in right case.
> 
> But before that works, also found some hotplug bugs when testing
> blocker adding failed case. PATCH1-4 fix them.
> 
> See patch description for details.
> 
> v4: Rebased on [1] which contains Avihai's patchset [2]
>      Add more patches to fix resource leak issue, split based on
>      different fix TAG per Joao
>      Change to not print "Migration disabled" with explicit
>      enable-migration=off per Avihai
>      Rename vfio_block_giommu_migration to vfio_viommu_preset per Joao
> 
> v3: Add PATCH1,2 to fix hotplug bug
>      Fix bugs in PATCH3 Avihai and Joao pointed out
> 
> Tested vfio hotplug/unplug with vfio migration supported and unsupported cases,
> and different param of enable-migration=[on/off/auto] and -only-migratable.
> 
> [1] https://github.com/legoater/qemu/tree/vfio-next
> [2] https://lists.nongnu.org/archive/html/qemu-devel/2023-06/msg06117.html
> 
> Thanks
> 
> Zhenzhong Duan (5):
>    vfio/pci: Fix a segfault in vfio_realize
>    vfio/pci: Free leaked timer in vfio_realize error path

Applied patch 1-2 to vfio-next. PR is sent.

Thanks,

C.


>    vfio/pci: Disable INTx in vfio_realize error path
>    vfio/pci: Free resources when vfio_migration_realize fails
>    vfio/migration: Refactor and fix print of "Migration disabled"
> 
>   hw/vfio/common.c              | 66 +++++++----------------------------
>   hw/vfio/migration.c           | 30 +++++++++-------
>   hw/vfio/pci.c                 | 18 +++++++---
>   include/hw/vfio/vfio-common.h |  7 ++--
>   4 files changed, 48 insertions(+), 73 deletions(-)
> 


