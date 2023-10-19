Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 788337CF8A9
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:25:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtS46-0000lA-2N; Thu, 19 Oct 2023 08:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtS43-0000jH-J6
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtS42-0003uG-1X
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697718225;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6TeqVwUSqD95zt7KZp/rA4+jzcR5SOvQ8Ek+xtJ4/RA=;
 b=IInG0l/PCyjAC85t5sap1kOSHzWcpqo9a3TyzsKaC3Ijr9A9evQn7hczSvVUeQFgolt/T6
 yhlLipQiH1QWVI/RxEDpGwdOEelWvsmSaBxrv/EfxOAie68qWIyUP+HYo1KOFCQqoNdHyU
 DzlBnX0FPyb+sLZjM/XGwxzgUx/zeP0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-6C8TYwTKOp2dmMYJsJ6sWg-1; Thu, 19 Oct 2023 08:23:38 -0400
X-MC-Unique: 6C8TYwTKOp2dmMYJsJ6sWg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32dcad22c5fso1094267f8f.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697718217; x=1698323017;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6TeqVwUSqD95zt7KZp/rA4+jzcR5SOvQ8Ek+xtJ4/RA=;
 b=lQcS51a3xn/PTQZnC493x77nbOo4EWKQhI+M2W+Q9RgGrUl0xuP0dIu2GyE6GAdt4Q
 jHlrC3WqMu2wBpEkdHmxTcdkrR8YpoajnCr0xWHbCijTQtxmJB61TM8tQVaz2mmZFNAL
 qz1acr1M1QnDsr3Re/QUQo6vW8hWE+/c+LLTkML9ZcCB7n2OBKxPYpYH6LdPcTQQqRY/
 Th3JqbH/U2FP8lASaIP89jMqnFkRdAXf8Dh0CSfy+imk0FtBgY5gbsptp55nFau05vbk
 UXaGeX/u0wSDZInv8ECEmBPkP/ml9nDS3IogYZz0mOCPQWsBrEUl8KBnLHPa8SVmuL5q
 2lkw==
X-Gm-Message-State: AOJu0YwgSvbew8IybWL5cqQwV2tPgc4f+9uGLcS9R5BHHWf/ZLQ9ieAU
 5OjdOPi9zUMBl3+6ZoXannAYgV1JFxADKWGGsv5gyr1fe8r2XijpTsjcndA2GWPXCc5LKNKJx4o
 VQdeNiC8GlfipxvY=
X-Received: by 2002:a05:6000:bc3:b0:32d:9d66:5742 with SMTP id
 dm3-20020a0560000bc300b0032d9d665742mr1735498wrb.10.1697718217655; 
 Thu, 19 Oct 2023 05:23:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFI5KfqN0GZKG0+S061kbTJoDfhFiM5h6loIqmYm5s4Fe84A5b+Pr5/AhoCzkhlgw6qdjgaAg==
X-Received: by 2002:a05:6000:bc3:b0:32d:9d66:5742 with SMTP id
 dm3-20020a0560000bc300b0032d9d665742mr1735478wrb.10.1697718217302; 
 Thu, 19 Oct 2023 05:23:37 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 k8-20020adfe3c8000000b0032710f5584fsm4364759wrm.25.2023.10.19.05.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:23:36 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  qemu-devel@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Chensheng Dong <chdong@redhat.com>,  Zhiyi Guo
 <zhguo@redhat.com>,  Eric Blake <eblake@redhat.com>,  Joao Martins
 <joao.m.martins@oracle.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH v4] migration: Allow user to specify available
 switchover bandwidth
In-Reply-To: <87wmvkxvza.fsf@pond.sub.org> (Markus Armbruster's message of
 "Wed, 18 Oct 2023 08:53:13 +0200")
References: <20231010221922.40638-1-peterx@redhat.com>
 <87y1g149t3.fsf@pond.sub.org> <ZS6qJ0F1uRlKWe45@x1n>
 <87wmvkxvza.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 14:23:35 +0200
Message-ID: <875y324x88.fsf@secure.mitica>
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
> Peter Xu <peterx@redhat.com> writes:

[..]

>>> "unconvergence" isn't a word :)
>>> 
>>> Suggest "like migration not converging, because the automatically
>>> detected migration bandwidth is hilariously low for whatever reason."
>>> 
>>> Appreciate the thorough explanation!
>>
>> Thanks for reviewing!
>>
>> The patch is already in today's migration pull, so unfortunately no planned
>> repost for now.  I'll amend the commit message and collect the ACK if I'll
>> need to redo it.
>
> Didn't see the PR, and didn't expect it so soon.

Sorry.

When a series is at v4 reviewed I tend to be faster pulling.
For new series, I try to let them in the list for a couple of days to
let people comment.

Later, Juan.


