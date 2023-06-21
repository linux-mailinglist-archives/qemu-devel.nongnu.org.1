Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E2773900D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:26:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3Sn-0005Au-GQ; Wed, 21 Jun 2023 15:25:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC3Sj-0005Ai-H9
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:25:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC3Sh-0004bj-M3
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687375550;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hC45HfnF3wa3gE3dE3ykWurOhQ3b7U62Yjsh2yLrk/A=;
 b=JWgagSrUvPbZcZosL3CF/tPDn4CJtsEew3COUrUSF5NRSwcclnjISCVvCbUNRizxM2uNjB
 TjHi4QQLW73bn5CNv9q6V+aYrip3n/2byleIhSmJ5zQsPmuZx3yTbuwa1D6UtKgnDpgoaG
 mgbv6KfmWPmQ+IeqUj60CBr3TE2dmS0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-dttV3BeOPXyT8EZeAfFhlA-1; Wed, 21 Jun 2023 15:25:49 -0400
X-MC-Unique: dttV3BeOPXyT8EZeAfFhlA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f8ff5efc90so23903195e9.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 12:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687375547; x=1689967547;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hC45HfnF3wa3gE3dE3ykWurOhQ3b7U62Yjsh2yLrk/A=;
 b=QcnHI+6WWSac3Ueecl5hxA/YDXv5FiG/R2b+lG89YpTNDAyNJ5UQe5pGzURryA/Pe4
 wGtKGtVZS1mukQeHK6oLuDP3D81qPStjv4B3EbCYTutfqWLLQy+3BYOSTx+zGPhcMZwr
 CnaUzfLpDat/ILYt5tBSNxoEtprRhttQIf6xYC83Gm8sVroMMgDC0Pkn/YLlVcibFmPl
 2a0oHqXkPAU74AIZA3U6DO7Eyi0C5vXSWkdAmUX8VqaP9gWVvbHC8xBxWdoiqhtuPq73
 hmot0TVIt+DoNS4liwvqRYh6+LMLyK5GMM4HLtBjml+kmcF1uWczkJmofKr1gL68q74G
 unpA==
X-Gm-Message-State: AC+VfDw0qud7VyELz4+Y6ufJAVHXSTUP7nKl47OdV/alvMcnlasIXxCI
 ccsFQhBxUrb/a88AJNHEvIDdSqcT9+6Ovc+eHQblQ+SPZR69AV/hAO/DCPWgoJLY7Q7VrA0Xjqh
 LbeZEVfuQasczpfw=
X-Received: by 2002:a05:600c:2190:b0:3f9:be1:507d with SMTP id
 e16-20020a05600c219000b003f90be1507dmr8305969wme.20.1687375547757; 
 Wed, 21 Jun 2023 12:25:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ59hH2cc0tljJ6Jf0GP90+6G5QreXl5BVOrpKmg+98hakguwmkAjlkxcnmvTD4ZCugXKEZbkA==
X-Received: by 2002:a05:600c:2190:b0:3f9:be1:507d with SMTP id
 e16-20020a05600c219000b003f90be1507dmr8305956wme.20.1687375547453; 
 Wed, 21 Jun 2023 12:25:47 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 r19-20020a05600c285300b003f605566610sm16726021wmb.13.2023.06.21.12.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 12:25:46 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Tejus GK <tejus.gk@nutanix.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 berrange@redhat.com,  aravind.retnakaran@nutanix.com,
 shivam.kumar1@nutanix.com
Subject: Re: [PATCH v5 0/2] Update error description whenever migration fails
In-Reply-To: <20230621130940.178659-1-tejus.gk@nutanix.com> (Tejus GK's
 message of "Wed, 21 Jun 2023 13:09:38 +0000")
References: <20230621130940.178659-1-tejus.gk@nutanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 21:25:46 +0200
Message-ID: <87sfakaa85.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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

Tejus GK <tejus.gk@nutanix.com> wrote:
> Hi everyone,
>
> This is the v5 patchset which has been rebased on the current 
> master. Requesting this to be queued for merge as this has already been
> reviewed. 

queued.

thanks.

>
> Regards,
> Tejus
>
> Tejus GK (2):
>   migration: Update error description whenever migration fails
>   migration: Refactor repeated call of yank_unregister_instance
>
>  migration/migration.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)


