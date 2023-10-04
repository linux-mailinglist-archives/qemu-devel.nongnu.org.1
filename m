Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CF37B8280
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:37:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo2zn-0007EL-TH; Wed, 04 Oct 2023 10:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2zk-0007Dw-Ed
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo2zi-0004RB-6m
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696430216;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ELFV+7PDWnORYPqvnIPRMNBIN5+/aoEQREp856MXBJU=;
 b=Tz9y5KF4GQdNp28bpVECSd0vlhUnjOZmku61o0ldU0QbrcvhN6y16NOXRrIbpZnZkntpU+
 knI6nvy2odRBIOzEsREcdYB73hODXDAOMldWVMakdhk3LxJijzKaak5yhT13qCLj7dqNLe
 /HYBt31VKw11R88jYWNX5g1HjeBguL8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-wuuYE1vcP-KLnjVcaw9VhQ-1; Wed, 04 Oct 2023 10:36:45 -0400
X-MC-Unique: wuuYE1vcP-KLnjVcaw9VhQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-405917470e8so16988215e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:36:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696430204; x=1697035004;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELFV+7PDWnORYPqvnIPRMNBIN5+/aoEQREp856MXBJU=;
 b=spHnSrjFY5n/HHhLXR8PDi49JXFjjlbG0PDwY/kM1ETVRJVL/JniYi2H9mHMcFz8Nt
 c5aHjj1G7CSNym9UiNehBqG/x2o0ETwhKuCsxdqTrunRk9a3sdOH8x/8BOrfUGCdNcRc
 HI29hh0VXksIXacTYpt2rCE4JfpOPLf3Fa8vCniUba2A0DFvO3KKCY5vltbI4A2Ywxg1
 BtsaFLwwAK1QYdMsaWiKM7mge0wAI5nThqeXUOmHWm4IBLYhEZkGFHtZ3bQhJ2WsU6r6
 UtkhtvuczeF6gRDlLxmRKkSYjMcZyOfnGjCiDftD+K43O/qlOjslRbZ62kJ5SGalJ3/y
 x4XQ==
X-Gm-Message-State: AOJu0Yyy5MOgaOCxYHUtvXIDB0kCrLH2N4smDkOMHjye55aOuMS/ton6
 dN3Vq9IKi0TmzvJI3pF3Zz0PsBXbInYfI60nh+tjlXZsjT62pcVk5wGHL+p3Z4lmEngEGencpTR
 eJJeXQ3WUdAc5zA4=
X-Received: by 2002:a5d:680d:0:b0:319:83e4:bbbf with SMTP id
 w13-20020a5d680d000000b0031983e4bbbfmr2517537wru.20.1696430203810; 
 Wed, 04 Oct 2023 07:36:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKy0qdM7xML+ggvzA7VbQettvkhj5tUF5PogFyx/+MsBgB+OSjFL8EpvGi9TE5gpVVhjzt2w==
X-Received: by 2002:a5d:680d:0:b0:319:83e4:bbbf with SMTP id
 w13-20020a5d680d000000b0031983e4bbbfmr2517519wru.20.1696430203461; 
 Wed, 04 Oct 2023 07:36:43 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 d9-20020adff849000000b003248a490e3asm4180366wrq.39.2023.10.04.07.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:36:42 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 03/53] migration/rdma: Clean up rdma_delete_block()'s
 return type
In-Reply-To: <20230928132019.2544702-4-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 28 Sep 2023 15:19:29 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-4-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:36:42 +0200
Message-ID: <87y1gizc79.fsf@secure.mitica>
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
> rdma_delete_block() always returns 0, which its only caller ignores.
> Return void instead.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


