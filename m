Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAFF7CF816
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:04:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtRkr-0005M7-4d; Thu, 19 Oct 2023 08:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRkm-0004ny-2V
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtRkj-0002ko-Kl
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697717028;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=osN42eSL+20VeNBLNbvZsxcyjJkeitcb/m5JZkFCzWo=;
 b=dGh9L9wrcXxmUzyqRPtQD4W2HOD7S20FyTgMq9ZbSXo9feTM2TwEmI2Pej++/kW/TTWQE4
 M44rjm46wKzhymWkurGkd6m3CJzgn3zBDKvA+pyEgHeLAuX+mJyRIlE7cPG/6iEUVFvw01
 R0N5E0GpReKpzqs7qbWrUMAR5vD208g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-mG4u_R1aNv-Spw9RmVE3Dg-1; Thu, 19 Oct 2023 08:03:42 -0400
X-MC-Unique: mG4u_R1aNv-Spw9RmVE3Dg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4053a5c6a59so50241305e9.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697717021; x=1698321821;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=osN42eSL+20VeNBLNbvZsxcyjJkeitcb/m5JZkFCzWo=;
 b=EC7v+GP/3rcdNQJsr494f0mJ4pSLlG62CrK+x59/++T0zmFGAgqhzmCA+65eRqvS5x
 RTdFoD579m3N9vxsMp5cd/kfSvG8CoIDBz/bPKy+rehsoK0hZqQ6o+G/zuPLKPybvhzp
 1AKwgyhDyNR/Esh+mgMCiKdRavdxyTd6XHFlDCs8rHzhyuOcpynW9ypOCcU5q0j6G4kJ
 azN4WTWgyMnwD1BessOCx2oNdqYS41z3QaEP3rZOeOONK8bCNShnNjdqrVhkM3weDcVv
 9t4ZBYkA82pn2r1uqIkqIVUm8FzwlBZrLkthdDW9yp7gFWvU5vOW6vhxgSdctnVeMItH
 VvzA==
X-Gm-Message-State: AOJu0YzdamJ30OFXZf/OklNEHLaCnmLBwWs2g9rvDkj6Kz6B4RMj2nsS
 aixOTVPF9SJlMj9e9XMd3hfyn15QJyU0Msxom8tnrr2pumD0BG0cwPc1525by4f1mRIdooewS5F
 zhHJl0FUAF3Q4Yzc=
X-Received: by 2002:a05:600c:4747:b0:405:3ae6:2413 with SMTP id
 w7-20020a05600c474700b004053ae62413mr1665987wmo.25.1697717021089; 
 Thu, 19 Oct 2023 05:03:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgS65jwj9WZJOfrgvnjxj0YkPRTF+Mim9TENRwpcibqLxc03J0ApUhyZDAya+CF19YgzIVzg==
X-Received: by 2002:a05:600c:4747:b0:405:3ae6:2413 with SMTP id
 w7-20020a05600c474700b004053ae62413mr1665927wmo.25.1697717019816; 
 Thu, 19 Oct 2023 05:03:39 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 i18-20020a05600c481200b00407b93d8085sm4199326wmo.27.2023.10.19.05.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:03:39 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Leonardo Bras
 <leobras@redhat.com>,  Vladimir Sementsov-Ogievskiy
 <vsementsov@yandex-team.ru>,  Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Fam
 Zheng <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Li
 Zhijian <lizhijian@fujitsu.com>,  John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org,  Cleber Rosa <crosa@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>
Subject: Re: [PULL 13/38] migration: Non multifd migration don't care about
 multifd flushes
In-Reply-To: <5322a867-8675-4257-8dc1-5b0d3054d44f@tls.msk.ru> (Michael
 Tokarev's message of "Thu, 19 Oct 2023 14:47:53 +0300")
References: <20231017083003.15951-1-quintela@redhat.com>
 <20231017083003.15951-14-quintela@redhat.com>
 <5322a867-8675-4257-8dc1-5b0d3054d44f@tls.msk.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 19 Oct 2023 14:03:38 +0200
Message-ID: <87mswe4y5h.fsf@secure.mitica>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Michael Tokarev <mjt@tls.msk.ru> wrote:
> 17.10.2023 11:29, Juan Quintela:
>> RDMA was having trouble because
>> migrate_multifd_flush_after_each_section() can only be true or false,
>> but we don't want to send any flush when we are not in multifd
>> migration.
>> CC: Fabiano Rosas <farosas@suse.de
>> Fixes: 294e5a4034e81 ("multifd: Only flush once each full round of memory")
>
> Is it worth to pick it up for stable-8.1?

Yeap, please.

Later, Juan.


