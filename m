Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A75777D0C22
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:40:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlyX-0005S1-Vq; Fri, 20 Oct 2023 05:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlyR-0005RS-RE
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlyG-0006Uc-VR
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697794748;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZBdzmQ9BgKShGJ53EvKWOwZ7wPXtckqxj/EDAgC0a70=;
 b=cPjvdbXXs3dslsAr9P8P2ULiSs1BdYNzvIwV3nx7QUI2jMUqv3J8S48NoSn4asp8hEfuxi
 /n9/o9W/S6x536MWcdUGIxB2HrulIC8KJwxqZMr8P50Y0uc9iAa6viY4GWhc4xJW64e6PA
 lsMlaAdIA1SGlD7c93nl7aKN8yDayvw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-4ssdGEdeMqeZsT-AdPeNcQ-1; Fri, 20 Oct 2023 05:38:58 -0400
X-MC-Unique: 4ssdGEdeMqeZsT-AdPeNcQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f5df65f9f4so3811105e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 02:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697794737; x=1698399537;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZBdzmQ9BgKShGJ53EvKWOwZ7wPXtckqxj/EDAgC0a70=;
 b=BYgPBlUBZlVwBdHaqvp0WKg7a33Zgwdl4/zVDfpoPaUIZoUI/aok8/3Cy7F0rrdBXL
 m0ciHeoaUCzYkRRd/9Q15ZFb4Q9M2SIG4smM6K8IE/YXzVLAJtGtcXZ6SHA4yd/ZarCh
 9UY4zM8Y/B8xpDZcEQwpeTf+3uT8irbVLl8nxrsigd59aFiBDRWVUsz2iJYKLx3DtrR4
 2kfrMxUppEOF0VhFrIdaeNsF7qCNkMW3fwnHCarq7nnpljJHZfM2Wq8qGwq5GzowS7Q7
 xzy7ODiCCCp0pnhCmvjyMbJQN+nSa7pH5ikvoHk357gxY3jc8KZi3BNSo5MrbcQIoAn1
 fvcg==
X-Gm-Message-State: AOJu0YzLKSM+Z49Z8QtHnG1wCKeT/zfRjhRghRkTxz8rn0JvjmYA7Adl
 5HihbBn3HKVMk1HqH7H0gKATM4f187Ux+o59c3APX3WaCS/0bugbdE6SqohfQvaJ9Cfms042fRO
 cPkDkDeN46GcaokU=
X-Received: by 2002:a05:600c:3585:b0:406:177e:5de8 with SMTP id
 p5-20020a05600c358500b00406177e5de8mr1091410wmq.35.1697794737213; 
 Fri, 20 Oct 2023 02:38:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEgfFvUW3MeKzfgnYjhSfKIiBwee0NhrH+Lt4fCiJurud12Vubcb86P3qoSYMWRFZzLdGuvlQ==
X-Received: by 2002:a05:600c:3585:b0:406:177e:5de8 with SMTP id
 p5-20020a05600c358500b00406177e5de8mr1091392wmq.35.1697794736896; 
 Fri, 20 Oct 2023 02:38:56 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c4fcc00b0040775501256sm1732480wmq.16.2023.10.20.02.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:38:56 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V1 3/4] cpr: relax some blockers
In-Reply-To: <1697748466-373230-4-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Thu, 19 Oct 2023 13:47:45 -0700")
References: <1697748466-373230-1-git-send-email-steven.sistare@oracle.com>
 <1697748466-373230-4-git-send-email-steven.sistare@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Fri, 20 Oct 2023 11:38:55 +0200
Message-ID: <87r0lpzl8w.fsf@secure.mitica>
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
> Some devices block migration because they rely on local state that
> is not migrated to the target host, such as for local filesystems.
> These need not block cpr, which will restart qemu on the same host.
> Narrow the scope of these blockers so they only apply to normal mode.
> They will not block cpr modes when they are added in subsequent patches.
>
> No functional change until a new mode is added.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

They are all basically block devices support, would be great to have a
comment from someone from the block layer.

Later, Juan.


