Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 514767B831B
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:00:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3MZ-000192-Ct; Wed, 04 Oct 2023 11:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3MW-00016q-3b
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:00:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3MU-0005vX-Bn
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696431628;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Jea7xYxS3f4n8xI6DktbwjG+LahanIhqjYprP9cg9Fg=;
 b=HxEdE+JHPrmC38fFRirKQ6kw0VwGEpzq4Ks2hVWjKmmB5Gj6kpCKTNVf2f1pNHPUTHhcpP
 puAfTlYz9uGdEyVTlLaA9DdgfJ8GXe27CgPpRWLy32p/R9lJQdjDtpDR0FZkvGbQ1mew6/
 /okicVUXKpUdOGiW1Tjknuofw8Ft5X4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-RxcCNt22NgulAEH89SirPg-1; Wed, 04 Oct 2023 11:00:27 -0400
X-MC-Unique: RxcCNt22NgulAEH89SirPg-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-32661ca30d9so1578487f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:00:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696431626; x=1697036426;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jea7xYxS3f4n8xI6DktbwjG+LahanIhqjYprP9cg9Fg=;
 b=dULE7y0qc17TjZ4U+aXevRdxfPZuKsB8zQgPEEzh5DUrL4Bs0KVhmtlO8oR+xhMNJt
 0BZEcVJdrQ5rrOAP6miYxXJiaNaQmV2i8MjGf2Ad8qMmc2JbEo00HnVASsotiSDmmzVQ
 Kjh3gaJHc3tLb6f2sxs1eb7cXFf5EAuJ30sCYeZkDp5D5CtU8psQfg/F6LBMOCv365gQ
 qp6aDXd+8rFhmx9MLwLf87Vn1r7ZwWLodqiwTjI3VvYNq1fbzsMhd8OcvojhewyyHkO7
 HLzvqiPfksgWGXjuy/pEbzNhmDUdIdI5xqf1CFjaw8utCCkbKS9mY4un6GdJXIBC82cS
 ekYw==
X-Gm-Message-State: AOJu0YzkgDV7dgymi67GYe+8IlfrM0/J0iKA1sMNRIdMX8DnBSZfAoqJ
 JmyRHjQUh0/aB6PH0epof1NbhpyOPFHiyPGy2UepprZWRVrwMV1vMuKML+YSLxQ4xqlHi2dAtYb
 F7tfnv1BO83NBrpA=
X-Received: by 2002:a5d:58ed:0:b0:31f:e026:30ac with SMTP id
 f13-20020a5d58ed000000b0031fe02630acmr2302466wrd.34.1696431625992; 
 Wed, 04 Oct 2023 08:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7PR6KXHPvZIEzn+UJcw7eBIbAg7pbtYdaS6n8GcQRX05+457ihnZV6BKJ8px0PJJCE//GMg==
X-Received: by 2002:a5d:58ed:0:b0:31f:e026:30ac with SMTP id
 f13-20020a5d58ed000000b0031fe02630acmr2302444wrd.34.1696431625583; 
 Wed, 04 Oct 2023 08:00:25 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 y6-20020adff6c6000000b0031c6581d55esm4174477wrp.91.2023.10.04.08.00.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:00:24 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 13/53] migration/rdma: Drop
 qemu_rdma_search_ram_block() error handling
In-Reply-To: <20230928132019.2544702-14-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:39 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-14-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:00:24 +0200
Message-ID: <87pm1uxwjb.fsf@secure.mitica>
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
> qemu_rdma_search_ram_block() can't fail.  Return void, and drop the
> unreachable error handling.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


