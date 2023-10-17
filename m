Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2147CCECF
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 22:55:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsr5V-0003yM-4I; Tue, 17 Oct 2023 16:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsr5T-0003xu-1y
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:54:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsr5R-0006Is-IB
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 16:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697576084;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=APXAT0Mufwa4LiaWaETOX+0L3iAc/blRNWWgFHc9wFc=;
 b=ZbAoHlHkJTXP6BCYHyK9OCO5+AClImVH1U4Rl98F5EQgPnEss1mBZ+Hy+S26nEDcpFDb2L
 XVvazQonHeTKNtCCw95IMWLH6XAGmH/pV+ta66zfHN9iTaC3vuQ2DTb+1wJtaqo90N0B2U
 08DpkRtCnT9M6epfjcLaORQb+kKIisI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-coo9FxqWPdOc3Nuw_ATnSA-1; Tue, 17 Oct 2023 16:54:41 -0400
X-MC-Unique: coo9FxqWPdOc3Nuw_ATnSA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40837aa4a58so3748375e9.0
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 13:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697576075; x=1698180875;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=APXAT0Mufwa4LiaWaETOX+0L3iAc/blRNWWgFHc9wFc=;
 b=ZerCK4N4xjdsWApl1nMXLNlhr5eHEjaWX/8wcWFnt09xk9i795N2d0O6H7a1PbHJsM
 i7zHZfTTLTP9HcVYoIAFeLsAHhTZ+3UhtvULCG6363brtJNQZeTdR5DZgLQZZRLiS/9N
 /f1m3Lgnu2dfvr6S5GX0Aj27hGkR49jHnzJ0UCE5jLDiCHH320qJddsRAjMFPRNKWIIi
 hmvK1CRtvx97CrQqb0Jb61DF3gNcD6cAaK6j7L0m1P6cULkr1vvZKKgC5lJ+Svt5YZEr
 A1jpZ3KAKNDlGKCIv+gg8owi2+woE2fVYfSojefjMJz4lyfdhkFTl4mDaRhjYasecoXS
 VYnQ==
X-Gm-Message-State: AOJu0YznOqn/UshRqOREiwff0iYebaz1UXCLoJexr3wpjKfOTD1ujufU
 h5/0dZ/ZxCWZBlqv28x3k2sEOeKgwZdUwjRFNstlqd/jB1rPU71lgGhNeIvGCnXddV3PLyGlfDp
 M89gEBug31AAaDTeVoBvrs7C+WKXgd6dZ2JFAQWgWia8/a+ujaEDbJ1tEdjuQMS7vIXeOVHt0az
 mxdwUC
X-Received: by 2002:a05:600c:4f01:b0:401:c8b9:4b86 with SMTP id
 l1-20020a05600c4f0100b00401c8b94b86mr2813142wmq.9.1697576074795; 
 Tue, 17 Oct 2023 13:54:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGtH/iowvLS457ohstlFq966ExjVMhBZBQ5spwGgLhW6SdUsPbiEaMHn5yabx//i4UQuP+EQ==
X-Received: by 2002:a05:600c:4f01:b0:401:c8b9:4b86 with SMTP id
 l1-20020a05600c4f0100b00401c8b94b86mr2813122wmq.9.1697576074448; 
 Tue, 17 Oct 2023 13:54:34 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 z20-20020a05600c0a1400b003feae747ff2sm10748551wmp.35.2023.10.17.13.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 13:54:33 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com,  Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org,  Leonardo Bras <leobras@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Markus Armbruster <armbru@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v6 3/5] migration: migrate 'blk' command option is
 deprecated.
In-Reply-To: <20231017172307.22858-4-quintela@redhat.com> (Juan Quintela's
 message of "Tue, 17 Oct 2023 19:23:05 +0200")
References: <20231017172307.22858-1-quintela@redhat.com>
 <20231017172307.22858-4-quintela@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Tue, 17 Oct 2023 22:54:32 +0200
Message-ID: <87v8b5x94n.fsf@secure.mitica>
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

Juan Quintela <quintela@redhat.com> wrote:
> Use blocked-mirror with NBD instead.
>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

Hi Kevin and Stefan

Can we change the iotest output to fix this?

https://gitlab.com/juan.quintela/qemu/-/jobs/5314070229

tput mismatch (see /builds/juan.quintela/qemu/build/tests/qemu-iotests/scratch/raw-file-183/183.out.bad)
--- /builds/juan.quintela/qemu/tests/qemu-iotests/183.out
+++ /builds/juan.quintela/qemu/build/tests/qemu-iotests/scratch/raw-file-183/183.out.bad
@@ -28,6 +28,8 @@
 { 'execute': 'migrate',
        'arguments': { 'uri': 'unix:SOCK_DIR/migrate', 'blk': true } }
+warning: parameter 'blk is deprecated; use blockdev-mirror with NBD instead
+warning: block migration is deprecated; use blockdev-mirror with NBD instead
 {"return": {}}
 { 'execute': 'query-status' }
 {"return": {"status": "postmigrate", "singlestep": false, "running":
 false}}


I really want to give the warnings two users.

I guess that you want to test blk migration.

What do you recommend?

Later, Juan.




