Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A070DD19
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 14:57:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1RZe-0008IW-0D; Tue, 23 May 2023 08:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q1RZW-0008Hs-Es
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1q1RZU-0007Nc-M4
 for qemu-devel@nongnu.org; Tue, 23 May 2023 08:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684846619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v6W0qPaJcvkAcmyGpIvpgI3p5gV3TzsuvLNSioCrrV4=;
 b=JfGccRpz7TnkgeGcJlquI5mPJZAPIqXPsB/W10I0Izr8DUWri7lwy0TadPnH8tPT4sUb7Z
 PG+vfQeAwuZFIF5P/bl4BTZG+cEkeGftbatIePWfhgRH6/YpK7bBTC8+tGCRbR7NREfCCJ
 WiLroaRgGD+uJ8HDiV7j19ybdn6YGcc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-V4ayf5pfO72QoxJAnb2JYQ-1; Tue, 23 May 2023 08:56:58 -0400
X-MC-Unique: V4ayf5pfO72QoxJAnb2JYQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-510f6e39f5aso1242265a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 05:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684846617; x=1687438617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6W0qPaJcvkAcmyGpIvpgI3p5gV3TzsuvLNSioCrrV4=;
 b=A5vXj7jXYrqyCuQ3LxO8nc8ohTKe/0CWoB7oqqkD2w8T7YKW6dSN91SoAC08WZelkS
 qp4RXs6SVVBqpqzA11ALgCqvloi623fG+0l8Io70VVrh6HkNpp6lfCnnm/K9HtauEu8n
 pCxJRG9XA/gcC5rChyWoaZldvh8OkPKzThBgbJy7K0dF9Xs0PmZ4fFabiWqfRIVWlzVI
 UuRpGRnffOIyvysfD8C/Ep9rjsRYLYwMcFAA58+kpZ91F83xkWWL9PR9zgBMdoUA2FXo
 pzwXWaaViTRT0sQNFtg6Zy7TkGrosne3kdh3xyqvy29xMxmVJo7JJIRmtoe24/04+Lwl
 RNgA==
X-Gm-Message-State: AC+VfDy0bNbBgk2YwoQioTpz4cJa1y7tmtY+iWNT6zI2x90xdpw55f5B
 lC8Qb5MCkN3P/8fvNEEDCo44qD0Us0G0QPdBZv0X8WZcl+3EWfwbxc8AczuEMJE9SXPNJdFBVp7
 N6cOXUuSiRSBTndk=
X-Received: by 2002:aa7:d68c:0:b0:510:d6a2:408 with SMTP id
 d12-20020aa7d68c000000b00510d6a20408mr13197688edr.17.1684846617238; 
 Tue, 23 May 2023 05:56:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7U6KRa6qtLB/HId8PQ3ByX6dm6X6GFhISbpgctYk0NuS+9/9FNs7NNt5sOxBKYFyz/ABRP2Q==
X-Received: by 2002:aa7:d68c:0:b0:510:d6a2:408 with SMTP id
 d12-20020aa7d68c000000b00510d6a20408mr13197667edr.17.1684846616902; 
 Tue, 23 May 2023 05:56:56 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 b17-20020aa7c911000000b00502689a06b2sm3963916edt.91.2023.05.23.05.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 05:56:56 -0700 (PDT)
Date: Tue, 23 May 2023 14:56:55 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, wangyanan55@huawei.com,
 pbonzini@redhat.com, thuth@redhat.com, Peter Maydell
 <peter.maydell@linaro.org>, "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>
Subject: Re: The madness of ad hoc special IDs (was: [PATCH] machine: do not
 crash if default RAM backend name has been stollen)
Message-ID: <20230523145655.739f0014@imammedo.users.ipa.redhat.com>
In-Reply-To: <877csz6xgd.fsf@pond.sub.org>
References: <20230522131717.3780533-1-imammedo@redhat.com>
 <877csz6xgd.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, 23 May 2023 14:31:30 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> Igor Mammedov <imammedo@redhat.com> writes:
> 
> > QEMU aborts when default RAM backend should be used (i.e. no
> > explicit '-machine memory-backend=' specified) but user
> > has created an object which 'id' equals to default RAM backend
> > name used by board.
> >
> >  $QEMU -machine pc \
> >        -object memory-backend-ram,id=pc.ram,size=4294967296
> >
> >  Actual results:
> >  QEMU 7.2.0 monitor - type 'help' for more information
> >  (qemu) Unexpected error in object_property_try_add() at ../qom/object.c:1239:
> >  qemu-kvm: attempt to add duplicate property 'pc.ram' to object (type 'container')
> >  Aborted (core dumped)
> >
> > Instead of abort, check for the conflicting 'id' and exit with
> > an error, suggesting how to remedy the issue.  
> 
> This is an instance of an (unfortunately common) anti-pattern.
> 
> The point of an ID is to *identify*.  To do that, IDs of the same kind
> must be unique.  "Of the same kind" because we let different kinds of
> objects have the same ID[*].
> 
> IDs are arbitrary strings.  The user may pick any ID, as long as it's
> unique.  Unique not only among the user's IDs, but the system's, too.
> 
> Every time we add code that picks an ID, we break backward
> compatibility: user configurations that use this ID no longer work.
> Thus, system-picked IDs are part of the external interface.

in this case, IDs are there to keep backward compatibility
(so migration won't fail) and it affects only default (legacy**)
path where user doesn't provide memory-backend explicitly
(which could be named anything that doesn't collide with other objects)

> We don't treat them as such.  They are pretty much undocumented, and
> when we add new ones, we break the external interface silently.

this ID in particular is introspect-able (a part of qmp_query_machines output)
to help mgmt pick backward compatible ID when switching to explicit
RAM backend CLI (current libvirt behaviour).

> How exactly things go wrong on a clash is detail from an interface
> design point of view.  This patch changes one instance from "crash" to
> "fatal error".  No objections, just pointing out we're playing whack a
> mole there.
> 
> The fundamental mistake we made was not reserving IDs for the system's
> own use.
> 
> The excuse I heard back then was that IDs are for the user, and the
> system isn't supposed to pick any.  Well, it does.
> 
> To stop creating more moles, we need to reserve IDs for the system's
> use, and let the system pick only reserved IDs going forward.
> 
> There would be two kinds of reserved IDs: 1. an easily documented,
> easily checked ID pattern, e.g. "starts with <prefix>", to be used by
> the system going forward, and 2. the messy zoo of system IDs we have
> accumulated so far.
> 
> Thoughts?

I'd vote for #1 only, however that isn't an option
as renaming existing internal IDs will for sure break backward compat.
So perhaps a mix of #1 (for all new internal IDs) and #2 for
legacy ones, with some centralized place to keep track of them.
 
> [...]
> 
> 
> [*] Questionable idea if you ask me, but tangential to the point I'm
> trying to make in this memo.
> 

[**] If it were up to me, I'd drop implicit RAM backend creation
and require explicit backend being provided on CLI by user
instead of making thing up for the sake of convenience.
(If there is a support in favor of this, I'll gladly post a patch)


