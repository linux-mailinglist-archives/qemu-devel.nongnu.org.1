Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD527C6EB9
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:05:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqvLt-0000Qk-7r; Thu, 12 Oct 2023 09:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqvLr-0000NU-Mm
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqvLq-0004Tn-50
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:03:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697115820;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mmZsyuFMw+2a0llnW8pNEkD1iMhuBEjQuKkxc0a9vd0=;
 b=dn6YQQI6MquyYnfBsQLVrYS+dgPvw4F/wecDhc26mEpN1LMM4nO6IClh1mdnazCzrBDC7b
 zSkU8TTUrnRkjWr8nHXSlu91wUREY4kuwJiHnLB/a+ZSGkcRezHw0Vx5uIPbFR8LOHPuFs
 wVebzS02WvburRJBtpgikCj5aZXeFK8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-Db4Y-NrsOy2sTOLu2Nxxnw-1; Thu, 12 Oct 2023 09:03:28 -0400
X-MC-Unique: Db4Y-NrsOy2sTOLu2Nxxnw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-691029189b8so70962b3a.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697115808; x=1697720608;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mmZsyuFMw+2a0llnW8pNEkD1iMhuBEjQuKkxc0a9vd0=;
 b=FX9dl7/m7H8ZLZWBWR1M3jSKt/ip+oixd46vA9IemlQ4gMlG6qDR9C17TiGDCc7sWT
 0+GcO6s5VTw4B8X61c3GbITBFh3UI8cUNbdyAEkEAWBS7Y7G8DOSQp4n+ZOsGpvFSmle
 Kpc1AZMMo0hQ4BQH90O+rIaHFfs6E2w4oTl5lrtqjT51u2yJCc4y12DIy3TQBx2Ah7dQ
 LxxR/3lQtHb5GpAsJYg4K67Xh77RLUncTfUxxhKvQML99h82kbQNRKsYPS6myTdpIJxd
 3Piv5A2LX60JqccUZ8LAfy6RI0JdzZIcY4o+v9NP2SucAT/g4ZqDy0CPxlFkEOK6TKzq
 U3nA==
X-Gm-Message-State: AOJu0Yw8nSX9vMFF80bg81CZFKUkrL/SwKiwoqAPiMP8U8uwEqRx/Vqd
 CTD1aEpx51dGmoXw2bBodpEDaBSKhOJf+GHyeO0o27LHkaKyF7fLu5oWocpdF6s/FtchjYjEup0
 RuwCnQ1kztiAGsRs=
X-Received: by 2002:a05:6a20:3d85:b0:163:f945:42c4 with SMTP id
 s5-20020a056a203d8500b00163f94542c4mr27751870pzi.1.1697115807737; 
 Thu, 12 Oct 2023 06:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEzculIR8xV/di+X+t1KL1nbm4nZyI6yW/RGzC0FkC62gD8evGAY6TxdQVkCkMZ5/YtpI38g==
X-Received: by 2002:a05:6a20:3d85:b0:163:f945:42c4 with SMTP id
 s5-20020a056a203d8500b00163f94542c4mr27751847pzi.1.1697115807399; 
 Thu, 12 Oct 2023 06:03:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 q25-20020a62e119000000b006933866f49dsm12213249pfh.19.2023.10.12.06.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Oct 2023 06:03:27 -0700 (PDT)
Date: Thu, 12 Oct 2023 09:03:24 -0400
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Leonardo Bras <leobras@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Li Zhijian <lizhijian@fujitsu.com>
Subject: Re: [PATCH 1/1] migration: Non multifd migration don't care about
 multifd flushes
Message-ID: <ZSfunMwKKowWd1oo@x1n>
References: <20231011205548.10571-1-quintela@redhat.com>
 <20231011205548.10571-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231011205548.10571-2-quintela@redhat.com>
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

On Wed, Oct 11, 2023 at 10:55:48PM +0200, Juan Quintela wrote:
> RDMA was having trouble because
> migrate_multifd_flush_after_each_section() can only be true or false,
> but we don't want to send any flush when we are not in multifd
> migration.
> 
> CC: Fabiano Rosas <farosas@suse.de
> Fixes: 294e5a4034e81b3d8db03b4e0f691386f20d6ed3
>        multifd: Only flush once each full round of memory
> Reported-by: Li Zhijian <lizhijian@fujitsu.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


