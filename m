Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 828A3788C23
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 17:08:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZYPA-00073b-GI; Fri, 25 Aug 2023 11:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZYP7-00073P-OP
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:07:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZYP4-00043y-RH
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 11:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692976030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywrCirixNM5RcryMBAwxvb9J29NJDCZ8ZD/AeJQdHRU=;
 b=UrRcNKGuYYfXzDGk+zct6BWubV6PMEcLRq9uvtpugwy/XooxRUcjSi4D82kMKPmMF2i0on
 itzWTLLMJLtNOUQ0/cEGb/WaOx1lkQkVuvrsGWXrukLKE54ZjaKFDQc95AkQhLhN0Bc0js
 HF3mnseslOFhowQRgeDCwKAppGWI40g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-IaCKWHb9MEWcVjJemHGOEg-1; Fri, 25 Aug 2023 11:07:09 -0400
X-MC-Unique: IaCKWHb9MEWcVjJemHGOEg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76e1e6b1aa4so4837585a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 08:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692976027; x=1693580827;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywrCirixNM5RcryMBAwxvb9J29NJDCZ8ZD/AeJQdHRU=;
 b=ZoQjnS1QMLv7NPee/kZSoKTfJxD8WQ2Ue1VC1/5ytzpNFxHvY+vALN6SUgOSEO1tcK
 i4qcE2vJ9I8VGPkGgVZe2xs1/LNsj3eMBWu8XyXOErurGm2TMIEoGtHtYSi2+W/UrVs9
 QqUKqNh8g/RFvNKJksmE4SOeNdDWZNdPP0k8BAbKXxbdo7B1cGN6133NeW/GOwpFzD7V
 wKJGpcFG39hFqJsXg2rYQFPbQh7XhGSRPfrwUctfgU8S/3jxpp5MrvRAANu6lY2A1md/
 IgrabpUgT9umDQLOIv9A2r5QvWsWeHI3t0CpCpNZOJLqUQOApMVm5OgFLcIWgzx0fTM/
 JFIA==
X-Gm-Message-State: AOJu0Ywyhrfurp2Bl2Cdn00wzTvWFMud1/kZf74zpq85zYawLNufbz53
 i2lA3MSyp5g3aqe+W9SDnIf0ufT5xTuQ+roUdtU6NZZMhz1rHseZtH5NFTwMWmsPWtuxE5qKssk
 TTsWdH1voislUI0s=
X-Received: by 2002:a05:620a:198a:b0:76c:b3a0:526e with SMTP id
 bm10-20020a05620a198a00b0076cb3a0526emr21667481qkb.6.1692976027315; 
 Fri, 25 Aug 2023 08:07:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/WuszH7ZCswgu6vfuhJINx9ALqLXKG8Y6DHhMPzpwbKFgFizUhQj6spgasypSXfQdSGEXIQ==
X-Received: by 2002:a05:620a:198a:b0:76c:b3a0:526e with SMTP id
 bm10-20020a05620a198a00b0076cb3a0526emr21667459qkb.6.1692976027023; 
 Fri, 25 Aug 2023 08:07:07 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 o15-20020ae9f50f000000b007675c4b530fsm579608qkg.28.2023.08.25.08.07.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 08:07:06 -0700 (PDT)
Date: Fri, 25 Aug 2023 11:07:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V3 00/10] fix migration of suspended runstate
Message-ID: <ZOjDmf/o77puC+OW@x1n>
References: <1692039276-148610-1-git-send-email-steven.sistare@oracle.com>
 <ZN5lrPF9bY4acpvM@x1n>
 <f26b44e5-ef9a-60fc-1172-559ff5ea70de@oracle.com>
 <964c8871-174d-b94d-eb1c-a84f0882a351@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <964c8871-174d-b94d-eb1c-a84f0882a351@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Fri, Aug 25, 2023 at 09:28:28AM -0400, Steven Sistare wrote:
> On 8/24/2023 5:09 PM, Steven Sistare wrote:
> > On 8/17/2023 2:23 PM, Peter Xu wrote:
> >> On Mon, Aug 14, 2023 at 11:54:26AM -0700, Steve Sistare wrote:
> >>> Migration of a guest in the suspended runstate is broken.  The incoming
> >>> migration code automatically tries to wake the guest, which is wrong;
> >>> the guest should end migration in the same runstate it started.  Further,
> >>> for a restored snapshot, the automatic wakeup fails.  The runstate is
> >>> RUNNING, but the guest is not.  See the commit messages for the details.
> >>
> >> Hi Steve,
> >>
> >> I drafted two small patches to show what I meant, on top of this series.
> >> Before applying these two, one needs to revert patch 1 in this series.
> >>
> >> After applied, it should also pass all three new suspend tests.  We can
> >> continue the discussion here based on the patches.
> > 
> > Your 2 patches look good.  I suggest we keep patch 1, and I squash patch 2
> > into the other patches.

Yes.  Feel free to reorganize / modify /.. the changes in whatever way you
prefer in the final patchset.

> > 
> > There is one more fix needed: on the sending side, if the state is suspended,
> > then ticks must be disabled so the tick globals are updated before they are
> > written to vmstate.  Otherwise, tick starts at 0 in the receiver when
> > cpu_enable_ticks is called.
> > 
> > -------------------------------------------
> > diff --git a/migration/migration.c b/migration/migration.c
> [...]
> > -------------------------------------------
> 
> This diff is just a rough draft.  I need to resume ticks if the migration
> fails or is cancelled, and I am trying to push the logic into vm_stop,
> vm_stop_force_state, and vm_start, and/or vm_prepare_start.

Yes this sounds better than hard code things into migration codes, thanks.

Maybe at least all the migration related code paths should always use
vm_stop_force_state() (e.g. save_snapshot)?

At the meantime, AFAIU we should allow runstate_is_running() to return true
even for suspended, matching current usages of vm_start() / vm_stop().  But
again that can have risk of breaking existing users.

I bet you may have a better grasp of what it should look like to solve the
current "migrate suspended VM" problem at the minimum but hopefully still
in a clean way, so I assume I'll just wait and see.

Thanks,

-- 
Peter Xu


