Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2558C7CDDF1
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 15:54:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt6zj-0003vu-1U; Wed, 18 Oct 2023 09:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt6zZ-0003oL-8U
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:53:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt6zX-0000Mh-O3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 09:53:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697637222;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=+O+ywQo+XPePe/w5kx6Z2E6xmE+2rY0s8hcY2eFRHBI=;
 b=ON5uXtPPGYDUVf1FYVi0LeCBBQOXm9d8WrpEJVpwOPI7vO3CF9ogUUp30AXJI704mg9qNJ
 hZnHLccvJ/WGJ6rMR9+mLF/DMNI8KwReUpf3XvLuWD0vh4vIkYRt/leXGu7L2RmQJz3LlG
 Pix5weFV3k0MHuRDNsrFi5TflW/kQEg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630--tXemE6OOjiaQ1k--9yeHQ-1; Wed, 18 Oct 2023 09:53:41 -0400
X-MC-Unique: -tXemE6OOjiaQ1k--9yeHQ-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32db9cd71d7so1568188f8f.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 06:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637220; x=1698242020;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+O+ywQo+XPePe/w5kx6Z2E6xmE+2rY0s8hcY2eFRHBI=;
 b=CCE4V2uDLK+D9m9KFwJWtwc/ODGzNBjwuzRhoAYUrHF8+bD8ehW3TWGeMHrUTG4jQt
 hSvN9CrqcjiuB6IKW6VsNeGNQByzD8URMZ1K6OIqzy2atJx5ouPF+NLGP9GIXIL7lqTR
 oJ117D+j8D0fB+ZRUIS/E10jFeJlmYQ++LHbbMvQCvLvrmGV/VfkFwpMWhgltJAZKWcI
 xA+eBTJCNtkoTgvSNBZOXR0qVMo7Q8YsT4x8QN2ZqPgy6lCC2ZmQpD7rO+5kOX4Rx5bH
 2mpJ7mlyNKDP/nc6ahyK8zdQFBUTJxI3xSKNMo0qe6OTiaCGVwL0yEHs9cO+JlSyVqj6
 CT8w==
X-Gm-Message-State: AOJu0Yyp3mbNL6Baw/2bSxIMnOdqqHK+p4UySgTvIxq0ogRl/ZTicplg
 KLpizZmxUrCpBgIat8IsqmE57gJLjjtp4if8a6GGlJChMPsWH78oECgsF5bwFKr//BrFGPLrw/+
 ycpqhANTsxS/L56M=
X-Received: by 2002:a5d:4a49:0:b0:32d:cb04:829b with SMTP id
 v9-20020a5d4a49000000b0032dcb04829bmr3392795wrs.12.1697637220073; 
 Wed, 18 Oct 2023 06:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW+WRBC6F2Owh8M6Y/JKVTOTwBdoVqHnpm//4Yyf7ScRPjHt1fm9pmT7lrNDffxAiZEG095w==
X-Received: by 2002:a5d:4a49:0:b0:32d:cb04:829b with SMTP id
 v9-20020a5d4a49000000b0032dcb04829bmr3392774wrs.12.1697637219756; 
 Wed, 18 Oct 2023 06:53:39 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 q12-20020a05600c2e4c00b0040648217f4fsm1709181wmf.39.2023.10.18.06.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 06:53:39 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V5] migration: simplify blockers
In-Reply-To: <1697634216-84215-1-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Wed, 18 Oct 2023 06:03:36 -0700")
References: <1697634216-84215-1-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 15:53:38 +0200
Message-ID: <87r0ls82al.fsf@secure.mitica>
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

Steve Sistare <steven.sistare@oracle.com> wrote:
> Modify migrate_add_blocker and migrate_del_blocker to take an Error **
> reason.  This allows migration to own the Error object, so that if
> an error occurs in migrate_add_blocker, migration code can free the Error
> and clear the client handle, simplifying client code.  It also simplifies
> the migrate_del_blocker call site.
>
> In addition, this is a pre-requisite for a proposed future patch that would
> add a mode argument to migration requests to support live update, and
> maintain a list of blockers for each mode.  A blocker may apply to a single
> mode or to multiple modes, and passing Error** will allow one Error object
> to be registered for multiple modes.
>
> No functional change.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Tested-by: Michael Galaxy <mgalaxy@akamai.com>
> Reviewed-by: Michael Galaxy <mgalaxy@akamai.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

Something weird happened with your rebase:

(next *|AM 1/1)$ find . -name "*rej"
./block/vpc.c.rej
./block/qcow.c.rej
./block/parallels.c.rej
./block/vdi.c.rej
(next *|AM 1/1)$ 

trivial to fix, so I did it.

queued.


