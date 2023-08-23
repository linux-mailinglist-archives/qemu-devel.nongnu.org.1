Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D49786151
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 22:22:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYuLn-0004uF-MI; Wed, 23 Aug 2023 16:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYuLm-0004tx-3p
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:21:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qYuLk-00054g-PJ
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 16:21:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692822067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z1lKqTiG0KArQQ1SijYp9FWqVjXhwXH0rWn7cngBDyU=;
 b=VAea96BmmZGskZFkiscx9vKZBU+fYSqkc67P602eB/ljzgNvhMCRjoBWh8VZqMm1iVrvar
 jChWWkXg2528SXKHCpml5DpxCHH4OZnJvjdaghcoDIWDpIQ0oUzl0Hxhq8NM5Q/Mk3+Ox6
 +clRmVctL4mzsrbAHOsBYxwMuFRKADY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-2lr6fd1vPHKuqgiOfT10NQ-1; Wed, 23 Aug 2023 16:21:05 -0400
X-MC-Unique: 2lr6fd1vPHKuqgiOfT10NQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76db31ecf3dso46891285a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 13:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692822065; x=1693426865;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1lKqTiG0KArQQ1SijYp9FWqVjXhwXH0rWn7cngBDyU=;
 b=C3xltmBNHxhLVqdX/mfFOoajfq6YcekKRlpYk+TD3HGv54WUg4Z0C1aiesHxXg7cHg
 Vz0LEq4/cszohfbo0bdAse18rTZkiLfk610kmnJriyQwEbasfL7Jud6ikgcz1AJDOxu+
 qNZVHCqsiurETfawfg/mmo63ZKknOcqDO5/1dwC7UZ/xhUx8qNFgTEUUJPzT8vcpY2zw
 GJLEu7fE5DHzoN0/bWfGvbaB6Mi/cV88fTH4QGTttuXdjeN9zuHrZHGW3K0tyQaN5YpB
 ySAZ07n8fBJJ3T9Byw2F5OEF6FNGofG406q7TcG6r5nHFWPE21vYfwZtjQOUT90YaMQT
 pD2g==
X-Gm-Message-State: AOJu0YyaovmdRTb5Cg3bcfeRZEJ6sGAWgj74mGqOVO0fs2bHdJ8DES+q
 +J28qldgunDyuE+cPS1k8lblpu82caMo8+0gH4Oq4avvNoTIekT83KFkSjiU2HaqV/AIDz7aDtD
 34dh9W018qokf74U=
X-Received: by 2002:a05:620a:198a:b0:76c:e028:5fe1 with SMTP id
 bm10-20020a05620a198a00b0076ce0285fe1mr15507729qkb.0.1692822065247; 
 Wed, 23 Aug 2023 13:21:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE775I9zhFpvWfKTZskSQ2RN0NOEVbwwYg6wDYtrRWH96g3pVaWBvTu9PKGIQV748ib2BZ/Xw==
X-Received: by 2002:a05:620a:198a:b0:76c:e028:5fe1 with SMTP id
 bm10-20020a05620a198a00b0076ce0285fe1mr15507706qkb.0.1692822064937; 
 Wed, 23 Aug 2023 13:21:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 cx18-20020a05620a51d200b0076cb0ed2d7asm4178805qkb.24.2023.08.23.13.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 13:21:04 -0700 (PDT)
Date: Wed, 23 Aug 2023 16:21:01 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Greg Kurz <groug@kaod.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v3 02/11] softmmu/physmem: Distinguish between file
 access mode and mmap protection
Message-ID: <ZOZqLTF7pIx9R7Tg@x1n>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823153412.832081-3-david@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Aug 23, 2023 at 05:34:02PM +0200, David Hildenbrand wrote:
> There is a difference between how we open a file and how we mmap it,
> and we want to support writable private mappings of readonly files. Let's
> define RAM_READONLY and RAM_READONLY_FD flags, to replace the single
> "readonly" parameter for file-related functions.
> 
> In memory_region_init_ram_from_fd() and memory_region_init_ram_from_file(),
> initialize mr->readonly based on the new RAM_READONLY flag.
> 
> While at it, add some RAM_* flags we missed to add to the list of accepted
> flags in the documentation of some functions.
> 
> No change in functionality intended. We'll make use of both flags next
> and start setting them independently for memory-backend-file.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


