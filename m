Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC96A7420A4
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 08:48:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qElQe-0002lD-6C; Thu, 29 Jun 2023 02:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qElQW-0002ku-AJ
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qElQT-0004Pd-Hp
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 02:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688021197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d8TylTYOPduQg8TLv7mDi395AgrpfZgzIBhob5u5NX0=;
 b=OUL2H/H3sr7IyKf2NvdDf5/+TFGvAIjDR6b+a8RPe26DmZGExxXDOyEWDQQbDWOfBESI0H
 GwEBJuacRVhRyUOG4uVB/LxM+GM59uc/ATtEn8c4ZN5TqF/hvxh/2mZ/H96XQBs49nikwB
 4ahDXHlZwS+w6uMFDdwyGS++3kBiYuE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-jg-PPiMrPyGZ9QqMV-EZKQ-1; Thu, 29 Jun 2023 02:46:35 -0400
X-MC-Unique: jg-PPiMrPyGZ9QqMV-EZKQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f81f4a7596so2173795e9.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 23:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688021194; x=1690613194;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=d8TylTYOPduQg8TLv7mDi395AgrpfZgzIBhob5u5NX0=;
 b=aPYXGfgQFwLJwV89Ogs3L4HaqDbz2JzADeWjNHR85xbkTdiDljXg7dkFjO2bCsBsxB
 9jj9Nbq50m0e0ofu250MUZcrtPZj8pc9HIG+7KuZ8X9aqntYkROTVQr6BEJg8tOo7Wvn
 WSAFQHgmdW6ULAjOrE8X8ts3+gk2YOKvyZTMvOb6+tpeZaMBbTu2/oLsrugRihZwSpIz
 LMPBBbccOXbwKXHMr5duh/Zkc7lg9yWHfL8yBP3D+BuRnoiaqZ2XTC5J1rQityGcIEdy
 eGfkD9XLQfLFK7vnSbTc7kyticgyhpdEjPEdQPiM/lsValuP1XWc/pYBChMLKgzazfOG
 sEmA==
X-Gm-Message-State: AC+VfDykooX9unxPGwv+Ke+FiZFq4PwRbXgetFjlYozDw7WYJrhCnOsJ
 8bgda/CmzN3x4uWdfhvevCkRkd7rY1EBRIeVt2NW2E/Eh70XCVR1zRMDFCrjJc55KueVz/eGLM2
 5a40ycjZ2QbH5gw4=
X-Received: by 2002:a7b:c399:0:b0:3fa:95c7:e891 with SMTP id
 s25-20020a7bc399000000b003fa95c7e891mr9489110wmj.35.1688021194859; 
 Wed, 28 Jun 2023 23:46:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ52lsRqVQQ1JrrV+qRsKIA8l8pt/Cegm5ByduAy+molhuoGZckerhsFynGUPiAooUCk9jYXuA==
X-Received: by 2002:a7b:c399:0:b0:3fa:95c7:e891 with SMTP id
 s25-20020a7bc399000000b003fa95c7e891mr9489092wmj.35.1688021194572; 
 Wed, 28 Jun 2023 23:46:34 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 12-20020a05600c020c00b003f90ab2fff9sm15582288wmi.9.2023.06.28.23.46.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jun 2023 23:46:34 -0700 (PDT)
Message-ID: <355faa50-6de9-9322-4f3f-b7aa4095924a@redhat.com>
Date: Thu, 29 Jun 2023 08:46:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/6] tests/qtest: migration: Expose migrate_set_capability
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20230628165542.17214-1-farosas@suse.de>
 <20230628165542.17214-3-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230628165542.17214-3-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 28/06/2023 18.55, Fabiano Rosas wrote:
> The following patch will make use of this function from within
> migrate-helpers.c, so move it there.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>   tests/qtest/migration-helpers.c | 11 +++++++++++
>   tests/qtest/migration-helpers.h |  3 +++
>   tests/qtest/migration-test.c    | 11 -----------
>   3 files changed, 14 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


