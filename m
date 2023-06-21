Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADF5737F94
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 12:32:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBv74-00067G-VG; Wed, 21 Jun 2023 06:30:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBv72-00062d-4m
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qBv70-0007mT-Gr
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 06:30:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687343453;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ePg5yqdEGA+3qAIbqS/Fw5p4vAjQ9A+r4Bbggr6JR74=;
 b=Gl2w/PVtiUpQlIUO9Xf1TPauNEhqr3sZhuZeBRyg9G9Ap5EDNriaf4BnbljRLM7yy4UriL
 Z0SmSz4q1SpTLzm80/bcKF/i7YoMitNiSrdClGXTPwfyxjnI6HYzzfiwsHzhv37HxnDfm+
 39KRo36nhBCF0cVAmSeyAn5LzEXfEQA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-vW7lXE8XMkeVYmFntQnMHQ-1; Wed, 21 Jun 2023 06:30:52 -0400
X-MC-Unique: vW7lXE8XMkeVYmFntQnMHQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3113da8b778so1349880f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 03:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687343451; x=1689935451;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ePg5yqdEGA+3qAIbqS/Fw5p4vAjQ9A+r4Bbggr6JR74=;
 b=a888hkQzSw8lFnOLMny0+W0mdJAwwRJHoi25aiOhKxt9GgxfxFZ5LjVk4MCyxprwhP
 pXjdGVF2cguzhqNmoCHCFvrHMdplhTzOoppTF9HLUKKqkXAKA9LDfmQz6PMAZ1j9c0bQ
 QgIhYUJjmnSGMO3UiePu2axN8+abzi8vtZSFxmiGkWz7kgjQ49PRvpMAQf8VtuJwjqKX
 s0NwWej6pBeORFcPZq4tqyYAmLQsa2+c1pgQ/7s5FBHCjuNEFr1PSLuCzYSqksrWDJ5v
 SaSH850FpjhJ0sozgoohTYDM4LyTwnrILN+S0yegKIryUfy/7rzS/Zk6vKRuAzZ0B6F8
 d8LQ==
X-Gm-Message-State: AC+VfDwB2iOOvATh51ldlvJ+tzGP7QmfzxJwNAEDS0hrEFSFnQ+8Y4jv
 8qk/GzTgjA0dFMusxA5kWFUlvMfbPHVzYukRJL2bANU8ATeZBaFIz/YZ0BThZRGnjzYvpvI+blt
 UF+0mqsA1I4pc8n8=
X-Received: by 2002:a5d:5005:0:b0:309:5122:10a3 with SMTP id
 e5-20020a5d5005000000b00309512210a3mr9873453wrt.48.1687343451049; 
 Wed, 21 Jun 2023 03:30:51 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5/RN/BUgSXe6pTj/uV9uHasdi887FXgsSPshllczzdGlXDMzBIFkXyQ4hHpYwQM9UJsR+P2g==
X-Received: by 2002:a5d:5005:0:b0:309:5122:10a3 with SMTP id
 e5-20020a5d5005000000b00309512210a3mr9873438wrt.48.1687343450735; 
 Wed, 21 Jun 2023 03:30:50 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 w3-20020adfee43000000b0030e5b1fffc3sm4174694wro.9.2023.06.21.03.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 03:30:50 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Laurent
 Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 16/42] migration-test: Create do_migrate()
In-Reply-To: <ZJHLahb43lc27gIR@x1n> (Peter Xu's message of "Tue, 20 Jun 2023
 11:53:14 -0400")
References: <20230608224943.3877-1-quintela@redhat.com>
 <20230608224943.3877-17-quintela@redhat.com> <ZJHLahb43lc27gIR@x1n>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 12:30:49 +0200
Message-ID: <878rcdayzq.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> On Fri, Jun 09, 2023 at 12:49:17AM +0200, Juan Quintela wrote:
>> We called migrate_qmp() in lot of places.  And there are tricks like
>> changing tcp address with the right port.
>> 
>> Only two callers remaining:
>> - postcopy resume: It needs to play with the qmp.
>> - baddest: We want to do a unvalid URI. For that we need to do it by
>>   hand.
>> -    uri = migrate_get_socket_address(to, "socket-address");
>> -
>> -    migrate_qmp(from, uri, "{}");
>> +    do_migrate(from, to, "127.0.0.1:0");
>
> I think this means migrating to "127.0.0.1:0".  Can this work?

You are right.

do_migrate(from, to, NULL)

Same for the next one.

Too many rebases trying to make things clearer.

Good catch.


