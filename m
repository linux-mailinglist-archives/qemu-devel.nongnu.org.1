Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C84C719C3B
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 14:35:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4hVK-0006F1-Vo; Thu, 01 Jun 2023 08:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hVF-0006Ab-39
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:34:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q4hVD-0002cR-Ih
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 08:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685622840;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3rPaiZ0SKfNzo3wkO6B+/fNJpl9TK2uVPS185hGQwUg=;
 b=Qq4hOvI/taCFP4RCJHsHnBlqOsv8ycLz8U80kLQwKMqo78w+Q0EPJHu8ARC+e8iJhzp1hH
 32cL8nQNkc6/6+VEB8qi430CS/rUvFFYRAOedzIbcmekq+qsV/EuwcKW5ZMQqJNi1qBc1h
 VA45cAOX8RyxIa8ZWcxEeCdIq2A+2m4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-wIw2bLjZPBa6UNUp9KgPNw-1; Thu, 01 Jun 2023 08:33:59 -0400
X-MC-Unique: wIw2bLjZPBa6UNUp9KgPNw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f60fb7b31fso4477625e9.2
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 05:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685622838; x=1688214838;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3rPaiZ0SKfNzo3wkO6B+/fNJpl9TK2uVPS185hGQwUg=;
 b=SFDaF72qSuOzmk568+Ax8kgSjlfMfQ9ki3LcHIAyOjTanuyZqBu9KseWe84PV4dgi8
 ej9GvlUQZ09gp9eVlO4okoiTqOUYHBKG906+HJFC5dSwobosKtZP4HxWinOv99F3aRE0
 fZ8SDwuO0hZEm3uywkITusX/kdQhEpzlE016OppWhlSGkE8jEmD6H07tqzBRUeyJIKZ2
 Gr0YpIYzndM4hiGjltJOg/GZA7D5r72uKGsWUKHyyYfuy7Axtyz3HMVY5rk5iFs2kHRq
 s1nke6pk5eHCK0h8Ugrrly4Xvdsr2ZWqKuWw/POp//Ms5wxIdJ45WKkNO4kb7+oB466n
 4e/Q==
X-Gm-Message-State: AC+VfDwU4sRzDuWGoE9bxLVc2/vh0qlLzTD5LrHDJiqaaNnqc1wQnZdq
 R0ZuQJMZq5phtFlexzxB/e/NKqj9J6DL/jIt0xiAVW4fq4j70G0CQrJU1H6K4vV+07qtHWTVoJh
 GwiWljikUcy46UrU6BSZJzzX6Fg==
X-Received: by 2002:a05:600c:228c:b0:3f6:ae3:5948 with SMTP id
 12-20020a05600c228c00b003f60ae35948mr2283568wmf.33.1685622838107; 
 Thu, 01 Jun 2023 05:33:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OaJuZuu/hOYWY1sVtwthJdeRZfCBXQ+rU2aNm/IOod/nI4AYHNtMUPNe+O+N0xLjOfnj32Q==
X-Received: by 2002:a05:600c:228c:b0:3f6:ae3:5948 with SMTP id
 12-20020a05600c228c00b003f60ae35948mr2283543wmf.33.1685622837778; 
 Thu, 01 Jun 2023 05:33:57 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 h12-20020a05600004cc00b0030aee3da084sm10302944wri.49.2023.06.01.05.33.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 05:33:57 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Laurent Vivier <lvivier@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
In-Reply-To: <20230531132400.1129576-9-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 31 May 2023 14:23:59
 +0100")
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 01 Jun 2023 14:33:56 +0200
Message-ID: <87a5xjs6ob.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.166,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> There are 27 pre-copy live migration scenarios being tested. In all of
> these we force non-convergance and run for one iteration, then let it
> converge and wait for completion during the second (or following)
> iterations. At 3 mbps bandwidth limit the first iteration takes a very
> long time (~30 seconds).
>
> While it is important to test the migration passes and convergance
> logic, it is overkill to do this for all 27 pre-copy scenarios. The
> TLS migration scenarios in particular are merely exercising different
> code paths during connection establishment.
>
> To optimize time taken, switch most of the test scenarios to run
> non-live (ie guest CPUs paused) with no bandwidth limits. This gives
> a massive speed up for most of the test scenarios.
>
> For test coverage the following scenarios are unchanged
>
>  * Precopy with UNIX sockets
>  * Precopy with UNIX sockets and dirty ring tracking
>  * Precopy with XBZRLE
>  * Precopy with UNIX compress
>  * Precopy with UNIX compress (nowait)
>  * Precopy with multifd
>
> On a test machine this reduces execution time from 13 minutes to
> 8 minutes.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Hi

I have a different idea to get the migration tests faster.  Namely, just
stop letting enter the completation stage until we are ready to use it.

I need that functionality also for vfio migration, so as I have to
create the patches, can we put on hold the last two patches and give me
a couple of days?

Thomas, do you care if I get the whole sets of patches through the
migration tree?  Almost everything is migration related, and I am
changing the same files that Daniel, so it is easier if I can get them
into my tree.

Later, Juan.


