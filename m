Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF747B838E
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:29:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3nt-00086l-Oy; Wed, 04 Oct 2023 11:28:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3ns-00085b-9R
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3nq-0000Na-Gb
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696433325;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sFzhUV8Flbq83PtRexeOlFAGVYpKj2u/EDo4ICUCblc=;
 b=SHxltmRMEVZ6VqicnliAotkqBZkU2Y5S/mX20b7oc+562ewM4IWrWUOo2b0POGkL6N6dA/
 zJwRuMxgOdkWpn1v0IJVdxgbVPlBG3K7/yM+uxt6pC/+dAiO4M0KrpF8SNULlk87Qljavi
 7VupnRoGJ2PQQVcqTwjbtR5usV2pkfY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-m5xXgugwN3y22J8sA2xNUw-1; Wed, 04 Oct 2023 11:28:44 -0400
X-MC-Unique: m5xXgugwN3y22J8sA2xNUw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4053d832d51so15791895e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696433322; x=1697038122;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sFzhUV8Flbq83PtRexeOlFAGVYpKj2u/EDo4ICUCblc=;
 b=et2pXVUYiA07HTV2FVYXuxRoXdP2DJvjPPbwxvmyEUwdUzEGxUlaygh+VqvTTy06Ri
 kLbsx2b/FJ52w7TzuaPPNm/nN6QlzPIWXe012mRkIB2YWGsj3HgvAruZHk2p5DSjKO8h
 SqTgBB8jt9GnG+aEV2InlvUiv7UYogU87v6gLAMBannEiiejsPAS6GU6u0+gV9bR4m2i
 wrLuSQ6k9XgttugE6ykNgNzfaqIz197saPfxJka61ec7kYEGi46gx7sgnAncIdcghGgH
 XkHGoab14lOPRf9VbvasKYfP262xSqvR2/qRCk3ZphSny5d7HlJjHUXi8pRThpsaU7O3
 s67w==
X-Gm-Message-State: AOJu0Yzn77yxHlN9m3qYmtyi6k16Shl3UTsSF7BTijvvJbgN4Tt5qagK
 ubxxdV2ajAWskgoPZZjv8lq/OS0D0N5VYn99yEVIjRCiAja2th4vklH63/I+GliYgA+ACrPHP/x
 BGK+yr6rbdymgltU=
X-Received: by 2002:a5d:548f:0:b0:31d:d48f:12a3 with SMTP id
 h15-20020a5d548f000000b0031dd48f12a3mr2219454wrv.43.1696433322148; 
 Wed, 04 Oct 2023 08:28:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0OoUh+sh8EYuQ8mkTOQptHyAfBhRFA7GocnNWX4q6VO9BtrTCGx5OWQxx5D0HMZE+nabBbw==
X-Received: by 2002:a5d:548f:0:b0:31d:d48f:12a3 with SMTP id
 h15-20020a5d548f000000b0031dd48f12a3mr2219431wrv.43.1696433321804; 
 Wed, 04 Oct 2023 08:28:41 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 t6-20020a5d49c6000000b003142e438e8csm4302959wrs.26.2023.10.04.08.28.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:28:41 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 23/53] migration/rdma: Fix QEMUFileHooks method
 return values
In-Reply-To: <20230928132019.2544702-24-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:49 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-24-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:28:40 +0200
Message-ID: <87r0mawgnr.fsf@secure.mitica>
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

Markus Armbruster <armbru@redhat.com> wrote:
> The QEMUFileHooks methods don't come with a written contract.  Digging
> through the code calling them, we find:
>
> * save_page():
>
>   Negative values RAM_SAVE_CONTROL_DELAYED and
>   RAM_SAVE_CONTROL_NOT_SUPP are special.  Any other negative value is
>   an unspecified error.
>
>   qemu_rdma_save_page() returns -EIO or rdma->error_state on error.  I
>   believe the latter is always negative.  Nothing stops either of them
>   to clash with the special values, though.  Feels unlikely, but fix
>   it anyway to return only the special values and -1.
>
> * before_ram_iterate(), after_ram_iterate():
>
>   Negative value means error.  qemu_rdma_registration_start() and
>   qemu_rdma_registration_stop() comply as far as I can tell.  Make
>   them comply *obviously*, by returning -1 on error.
>
> * hook_ram_load:
>
>   Negative value means error.  rdma_load_hook() already returns -1 on
>   error.  Leave it alone.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

I "remove" QEMUFileHooks on this series:

https://lists.gnu.org/archive/html/qemu-devel/2023-10/msg01037.html

Do you mean waiting for the series to land before adding this one?

As that hooks only get rdma use, I just changed them to be normal
functions, no hooks.

And yes, it was not fun.  I know you have feel the "pleasure" of hacking
this file O:-)

Thanks, Juan.


