Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E7C7D4E89
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 13:06:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvFDb-0002mw-OB; Tue, 24 Oct 2023 07:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qvFDZ-0002mQ-Fd
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:05:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qvFDT-00059d-Sb
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 07:05:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698145494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w4mzQ9zo6NVm4bfCKjlNdpyJOc3NW8RfgmQyySgcd4U=;
 b=SfYsxLukDfHtmgNCKdCvxC2jNmQuH0IMXERa86O65vZwL1Gki29SGrUWVs2/mbL/l7MNRB
 I/sIcEuiCvrXHhPudqxoEV8qTVnV7T9bjaP9O4q3OeM4c5aSi6k/84H/nfEuL1MTh5JwXK
 fx2dVE17Pn2vsDbqiuQbCs2radiKzPQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-519-UbbafjT0NIyLldkC7me-XQ-1; Tue,
 24 Oct 2023 07:04:53 -0400
X-MC-Unique: UbbafjT0NIyLldkC7me-XQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D85A33822E86;
 Tue, 24 Oct 2023 11:04:52 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.233])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A354C2166B26;
 Tue, 24 Oct 2023 11:04:50 +0000 (UTC)
Date: Tue, 24 Oct 2023 13:04:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, vsementsov@yandex-team.ru,
 jsnow@redhat.com, den@virtuozzo.com, t.lamprecht@proxmox.com,
 alexander.ivanov@virtuozzo.com
Subject: Re: [PATCH v3 5/9] mirror: implement mirror_change method
Message-ID: <ZTek0Qlg2KFFzY2e@redhat.com>
References: <20231013092143.365296-1-f.ebner@proxmox.com>
 <20231013092143.365296-6-f.ebner@proxmox.com>
 <ZTAO+TJuztCHDsUW@redhat.com>
 <92c65eb0-a069-48ea-9cbb-f8dd27b1f632@proxmox.com>
 <ZTZuTRw/+EYY0Nc+@redhat.com>
 <e84fc767-e50c-4578-9640-44365c96f814@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e84fc767-e50c-4578-9640-44365c96f814@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
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

Am 23.10.2023 um 16:14 hat Fiona Ebner geschrieben:
> Am 23.10.23 um 14:59 schrieb Kevin Wolf:
> > Am 23.10.2023 um 13:37 hat Fiona Ebner geschrieben: 
> >>>> +    current = qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
> >>>> +                              change_opts->copy_mode);
> >>>> +    if (current != MIRROR_COPY_MODE_BACKGROUND) {
> >>>> +        error_setg(errp, "Expected current copy mode '%s', got '%s'",
> >>>> +                   MirrorCopyMode_str(MIRROR_COPY_MODE_BACKGROUND),
> >>>> +                   MirrorCopyMode_str(current));
> >>>> +    }
> >>>
> >>> The error path is strange. We return an error, but the new mode is still
> >>> set. On the other hand, this is probably also the old mode unless
> >>> someone added a new value to the enum, so it didn't actually change. And
> >>> because this function is the only place that changes copy_mode and we're
> >>> holding the BQL, the case can't even happen and this could be an
> >>> assertion.
> >>>
> >>
> >> AFAIU and testing seem to confirm this, the new mode is only set when
> >> the current mode is MIRROR_COPY_MODE_BACKGROUND. The error is only set
> >> when the current mode is not MIRROR_COPY_MODE_BACKGROUND and thus when
> >> the mode wasn't changed.
> > 
> > Yes, the new mode is only set when it was MIRROR_COPY_MODE_BACKGROUND,
> > that's the meaning of cmpxchg.
> > 
> > And now that I checked the return value of qatomic_cmpxchg(), it's not
> > the actual value, but it returns the second parameter (the expected old
> > value). As this is a constant in our call, that's what we'll always get
> > back. So the whole check is pointless, even as an assertion. It's
> > trivially true, and I expect it's even obvious enough for the compiler
> > that it might just optimise it away.
> > 
> 
> From testing, I can see that it returns the current value, not the
> second parameter. I.e. if I am in MIRROR_COPY_MODE_WRITE_BLOCKING, it
> will return MIRROR_COPY_MODE_WRITE_BLOCKING. (Of course, I have to
> comment out the other check to reach the cmpxchg call while in that mode).

You're right, I misread. Sorry for the noise.

> > Just qatomic_cmpxchg(&s->copy_mode, MIRROR_COPY_MODE_BACKGROUND,
> > change_opts->copy_mode); without using the (constant) result should be
> > enough.
> > 
> >> Adding a new copy mode shouldn't cause issues either? It's just not
> >> going to be supported to change away from that mode (or to that mode,
> >> because of the change_opts->copy_mode != MIRROR_COPY_MODE_WRITE_BLOCKING
> >> check above) without adapting the code first.
> > 
> > The checks above won't prevent NEW_MODE -> WRITE_BLOCKING. Of course,
> > the cmpxchg() won't actually do anything as long as we still have
> > BACKGROUND there as the expected old value. So in this case, QMP would
> > probably return success, but we would stay in NEW_MODE.
> > 
> 
> No, that's the whole point of the check. It would fail with the error,
> saying that it expected the current mode to be background and not the
> new mode.

Yes, this makes sense now.

> > That's different from what I thought (I didn't really realise that we
> > have a cmpxchg here and not just a xchg), but also not entirely right.
> > 
> > Of course, all of this is hypothetical. I'm not aware of any desire to
> > add a new copy mode.
> > 
> >> Of course, if we want to allow switching from active to background mode,
> >> the function needs to be adapted too.
> >>
> >> I wanted to make it more future-proof for the case where it might not be
> >> the only place changing the value and based it on what Vladimir
> >> suggested in the review of v2:
> >> https://lists.nongnu.org/archive/html/qemu-devel/2023-10/msg03552.html
> > 
> > As long as all of these places are GLOBAL_STATE_CODE(), we should be
> > fine. If we get iothread code that changes it, too, I think your code
> > becomes racy because the value could be changed by the iothread between
> > the first check if we already have the new value and the actual change.
> > 
> 
> Right, but I think the only issue would be if the mode changes from
> MIRROR_COPY_MODE_BACKGROUND to MIRROR_COPY_MODE_WRITE_BLOCKING between
> the checks, because then the QMP call would fail with the error that the
> mode was not the expected MIRROR_COPY_MODE_BACKGROUND. But arguably,
> that is still correct. If we are already in the requested mode at the
> time of the first check, we're fine.
> 
> Still, I'll add the GLOBAL_STATE_CODE() and a comment for the future :)

Thanks, sounds good.

Kevin


