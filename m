Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D6D7B8381
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 17:25:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo3kK-0003vP-BB; Wed, 04 Oct 2023 11:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3kD-0003r4-0H
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:25:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo3k3-00077F-Qv
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 11:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696433090;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9KXvSUCAOG8VA6NjKjJ4sNdXf8D0mbCa1jU4QfUjklw=;
 b=af/GIIkrPVMeuY4IIcZhNAS0koTATUcSMkCIHPQmzrkTyg6qwmMvCdSskR/bcBJv6UfRFz
 gWmTxUikdDvWHW+kBfT5UiqcI3+ZiZnGh0LWkSAAU+ujO6nxUqReN7Q4a8YHHaaruG0sOk
 +NrHOHTRJxupJljh8s6WQOBB0KCahV4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-h4i9xhw5Oc-esch_3ujD2g-1; Wed, 04 Oct 2023 11:24:49 -0400
X-MC-Unique: h4i9xhw5Oc-esch_3ujD2g-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4030ae94fedso16549445e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 08:24:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696433088; x=1697037888;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9KXvSUCAOG8VA6NjKjJ4sNdXf8D0mbCa1jU4QfUjklw=;
 b=WBKFgzaDwQxIBDjnYG6JlKyYdHhr1WB2usF29J/PQb2llbmn0i0PyBEjSKKiUXO1pc
 umKAwmvBPKp0sPmVFGTERGVko6GlfrLw1utswXEe620jzmXJyKzfqNImr94FZ0bwfYHc
 grCDIFDF2eOXkkVklsvqg3gd3FRD4J+M64JYPXbcCcj0wh8Yg8AgvrMbpBAS/YhWEKDc
 MhqT5R7Jdkr939eeFhALReFIQs2g2yZQ0wSHWmdmz6uShy5EnWoJIJ7Rrq4PdN9W3//h
 xeWiOz/p4RoysV6/9SbNDVzKsYULN/x7SRQUnVfM6RxFLoLZkuTEHRPJUBbhuAXwgbMa
 dqYQ==
X-Gm-Message-State: AOJu0YyESg+JhdyoKzGoAiei9K9QlhCXVKa7q9npfabfUWGkLLCxQNQh
 OAIpMbCC0nYIbMT6y4+cX+FJzaINbWOGzksbVsQ21zH+TMEwPF7ar9hQbldmxZiZ1IhTYYGJo1g
 800HH2ghKCjzv+NE=
X-Received: by 2002:a1c:720a:0:b0:401:b6f6:d90c with SMTP id
 n10-20020a1c720a000000b00401b6f6d90cmr2725607wmc.35.1696433087898; 
 Wed, 04 Oct 2023 08:24:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvYDnHIh94vpeuUQdP3ZLxfPvdGvaIfJ4A54B6LMP6/F3v1pQo/gbGvs0MX0vt3Cpp5DvyrQ==
X-Received: by 2002:a1c:720a:0:b0:401:b6f6:d90c with SMTP id
 n10-20020a1c720a000000b00401b6f6d90cmr2725589wmc.35.1696433087525; 
 Wed, 04 Oct 2023 08:24:47 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 k16-20020a05600c0b5000b00403bbe69629sm1792413wmr.31.2023.10.04.08.24.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 08:24:47 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 22/53] migration/rdma: Drop dead
 qemu_rdma_data_init() code for !@host_port
In-Reply-To: <20230928132019.2544702-23-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:48 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-23-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 17:24:46 +0200
Message-ID: <87zg0ywgu9.fsf@secure.mitica>
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
> qemu_rdma_data_init() neglects to set an Error when it fails because
> @host_port is null.  Fortunately, no caller passes null, so this is
> merely a latent bug.  Drop the flawed code handling null argument.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

As your discussion with Peter, I think that this is ok.  The only other
thing we could do is add an assert(), but I am not a big fan either.


