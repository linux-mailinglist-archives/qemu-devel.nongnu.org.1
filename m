Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D287AF186
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:05:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBUP-0007RK-NW; Tue, 26 Sep 2023 13:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlBUM-0007QX-VR
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlBUL-00082S-H2
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 13:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n6aPhBmlUNXzLPKQjObc21rIjuIjpl8EuOF1O5lv63c=;
 b=amL+M0VoqGuZaAOeEPPQq1f/J5Z+7I6R2Fd8DdQDAUpocD7axrFsna3mEayX5TEGHtaItW
 sR8ZzFIExVZK2iYQNi54eawcZqORRAq+5abMpvL/L714J/ds/EZu7VLUaEfwK/GmWONeHV
 WL/+L4aW6CxOid1rahwTvVWxYppen0E=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-SmGZ0NZnP6aFMnMIvwYIDQ-1; Tue, 26 Sep 2023 13:04:42 -0400
X-MC-Unique: SmGZ0NZnP6aFMnMIvwYIDQ-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-495fe2e308cso1107062e0c.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 10:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747882; x=1696352682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n6aPhBmlUNXzLPKQjObc21rIjuIjpl8EuOF1O5lv63c=;
 b=emXJAH5tmgmKjP/d+KtW2hvLy3Xvno4TSNz9VO/b2DGeNvi5LLW0HxbZEXzlmMzA6s
 euBavvvcepKTTZrSU/w7mvWcJ+Vb1b5vt62mB1kysPvyZNUPytZdEMe56aEjt7ZzPygL
 5xRy2c9aqgafyv0kxqZWZKfIRPUldgkiDvHEwTozmCk6kS15Lt8Kuiwk0z2wgej91xUn
 cw5H0m58ps0jpdbMoABC0QGde0KwCK9Mx7kECc/TkFK4uiiAIW3QSz3sbibUfr/Yjszs
 yCOjjt9OEMmCUnecz6XCJ8ToQ/ZvMa8IrHHXy7g13DCZJ3oIZO7SYHprMBRzg5uHReu0
 gdXg==
X-Gm-Message-State: AOJu0YwuS/sLC7+sUb7subb6TAcc+Z3HzuC7We5MbskZuZdy31zDMw4F
 Pd1NZ6iSKMn5EqyHSq+SyfocHiCL+DctWayuPcmK5F+pOZ/kTpdD1wZS1JhKHU2uttvXk/eHyun
 cmGJTNnrtNmCfLv8=
X-Received: by 2002:a05:6122:a1d:b0:493:a661:c607 with SMTP id
 29-20020a0561220a1d00b00493a661c607mr4109021vkn.1.1695747882073; 
 Tue, 26 Sep 2023 10:04:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgWVJ/t7kNFWtxqPp5ExvvLvMY/YsJTdtqkFbbcSzlkTidJQ+vjBrLM1oz1TObqw93oNsOCQ==
X-Received: by 2002:a05:6122:a1d:b0:493:a661:c607 with SMTP id
 29-20020a0561220a1d00b00493a661c607mr4108986vkn.1.1695747881722; 
 Tue, 26 Sep 2023 10:04:41 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 jr2-20020a05622a800200b003eabcc29132sm592531qtb.29.2023.09.26.10.04.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 10:04:41 -0700 (PDT)
Date: Tue, 26 Sep 2023 13:04:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: quintela@redhat.com, leobras@redhat.com, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 1/2] migration: Fix rdma migration failed
Message-ID: <ZRMPJsiSuSso9JGf@x1n>
References: <20230926100103.201564-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926100103.201564-1-lizhijian@fujitsu.com>
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

On Tue, Sep 26, 2023 at 06:01:02PM +0800, Li Zhijian wrote:
> Migration over RDMA failed since
> commit: 294e5a4034 ("multifd: Only flush once each full round of memory")
> with erors:
> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
> 
> migration with RDMA is different from tcp. RDMA has its own control
> message, and all traffic between RDMA_CONTROL_REGISTER_REQUEST and
> RDMA_CONTROL_REGISTER_FINISHED should not be disturbed.
> 
> find_dirty_block() will be called during RDMA_CONTROL_REGISTER_REQUEST
> and RDMA_CONTROL_REGISTER_FINISHED, it will send a extra traffic(
> RAM_SAVE_FLAG_MULTIFD_FLUSH) to destination and cause migration to fail
> even though multifd is disabled.
> 
> This change make migrate_multifd_flush_after_each_section() return true
> when multifd is disabled, that also means RAM_SAVE_FLAG_MULTIFD_FLUSH
> will not be sent to destination any more when multifd is disabled.
> 
> Fixes: 294e5a4034 ("multifd: Only flush once each full round of memory")
> CC: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> 
> V2: put that check at the entry of migrate_multifd_flush_after_each_section() # Peter

When seeing this I notice my suggestion wasn't ideal either, as we rely on
both multifd_send_sync_main() and multifd_recv_sync_main() be no-op when
!multifd.

For the long term, we should not call multifd functions at all, if multifd
is not enabled..

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


