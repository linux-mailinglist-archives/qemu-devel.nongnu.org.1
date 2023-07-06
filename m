Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 52073749B42
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 14:00:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHNeK-00057h-TA; Thu, 06 Jul 2023 07:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHNeI-00057A-Ij
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:59:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHNeH-0001Q0-6D
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 07:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688644788;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=l2lOt8AV88gkFrn2q1ZpzaYSoe28LnnAlCxhSI1HR3c=;
 b=cmL70j78yjJugfl/uYqOYcN3wLOJt2K6b+Aj/NAb7LwHt8b/hXdDQFP2HgZl/y9CguRNe6
 zWpPPBARxyJ7WX4lXymrtENcx0HP0o8aGz6OsgRtMULqR1+y93Kx0pV4OCD4hcmr7czR68
 LXH8OQcDMEaEWYHX9f03Yj6ughTfcDI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-_RHFkYA9Nz2969hVNA2NHg-1; Thu, 06 Jul 2023 07:59:47 -0400
X-MC-Unique: _RHFkYA9Nz2969hVNA2NHg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3140030cacfso295359f8f.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 04:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688644785; x=1691236785;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l2lOt8AV88gkFrn2q1ZpzaYSoe28LnnAlCxhSI1HR3c=;
 b=ccL6peqT9nNy51RDdr3JGbmeRtrQDkEACbacgUZOqQB5yc1oIM5NLNEWt6O9R0yNhI
 lLjSSTnujiAexHsWWg7DDTwNjH79qGUM7+W2lavNIUnQSF61dextGE87l+6D5oA2OXXZ
 uTEjML+VcE2veSXDkMzJQ72jVK9IMcDFWGSK0AsNowWVHkatH6ThjH9jcMIdXagsd5VY
 hkJhpkB9LtKYYPIbFQCZzGR22hiX/Hb0RfyeN6VcJeR5Ps6X1LnhqsAvJdBN0czhzPJx
 zHcxhe8msoRJG2tK2a1JBS55zN5zJRlgYC/Q6hTVQvqyZyjYZgOioAxzO1aHVTYciaXc
 4ByA==
X-Gm-Message-State: ABy/qLaorj6gbkyo+rzmpSvWN52PH5nFvzo7jAhOlMx+TLET+6nhje11
 POH64fhRd2dyQryk4okXZrXGHLJnUgU2eFO120w4CLg/tmekglkMLxKLom/aBlBty2eBf+s7PNG
 6zLfmyT/HAtmBcNVxlxpsaoUGwQ==
X-Received: by 2002:a7b:cb8f:0:b0:3fb:4165:9deb with SMTP id
 m15-20020a7bcb8f000000b003fb41659debmr1166954wmi.18.1688644785284; 
 Thu, 06 Jul 2023 04:59:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE+iLRAdMKiKUO44d/ayetGPjeCGLoxnIp/0yJpCzNjtO1tMTp6B1+f3daVFe6r0r/SMzDjyg==
X-Received: by 2002:a7b:cb8f:0:b0:3fb:4165:9deb with SMTP id
 m15-20020a7bcb8f000000b003fb41659debmr1166946wmi.18.1688644785013; 
 Thu, 06 Jul 2023 04:59:45 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 c26-20020a7bc01a000000b003f7f475c3bcsm5613656wmb.1.2023.07.06.04.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 04:59:44 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peng
 Tao <tao.peng@linux.alibaba.com>,  Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v2 4/4] virtio-mem: Support "x-ignore-shared" migration
In-Reply-To: <20230706075612.67404-5-david@redhat.com> (David Hildenbrand's
 message of "Thu, 6 Jul 2023 09:56:09 +0200")
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-5-david@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 06 Jul 2023 13:59:43 +0200
Message-ID: <87o7kp9ro0.fsf@secure.mitica>
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

David Hildenbrand <david@redhat.com> wrote:
> To achieve desired "x-ignore-shared" functionality, we should not
> discard all RAM when realizing the device and not mess with
> preallocation/postcopy when loading device state. In essence, we should
> not touch RAM content.
>
> As "x-ignore-shared" gets set after realizing the device, we cannot
> rely on that. Let's simply skip discarding of RAM on incoming migration.
> Note that virtio_mem_post_load() will call
> virtio_mem_restore_unplugged() -- unless "x-ignore-shared" is set. So
> once migration finished we'll have a consistent state.
>
> The initial system reset will also not discard any RAM, because
> virtio_mem_unplug_all() will not call virtio_mem_unplug_all() when no
> memory is plugged (which is the case before loading the device state).
>
> Note that something like VM templating -- see commit b17fbbe55cba
> ("migration: allow private destination ram with x-ignore-shared") -- is
> currently incompatible with virtio-mem and ram_block_discard_range() will
> warn in case a private file mapping is supplied by virtio-mem.
>
> For VM templating with virtio-mem, it makes more sense to either
> (a) Create the template without the virtio-mem device and hotplug a
>     virtio-mem device to the new VM instances using proper own memory
>     backend.
> (b) Use a virtio-mem device that doesn't provide any memory in the
>     template (requested-size=0) and use private anonymous memory.
>
> Tested-by: Mario Casquero <mcasquer@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

After very nice explanation.

Reviewed-by: Juan Quintela <quintela@redhat.com>


