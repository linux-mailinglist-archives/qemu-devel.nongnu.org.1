Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2A07B9B23
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:38:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoHzN-0006Dv-Nb; Thu, 05 Oct 2023 02:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoHzL-0006Dl-EC
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoHzJ-0006Tf-Tj
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696487853;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=fr69LDeQ54PshvG6X34cDsRKRA4mS4koNP4LdPdRUYE=;
 b=aw+J7z8XK1gXn36WyDU7GL9dDyES+Mex4F2FuNFF0A105KgjlM9bkUfP/wCPgNFYK8cuNM
 c0UqmanCA8fIfWsHbN0+ZazeqUuPiFuE1Jj526Ho92IeAW/Ef8ttQZe7+DKS3b6zxD8B5i
 JTOoSrURzeEhf89+0g6CPaYuudDBStM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-olUD0p5eN8m59mCzZHh36A-1; Thu, 05 Oct 2023 02:37:16 -0400
X-MC-Unique: olUD0p5eN8m59mCzZHh36A-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3231f43fc5eso460384f8f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696487835; x=1697092635;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fr69LDeQ54PshvG6X34cDsRKRA4mS4koNP4LdPdRUYE=;
 b=rfOSTL3T09kM+7g5JaGFP3XcBUGQE/uauFeiAD0AQCeDMWRIxX/H8b8MVXAFT1y+Kf
 BkA3mZwiRD8XAl3LR2YEvXm0lraMOHqZejstAt7qCEUiUEh96rJIk7MVUR0SFANS2zpO
 36lXnpscSBMvcOKx91bREdA4kyYCQXRS2lrRBKS1zQA152nVUryE7jUzLutIG5rEjcDA
 bdwQ0IIaMT2kpUtyHo1A/Dr86L5SL5uUK1kzr5CyqY9833EWGlqRvrjmKU0Fhb6cUE4U
 CmrBTe11a1rqOUyCdUlPNmK7jDOysohYB2ZXUv2iXgr2HdHddrixcDiL1ozQmg9YAMdY
 DNqQ==
X-Gm-Message-State: AOJu0Ywx0h+quHpBpkZzJRocSnX/gH21pblA7KBSrGBxSC/BXlDOaSly
 bCP3ungqY3JwcYQWT11Af9W3/zuIn9ArAGNgoX3nbmrwf7ZMCwYXICXc6rGr+hUXM+EzTNRVSpp
 wx5rUgdB6alxYfdPICazUlOR+/g==
X-Received: by 2002:a05:6000:1b09:b0:31f:e534:2d6f with SMTP id
 f9-20020a0560001b0900b0031fe5342d6fmr4115724wrz.11.1696487835166; 
 Wed, 04 Oct 2023 23:37:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5gk8ePq8nX6ZV690RuNCSSvnQ2w3yeTpo9sOLyGxPM3KwGjAvHzl3/NNuoQP7f4EQ7A1uUQ==
X-Received: by 2002:a05:6000:1b09:b0:31f:e534:2d6f with SMTP id
 f9-20020a0560001b0900b0031fe5342d6fmr4115715wrz.11.1696487834878; 
 Wed, 04 Oct 2023 23:37:14 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 e15-20020a5d594f000000b0030ada01ca78sm964164wri.10.2023.10.04.23.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 23:37:14 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 00/53] migration/rdma: Error handling fixes
In-Reply-To: <87r0m9ac97.fsf@pond.sub.org> (Markus Armbruster's message of
 "Thu, 05 Oct 2023 07:07:00 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <87fs2qs2b3.fsf@secure.mitica> <87r0m9ac97.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 08:37:13 +0200
Message-ID: <875y3lr2w6.fsf@secure.mitica>
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
>>> Oh dear, where to start.  There's so much wrong, and in pretty obvious
>>> ways.  This code should never have passed review.  I'm refraining from
>>> saying more; see the commit messages instead.
>>>
>>> Issues remaining after this series include:
>>>
>>> * Terrible error messages
>>>
>>> * Some error message cascades remain
>>>
>>> * There is no written contract for QEMUFileHooks, and the
>>>   responsibility for reporting errors is unclear
>>>
>>> * There seem to be no tests whatsoever
>>>
>>> PATCH 29 is arguably a matter of taste.  I made my case for it during
>>> review of v1.  If maintainers don't want it, I'll drop it.
>>>
>>> Related: [PATCH 1/7] migration/rdma: Fix save_page method to fail on
>>> polling error
>>
>> Hi Markus
>>
>> I integrated everything except:
>>
>>>   migration/rdma: Fix or document problematic uses of errno
>>
>> Most of them are dropped on following patches.
>
> The hunks that are dropped in later patches are:
>
> * Four FIXME comments about incorrect or problematic use of perror().
>
>   If you drop the patch, you have to adjust the later patches that
>   remove these hunks.  Resolving the conflicts is *not* enough; you also
>   have to correct the commit messages.
>
> The hunks that are not dropped are:
>
> * Three comments about bugs (either library doc bug or incorrect use of
>   @errno here).  I'd hate to lose them.
>
> * One bug fix, in qemu_rdma_advise_prefetch_mr().  Losing this one would
>   be foolish.
>
> Please consider keeping the patch.

And here I am, having to redo the merge from this patch O:-)

>>>   migration/rdma: Use error_report() & friends instead of stderr
>>
>> You said you have to resend this one.
>
> Can do, but since the change is trivial, perhaps you could make it in
> your tree without a resend.  Change the line
>
>                 warn_report("WARN: migrations may fail:"
>
> to
>
>                 warn_report("migrations may fail:"

I thought it was more complicated.

Ok doing both.

Thanks, Juan.


