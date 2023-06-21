Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1058873904D
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 21:42:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qC3i2-0001WP-QI; Wed, 21 Jun 2023 15:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC3i1-0001WH-9s
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:41:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qC3hz-0002K3-V4
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 15:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687376499;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=21/fMto7FPWz3MHKRHGZQero3o5nwN4vYVOjaabaGIs=;
 b=K154MG9rtHUa7pf57X7wQoQNulbRWSI8v+ILMIchz8+9BYB9f/pGTk9ha0GpCOoFzTle0G
 5CMAnBgg+LuzQbREDN9v+Yd0yW8n1JL4gbjCdKfRz3nE/JcVKOkk4gpgC5+6UTzZDkm+2l
 pYzH+rdrUn08nPPG2AJM85FKL3X8DqU=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-bY3VzP6-Ni-MWlmzAGQnVA-1; Wed, 21 Jun 2023 15:41:37 -0400
X-MC-Unique: bY3VzP6-Ni-MWlmzAGQnVA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f8727c7fb6so3161137e87.0
 for <qemu-devel@nongnu.org>; Wed, 21 Jun 2023 12:41:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687376496; x=1689968496;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=21/fMto7FPWz3MHKRHGZQero3o5nwN4vYVOjaabaGIs=;
 b=FysN4hclfmiGGQ36g738ZnI6gj5kunPfVb5bQqasxPqGlK9iU0CGXUF6DM62OyGKY4
 cxUe8OZN5hmwnNoGMUTE102YGKUh/km4G4P62m7t52VydNK0DXgKOfRgVxeANpNByiVn
 0IfB3hw4BjM917kHr39gtEeZkL7td2B9tDzsVKw0TcO+5jMhFr4CpTCEd/uk3Kgr+I/Y
 qkOFWAJ9Zmb/4+OIcxtAY5iJ0MJ2zWLw9INlx7EXSseEiNc8p5UWlfK9NLC/FMGEryqu
 05bvrT7H+kohxBm3xbDlv72hIat8Jyn6lBsoTo8qKfqpNTOqOM9k3YDjZpS9v2T4HjhP
 1qng==
X-Gm-Message-State: AC+VfDwZyrw0lD9u/LkOwFA1x8ebe5Mu3UrZQt68LXmUJhVQokeWev1e
 fCGB9a+TkHcTQ4aR93iECWdr/eJihi0/Krz+ocusym63NFYPwRjiuneaaJnI6U3zi9FojUjwDEA
 000ntSZwtDRWhJdU=
X-Received: by 2002:a19:5e01:0:b0:4f6:45af:70b8 with SMTP id
 s1-20020a195e01000000b004f645af70b8mr9368071lfb.58.1687376496312; 
 Wed, 21 Jun 2023 12:41:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7btsAuTz3J6MNMj91spmUZRBTsjyjAZ4bf6btQDSaesJ4lW0FOB+xAuOldahHHc6U2yeSwsQ==
X-Received: by 2002:a19:5e01:0:b0:4f6:45af:70b8 with SMTP id
 s1-20020a195e01000000b004f645af70b8mr9368058lfb.58.1687376496004; 
 Wed, 21 Jun 2023 12:41:36 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 p25-20020a1c7419000000b003f8fac0ad4bsm5757277wmc.17.2023.06.21.12.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jun 2023 12:41:35 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Wei Wang <wei.w.wang@intel.com>
Cc: peterx@redhat.com,  lei4.wang@intel.com,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] migration: enfocre multifd and postcopy preempt
 to be set before incoming
In-Reply-To: <20230606101910.20456-2-wei.w.wang@intel.com> (Wei Wang's message
 of "Tue, 6 Jun 2023 18:19:09 +0800")
References: <20230606101910.20456-1-wei.w.wang@intel.com>
 <20230606101910.20456-2-wei.w.wang@intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 21 Jun 2023 21:41:34 +0200
Message-ID: <87fs6ka9ht.fsf@secure.mitica>
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

Wei Wang <wei.w.wang@intel.com> wrote:
> qemu_start_incoming_migration needs to check the number of multifd
> channels or postcopy ram channels to configure the backlog parameter (i.e.
> the maximum length to which the queue of pending connections for sockfd
> may grow) of listen(). So enforce the usage of postcopy-preempt and
> multifd as below:
> - need to use "-incoming defer" on the destination; and
> - set_capability and set_parameter need to be done before migrate_incoming
>
> Otherwise, disable the use of the features and report error messages to
> remind users to adjust the commands.
>
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


