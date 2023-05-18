Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE03C707F06
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:19:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbeU-00079s-BA; Thu, 18 May 2023 07:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbeR-00079R-Pl
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbeQ-0007Z2-42
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:18:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684408709;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=NrKcO1mClBl9aTvXSqeafivVP0c89Qj/PB7/9eaI/zU=;
 b=LMxafMuYILGIe906Anm4gcPeXugnf1CBU9vRIM6VpsvcWhIXKRE5qBFv6aJUXJtZ9/5f2Y
 4fj27miFWed50aV5A7Fyrj0OQ5vNlrSz2yiFJ7fgEzEbH3oDnAvpWL6z58M9WKWOaGvOoQ
 M6Qn4yP+WSB/wYhzx0rxhxK9AMXgoqU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-q5ZlGqi1M1qvlTkRCktRKg-1; Thu, 18 May 2023 07:18:27 -0400
X-MC-Unique: q5ZlGqi1M1qvlTkRCktRKg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f426d4944fso7215505e9.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:18:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684408706; x=1687000706;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NrKcO1mClBl9aTvXSqeafivVP0c89Qj/PB7/9eaI/zU=;
 b=dokISH9SRYrWBngjrG/r48/HFyD1BhEaF4TRb0qElefMrN5Yu9ShPumPjkrA6MK8bo
 JhFvclUucvgg+48FwxOeCdSB/4fUaG5ic2VSIsKj6m5cniZX6bpM4vF2AtTddwgopU/t
 1shiq1BYri4wZL7lSZ1Be+btElaDcQM7CPHWsdW2DNbT1Mnctp4Gjw841cCWSGGnXPg2
 XJ78ABXX4pa1vA2yiEtCV84HBtmqfUwVnl42ESYYlR25h2QmMs4QMthlV5ExEbAtGIGc
 pqv4xrRmR3ll4q361luLeJ7LOmuOtbtSCGohRKQR7yDEhfGPRLeLXrHtcg7dYk/Cqy8q
 nIYQ==
X-Gm-Message-State: AC+VfDxHGNcTuQgLkfpAu/myoWCKgCirM/Pm5tpLM3tL1OPc+pcMS9oE
 EIs9UOIh/fqNKPurRMXmGhdQxgGN5xtL9VNdvcFT7jeLgaWGZHBS2l3XtDnkjBhm4tqAjHI3I9a
 pmet6FZtLXL2/OmQ=
X-Received: by 2002:a05:600c:290a:b0:3f4:2897:4eb7 with SMTP id
 i10-20020a05600c290a00b003f428974eb7mr1224729wmd.38.1684408706791; 
 Thu, 18 May 2023 04:18:26 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4dM/9EehYAtQLbXT7p77JvLPbFE+WC7fkiIjC0t0C8m2DqDyKvyFbjrDA3cyU+zTtIbB7i6w==
X-Received: by 2002:a05:600c:290a:b0:3f4:2897:4eb7 with SMTP id
 i10-20020a05600c290a00b003f428974eb7mr1224718wmd.38.1684408706515; 
 Thu, 18 May 2023 04:18:26 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 j3-20020adfe503000000b003062675d4c9sm1881614wrm.39.2023.05.18.04.18.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:18:25 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  leobras@redhat.com,
 peterx@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH 2/5] migration: never fail in global_state_store()
In-Reply-To: <20230517123752.21615-3-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 17 May 2023 15:37:49 +0300")
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
 <20230517123752.21615-3-vsementsov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:18:25 +0200
Message-ID: <87ilcpevlq.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
> Actually global_state_store() can never fail. Let's get rid of extra
> error paths.
>
> To make things clear, use new runstate_get() and use same approach for
> global_state_store() and global_state_store_running().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

I don't know.

On one hand, you have removed a lot of code that "can't" happen.

On the other:

> +static void global_state_do_store(RunState state)
>  {
> -    if (!runstate_store((char *)global_state.runstate,
> -                        sizeof(global_state.runstate))) {
> -        error_report("runstate name too big: %s", global_state.runstate);
> -        trace_migrate_state_too_big();
> -        return -EINVAL;
> -    }
> -    return 0;
> +    const char *state_str = RunState_str(state);
> +    assert(strlen(state_str) < sizeof(global_state.runstate));

First: g_assert() please.

Second: We try really hard not to fail during migration and get the
whole qemu back.  One assert is bad.  Specially in a place like this
one, where we know that nothing is broken, simpli that we can't migrate.

Later, Juan.


