Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 579927B839B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:31:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3pN-0002L3-DI; Wed, 04 Oct 2023 11:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3pL-0002Ko-0h
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:30:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3pE-0000zk-Dc
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:30:18 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-m5xl7ZUWNGydWoY9qB_0QQ-1; Wed, 04 Oct 2023 11:30:08 -0400
X-MC-Unique: m5xl7ZUWNGydWoY9qB_0QQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4030ae94fedso16593625e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:30:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696433407; x=1697038207;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Py48QtEci+NSgfXwDmb4xOOcYuWillbF9AAKji3mEHs=;
 b=fQd3EtBCr2IFkcuIBXO4sBQbm11tXuB/I1nESi67VAlqdykWn7oZmHB6N1pGZP97rB
 uwQBPOO2GqtLkHd7pc8WoywGgca12xFmnVAWHXgeezcjJL3mAiOlupsWMQ5gmve5QM9d
 XusJ6d2tS9JzKrJXiCdR2KTb0B9lNOA0d6sycxFiAUEweQH8964UzEOwKWO3Cv1REyIr
 6L4WYX1dP+nDnOJ5e365yzNDVtpWxRuk7g+FjIJ+g/WLE4/whCos+N9xflxjxZZ7NJIy
 r1toDV9oIDTosjkdWHNegmSvAerTX/L6XjYlnV0/aUHVy+GxgU3/63FQ7mnxZuhiRrI1
 c7Ag==
X-Gm-Message-State: AOJu0YyIZY8qlyz4iZdGBgqpvMtwO8keWswY/PxzVAx1AOzaIEB+lvLy
 rG6HjI5FqO9hN5e1wii2ItfVH8JGGpcA2WFbeI+wFoWJi9NTET4mZuv39AEQXjlM45g/FMZqxtt
 XBoQOwRjpfDG7MnA=
X-Received: by 2002:a05:600c:c9:b0:406:4d8f:9fee with SMTP id
 u9-20020a05600c00c900b004064d8f9feemr2670333wmm.24.1696433407431; 
 Wed, 04 Oct 2023 08:30:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhwOhiNok0/jWAOo0nnJ7KYCWfXyUBSSlas4vuPsW4JSCNq+7JKOkusQoGf73zE5Ckdok7Cg==
X-Received: by 2002:a05:600c:c9:b0:406:4d8f:9fee with SMTP id
 u9-20020a05600c00c900b004064d8f9feemr2670309wmm.24.1696433407079; 
 Wed, 04 Oct 2023 08:30:07 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 l19-20020a5d5273000000b0031ad5fb5a0fsm4270293wrc.58.2023.10.04.08.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:30:06 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 24/53] migration/rdma: Fix rdma_getaddrinfo() error
 checking
In-Reply-To: <20230928132019.2544702-25-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:50 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-25-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:30:05 +0200
Message-ID: <87mswywgle.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Markus Armbruster <armbru@redhat.com> wrote:
> rdma_getaddrinfo() returns 0 on success.  On error, it returns one of
> the EAI_ error codes like getaddrinfo() does, or -1 with errno set.
> This is broken by design: POSIX implicitly specifies the EAI_ error
> codes to be non-zero, no more.  They could clash with -1.  Nothing we
> can do about this design flaw.
>
> Both callers of rdma_getaddrinfo() only recognize negative values as
> error.  Works only because systems elect to make the EAI_ error codes
> negative.
>
> Best not to rely on that: change the callers to treat any non-zero
> value as failure.  Also change them to return -1 instead of the value
> received from getaddrinfo() on failure, to avoid positive error
> values.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


