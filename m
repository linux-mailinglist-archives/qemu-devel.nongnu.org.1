Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF979F2B8
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 22:14:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgWFJ-0008SZ-0a; Wed, 13 Sep 2023 16:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgWFH-0008Nr-1Y
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgWFB-0000T2-1Z
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 16:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694636028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ANgggfjRflJSTN4V0UUcERXX2AHL7NotMnNPr5mmBQ=;
 b=RwRVHgIeNUoP9tUAOpQ6R/+zLHxcSSRRsVqGh2jg0EJih9YgwsAkDd8EMSL1a8G8E6moon
 Yc5Ere5/zZvQLyULqAjCcD+Q1/MccUedARjrtoJKhh6f8HMzQegyTBq/Yz4LmbN7+c8oOP
 8KnhCtMJgAfw3n7uFzX3mrOutedrEJ8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-8Hi-XCBvOnG5TwdZQw-nnQ-1; Wed, 13 Sep 2023 16:13:46 -0400
X-MC-Unique: 8Hi-XCBvOnG5TwdZQw-nnQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-637948b24bdso555086d6.1
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 13:13:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694636026; x=1695240826;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ANgggfjRflJSTN4V0UUcERXX2AHL7NotMnNPr5mmBQ=;
 b=h9dnOo5aU73RYlcggTV/PbdQA40WLtSbu3WaNTcMhvK4F+g4x+whkhs5PYAhjSRuAE
 gLd+Xl0aje/tK1kf8GOG3aGVxBrhXEQm/05iP7DD3RjjAtFskT+3V+KHsQWTdXAwaAWv
 YJ7+yOlmwDzOoy+0BuoaYXNkwaKDYRQ9D+Sgn5xIpjkW5yuGNJHkz3a3uNbu4idGW3kN
 etoTcJ8465NZU7G9qNiyy4fVgEM8wVKvUOg2vfeaIB+GrMe7rZlDZEe2tTGcvQg6Uo9Q
 veGEeysIkfhOoO9DtwPziVKum8GGxJK1CQaJKW9uSIpdqDiw2FMN1nY3I5d0XjYbVSbv
 IWrw==
X-Gm-Message-State: AOJu0YyjP73b/mC3JqWj7Qj7oiED3lxQ00h6IUqdofLUoQPxOiMkovQR
 tTE8tjBBlZ8YJcBHnU53FEFK0wecYx60z4wmosnc77tQqh0YF+96d+5tuGcV3JSPiw0FMqARujJ
 UVv63h40Stwhnb2pKLTpo/ag=
X-Received: by 2002:ad4:5dcc:0:b0:616:870c:96b8 with SMTP id
 m12-20020ad45dcc000000b00616870c96b8mr3606599qvh.3.1694636026268; 
 Wed, 13 Sep 2023 13:13:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoB1ZF0KYCNer9WKA5BwVjKU5+UbgVvXb1AAKJ1YLJpTA596Fx302KcxFG9QZi6jnXq/aBTA==
X-Received: by 2002:ad4:5dcc:0:b0:616:870c:96b8 with SMTP id
 m12-20020ad45dcc000000b00616870c96b8mr3606588qvh.3.1694636026009; 
 Wed, 13 Sep 2023 13:13:46 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d1-20020a05620a166100b0076db5b792basm4117081qko.75.2023.09.13.13.13.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 13:13:45 -0700 (PDT)
Date: Wed, 13 Sep 2023 16:13:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v6 09/10] migration/yank: Keep track of registered yank
 instances
Message-ID: <ZQIX+KUgL5V6H/gj@x1n>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-10-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230911171320.24372-10-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Sep 11, 2023 at 02:13:19PM -0300, Fabiano Rosas wrote:
> The core yank code is strict about balanced registering and
> unregistering of yank functions.
> 
> This creates a difficulty because the migration code registers one
> yank function per QIOChannel, but each QIOChannel can be referenced by
> more than one QEMUFile. The yank function should not be removed until
> all QEMUFiles have been closed.
> 
> Keep a reference count of how many QEMUFiles are using a QIOChannel
> that has a yank function. Only unregister the yank function when all
> QEMUFiles have been closed.
> 
> This improves the current code by removing the need for the programmer
> to know which QEMUFile is the last one to be cleaned up and fixes the
> theoretical issue of removing the yank function while another QEMUFile
> could still be using the ioc and require a yank.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/yank_functions.c | 81 ++++++++++++++++++++++++++++++++++----
>  migration/yank_functions.h |  8 ++++
>  2 files changed, 81 insertions(+), 8 deletions(-)

I worry this over-complicate things.

If you prefer the cleaness that we operate always on qemufile level, can we
just register each yank function per-qemufile?  I think qmp yank will
simply fail the 2nd call on the qemufile if the iochannel is shared with
the other one, but that's totally fine, IMHO.

What do you think?

In all cases, we should probably at least merge patch 1-8 if that can
resolve the CI issue.  I think all of them are properly reviewed.

Thanks,

-- 
Peter Xu


