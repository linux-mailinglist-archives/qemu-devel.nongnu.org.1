Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F587B716D
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 21:00:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnkdN-0004Ci-87; Tue, 03 Oct 2023 15:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnkdB-00041B-Gn
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnkd8-0000Yq-RJ
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 15:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696359625;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=D/VsW9EF5FeDmsxT4EN1NZ0ob3zmVP+4rcmNJDW6FRQ=;
 b=f2o98wmajdpoyicHgtVHIP/sU4KLBumPgqQnsEtu//eJtbB+GJwGikt4XYShbFMfympcRk
 zkaHf+nwp5n5YEvO7Rd932XKXWBMSYBL2IROo05w7yM1t5CK9wDrINI6SSCxZ3FsV9VdVZ
 M1OoEFfxS+YrJlrgFXNnAB8P/7lRxRs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-lZWDy60bNrS-9MXMOZekKQ-1; Tue, 03 Oct 2023 15:00:23 -0400
X-MC-Unique: lZWDy60bNrS-9MXMOZekKQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4067f186094so6687725e9.1
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 12:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696359622; x=1696964422;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/VsW9EF5FeDmsxT4EN1NZ0ob3zmVP+4rcmNJDW6FRQ=;
 b=mjnnnN6PgXREeUxmSjPdQ/PneHi27orZAhhqsToAl84sPW8PtGRvMm13k43Q0uq0I3
 UTYNkUw2TWn+oGyzKg09zwtAsudwXt7/B2rThRahQ9KDlhWCTosD7Gori2pdEAvHgRZR
 AOfhPS+41UDp5sHtVPSFBoQjFz1IANGoQqz+Lnt00CNGKWoT/xUjT2zMqZeLKc+P6vue
 xQRMOkh95Pnhig1DkCmCiBpDKuDkzxdCnepMV3BQwEh7VLU/bMwnaScZnSfRUasJokSu
 gXFvpolEXWp5lVnZswZUR6+mncaKJ+5nUQPNCCB0Kwlg1hXrWpMfsfC8qTNf+skBCc98
 WQwQ==
X-Gm-Message-State: AOJu0YyZA1AzC4qBnBl03btMi3HUQmukMLU0/4iJ7DSW8pl4WnAX9xx9
 G3H1y/9ldBdt2rKoI7uOixxoYBiR3FClbCKWLMFgXPk+sZ1f4qPrqgbEMUpStQeVXgiRJlsN7En
 yFx2rmZMOyVnThyo=
X-Received: by 2002:a7b:ca59:0:b0:402:bbe3:827c with SMTP id
 m25-20020a7bca59000000b00402bbe3827cmr318017wml.31.1696359622745; 
 Tue, 03 Oct 2023 12:00:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQT7xbQDp7PW+F82GtBkuxDtmuPbIVVOI56iv33mMfXA7Ek30quGn26w+hHScCN6zVn5c4Lw==
X-Received: by 2002:a7b:ca59:0:b0:402:bbe3:827c with SMTP id
 m25-20020a7bca59000000b00402bbe3827cmr318001wml.31.1696359622316; 
 Tue, 03 Oct 2023 12:00:22 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 u5-20020a05600c00c500b004047ac770d1sm10078899wmm.8.2023.10.03.12.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 12:00:21 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Li Zhijian <lizhijian@fujitsu.com>,  leobras@redhat.com,
 qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/2] migration: Fix rdma migration failed
In-Reply-To: <ZRMPJsiSuSso9JGf@x1n> (Peter Xu's message of "Tue, 26 Sep 2023
 13:04:38 -0400")
References: <20230926100103.201564-1-lizhijian@fujitsu.com>
 <ZRMPJsiSuSso9JGf@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 03 Oct 2023 21:00:20 +0200
Message-ID: <875y3n5y63.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> On Tue, Sep 26, 2023 at 06:01:02PM +0800, Li Zhijian wrote:
>> Migration over RDMA failed since
>> commit: 294e5a4034 ("multifd: Only flush once each full round of memory")
>> with erors:
>> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
>> 
>> migration with RDMA is different from tcp. RDMA has its own control
>> message, and all traffic between RDMA_CONTROL_REGISTER_REQUEST and
>> RDMA_CONTROL_REGISTER_FINISHED should not be disturbed.
>> 
>> find_dirty_block() will be called during RDMA_CONTROL_REGISTER_REQUEST
>> and RDMA_CONTROL_REGISTER_FINISHED, it will send a extra traffic(
>> RAM_SAVE_FLAG_MULTIFD_FLUSH) to destination and cause migration to fail
>> even though multifd is disabled.
>> 
>> This change make migrate_multifd_flush_after_each_section() return true
>> when multifd is disabled, that also means RAM_SAVE_FLAG_MULTIFD_FLUSH
>> will not be sent to destination any more when multifd is disabled.
>> 
>> Fixes: 294e5a4034 ("multifd: Only flush once each full round of memory")
>> CC: Fabiano Rosas <farosas@suse.de>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
>> ---
>> 
>> V2: put that check at the entry of migrate_multifd_flush_after_each_section() # Peter
>
> When seeing this I notice my suggestion wasn't ideal either, as we rely on
> both multifd_send_sync_main() and multifd_recv_sync_main() be no-op when
> !multifd.
>
> For the long term, we should not call multifd functions at all, if multifd
> is not enabled..

Agreed.

Send a different patch that makes this clear.

> Reviewed-by: Peter Xu <peterx@redhat.com>


