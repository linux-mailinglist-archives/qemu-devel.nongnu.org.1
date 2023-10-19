Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0CE7CFDAC
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 17:20:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtUoR-0007lg-6Q; Thu, 19 Oct 2023 11:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtUoN-0007h8-4W
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtUoK-0001Fb-Qz
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 11:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697728783;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=OwHlwGtmkG9N+2XMTYuXih/Skau4B6xjeXcM/4tShn8=;
 b=QIcPvo4MCkq4wj6TqPYiiq5JhLIgF8kLibZk1rVvZlslE6xdtqpaReR5t6egXQivVcaXa4
 XXKYjhQRkTxQ8zuBKh82KBp4v+r9930FbWGOMpBkqbpu0B0FdTqBq06W+UJPtneEhK6AQW
 f8p/RIfqQXc3K1X9diGbduhynaaEYNw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-Dfja5uToOZ2KYNVqfmBL1w-1; Thu, 19 Oct 2023 11:19:40 -0400
X-MC-Unique: Dfja5uToOZ2KYNVqfmBL1w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f41a04a297so58421135e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 08:19:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697728778; x=1698333578;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwHlwGtmkG9N+2XMTYuXih/Skau4B6xjeXcM/4tShn8=;
 b=Uk59VFjo+Ec8bttC/Bll9fp5aVaxxYUeM7e0TnPLHnVDaM68D8RJMdJP38p33Feg2E
 2IQ2LsHUk7F+QOFLiEQq5V+eiRhISzGKtDtWBD9A5ElhbjB8cXyO7yN+b6RBNUUN3Phg
 rxHDA1Fp5ICWLmlDdLja15uAmbnpS0dvMOyrpRS0Th+ii8bnf0SWGfLOZ8gMTfZX2vhL
 HErJRzB5hO1dRbgg9UhmgoD0GSPcxOxf0aMvQCR5psqbz9qf8ZRVwKMhYLRbZBRKmonU
 V5OxHZpL4pEjYkAhRzVP65gld9Ww9QiudcGwriCY7v5NDTOiBy4ozwGW7ZDAhIH5//Np
 DGoA==
X-Gm-Message-State: AOJu0YxnsWqx/0UWT/A+Iz2cw12VvVk2fnjWtkOS29dHy1l/IdD28OaX
 lbL8Hs2uea5VVM3t2kHQwb9+3tQw53DtueVL4b8QkJJj7pqB+A9Cmbnq/6AhX0e6da0HFIXR8Ik
 81Nill0GMFDT9vWQ=
X-Received: by 2002:a05:600c:4f90:b0:405:1baf:cedf with SMTP id
 n16-20020a05600c4f9000b004051bafcedfmr1978837wmq.24.1697728777951; 
 Thu, 19 Oct 2023 08:19:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHeOS0XQgAzPXgD+QbDedRz75edbd7KpZde18YmOwDYzNlVYFDqw9n+LTmkHAOuqssaJbHcwA==
X-Received: by 2002:a05:600c:4f90:b0:405:1baf:cedf with SMTP id
 n16-20020a05600c4f9000b004051bafcedfmr1978822wmq.24.1697728777587; 
 Thu, 19 Oct 2023 08:19:37 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 f19-20020adfb613000000b003232380ffd7sm4660413wre.102.2023.10.19.08.19.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:19:37 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC PATCH v2 2/6] migration/multifd: Stop checking p->quit in
 multifd_send_thread
In-Reply-To: <87o7guy7zu.fsf@suse.de> (Fabiano Rosas's message of "Thu, 19 Oct
 2023 11:58:13 -0300")
References: <20231012140651.13122-1-farosas@suse.de>
 <20231012140651.13122-3-farosas@suse.de>
 <87o7gv6kt6.fsf@secure.mitica> <87o7guy7zu.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 17:19:36 +0200
Message-ID: <87sf663aif.fsf@secure.mitica>
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

Fabiano Rosas <farosas@suse.de> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> Fabiano Rosas <farosas@suse.de> wrote:
>>> We don't need to check p->quit in the multifd_send_thread() because it
>>> is shadowed by the 'exiting' flag. Ever since that flag was added
>>> p->quit became obsolete as a way to stop the thread.
>>>
>>> Since p->quit is set at multifd_send_terminate_threads() under the
>>> p->mutex lock, the thread will only see it once it loops, so 'exiting'
>>> will always be seen first.
>>>
>>> Note that setting p->quit at multifd_send_terminate_threads() still
>>> makes sense because we need a way to inform multifd_send_pages() that
>>> the channel has stopped.
>>>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>
>> But then should we remove the quit altogether?
>>
>
> It still serves a purpose to allow multifd_send_pages() to see that the
> channel has exited. While that function does also check
> multifd_send_state->exiting, it could already be waiting at the mutex
> when the channel aborts. So we need to either check 'exiting' again or
> keep p->quit.

At the point that we are putting p->quit = true, we are really next to
where we put p->running = false.

I think we can move to use only p->running.

Later, Juan.


