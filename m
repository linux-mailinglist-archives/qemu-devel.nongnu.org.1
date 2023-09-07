Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 270E17971C3
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 13:29:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeDC6-0000h1-HQ; Thu, 07 Sep 2023 07:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeDC5-0000gs-BM
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:29:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeDC2-0006P3-US
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 07:29:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694086142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3plmDgcRM7WLUvLGnjVyUIkI0/DPUxjLd/UqdejgxEM=;
 b=BPXSebOobemOQWItgXnOxF1Te2IluFMMxCrUN0StZ5+pPd1CSSDvSSywOT6p+pLQqZgMxg
 NFOmF4zFE79rhHdKwJ1z1LdNEd7vJXj7qJThi7ox2mGbQeUdKuRa5tY6s8VCaJVugh0C9J
 0qccxAXZ8XOODFe4aRurNpQHYcUWPgA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-T8M6kffVNIiLE2ouiPtK4Q-1; Thu, 07 Sep 2023 07:28:58 -0400
X-MC-Unique: T8M6kffVNIiLE2ouiPtK4Q-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-314256aedcbso561204f8f.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 04:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694086137; x=1694690937;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3plmDgcRM7WLUvLGnjVyUIkI0/DPUxjLd/UqdejgxEM=;
 b=XL/xDqxu41+YiE6SPV4qt2IXdz3iUAF01m8s6zL46oFJ1g34ySmqvcHmrQ9rKhBD0T
 i7ZSTqJDaF+rTDSsivLzpX6eQj5krFIVh4yiFVQ+hyzplyI38Jv+XDXCnWyeamNPy7jU
 VQHCOtnkPBn4xcfQO/9rj+gicbqBQRA+AKdHPminGRjHmChG5K09Y5Ri7jXVHmRibpz4
 NS0/+2CZi/SFi9f5/SSmdA944Z/zer5Wpv0Y05FXyQQyDK1fHJdNl+MnwiLi6vKBmNSY
 ivhK/cxDoUje/ftrf2yGXpkQkWlOCJFKv9xuALn6P61uojais0B8P54qcLFmKZkiVSTN
 y+oQ==
X-Gm-Message-State: AOJu0YwPQvo7Nz56L0SndMUA8UAqruwzkCFtpgstT++rEuNM8CJ7PcXG
 9kp538khQUBBRCSW7r3x1XphoGzKM4/3gBMjq6u+ztVc6iE01iTCItUDwKH++vYz0phUZvBB4DA
 /uIkrKYkCqMZtMRE=
X-Received: by 2002:a1c:7905:0:b0:401:d69e:8b4d with SMTP id
 l5-20020a1c7905000000b00401d69e8b4dmr4908336wme.9.1694086137298; 
 Thu, 07 Sep 2023 04:28:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCpf7S2yaNWiodiC/xgdyDB/ZtYPMUFQF3HA/wi6Tbw+WD/v04mZymeAgL+5CUEeADo9btwg==
X-Received: by 2002:a1c:7905:0:b0:401:d69e:8b4d with SMTP id
 l5-20020a1c7905000000b00401d69e8b4dmr4908325wme.9.1694086136899; 
 Thu, 07 Sep 2023 04:28:56 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312::1fc? ([2001:b07:6468:f312::1fc])
 by smtp.googlemail.com with ESMTPSA id
 p33-20020a05600c1da100b003fef5e76f2csm2406170wms.0.2023.09.07.04.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Sep 2023 04:28:56 -0700 (PDT)
Message-ID: <1fa3ad95-c335-7e97-42f0-00dca5c5ba48@redhat.com>
Date: Thu, 7 Sep 2023 13:28:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC 0/3] qmp: make qmp_device_add() a coroutine
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, Markus Armbruster
 <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20230906190141.1286893-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230906190141.1286893-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/6/23 21:01, Stefan Hajnoczi wrote:
> It is not safe to call drain_call_rcu() from qmp_device_add() because
> some call stacks are not prepared for drain_call_rcu() to drop the Big
> QEMU Lock (BQL).
> 
> For example, device emulation code is protected by the BQL but when it
> calls aio_poll() -> ... -> qmp_device_add() -> drain_call_rcu() then the
> BQL is dropped. See https://bugzilla.redhat.com/show_bug.cgi?id=2215192 for a
> concrete bug of this type.
> 
> Another limitation of drain_call_rcu() is that it cannot be invoked within an
> RCU read-side critical section since the reclamation phase cannot complete
> until the end of the critical section. Unfortunately, call stacks have been
> seen where this happens (see
> https://bugzilla.redhat.com/show_bug.cgi?id=2214985).

I think the root cause here is that do_qmp_dispatch_bh is called on the 
wrong context, namely qemu_get_aio_context() instead of 
iohandler_get_aio_context().  This is what causes it to move to the vCPU 
thread.

Auditing all subsystems that use iohandler_get_aio_context(), for 
example via qemu_set_fd_handler(), together with bottom halves, would be 
a bit daunting.

I don't have any objection to this patch series actually, but I would 
like to see if using the right AioContext also fixes the bug---and then 
treat these changes as more of a cleanup.  Coroutines are pretty 
pervasive in QEMU and are not going away which, as you say in the 
updated docs, makes drain_call_rcu_co() preferrable to drain_call_rcu().

Paolo


> This patch series introduces drain_call_rcu_co(), which does the same thing as
> drain_call_rcu() but asynchronously. By yielding back to the event loop we can
> wait until the caller drops the BQL and leaves its RCU read-side critical
> section.
> 
> Patch 1 changes HMP so that coroutine monitor commands yield back to the event
> loop instead of running inside a nested event loop.
> 
> Patch 2 introduces the new drain_call_rcu_co() API.
> 
> Patch 3 converts qmp_device_add() into a coroutine monitor command and uses
> drain_call_rcu_co().
> 
> I'm sending this as an RFC because I don't have confirmation yet that the bugs
> mentioned above are fixed by this patch series.
> 
> Stefan Hajnoczi (3):
>    hmp: avoid the nested event loop in handle_hmp_command()
>    rcu: add drain_call_rcu_co() API
>    qmp: make qmp_device_add() a coroutine
> 
>   MAINTAINERS            |  2 ++
>   docs/devel/rcu.txt     | 21 ++++++++++++++++
>   qapi/qdev.json         |  1 +
>   include/monitor/qdev.h |  3 ++-
>   include/qemu/rcu.h     |  1 +
>   util/rcu-internal.h    |  8 ++++++
>   monitor/hmp.c          | 28 +++++++++++----------
>   monitor/qmp-cmds.c     |  2 +-
>   softmmu/qdev-monitor.c | 34 +++++++++++++++++++++++---
>   util/rcu-co.c          | 55 ++++++++++++++++++++++++++++++++++++++++++
>   util/rcu.c             |  3 ++-
>   hmp-commands.hx        |  1 +
>   util/meson.build       |  2 +-
>   13 files changed, 140 insertions(+), 21 deletions(-)
>   create mode 100644 util/rcu-internal.h
>   create mode 100644 util/rcu-co.c
> 


