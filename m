Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CBA7B84E7
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 18:22:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo4dg-0005Bx-A7; Wed, 04 Oct 2023 12:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4dd-0005Bi-8y
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:22:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo4db-0005jF-2L
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 12:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696436534;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=C4uOeTH9zqCAGUR+7lRjRlHMTkOpHqZdITwPP117Ox8=;
 b=RHqtn8YPWg9Ljk1KVmzrirOZVZP0Qs5Zg7EbekAat6XjAa5HXZnnmeySkofz3XLmZkbjeQ
 8tbQ8m2BTxHRrrkTEQ05qmDICr32SlhagqISqwzMXgWJYmhU+9QI0o3T89HJEnf4BKeSS3
 VOmlSYOMwIQBg5o76CL2ZvtRWSaYcho=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-qfwKnOnuOqStIf2T5FxY3g-1; Wed, 04 Oct 2023 12:22:10 -0400
X-MC-Unique: qfwKnOnuOqStIf2T5FxY3g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40647c6f71dso17847015e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 09:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696436528; x=1697041328;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4uOeTH9zqCAGUR+7lRjRlHMTkOpHqZdITwPP117Ox8=;
 b=AK6JX93KOlzeInAy/kfwCLlDIcjrFVabzs46L791gtrjVqj3ujKzmPWe6Go0VST8tm
 TkOFWSYIvO3qeEHRB66XGKyQ012KJxHN1so2aMcG1W+jNASAT/hS2uKGnvegySPvRtmj
 TVwoe01TOoCQGtBcq5jJRFHz0sl+IYQXvGD26wd5hNRs0foz3hwIJ0enWHso/xsjgx+g
 26lo7j1eNv3lOpJQPoJvxeWSVseTyQeNckxJFSxbz+fVXs1uRI8HKihUn5QykbpKpZmN
 ZynKpsqUNK1Ap6o+H3AoSquYP5gAJRV1wFltiCLxnldzvpi1702z0v12x7AKZoVF4As3
 tsmA==
X-Gm-Message-State: AOJu0YwS+DKkrV9HhqYXjMgG9rosB+wRTgGVdM6jpl/eDVIaA+VSwZVv
 GT0USI3W5ndcy9cuYjTC5LLcsi7mfZUUQPvEo3HvGoi0MobgfXqWpQ5HK5kLtNJUYEn7XlOwzre
 MquRSSz0I5AR6QZQ=
X-Received: by 2002:a05:600c:2981:b0:403:8fb9:8d69 with SMTP id
 r1-20020a05600c298100b004038fb98d69mr2635811wmd.25.1696436528391; 
 Wed, 04 Oct 2023 09:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLJ4NF9rWpXQZq6whKJ52UOlV6tL2CLJSEdMwd6eilt/6+1W9ZL2BzVPOfzJEAKK/mD1J4yg==
X-Received: by 2002:a05:600c:2981:b0:403:8fb9:8d69 with SMTP id
 r1-20020a05600c298100b004038fb98d69mr2635796wmd.25.1696436528065; 
 Wed, 04 Oct 2023 09:22:08 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 w21-20020a05600c015500b0040652e8ca13sm1888051wmm.43.2023.10.04.09.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:22:07 -0700 (PDT)
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
Date: Wed, 04 Oct 2023 18:22:06 +0200
Message-ID: <87a5sywe6p.fsf@secure.mitica>
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

Reviewed-by: Juan Quintela <quintela@redhat.com>

Changed idea.  Will include this and rebase mines on top.


