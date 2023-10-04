Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F53E7B82C9
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:55:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3Gw-0002p5-PW; Wed, 04 Oct 2023 10:54:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3Gr-0002lw-84
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3Go-0004IQ-In
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696431277;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nlR+jCZIKOSxsApgI5z4n+etcCgA5EREG8gbKalU2hs=;
 b=e9fSazLAYzjjUGbWU7CmIfIH1bPdA49IaeDMrtW54BOFSMmdZzBLY8d2aQOhWj/+4faW7C
 FFzXhdDKboi81S4nqlcUWnYkAMFCcnFry9kdxw8TTzaEK0RVOVc9k0nQGaaQqXNggEKdjO
 7SXMlfrFPBIASD7OY79d59efauZ6Ofw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-z_MatqNSOXi9SzLYJyfJbg-1; Wed, 04 Oct 2023 10:54:31 -0400
X-MC-Unique: z_MatqNSOXi9SzLYJyfJbg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4067f186094so14701315e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:54:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696431270; x=1697036070;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nlR+jCZIKOSxsApgI5z4n+etcCgA5EREG8gbKalU2hs=;
 b=DRF9OLwwSJm6+TptgWQNe1Ex5M5PZU5V6fS6NFbQBtgqL9EB0ro9wK/35tJI88CDm5
 1b3pSKJD4zE9KNb6+5h60YMhI2esanTP42waFRx30WVLBeDc+BT4iHC69NocgY42ebqC
 9fHCiOgG+sNOm9XuIyFOmOx9ogPiniVRKjdXzm7Ds+9/A566g9xHZQRUkYKLTQPCbYze
 K7uNriokeYLELTtj0BtGeVVn2vCW0XpC3qMetoR96f2w0VjqzJqG2fd1sQCvPiFuKrOp
 CO/gSyLwc6j8vS/PkaK4I8wBnZxKKBKWk39FSJeA7cd46tMMFmYKShqmKLiscl3uv6dz
 tZAg==
X-Gm-Message-State: AOJu0YwRsCtFG7lPexV3jMXQZZJIy8H6mMy6FCotlwUW0UbToz1Ep95n
 u4HZAHWdwzHi/n+tfeM9ghDo+TtysNs6oBrl4APRrlzAky5JE8wQRWky3UUqcbQtKuNKeFjZ/l5
 +xctJd2xIeuQD5zc=
X-Received: by 2002:a05:600c:ac1:b0:405:39b4:3145 with SMTP id
 c1-20020a05600c0ac100b0040539b43145mr2864391wmr.2.1696431270076; 
 Wed, 04 Oct 2023 07:54:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9I05Wv5LHKaDJTmS3zY4tIa4Obj+e/t22IVJ/X/Uyl4vUVyVd+W4Deje8re6wB8tWDc98qw==
X-Received: by 2002:a05:600c:ac1:b0:405:39b4:3145 with SMTP id
 c1-20020a05600c0ac100b0040539b43145mr2864371wmr.2.1696431269717; 
 Wed, 04 Oct 2023 07:54:29 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 w21-20020a05600c015500b0040652e8ca13sm1717929wmm.43.2023.10.04.07.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:54:28 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 10/53] migration/rdma: Put @errp parameter last
In-Reply-To: <20230928132019.2544702-11-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:36 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-11-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:54:28 +0200
Message-ID: <8734yqzbdn.fsf@secure.mitica>
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
> include/qapi/error.h demands:
>
>  * - Functions that use Error to report errors have an Error **errp
>  *   parameter.  It should be the last parameter, except for functions
>  *   taking variable arguments.
>
> qemu_rdma_connect() does not conform.  Clean it up.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


