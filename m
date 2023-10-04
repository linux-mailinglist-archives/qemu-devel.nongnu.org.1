Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A02877B8337
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:11:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3Wh-0008Fo-EZ; Wed, 04 Oct 2023 11:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3We-0008FF-Sy
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:11:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3WZ-0001wq-Sb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:11:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696432249;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=99VlLS/kifsyUiDvIJoDSmFAvI8ZyZtGmn3Lqg2uR1c=;
 b=LrhcK8tNjIziIcXhkZsk7yhhOu5k5ydv9IBhjPYUaAAuizeKb2Ps1Ll4kMi/rodJIJxsHE
 wN0Pj/j1V4PEBrMwW68y8p482+Rh0o3pdzulE3e+mIMBBkmmAJuTLEUYjVuWp0XPmj1I8z
 iGoiZ2XNcOJShL/0rSm0XxyJ7RpkyAE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-rT3BaYRZNni6AjpzOlyAag-1; Wed, 04 Oct 2023 11:10:48 -0400
X-MC-Unique: rT3BaYRZNni6AjpzOlyAag-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fef3606d8cso17787535e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:10:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696432247; x=1697037047;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99VlLS/kifsyUiDvIJoDSmFAvI8ZyZtGmn3Lqg2uR1c=;
 b=PKqZWaDAHPvrIERExUhL4JBygRxe5vp1KckvDmjZ/i1MLU5mhA84fuIyofzMYTogMT
 0EhuJsZt9AqKHvMG++7oNmDBXNxC32Mfm8yBb0ETniWiE8qJuVQ+nkXyQeNs8RMIIx+U
 huKmt6HpaVGqrOj6MZnP2WgtL3pDm1t+114zL8yqgee4UUS376PyeCpkXmbWZNpyhok5
 CjI4idYanodwvxKmlEqYb0uTlSOrl72AttI6zgNhFCPym1kuUoAQiqlrVgtugr/X7YHT
 qZN9U+f/FGhgSrNjqgOdFt4J1rEHBgigaF3RjPoceClsamT5iY7wMe0THUyMLzKt+eyO
 BYBw==
X-Gm-Message-State: AOJu0Yy7EBKRPDWi+pXJ2lFYfyElE5Hfv/9nxTwjOyRmCz42boI+7UG7
 tMl449nfXaoAGnGjg8SOwzLABWK00SaP+m9noRjIADNBHd8m8AtOf3J1vTDMXyLgsIKSjtKz5FE
 ZEPpT5o6jXbGTUMo=
X-Received: by 2002:a1c:7c0a:0:b0:401:be5a:989 with SMTP id
 x10-20020a1c7c0a000000b00401be5a0989mr2519996wmc.23.1696432247208; 
 Wed, 04 Oct 2023 08:10:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHLHLKKK6Z9/bRs22yv/aVwfclO3zCDuW8RmT6SArTMs7hZKkzazbpxRCJPTxczt/agIZHBw==
X-Received: by 2002:a1c:7c0a:0:b0:401:be5a:989 with SMTP id
 x10-20020a1c7c0a000000b00401be5a0989mr2519983wmc.23.1696432246924; 
 Wed, 04 Oct 2023 08:10:46 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l16-20020a7bc450000000b0040536dcec17sm1750919wmi.27.2023.10.04.08.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:10:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 20/53] migration/rdma: Fix
 qemu_rdma_broken_ipv6_kernel() to set error
In-Reply-To: <20230928132019.2544702-21-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:46 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-21-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:10:45 +0200
Message-ID: <874jj6xw22.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> qemu_rdma_resolve_host() and qemu_rdma_dest_init() try addresses until
> they find on that works.  If none works, they return the first Error
> set by qemu_rdma_broken_ipv6_kernel(), or else return a generic one.
>
> qemu_rdma_broken_ipv6_kernel() neglects to set an Error when
> ibv_open_device() fails.  If a later address fails differently, we use
> that Error instead, or else the generic one.  Harmless enough, but
> needs fixing all the same.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


