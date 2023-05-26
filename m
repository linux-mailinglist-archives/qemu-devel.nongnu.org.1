Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B7C7121B7
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:00:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2SML-0004du-8l; Fri, 26 May 2023 03:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SMI-0004dT-64
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q2SMG-00020C-RJ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 03:59:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685087972;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZnptlWYq96+28nV0LA/J+jGkM3GiIjHPRLEQ0pTEhTk=;
 b=ZbFdnMo0xMd+aeRaCA92cFawejCWCt3rogVPLcxV8VrX03eFfbsefvce8bXGdL1EuGzirT
 rURXjHNgf/eoP8xTOie95bVp5oONgsv7qx7pMzibwPqgX6J3rYCwaaxAh1Eh9fE+kU1bRY
 q/gfud+CtXDXCJwYrmAvLxHi0Xmreuo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-Koqg4pemPEiBngGeJ6JgKg-1; Fri, 26 May 2023 03:59:30 -0400
X-MC-Unique: Koqg4pemPEiBngGeJ6JgKg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30a8f6d7bbdso175879f8f.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 00:59:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685087969; x=1687679969;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZnptlWYq96+28nV0LA/J+jGkM3GiIjHPRLEQ0pTEhTk=;
 b=YdSRE8idmAbjDf7nxjnpaBrP0Nft3Zlq6kF1a3fjEO1Xwlz5kAud5NLICmCZlH4uj2
 ka+V0p1helkGcNhdfJC4RVKtMRYvT7+dPwBGBQc6ngDDEppS7faZFc7os4mHdh8DnnlY
 FQngVWdw6E56pz4I79a2eENgG5m3gebhpq9dIGfWHTaUOc/jkMqJeG1WkaVe2F7UZphM
 dwCtEBhfIfnU0iw2Nga+5CP2mVZJggufehwhp75h8oBJFRA1jYYHFzpLpGrTNvYHlvvq
 +I/f9sUawU1M7VMvSSGv0jyyNFXVM/etXvrOK5e4TGY0Zv34NZRggzfaHBhw0QCm5ewM
 DyEQ==
X-Gm-Message-State: AC+VfDzLo8DJaITgUavsQDRH0+gjhT702ps21YYXLoGpjU1kxNJ9yVa+
 CtwWoXz7AoO0gYCvAdkwTqvcOGVU6xSelsjn5YV2Pl1oumFE1wviK4n9BjRSoQFjLagJELMs0+E
 CUmjcnCIRzDTVaMzudEB/uAnEhQ==
X-Received: by 2002:a5d:6644:0:b0:304:6fef:f375 with SMTP id
 f4-20020a5d6644000000b003046feff375mr679421wrw.70.1685087968933; 
 Fri, 26 May 2023 00:59:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5vUl6E6MHFh6G96TcNB+yRXSz+rHozoleH6zyfwi7zW3DLJDSJEzEVg/9Y0c9u5ckevM0QRQ==
X-Received: by 2002:a5d:6644:0:b0:304:6fef:f375 with SMTP id
 f4-20020a5d6644000000b003046feff375mr679407wrw.70.1685087968647; 
 Fri, 26 May 2023 00:59:28 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 q14-20020adff50e000000b00307acec258esm4255304wro.3.2023.05.26.00.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 May 2023 00:59:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  leobras@redhat.com,
 peterx@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH 0/5] Restore vmstate on cancelled/failed migration
In-Reply-To: <19a170c1-fd9f-e62e-ed17-0315b566cd7f@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Thu, 18 May 2023 17:49:01 +0300")
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
 <871qjdevcj.fsf@secure.mitica>
 <19a170c1-fd9f-e62e-ed17-0315b566cd7f@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Fri, 26 May 2023 09:59:27 +0200
Message-ID: <87edn34j6o.fsf@secure.mitica>
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
> On 18.05.23 14:23, Juan Quintela wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
>>> Hi all.
>>>
>>> The problem I want to solve is that guest-panicked state may be lost
>>> when migration is failed (or cancelled) after source stop.
>>>
>>> Still, I try to go further and restore all possible paused states in the
>>> same way. The key patch is the last one and others are refactoring and
>>> preparation.
>> Hi
>> I like and agree with the spirit of the series in general.  But I
>> think
>> that we need to drop the "never fail in global_state_store()".  We
>> shouldn't kill a guest because we found a bug on migration.
>> 
>
> Why migration is better in this sense than non-migration? We have a
> lot of places where we just assert things instead of creating
> unreachable error messages. I think assert/abort is always better in
> such cases. Really, if we fail in this assertion it means that memory
> is corrupted, and stopping the execution is the best thing to do.
>
> (Should we consider the case that in future we add 100 character length vmstate? I hope we should not)

Ok, I give up and integrate the series as they are O:-)

I agree that this is a case that shouldn't happen, so assert() is not as
out of question.

What I am trying to get migration is to really detect errors and be able
to recover from them.  My long term crusade is getting rid of
qemu_file_get_error() and just check the return value for functions that
do IO.  Yes, it is a big long term because we need to change the whole
interface to something saner.

Later, Juan.


