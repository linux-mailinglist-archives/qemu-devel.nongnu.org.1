Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8D1707F23
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 13:24:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzbjo-0002TJ-RO; Thu, 18 May 2023 07:24:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbjm-0002Sv-MP
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:24:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1pzbjl-0008P8-BE
 for qemu-devel@nongnu.org; Thu, 18 May 2023 07:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684409040;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vJhr/Tqx1iJ2PalmB9sUdZR57HaWblow+242XiQfZmc=;
 b=aelIWujOb0EG9slD33shoG22LMoQYj/kfwkVdP/3azYu7PScy14bsyNpIk1Xr6kHyOT1SY
 lkw89WUw0NJJ2yt+rcLZ7nfX4nA0II5NQSAEZvUQm37ulIPHvgDOx7pL2dlWBBq92dRBUS
 Uyd2uUFXAcBKEYJrhUdLq/Qt4m4BSvM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-RDKTp38wOb2NF6jnjRAsQg-1; Thu, 18 May 2023 07:23:59 -0400
X-MC-Unique: RDKTp38wOb2NF6jnjRAsQg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3063089cff4so1208254f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 04:23:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684409038; x=1687001038;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vJhr/Tqx1iJ2PalmB9sUdZR57HaWblow+242XiQfZmc=;
 b=ELWhmv3OP5vFMPhF031SLozB6jCHffO9eXXSTc8DxHNWcG2JywUfEjoQHPYQftgY+Y
 goZ8b3NlmoPCPTeWd/KFfJxrNlKyhfntmizzGTdHk795VFtZr+TGu6MOwyU45SWtDyTa
 pXhQ4FYx1SY1ZzaihNmvuvQPzARo3QYDdhqI8lcKNqS8K+Hui0M6n6PMg41NEKj1S7Yu
 NmtmBCEsvf3pFg2Y4iETU1o4fUuj81HWOPqgNjBQXNtW8O9qg2UGETNmbveOXj6ldOmR
 xlnfnD+4ySDcYsropZpXg3HBzIfc9Sxrh2mrWLXtIOxhS62PSMYTPK/5SKecfbexD87Z
 vUiA==
X-Gm-Message-State: AC+VfDx+n3AUrJWETN2JwVTqwHnYpB82i7OI3Z9QSk6nhG9pOfPe99Zd
 ib1wKo2/GJ0FeE83/M8+9c1b6uuHg/yOGkzL8f3Zp7FgqnoHwNVmp3hDXksa4q2jTb9InmZJnRy
 iTBTXv83YBDiMWM8=
X-Received: by 2002:a5d:6391:0:b0:309:4f21:ec7b with SMTP id
 p17-20020a5d6391000000b003094f21ec7bmr492721wru.30.1684409037860; 
 Thu, 18 May 2023 04:23:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7pX6Az7/DWIiZbtOs4M8DVczJI8Ek2K9xbsK3Jk2QYigWOTYfOiFKNnpfC6lWcctWj4B4Rfg==
X-Received: by 2002:a5d:6391:0:b0:309:4f21:ec7b with SMTP id
 p17-20020a5d6391000000b003094f21ec7bmr492704wru.30.1684409037530; 
 Thu, 18 May 2023 04:23:57 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 m11-20020adff38b000000b003062b6a522bsm1863094wro.96.2023.05.18.04.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 May 2023 04:23:57 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  leobras@redhat.com,
 peterx@redhat.com,  yc-core@yandex-team.ru
Subject: Re: [PATCH 0/5] Restore vmstate on cancelled/failed migration
In-Reply-To: <20230517123752.21615-1-vsementsov@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 17 May 2023 15:37:47 +0300")
References: <20230517123752.21615-1-vsementsov@yandex-team.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 18 May 2023 13:23:56 +0200
Message-ID: <871qjdevcj.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
> Hi all.
>
> The problem I want to solve is that guest-panicked state may be lost
> when migration is failed (or cancelled) after source stop.
>
> Still, I try to go further and restore all possible paused states in the
> same way. The key patch is the last one and others are refactoring and
> preparation.

Hi

I like and agree with the spirit of the series in general.  But I think
that we need to drop the "never fail in global_state_store()".  We
shouldn't kill a guest because we found a bug on migration.

Later, Juan.


