Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E07B8283
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 16:39:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo31F-0000Gt-FV; Wed, 04 Oct 2023 10:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo31C-0000El-O1
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qo31A-0004gn-UE
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 10:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696430308;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tbxhBSt/S9LEKgqhEDZZsvr+e4voO/OddJ4pQg/nZAI=;
 b=Srw2pbBkDwvBhVYzgdy/637OttyfJRXi7mslAthSK2BGR86k7iPoSScJtC95oyvzkmFJpN
 rlJ5rb4tjoOxap8tDONGwP95x9jrdiGRskIRscQgvoXj2AyzYoqTwHcphZIiAg4juQKlDe
 FOlx+RxgM8bt7vBDjWxzckOD2yeRxu4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-kTQG8bxFMPCLUx-dpPdBng-1; Wed, 04 Oct 2023 10:38:27 -0400
X-MC-Unique: kTQG8bxFMPCLUx-dpPdBng-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4054016ff33so5375455e9.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 07:38:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696430304; x=1697035104;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tbxhBSt/S9LEKgqhEDZZsvr+e4voO/OddJ4pQg/nZAI=;
 b=gURxGW9PfJFf/Rz/IS1n8yGVvt3x8KkvjODqz23JBaQge3QlFVMYnyhsgU7QFqR4hn
 6mhUZ+80+K4ND1eskl3cuwD24Am6u9SAOcEOHfLtZsdOA5Wzlcs1hBEt5b0WIwB5KXVB
 fi/qOIsIy+JXap6Ie5Bh66dZJDBVwcAOGMWfIGh8GnPtznQSrxoj5nI0arCj811MtFW+
 8r/FLz5j6bxgodKQNmBfEK62XqlLG6aTCdaMBT+We3ozXNOX8M5VtUED0O7DRzyXi9/7
 N7SwGC7EV+njxYsLtH2h28NnpE2IqRtRce+BbvGH7LWBCW60BSbDkwLl2vtYZ9njeCik
 68kA==
X-Gm-Message-State: AOJu0YzrvXdyI9kifUGhrc9VaqhlcZHImesvKytZjzz2y1FVFIO/EYk7
 ubwAQyMQTFdOPtKC7zCb+yIOWpZ2MQogCJ6KhR9E3mbGNR2YmoM5aTASQ3c19L/93kwKckUfZVv
 VoL1juzeGY7LzpSoOWcPcqnjfQg==
X-Received: by 2002:a1c:7416:0:b0:3fb:c075:b308 with SMTP id
 p22-20020a1c7416000000b003fbc075b308mr2090004wmc.12.1696430304654; 
 Wed, 04 Oct 2023 07:38:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYDwCJ1m4IbVTvUmSguAq4o3iUfCPO6baHgX2ghtGzQ/gdcp27rux2JKlQTG54M5YY+ZESCg==
X-Received: by 2002:a1c:7416:0:b0:3fb:c075:b308 with SMTP id
 p22-20020a1c7416000000b003fbc075b308mr2089981wmc.12.1696430303991; 
 Wed, 04 Oct 2023 07:38:23 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 a4-20020a05600c224400b003fe2b081661sm1695811wmm.30.2023.10.04.07.38.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 07:38:23 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 04/53] migration/rdma: Drop fragile wr_id formatting
In-Reply-To: <20230928132019.2544702-5-armbru@redhat.com> (Markus Armbruster's
 message of "Thu, 28 Sep 2023 15:19:30 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-5-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 04 Oct 2023 16:38:22 +0200
Message-ID: <87ttr6zc4h.fsf@secure.mitica>
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
> wrid_desc[] uses 4001 pointers to map four integer values to strings.
>
> print_wrid() accesses wrid_desc[] out of bounds when passed a negative
> argument.  It returns null for values 2..1999 and 2001..3999.
>
> qemu_rdma_poll() and qemu_rdma_block_for_wrid() print wrid_desc[wr_id]
> and passes print_wrid(wr_id) to tracepoints.  Could conceivably crash
> trying to format a null string.  I believe access out of bounds is not
> possible.
>
> Not worth cleaning up.  Dumb down to show just numeric wr_id.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Li Zhijian <lizhijian@fujitsu.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


