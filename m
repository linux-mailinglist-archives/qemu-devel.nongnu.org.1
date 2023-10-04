Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ED57B829A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:45:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo37W-00035y-C4; Wed, 04 Oct 2023 10:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo37U-00035l-SH
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo37T-0007ac-IP
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696430698;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=mzU4IkwM6rsxTI+psE9C1mcn7hajSY5o+Hg7t7qoyI8=;
 b=NjY2JYu9CwkePmcMGyNGn5BA7nCa2ks/G0SR9COGGanNs2AxYiSGvlRdPrMOQQPQHFAeN2
 oRyp5kMh3K4+i5uYLbRv1GY8H/T9mOYZRvTwdvrQfYOrPJkKzW3LrennLf2WHZ8cu3epmJ
 8UWMM0ogOOcAkIZLNKt/2ii5LboDa/A=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-9CJjX_qPOr6vEzbMGkKYBg-1; Wed, 04 Oct 2023 10:44:56 -0400
X-MC-Unique: 9CJjX_qPOr6vEzbMGkKYBg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-405629826ccso17110035e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:44:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696430696; x=1697035496;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mzU4IkwM6rsxTI+psE9C1mcn7hajSY5o+Hg7t7qoyI8=;
 b=B7pOW/CVOyYXWg4jHHPx8uirf2MAP68CIr5Yq3SlFODaFILsBqhH6xoxDX/kaEk421
 OU+9jzgMBM4D4cemw4LY9RI7vizqnK/SG180L6vMLyZpH+wK6kiyambwmYGsUROMgzmu
 MJ+s2oK/zitYLsUDfZGAR0PRRUJBVhbPWNjGd+P0aTceeVVjmB9loqUPDQkken9Hi4tH
 u+5vslDSfwS4GBG8cUTVtkojPaoIxSzLgA7ZB8hhbiPA3fbmssNrYD0JSgbnGsArN6XK
 H+TShXtt8dswiTk2h1nOclapWA/+5qYqvzG1r3HToCryISsNNOAQprhsJSjq1SFZ68eY
 6Yhg==
X-Gm-Message-State: AOJu0YyO//e+GC+vtsI1Cufb0+0jgkH8hlvrGFmXU5s+yEMLhBYI6Dpe
 QWEs8X5iDtQs6S1gx2WCP7Q6LfFERGk37z0CaWaDzCvNt/0UvLAPRiyfUe9ZuWzFUoAE9wXevCD
 xx+HGkH0DfMSa/ks=
X-Received: by 2002:a1c:4c03:0:b0:405:770b:e90a with SMTP id
 z3-20020a1c4c03000000b00405770be90amr2616434wmf.34.1696430695943; 
 Wed, 04 Oct 2023 07:44:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGL7fueFgGpRo8bUsDWT/pqFVqpPAj7QwpJkGHzyCBDM2cdY2ZQrOciNFm4qv7iTAhOPj+sfg==
X-Received: by 2002:a1c:4c03:0:b0:405:770b:e90a with SMTP id
 z3-20020a1c4c03000000b00405770be90amr2616413wmf.34.1696430695609; 
 Wed, 04 Oct 2023 07:44:55 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s11-20020a7bc38b000000b003fbe4cecc3bsm1730357wmj.16.2023.10.04.07.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:44:54 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 07/53] migration/rdma: Clean up two more harmless
 signed vs. unsigned issues
In-Reply-To: <20230928132019.2544702-8-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 28 Sep 2023 15:19:33 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-8-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:44:54 +0200
Message-ID: <87fs2qzbtl.fsf@secure.mitica>
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
> qemu_rdma_exchange_get_response() compares int parameter @expecting
> with uint32_t head->type.  Actual arguments are non-negative
> enumeration constants, RDMAControlHeader uint32_t member type, or
> qemu_rdma_exchange_recv() int parameter expecting.  Actual arguments
> for the latter are non-negative enumeration constants.  Change both
> parameters to uint32_t.
>
> In qio_channel_rdma_readv(), loop control variable @i is ssize_t, and
> counts from 0 up to @niov, which is size_t.  Change @i to size_t.
>
> While there, make qio_channel_rdma_readv() and
> qio_channel_rdma_writev() more consistent: change the former's @done
> to ssize_t, and delete the latter's useless initialization of @len.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>


