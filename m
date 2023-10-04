Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D147B7B1E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:06:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxdy-0001o2-MX; Wed, 04 Oct 2023 04:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnxda-0001iT-Hb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qnxdU-0000e9-1r
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:53:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409619;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=losr0Mub1lFBjfdoz5N8NmlhIlVhiNyKcqbu/wCbO64=;
 b=SQNm+f91HR+5Ly6MmCuytC6teRnrB12r6O9YPMlX+/P2+pepRZ7bE7SJjIZgxb5E15n4PP
 OFpwyAUvNjLPLYI7QJTkPJs0qwRHoRF+e3QhUO16vhwNqo2no7zLDIe4O2Urmt7sUKLFD0
 9PCoVk8lAgTGDj05ALufzm1Uf0Ci+4k=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-7egBK3h_Nb2d_SHvAD-8Hg-1; Wed, 04 Oct 2023 04:53:37 -0400
X-MC-Unique: 7egBK3h_Nb2d_SHvAD-8Hg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32320b9d671so1469563f8f.3
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:53:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409616; x=1697014416;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=losr0Mub1lFBjfdoz5N8NmlhIlVhiNyKcqbu/wCbO64=;
 b=LTtM6pJs4BjblyL554Zyno6MvCHet46HngTlUajTAtcdlYz630XAVeR6P3Kc1KWNre
 uEcJnkFk67w4f4VzGMN5UWjDseKKR8OLwuxtH90c14VKvBlM5sBTW1aVemezLX+drW7Y
 UQ9brTiJq470+wB2EvK4u99FPbIw1gcIieINorvJS1WxbzE6LZuyS7gGH4PxuhZ6Y/on
 QpAYyD/HoKo8UPWWDEgKTpeXvqTDcfROy07pRnyjXJGOw8C3opYbtVn40vwNZ8+7lzqm
 hXQmFkPvtyvloovyS3wgnDKzTsgdAf82dcFQl68Jd/aEUo7IDSBx3aaWfcPjRd0IrhiM
 wbdA==
X-Gm-Message-State: AOJu0YyRlG9ngRFeorq4AGZ90PwXGm5/GIT3HdfxdJTyt/Y7sRXwFdiL
 AnodJroBS2ujZw7ZT3xbJ37EN7vw9oL6LUWvqpLrqt63x/RwZWyoXYMbMZGX/GMjja1m4TyTk5j
 v5VnHfbJ3wlczQbM=
X-Received: by 2002:adf:e382:0:b0:319:7472:f0b6 with SMTP id
 e2-20020adfe382000000b003197472f0b6mr1537485wrm.15.1696409616654; 
 Wed, 04 Oct 2023 01:53:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0MvD2Fuuj0h260o5u05Ce07n4LPBLxlPULA9FGFD3kcmz2AQPH7Px9M21V6tR9kxsnhF2Jg==
X-Received: by 2002:adf:e382:0:b0:319:7472:f0b6 with SMTP id
 e2-20020adfe382000000b003197472f0b6mr1537471wrm.15.1696409616308; 
 Wed, 04 Oct 2023 01:53:36 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s12-20020a5d424c000000b00327cd5e5ac1sm3526617wrr.1.2023.10.04.01.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:53:35 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org,  qemu-s390x@nongnu.org
Subject: Re: [PATCH v2 2/3] i386/a-b-bootblock: zero the first byte of each
 page on start
In-Reply-To: <20230919102346.2117963-3-d-tatianin@yandex-team.ru> (Daniil
 Tatianin's message of "Tue, 19 Sep 2023 13:23:45 +0300")
References: <20230919102346.2117963-1-d-tatianin@yandex-team.ru>
 <20230919102346.2117963-3-d-tatianin@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 10:53:34 +0200
Message-ID: <87o7he4vld.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> The migration qtest all the way up to this point used to work by sheer
> luck relying on the contents of all pages from 1MiB to 100MiB to contain
> the same one value in the first byte initially.
>
> This easily breaks if we reduce the amount of RAM for the test instances
> from 150MiB to e.g 110MiB since that makes SeaBIOS dirty some of the
> pages starting at about 0x5dd2000 (~93 MiB) as it reuses those for the
> HighMemory allocator since commit dc88f9b72df ("malloc: use large
> ZoneHigh when there is enough memory").
>
> This would result in the following errors:
>     12/60 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 ERROR           2.74s   killed by signal 6 SIGABRT
>     stderr:
>     Memory content inconsistency at 5dd2000 first_byte = cc last_byte = cb current = 9e hit_edge = 1
>     Memory content inconsistency at 5dd3000 first_byte = cc last_byte = cb current = 89 hit_edge = 1
>     Memory content inconsistency at 5dd4000 first_byte = cc last_byte = cb current = 23 hit_edge = 1
>     Memory content inconsistency at 5dd5000 first_byte = cc last_byte = cb current = 31 hit_edge = 1
>     Memory content inconsistency at 5dd6000 first_byte = cc last_byte = cb current = 70 hit_edge = 1
>     Memory content inconsistency at 5dd7000 first_byte = cc last_byte = cb current = ff hit_edge = 1
>     Memory content inconsistency at 5dd8000 first_byte = cc last_byte = cb current = 54 hit_edge = 1
>     Memory content inconsistency at 5dd9000 first_byte = cc last_byte = cb current = 64 hit_edge = 1
>     Memory content inconsistency at 5dda000 first_byte = cc last_byte = cb current = 1d hit_edge = 1
>     Memory content inconsistency at 5ddb000 first_byte = cc last_byte = cb current = 1a hit_edge = 1
>     and in another 26 pages**
>     ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion failed: (bad == 0)
>
> Fix this by always zeroing the first byte of each page in the range so
> that we get consistent results no matter the initial contents.
>
> Fixes: ea0c6d62391 ("test: Postcopy")
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


