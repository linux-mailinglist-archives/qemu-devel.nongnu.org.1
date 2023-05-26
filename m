Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C0D7124BF
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 12:33:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2Ukh-0006Hk-DO; Fri, 26 May 2023 06:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2Ukf-0006HJ-HR
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:32:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2Uke-0006z2-6s
 for qemu-devel@nongnu.org; Fri, 26 May 2023 06:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685097169;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4CiZ/XUMrsTE2tFLD3hQ4fx/w3GlzrBJrLJSfrkVqt8=;
 b=DjWMsq204cJJHTNkif03BMRH5uqK4CXmjfS2Kk70DA4EUbWJVe0NF9WIMsgFCOnUY0VX7J
 d6rG1fnrzNrEJxVOThQlZnKO6+JbAh5eoVcdeyEfEt7WjKLtINJGu9ChJsfKqRyHczf+NP
 NC+47AO8bLhjkdIrYzXZ91/NvgkwM6w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-eT-HbaGmOGew95fbMVsnlQ-1; Fri, 26 May 2023 06:32:47 -0400
X-MC-Unique: eT-HbaGmOGew95fbMVsnlQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f60911a417so2773435e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 03:32:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685097166; x=1687689166;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4CiZ/XUMrsTE2tFLD3hQ4fx/w3GlzrBJrLJSfrkVqt8=;
 b=HV1GdXqiEPPXOTCrR2a7RqLLo9Ssoj/4Bi5shj2rhH846J7AbdvuhTzdSvlEiLb/EX
 0g6WLaK7yRVmri1utUotZoJOKAabG1Y7nqy5Rn+cd/2Uba+u5o/R4mNs42o9Z9Qwp/OO
 KvQMMdtYqzFjS2/P/H8haYA0nfTNn6tprl7/aeQeBTzsqyLooIYQseJQMLsP2auXU/y5
 nRfWgQOEqjPIUK6i/7lkjA5yDnJMkGWTVrySw3Y/G5sMV7TU3LqA6ujYn0KTzCBYIMEt
 6aHqpTtZ7EHsdJxeH+yJWhfBEGxiaHmw6VOFYepxxan0tu2Von1tbKRz7ZsAtoBMvw9C
 Krqw==
X-Gm-Message-State: AC+VfDwXLdhv/LhOtVRcHVn8/pvWmNBvofRSyJo0vS1o1jzGKjvsgw69
 z3+C7BAipQyziH6IU1k3S5WbS8APNIjCLS12QonlxeuiSwFR2/1g5OREBa2G+GwsJ/pKKs/6EjH
 nkxH0ycog7/J67ZU=
X-Received: by 2002:a05:600c:ad2:b0:3f4:26d4:91b0 with SMTP id
 c18-20020a05600c0ad200b003f426d491b0mr1124014wmr.40.1685097166363; 
 Fri, 26 May 2023 03:32:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fxxn2iafytr4r1jiojoZPrdnFj1r6IBT4gBpXVxr6REt+Lq8PYd2e9PuSi0I2+GU1MRu+bQ==
X-Received: by 2002:a05:600c:ad2:b0:3f4:26d4:91b0 with SMTP id
 c18-20020a05600c0ad200b003f426d491b0mr1124002wmr.40.1685097166075; 
 Fri, 26 May 2023 03:32:46 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 v1-20020a5d6781000000b002fae7408544sm4563723wru.108.2023.05.26.03.32.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 03:32:45 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/2] meson: Add static glib dependency for
 initrd-stress.img
In-Reply-To: <20230525212044.30222-3-farosas@suse.de> (Fabiano Rosas's message
 of "Thu, 25 May 2023 18:20:44 -0300")
References: <20230525212044.30222-1-farosas@suse.de>
 <20230525212044.30222-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 12:32:44 +0200
Message-ID: <87o7m71iyb.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Fabiano Rosas <farosas@suse.de> wrote:
> We recently moved glib detection code to meson but the static libs
> were left out. Add a specific dependency for stress.c which is linked
> statically.
>
> $ make V=1 tests/migration/initrd-stress.img
>
> before:
>  cc -m64 -mcx16 -o tests/migration/stress ... -static -Wl,--start-group
>  /usr/lib64/libglib-2.0.so -Wl,--end-group
>  ...
>  bin/ld: attempted static link of dynamic object `/usr/lib64/libglib-2.0.so'
>
> after:
>  cc -m64 -mcx16 -o tests/migration/stress ... -static -pthread
>  -Wl,--start-group -lm /usr/lib64/libpcre.a -lglib-2.0 -Wl,--end-group
>
> Fixes: fc9a809e0d ("build: move glib detection and workarounds to meson")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>
Tested-by: Juan Quintela <quintela@redhat.com>

queued.


