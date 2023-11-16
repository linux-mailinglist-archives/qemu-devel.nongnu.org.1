Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BD07EE4AE
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:51:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3eeK-00072z-BI; Thu, 16 Nov 2023 10:51:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3eeE-0006xX-8c
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:51:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3eeC-000616-MQ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700149875;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=i+zuEQJTKNYoldv2j7sN5okpAktFvt8QuKPbqszX8Ho=;
 b=PFl2Iny8krKwiTb7/vQBz6jUarJifnmEpTqNxhfVYgEsm2X8xpjcN4MTClXKhM3hg0v1zb
 g71TWzwV3wLvko662DfSZaTdpsOUiGR4lkYStfwFDE+ne2L+nv5WmqPdX7qpGLjae0O1Wt
 nKUWpq98DpfYSxqGGHfQpsk0WvH/USo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-blB99nrWPSyy7NAkoKUzfQ-1; Thu, 16 Nov 2023 10:51:14 -0500
X-MC-Unique: blB99nrWPSyy7NAkoKUzfQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32fbe5c7b9dso1005526f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 07:51:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149873; x=1700754673;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i+zuEQJTKNYoldv2j7sN5okpAktFvt8QuKPbqszX8Ho=;
 b=mjlnH73snaMkBSW38Z26oTefcC3gEqlhk44rZlXDHyA6QL6bVjPg2fhMCHGM3Nacen
 8bPxsQUnERfM/kj+MXZ77IpZQjDkJvZZZt0/oG7//SAq30ZnHQSLAeSF+kLOvk85t2xl
 fy2Idzq2BdkZzAz3gU3cwMqdyymOUGRKmCQQdPG4AAFx2hjDVewlZY/u0afTRy4+f562
 f+lCt+JrjvbqS8uEiFuLlXFd0g6JiG3qGHYHSKZuGTZYFplRdMw/Wyxg6FSbMb5sk3mI
 e+H82WfJ5PzGfWpnPlqpscb0htH8EYqTQFo+G9Za2wM4K31+/x6j98IJDvZGTuhD5ck3
 maCw==
X-Gm-Message-State: AOJu0YwtEab7bLU+MVPerBqAAwNQRm1+Sp38TqccrIhpOa8wNR4hqvmv
 Xmt6ihsNestdYaUWtj3otOZPmUkzaWd/fzuxY8FKXZl3HqsRqsrKbbmq6do71xjLY1a1Klvm8bo
 9eRzCQoexueofXL0=
X-Received: by 2002:a5d:648d:0:b0:32f:76f4:b2b with SMTP id
 o13-20020a5d648d000000b0032f76f40b2bmr1979059wri.11.1700149873149; 
 Thu, 16 Nov 2023 07:51:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSkd1tkoloQbI2oLNBhe1oEs7ozfTBsMivh6RW/kH4dYfLtrDSzuiUdISAnp4J8mzNSz8Xww==
X-Received: by 2002:a5d:648d:0:b0:32f:76f4:b2b with SMTP id
 o13-20020a5d648d000000b0032f76f40b2bmr1979042wri.11.1700149872843; 
 Thu, 16 Nov 2023 07:51:12 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 d1-20020adfe841000000b0032dba85ea1bsm14074226wrn.75.2023.11.16.07.51.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:51:12 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/2] migration/multifd: Move semaphore release into
 main thread
In-Reply-To: <87leb5zsw6.fsf@suse.de> (Fabiano Rosas's message of "Fri, 10 Nov
 2023 09:37:13 -0300")
References: <20231109165856.15224-1-farosas@suse.de>
 <20231109165856.15224-3-farosas@suse.de> <ZU0rY662a5C1mvyf@x1n>
 <87pm0hzucq.fsf@suse.de> <87leb5zsw6.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 16 Nov 2023 16:51:11 +0100
Message-ID: <87jzqhhf2o.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Fabiano Rosas <farosas@suse.de> writes:
>
>> Peter Xu <peterx@redhat.com> writes:
>>
>>> On Thu, Nov 09, 2023 at 01:58:56PM -0300, Fabiano Rosas wrote:

>> I think we historically stumbled upon the fact that qemu_thread_join()
>> is not the same as pthread_join(). The former takes a pointer and is not
>> safe to call with a NULL QemuThread. That seems to be the reason for the
>> p->running check before it.
>
> Scratch this part, the QemuThread is not a pointer.
>
> ...should it be? Because then we can test p->thread instead of
> p->running, which would be more precise and would dispense the
> thread_created flag.

You still need to make sure that you don't join the thread twice.
And we do the qemu_pthread_join() without any lock.

Later, Juan.


