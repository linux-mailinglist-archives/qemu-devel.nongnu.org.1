Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 187E67C5E6D
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 22:32:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqfqx-0003MS-D5; Wed, 11 Oct 2023 16:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfql-0003LV-Hy
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:30:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qqfqj-0001s7-SZ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 16:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697056232;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HlmM/Jq9fGF58hWatBGZFHJfS/t0BTr8e6+hfq5h5TY=;
 b=D4B3Exx8Vhq9rysH4r4SMrHgHoIqhli8S9p46HP7rUU7IwYSrRRAUNKDdg3L9WuxVyLHVb
 ZZZr2WZZgaipOpJRxDV1IB8gIzjhAqHX+lcwLLLjqXtMcbjAYxRmsPufLtZnIvOHJV5n8M
 0dxu9df9J4mXTFtPyLUSQI6dxZaFo7A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-oqXt792TMh-ZaCs9Ym7JzQ-1; Wed, 11 Oct 2023 16:30:30 -0400
X-MC-Unique: oqXt792TMh-ZaCs9Ym7JzQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-405535740d2so3124605e9.3
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 13:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697056229; x=1697661029;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HlmM/Jq9fGF58hWatBGZFHJfS/t0BTr8e6+hfq5h5TY=;
 b=qziyyldXbPzUichcTSbLgOYRmHpmbFSXy4XpWoHVilCHwPxqqqDYSmjj4zsFB/7vOj
 KrsVuP1FzXOVYcTI30Bo2YRtdi1hpdQ69Udw2FPyUfu9BZs+jqlnUclssBqU/gxsTh90
 joX/9zOBBK86zRauh539FIEEX2eyAFzjqjDsJCngP/W2NT3+j5TMcjhu6roWV0uaBV2v
 CJQtst++astk/2ZUzz4ocX7I5mP+LJJKaehf3Kqvo6YhZqkutcieptDgE52xt//8xwVV
 2bBQvBmpvVYQAklXsDiJ82JBUCBQLsfaLSAuL2uQjma9nrL6blXli3JSlZzOV58e4BEh
 5dXw==
X-Gm-Message-State: AOJu0YyZgBFN4/JzLghQqaalSgMGAurUvccS/8mi/79NIMnNGRsjyI+G
 ZuDpaIPJwR8I25RiQOo4nNa1qu6JUgq6r9b/yTCP94JhInbz1lUTRFhzFP8GowB9r7zmLNOyoiM
 cHIXI8FyUV9zlLgM=
X-Received: by 2002:a05:600c:2054:b0:402:906:1e87 with SMTP id
 p20-20020a05600c205400b0040209061e87mr18558024wmg.31.1697056229753; 
 Wed, 11 Oct 2023 13:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENDvBgeqq/fzD/COGIu3s7Mhodr79yROBWk27Jno+kFyQY5FaWnAdPoBhcC8MMNB7BKjsxJA==
X-Received: by 2002:a05:600c:2054:b0:402:906:1e87 with SMTP id
 p20-20020a05600c205400b0040209061e87mr18558013wmg.31.1697056229444; 
 Wed, 11 Oct 2023 13:30:29 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 n22-20020a7bcbd6000000b004060f0a0fdbsm20087662wmi.41.2023.10.11.13.30.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 13:30:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Markus
 Armbruster <armbru@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Li
 Zhijian <lizhijian@fujitsu.com>,  Leonardo Bras <leobras@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PULL 06/65] tests/qtest: migration: Add support for negative
 testing of qmp_migrate
In-Reply-To: <87wmvt1fb2.fsf@suse.de> (Fabiano Rosas's message of "Wed, 11 Oct
 2023 10:04:01 -0300")
References: <20231011092203.1266-1-quintela@redhat.com>
 <20231011092203.1266-7-quintela@redhat.com> <87wmvt1fb2.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 11 Oct 2023 22:30:27 +0200
Message-ID: <87r0m07vh8.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> From: Fabiano Rosas <farosas@suse.de>
>>
>> There is currently no way to write a test for errors that happened in
>> qmp_migrate before the migration has started.
>>
>> Add a version of qmp_migrate that ensures an error happens. To make
>> use of it a test needs to set MigrateCommon.result as
>> MIG_TEST_QMP_ERROR.
>>
>> Reviewed-by: Peter Xu <peterx@redhat.com>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Message-ID: <20230712190742.22294-6-farosas@suse.de>
>> ---
>
> Hi Juan,
>
> What's the plan for the last patch in that series? The one that adds the
> actual test:
> [PATCH v5 6/6] tests/qtest: migration-test: Add tests for file-based migration
> https://lore.kernel.org/r/20230712190742.22294-7-farosas@suse.de
>
> I'm trying to keep track of what's merged and what's not because I have
> more patches on top of it to send.

Added it back, it appears that now it is working.

If you hear nothing else from me, it should be on next pull request.

Later, Juan.


