Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0737CA961
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 15:30:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsNe8-0000lr-NR; Mon, 16 Oct 2023 09:28:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsNe1-0000lZ-CL
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:28:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsNdz-0008Vs-Gq
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 09:28:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697462906;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sdHYp+U9X7nad76cR5E8bjjcBBmZxJ3ieCJMtRCh50M=;
 b=OTrsEmYWxNZm3L3R4S+oVxIMQYHquu6dMUlEuTU0F6N4tJnre96LsepypriKDYQ/FX5GHK
 mZzGKDNOjW7b3hrgnTszVuVwDx+3nRC/fW2gYBKy5O8CuDkBn4Q4K6dmxrL9qOa4GDYsLU
 iUeZvQhJIhIx3awpzyPUAMVrENlxI5I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-zPd9C9JSPcqjxaSqm0GSbA-1; Mon, 16 Oct 2023 09:28:09 -0400
X-MC-Unique: zPd9C9JSPcqjxaSqm0GSbA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32d931872cbso2448081f8f.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 06:28:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697462888; x=1698067688;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sdHYp+U9X7nad76cR5E8bjjcBBmZxJ3ieCJMtRCh50M=;
 b=KLK/C/knowYBnHoodU2F60y4nK4CYeiWn2zcTgx3saM1lf0vwleXK9FkBCRSCeU+fe
 UbVV5vMhf4qKiPmwNMSjnZ7QN0pbwz3FA6E4ePDVPuDo0iFoOtpMusj6k5JSzn58VHbe
 ojNJvazFtqSudkTIvHdJkK+FB8CpiIzIh9PKie0Paoefxf44Fuv2WSEZTRUOBSxRygXL
 dT2UViXIZyDJF8LfNXT59D5KS0RR4+lq43iuz548VgK1Lq/dh+64pb7VNiZduu6V+cQb
 pfnje1OW+C6NMQP4iB17EWMihyzlRWlD6JMm08JmUWZQ3IjKrPwZIrdYNoIaLXW0WyWZ
 P6mQ==
X-Gm-Message-State: AOJu0YxCXd7cUwcVuNFo9cjc3YovvV4NfP1FSsLq/1RRifhwMsKZIUNy
 DQZUn7hcE78ey/QepSDnciag+URm1hn2OrgADTIm0BjdxZJt4Ew1/L0JRNYYd33irMkAw9JcHkV
 UhNw7Zq0noJo5lNI=
X-Received: by 2002:a05:6000:698:b0:32d:8819:4620 with SMTP id
 bo24-20020a056000069800b0032d88194620mr15481664wrb.14.1697462888557; 
 Mon, 16 Oct 2023 06:28:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsS61VqmrvhsANQbKIQpTzpqIWHvgaDsgpOVfAvZgR1aO8uDboC/YEsyBQczpRxUuNgBN/wg==
X-Received: by 2002:a05:6000:698:b0:32d:8819:4620 with SMTP id
 bo24-20020a056000069800b0032d88194620mr15481639wrb.14.1697462888203; 
 Mon, 16 Oct 2023 06:28:08 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 v3-20020adfa1c3000000b0032d8354fb43sm14068571wrv.76.2023.10.16.06.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 06:28:07 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,  libvir-list@redhat.com,  Fabiano Rosas
 <farosas@suse.de>,  qemu-block@nongnu.org,  Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Stefan
 Hajnoczi <stefanha@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Hailiang
 Zhang <zhanghailiang@xfusion.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 03/10] migration: migrate 'inc' command option is
 deprecated.
In-Reply-To: <87bkcyixwn.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 16 Oct 2023 11:42:44 +0200")
References: <20231013104736.31722-1-quintela@redhat.com>
 <20231013104736.31722-4-quintela@redhat.com>
 <8734yehdoc.fsf@pond.sub.org> <87a5sj59ww.fsf@secure.mitica>
 <87bkcyixwn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 15:28:05 +0200
Message-ID: <87fs2a3dei.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Juan Quintela <quintela@redhat.com> writes:
>
>> Markus Armbruster <armbru@redhat.com> wrote:
>>> Juan Quintela <quintela@redhat.com> writes:
>> So what I want, I want to remove -i/-b in the next version (9.0?).  For
>> the other, I want to remove it, but I don't care if the code is around
>> in "deprecated" state for another couple of years if there are still
>> people that feel that they want it.
>>
>> This is the reason that I put a pointer for -i/-b to
>> @block/@block-incremental.  They are "perfect" replacements.
>>
>> I can put here to use blockdev-mirror + NBD, but the replacement is not
>> so direct.
>>
>> Does this make sense?
>
> I see where you're coming from.  Now let's change perspective for a
> minute: what's the purpose of deprecating stuff?
>
> We normally deprecate with intent to remove.
>
> We don't remove right away, because we promised to first deprecate for a
> grace period, so users can adjust in an orderly manner.  The deprecation
> serves as signal "you need to adjust".  The documentation that comes
> with it should help with the adjustment.  It's commonly of the form "use
> $alternative instead".  The alternative is often a direct replacement,
> but not always.  There could even be no replacement at all.  We don't
> promise replacements, we promise an orderly process, so users can
> adjust.
>
> Sometimes, we don't have firm plans to remove, but are more like "maybe
> remove when gets in the way".  We could soften the "you need to adjust"
> signal in documentation, but I doubt that's a good idea.  Regardless,
> the need to help users adjust remains.
>
> Back to your patches.  There are two separate interfaces to block
> migration, and both are deprecated at the end of the series:
>
> 1. Migration parameter @block-incremental & friends
>
>    Not in the way, content to keep around for longer if it helps users.
>
>    The deprecation documentation advises to use block-mirror with NBD
>    instead.  All good.
>
> 2. QMP migrate parameters @inc and @blk
>
>    Firm intent to remove as soon as the grace period expires, because
>    it's in the way.
>
>    The deprecation documentation advises to use interface 1 instead.
>    But that's deprecated, too!
>
>    Insufficiently careful readers will miss that the replacement is
>    deprecated, and just use it.  Risks surprise when the replacement
>    goes away, too.
>
>    More careful readers will realize that this advises to use something
>    we elsewhere advise not to use.  Contradiction!  Confusion ensues.
>
>    On further reflection, these readers might conclude that the
>    *combined* advice is to use block-mirror with NBD instead.  This is
>    correct.
>
>    So why not tell them?
>
>    Perhaps you'd like to give more nuanced advice, like "you should move
>    to block-mirror with NBD, but if that's not practical for you, you
>    should at least move to @block-incremental & friends, which will
>    likely stick around for longer."  That's fine.  All I'm asking for is
>    to not make things more confusing than they need to be :)
>
> [...]

Telling this in deprecated.rst is enough?  or you want me to put it also
in the error/warn messages and qapi?

Later, Juan.


