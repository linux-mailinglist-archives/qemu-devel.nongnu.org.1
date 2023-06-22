Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A97F73A6DE
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:03:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNhk-0003Ha-Kv; Thu, 22 Jun 2023 13:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNhg-0003F9-Mm
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:02:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qCNhf-0005s5-Aj
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 13:02:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687453354;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Z3IWJaOorYWfW6EIR6/SQ4oCWE5LTZkE8r4nkzrY+ys=;
 b=JL98bCNjx4dMoCYGz2zE4bEDDvs4zyS2NGxGKcqL6PCSBFzICXAu29drbLyKDLgExYYMeG
 RLVdXC+6P172AF/N7op1VhKrR3j5AENTBouUZfElGZ8ibHFFIRlhzfJ+/H1wWXl10UbOBF
 bdzfT99fJh+5eZPqQP7V1OkML2NWmqE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-9dI5I4AMMN2jrw4cPbjH-A-1; Thu, 22 Jun 2023 13:02:21 -0400
X-MC-Unique: 9dI5I4AMMN2jrw4cPbjH-A-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f90ab2de48so102172135e9.2
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 10:02:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687453339; x=1690045339;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z3IWJaOorYWfW6EIR6/SQ4oCWE5LTZkE8r4nkzrY+ys=;
 b=Pb7qQ3FZlhUSh/3+dEXBdjf7Sy8Klrg8jPpGIlPTPv0n4y+GHnVamHN4hv5/PxWDNo
 Lg/KbjGx4F2/yuVX/YGayPw+jO+8+yZmUoOgMGCfPCoRPY50RUUuZvjH/VBA5M41fIV+
 EaK++RE9O0SWpUa4m/w6cGFFRU+kzujt3RccuYqA7ppx/WxxPFyuMV6udfqtZO8X4/Gx
 3ObwoGk2M7hqcHUrWhUaZ8/7Ze6khx9EXlDMZwTWKpaZv449cQSaQlxe7c6wGiz4cYLt
 QyNJP9e2k4v80HM3WOfeCuVf/bIkFGqVMvvY1FIPZcC1nAglfgvseb9eE6xxnMUirIL3
 it/Q==
X-Gm-Message-State: AC+VfDzh1QMMsDdYAp6dP77SmsaE4CxILSAlEQisJ/UFAsRBmhbkbCcX
 LIJYGN/i4PWz7kYUQHn6zpSwfzg2U5a30fCDt/E7Zeb9dXgZ/CsmQlGwGNqEiOcrWDBFtqDAr3X
 3LuqvZcpffZyTqvlSZL20vE/Ojw==
X-Received: by 2002:a1c:7c13:0:b0:3f8:fe21:b754 with SMTP id
 x19-20020a1c7c13000000b003f8fe21b754mr17707520wmc.6.1687453338993; 
 Thu, 22 Jun 2023 10:02:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7elMa8t519M3b3NO5pbbE8v72oZt/DTYP3exJKTYKtx2kCgy2tufnxkNZwu0NFaF/Dn3S7NA==
X-Received: by 2002:a1c:7c13:0:b0:3f8:fe21:b754 with SMTP id
 x19-20020a1c7c13000000b003f8fe21b754mr17707500wmc.6.1687453338662; 
 Thu, 22 Jun 2023 10:02:18 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k10-20020adff5ca000000b0030ae87bd3e3sm7520071wrp.18.2023.06.22.10.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 10:02:18 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] migration.json: Don't use space before colon
In-Reply-To: <87352jbpo5.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 22 Jun 2023 15:19:06 +0200")
References: <20230612191604.2219-1-quintela@redhat.com>
 <87352jbpo5.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 22 Jun 2023 19:02:16 +0200
Message-ID: <87edm3fn1j.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus Armbruster <armbru@redhat.com> wrote:
> Juan Quintela <quintela@redhat.com> writes:
>
>> So all the file is consistent.
>>
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Queued.  thanks!

My deprecated series depend on this, so I will got it through the
migration tree if you don't care.

Thanks, Juan.


