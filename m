Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBC071A3A1
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 18:04:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4kFq-0003bA-6Q; Thu, 01 Jun 2023 11:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4kFp-0003az-5M
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q4kFn-0004v3-LP
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 11:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685633418;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w3L/6eR5+dveULfxTSg8I+OUqBv/1yBCey8pXXlOGjw=;
 b=LzeEY20yATb75/VgWSEX9ZJoOkmcoP4ZlK+NVk60b6L+1wIbC8r0+7g8r3MV6oSYATU/kI
 j2rcrqdauhZmgoEivZwdv0WXhrRuv5XcMcztSprftXGfzsNzn4JmamFvQ4DmqgbKmZTSJh
 PzNa/3Zs1Q5sEtSBk2anxM4kTNT8gXE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-LV6gjPgwO6-PSeGfzHtNKg-1; Thu, 01 Jun 2023 11:30:15 -0400
X-MC-Unique: LV6gjPgwO6-PSeGfzHtNKg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-3f7d72d552fso2518381cf.0
 for <qemu-devel@nongnu.org>; Thu, 01 Jun 2023 08:30:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685633414; x=1688225414;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w3L/6eR5+dveULfxTSg8I+OUqBv/1yBCey8pXXlOGjw=;
 b=hF1IQ4eDYFOvRXr6mFYnLNV9TCHHe50x5DDqpgmYl45Etf5f7URJ6suct2mQoOx6tz
 bfdpIKagvOAohQLDi4gfmeTR1IvRRbSOl7S/wlOsggy5N1PVv3hwDzQlug+ibXOPuXro
 mvlJXnSreIoVsTtw3zRjhUja3vTxg+KLWAV9Rs61CO67Z9c2D0lkOvnfYA1S17+o4GtB
 BX5fjcd6XtWQuCzYMm/nX1qW62bxHiQhmNzaJQjXWK7sENJaxe93OADfxdonLOR6smSq
 xhgCBxIRG2Y9hxF0CPasPVDUQ9v8CDiR7yKDcabnnsnyf/jXI5ny6tuAky2pIpbD8w5v
 r6VA==
X-Gm-Message-State: AC+VfDz9NnUt8KZobVygTDwM35UpUQL5ilx3gBOJGTbcMwKwHPb6Jgdf
 LAWm/ZjAn+gAbWe+Gvnm0Ek2sgvLLIVeLYfrYHFF5crT2pKjhq7tQIodMgIXQJYtPjt/w2n3tl9
 2lZOYmkbbphy3OR8=
X-Received: by 2002:a05:6214:529c:b0:61b:73b2:85ca with SMTP id
 kj28-20020a056214529c00b0061b73b285camr6341043qvb.5.1685633414603; 
 Thu, 01 Jun 2023 08:30:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6iKNwzcn5VX5QDdnhollSq050oKY6zBVJ0S6QL1gKLZXdkEeXuARUaEEPGoJQvjY/OuZWQRQ==
X-Received: by 2002:a05:6214:529c:b0:61b:73b2:85ca with SMTP id
 kj28-20020a056214529c00b0061b73b285camr6341008qvb.5.1685633414166; 
 Thu, 01 Jun 2023 08:30:14 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 es1-20020a056214192100b00626195bdbbdsm5547193qvb.132.2023.06.01.08.30.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Jun 2023 08:30:12 -0700 (PDT)
Date: Thu, 1 Jun 2023 11:30:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 8/9] tests/qtest: make more migration pre-copy
 scenarios run non-live
Message-ID: <ZHi5gmd+5pQhDqBF@x1n>
References: <20230531132400.1129576-1-berrange@redhat.com>
 <20230531132400.1129576-9-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230531132400.1129576-9-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Thanks for looking into this.. definitely worthwhile.

On Wed, May 31, 2023 at 02:23:59PM +0100, Daniel P. Berrangé wrote:
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

Curious how are below chosen?  I assume..

> 
>  * Precopy with UNIX sockets

this one verifies dirty log.

>  * Precopy with UNIX sockets and dirty ring tracking

... dirty ring...

>  * Precopy with XBZRLE

... xbzrle I think needs a diff on old/new, makes sense.

>  * Precopy with UNIX compress
>  * Precopy with UNIX compress (nowait)
>  * Precopy with multifd

What about the rest three?  Especially for two compression tests.

> 
> On a test machine this reduces execution time from 13 minutes to
> 8 minutes.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Thanks,

-- 
Peter Xu


