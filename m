Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35972709B00
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:15:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q01nz-0007IT-3W; Fri, 19 May 2023 11:14:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01nt-0007H6-E8
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:14:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q01nr-0003wQ-48
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:14:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684509237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tNemhDyQgUihDWX7Ar2SEpYadUb1pS6ufvKhN5L0SOE=;
 b=Ci+jKS7bkoNp3B8FmyQAciFYxO5/nhD4bbB75Gn74gr6dHoTGJ3+rpqXPip8cuLbEmVIjM
 jrEa715n2ubl7hqWJNQVajMb5ccNQFvR/SwqUhRDxSq8i1PfMI2ILC5wJ7841uNQQMDSFZ
 rCRfF0XASxPBD3Hy3gDpG1mDqdeirz8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-oMRIPtTKOFa9NGNC3vslMg-1; Fri, 19 May 2023 11:13:55 -0400
X-MC-Unique: oMRIPtTKOFa9NGNC3vslMg-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-50d88a986afso2231084a12.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:13:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684509234; x=1687101234;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tNemhDyQgUihDWX7Ar2SEpYadUb1pS6ufvKhN5L0SOE=;
 b=imppy6i6yB/q7d6+DkR20bgyr/+UPNXT2mYPfzMnIXfZIC/MC8e/VpqRkdhyhTPl6N
 ixF5ybw5vnIx8eX9XmB1OzMHzAv1r+5VBlWgoKdVwjIGYo1Drs4tVW2biF6ul6DBpwSo
 0pbWZe/J9Dc1C2+Rin0WPWCaPi+a6AuNJiFQeTM+2isFYWnQmiF9A3AbYvQkODVUWdL4
 SY3bk5qMLTqskKVy2iMxvP2SxFNsx512O8qdE57eNTOvqFQ70koJ+Nyp4fBCusXh6qej
 ZldoiXjpZkYelxk/Gac+n/l3nLKk3YsNkmQDjuZMMljBKRQ15/00tSjSOTFnkD6BnIis
 wlFg==
X-Gm-Message-State: AC+VfDyC150tvWpLtqlqVHWIjIo9vuJemoZSwAPf+Rw7e0TWdUT9Cy/U
 24ajd6WnV26SBrXoanuFMnPNJ8VzNwIG5yn6PpK4cMUtvBRHkuEi7kLWJbOo7F4McmBKIT4xxIV
 Bt8nBSlwQiNsRRno=
X-Received: by 2002:a05:6402:6c6:b0:50b:f70b:9928 with SMTP id
 n6-20020a05640206c600b0050bf70b9928mr1805155edy.18.1684509234706; 
 Fri, 19 May 2023 08:13:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4abdWRLx2ayRL5qX4QV2EoWPOvk3r9bg58YOxhAEOVGmYIMNQCnklctScLVnS5cQ6B+14zUA==
X-Received: by 2002:a05:6402:6c6:b0:50b:f70b:9928 with SMTP id
 n6-20020a05640206c600b0050bf70b9928mr1805140edy.18.1684509234401; 
 Fri, 19 May 2023 08:13:54 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:284b:5990:6336:f84f?
 (p200300cfd723b0c7284b59906336f84f.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:284b:5990:6336:f84f])
 by smtp.gmail.com with ESMTPSA id
 i25-20020aa7dd19000000b0050488d1d376sm1784662edv.0.2023.05.19.08.13.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:13:53 -0700 (PDT)
Message-ID: <609ab33a-d0fe-d13b-274c-4c517ecd5428@redhat.com>
Date: Fri, 19 May 2023 17:13:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 11/19] test-cutils: Refactor qemu_strtosz tests for
 less boilerplate
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-12-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-12-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12.05.23 04:10, Eric Blake wrote:
> No need to copy-and-paste lots of boilerplate per string tested, when
> we can consolidate that behind helper functions.  Plus, this adds a
> bit more coverage (we now test all strings both with and without
> endptr, whereas before some tests skipped the NULL endptr case), which
> exposed a SEGFAULT on qemu_strtosz(NULL, NULL, &val) that will be
> parsed in an upcoming patch.
>
> Note that duplicating boilerplate has one advantage lost here - a
> failed test tells you which line number failed; but a helper function
> does not show the call stack that reached the failure.  Since we call
> the helper more than once within many of the "unit tests", even the
> unit test name doesn't point out which call is failing.  But that only
> matters when tests fail (they normally pass); at which point I'm
> debugging the failures under gdb anyways, so I'm not too worried about
> it.
>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>   tests/unit/test-cutils.c | 503 ++++++++-------------------------------
>   1 file changed, 100 insertions(+), 403 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


