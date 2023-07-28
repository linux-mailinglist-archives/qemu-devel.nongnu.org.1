Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE967676BD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 22:07:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPTP3-0000qd-Ti; Fri, 28 Jul 2023 15:45:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPTP1-0000qP-E5
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 15:45:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qPTOx-0004Bl-CR
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 15:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690573516;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6cVfyFkR7dw0sUUrSN6M9WHNomRx08m/J2kw+fe5xmQ=;
 b=Qen59nHymCY47jJkHnC8Q0VFAzcY7qLFHdjYDuV2iRsdHc3C7oo7PnohTTeD39JEEY81xP
 EeVfs7AFauiNzN+HJXolea4x/z5wPax5eG6vC/dTILfMyjXndM/n+2+XAIherC0/J3/d3d
 wG7stz15Jmk9s7M9o625JMtdroKw5SI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-wQlDsa-EN5Wi2JsHYUKzEA-1; Fri, 28 Jul 2023 15:45:15 -0400
X-MC-Unique: wQlDsa-EN5Wi2JsHYUKzEA-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76c8e07cbe9so13149785a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 12:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690573515; x=1691178315;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6cVfyFkR7dw0sUUrSN6M9WHNomRx08m/J2kw+fe5xmQ=;
 b=E7o4xcxdWUUu4Su9gJKyWrBrzy23+grVZF2PqQqT8K3RdgK3ONk9npqnmgzP9sjUbL
 xERWm0AHLC8R6mq6AGf7WhI1bEet00tOP01HG+Ed9b7awGV0Kp/vvP5d5mIdEU+GYpEN
 +gucpoY/jLIr5+ixrJY8rTPUtN4GUwyW6ddLR6KM6pGdlHshE40qJ8dKUz9VqBSeJC0/
 n9NWS4r92dYFr3FB4DP4K5XGOhVwwV+yN7Sa/LXj9cEdw3xCeDoa912gJwLOkprM0NPh
 EEWnI3akmHIDIH+oU3V7WCT0qzhBieKHlncxcuWkZ44FCAZEnpvHIejchImBQ829wjvR
 XN2w==
X-Gm-Message-State: ABy/qLYvG8kW0qsKYd1SpkiY27+jZBgTS2okUTYqw/PUO+3YIFXeKCKl
 m+ehkCTpp++PSCOkExe0b74Phbksr6ZC12f4CLVXygaIu174YHjU6fGjF6nDwXorTdveyfPAYrR
 vhwCKm0zH995mr8I=
X-Received: by 2002:a05:620a:178e:b0:767:614f:323b with SMTP id
 ay14-20020a05620a178e00b00767614f323bmr246574qkb.1.1690573514701; 
 Fri, 28 Jul 2023 12:45:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHX9+s78zgtCtL7GDpw2bW7wO63kqnLHu2u2h2fh7kfGuubmaPTlp9zmILYzmBQzf/7AQFoqg==
X-Received: by 2002:a05:620a:178e:b0:767:614f:323b with SMTP id
 ay14-20020a05620a178e00b00767614f323bmr246556qkb.1.1690573514394; 
 Fri, 28 Jul 2023 12:45:14 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 v13-20020ae9e30d000000b00767f14f5856sm1345877qkf.117.2023.07.28.12.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jul 2023 12:45:14 -0700 (PDT)
Date: Fri, 28 Jul 2023 15:45:13 -0400
From: Peter Xu <peterx@redhat.com>
To: ~hyman <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH QEMU 1/3] tests: Add migration dirty-limit capability test
Message-ID: <ZMQayZ3f4g8PSKdf@x1n>
References: <169056463135.22823.13693920045521586976-0@git.sr.ht>
 <169056463135.22823.13693920045521586976-1@git.sr.ht>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <169056463135.22823.13693920045521586976-1@git.sr.ht>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Yong,

On Thu, Jun 08, 2023 at 12:46:45AM +0800, ~hyman wrote:
> From: Hyman Huang(黄勇) <yong.huang@smartx.com>
> 
> Add migration dirty-limit capability test if kernel support
> dirty ring.
> 
> Migration dirty-limit capability introduce dirty limit
> capability, two parameters: x-vcpu-dirty-limit-period and
> vcpu-dirty-limit are introduced to implement the live
> migration with dirty limit.
> 
> The test case does the following things:
> 1. start src, dst vm and enable dirty-limit capability
> 2. start migrate and set cancel it to check if dirty limit
>    stop working.
> 3. restart dst vm
> 4. start migrate and enable dirty-limit capability
> 5. check if migration satisfy the convergence condition
>    during pre-switchover phase.
> 
> Signed-off-by: Hyman Huang(黄勇) <yong.huang@smartx.com>

How long does the test normally take?  How stable is it (the duration, not
the test itself; I assume it should be robust or it'll be a bigger problem..)?

Daniel just reworked the tests to shrink all tests to run in around 1m40s
locally here on a decent x86.  I hope this test won't take too long to
frustrate CI again.

-- 
Peter Xu


