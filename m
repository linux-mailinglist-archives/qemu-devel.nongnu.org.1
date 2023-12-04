Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D318041BF
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 23:39:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAHZR-0004Kh-Ut; Mon, 04 Dec 2023 17:37:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAHZQ-0004K4-Cl
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 17:37:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAHZO-0002Fj-Ow
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 17:37:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701729461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oavQVy7VMKTSzIh8vVMGp1Qv+3ExQUH80dQ957blTBM=;
 b=OtSj2ANmU71n93dR0D63X1vSasiNv1uorXgI2/oI3t8AwL5E1lCcVnuXVyf4XgGM8O8AkR
 1PLPrVrt0VZig4+fraBinV0uXlAkzAzlQmvBjzo5fVOrKhDzHDZ9hI6WBumdQukhSy7qGr
 f8jJdbw2y1+Znu/skdWjALohxf81ixg=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-08I64xx5NcuydObfUm7MMw-1; Mon, 04 Dec 2023 17:37:40 -0500
X-MC-Unique: 08I64xx5NcuydObfUm7MMw-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-35d6995d437so2094015ab.0
 for <qemu-devel@nongnu.org>; Mon, 04 Dec 2023 14:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701729459; x=1702334259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oavQVy7VMKTSzIh8vVMGp1Qv+3ExQUH80dQ957blTBM=;
 b=doNcQKcVjVXiYutlad6wvQZVTJ7opEyC8Mc+9qJK74qY3hUKWSIZGpgN8xx2k4mLKi
 Q50b2/nkqc2iPEHoXLo0dZJwEf9FXbPpw2tkpq07S+LFeQwkWvv69e18OiXjnJo6moxG
 w0ejF+Zgwi+hczy1M0s+ND2RTrnQoIsg8i5qv3vxOOVvD0/wmujyhC6OL8ZEQGBoX2XZ
 sqdq556bw73tP91bvqMuEtQRovMcyE6ZHzt5z4x7D9BNgCZsbqnuKMazhc7xSYTbRgl1
 UYGZNYTxomhkWFkTj9urEar2oG40BxUBvq+FOLAZC7wZtc0wwFVfzVEUtWi12r4LKYuA
 mndg==
X-Gm-Message-State: AOJu0YwThhmWF723uthDze2PPi/tS2atH3svm/UfJvXpk7mvo+Gl3Soj
 dVvSCYMIn6S9WO5rt0uYf2jo+ASljcUK47a0mzwniF6f7zLxJ6ih5CfLJZqnegYra/pOM7k1jsd
 LasA78vz/bc9fWh4=
X-Received: by 2002:a05:6e02:170f:b0:35d:6600:fceb with SMTP id
 u15-20020a056e02170f00b0035d6600fcebmr7567437ill.0.1701729459377; 
 Mon, 04 Dec 2023 14:37:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI4ysZaN5R4ICVJStKYFlGOaDzT+JqlK3Ge2VZBDrZwtytfWrkpMVRL5wxMWptTnUnd811Aw==
X-Received: by 2002:a05:6e02:170f:b0:35d:6600:fceb with SMTP id
 u15-20020a056e02170f00b0035d6600fcebmr7567408ill.0.1701729458693; 
 Mon, 04 Dec 2023 14:37:38 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 w1-20020a92db41000000b0035d65a1ea65sm192052ilq.55.2023.12.04.14.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 14:37:38 -0800 (PST)
Date: Mon, 4 Dec 2023 17:37:36 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>,
 Andrey Gruzdev <andrey.gruzdev@virtuozzo.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 13/14] tests/qtest: bootfile per vm
Message-ID: <ZW5UsIhP7GcKbwZK@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-14-git-send-email-steven.sistare@oracle.com>
 <87lea9n01r.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87lea9n01r.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Dec 04, 2023 at 06:13:36PM -0300, Fabiano Rosas wrote:
> Steve Sistare <steven.sistare@oracle.com> writes:
> 
> > Create a separate bootfile for the outgoing and incoming vm, so the block
> > layer can lock the file during the background migration test.  Otherwise,
> > the test fails with:
> >   "Failed to get "write" lock.  Is another process using the image
> >    [/tmp/migration-test-WAKPD2/bootsect]?"
> 
> Hm.. what is the background migration even trying to access on the boot
> disk? @Peter?

I didn't yet notice this patch until you asked, but background snapshot is
not designed to be used like this, afaict.

It should normally be used when someone would like to use "savevm", then
background snapshot makes that snapshot save happen with VM running (live)
and mostly as performant as "savevm" due to page write protections (IOW, it
is not dirty tracking, but wr-protect each page so not writtable at all
until unprotected).

Another difference (from "savevm") is, instead of storing that image onto
the block images, it stores that image also separately just like migrating
with "file:" as of now.

When the dest QEMU starts it'll try to grab the image lock already because
it should never run with src running, just like when "loadvm" QEMU doesn't
assume the QEMU that ran "savevm" will be running.

> 
> This might be a good use for the -snapshot option. It should stop any
> attempt to get the write lock. Not a lot of difference, but slightly
> simpler.

We don't yet have a background-snapshot test case.  If we ever need,
that'll need to be done in two steps: start src, save snapshot into file,
start dest, load from snapshot file.  We just shouldn't boot two together.

Now after two years when I re-read the snapshot code a bit, I didn't even
find where QEMU took the disk snapshots.. logically it should be done at
the start of live background snapshot when VM was dumping device states,
something like bdrv_all_can_snapshot() orshould be needed to make sure all
images support snapshot on its own or it should already fail, and take
snapshots to match the image.

IOW, I don't even think current raw disk would be able to support
background snapshot at all, otherwise if VM is live I don't see a way to
match the image (which is still lively updated by the running VM) to a live
snapshot taken.  Copy the author, Andrey, for this question.

Before that is confirmed, maybe the easiest way is we can go without a
background snapshot test case for suspend vm scenario.

Thanks,

-- 
Peter Xu


