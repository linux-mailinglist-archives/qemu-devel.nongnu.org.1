Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1917D710A
	for <lists+qemu-devel@lfdr.de>; Wed, 25 Oct 2023 17:38:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvfvz-0000Sd-Tq; Wed, 25 Oct 2023 11:36:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvfvw-0000PJ-JU
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvfvu-0007iy-U8
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 11:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698248192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KnqNgXlC8PFpV/YpGvj+SCdq6EDTqI3w0FbEZZoGO8=;
 b=a70J4RRN/BkmpmbM3yEthLaYNfiVCba7L2tVvPBqi707SpHBEb3R1OgMC7PjwhCgrerIPo
 Cw14olhEtzv9x7FVHqvl2eNqUHphqgSQeiAsLy4H03Q7OrXQRs5Yg46WfstUSjgNgEllFQ
 Lo5WOMQI8/uJq5h49GV8SzNtEhWCct0=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-r8-UemEKOfubXFtxp3Buqg-1; Wed, 25 Oct 2023 11:36:31 -0400
X-MC-Unique: r8-UemEKOfubXFtxp3Buqg-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-457eb7363f8so529286137.1
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 08:36:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698248191; x=1698852991;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2KnqNgXlC8PFpV/YpGvj+SCdq6EDTqI3w0FbEZZoGO8=;
 b=OFG5JGVp+YbZ0FQger+BgIBbPlEMlfida/ZKn/Rx6hjrE3hYepEZ5KkbIQZM8Yv5qk
 gSIk/ZN9aQPsc2PWiJAnfCi3eGNw3vl1uVMHk56JS0bQDu9/QIFZ6yIRPyURiQziAWhM
 /5co7LJp3GOOmp2m9+dLRQQwNp8czDI28rKbNina9cGV5GWjveWLLRU5PaKwS/CoP3e3
 VZxbyMRWY2W5xd8xdBcWg/Tf+GwhYShpmi9i4I+nslXAtKWqDFUwtPWYxhyohdiaijID
 pl3v2FKwcGdbmr9ZCqRfSpa9P4MbjFznyz9NVNKZnyCwIry25GzBFeDbAdu8FtJQh1Pj
 mFjQ==
X-Gm-Message-State: AOJu0YzzOGZZudXr1vIgYnqKDKcZRcOP9i34TB6lCL0eGJJwPDzvX1mh
 epZF7h0bk1u2y0nrwcyfDotbf3T6aJKWsKNiNWKI3W87GHZ9GnHj0OxZ+gsTkR+syXZg5Ucf8+n
 73QpTzzqVxhXtHEc=
X-Received: by 2002:a05:6122:491:b0:493:5938:c8a1 with SMTP id
 o17-20020a056122049100b004935938c8a1mr9127253vkn.0.1698248190694; 
 Wed, 25 Oct 2023 08:36:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgBAt07CYMMFFy8nij5awoipzj9dERvsdKTuqQEs0XZfwzTZv+hTfQPRbS+tBeuiYtZINpyA==
X-Received: by 2002:a05:6122:491:b0:493:5938:c8a1 with SMTP id
 o17-20020a056122049100b004935938c8a1mr9127238vkn.0.1698248190346; 
 Wed, 25 Oct 2023 08:36:30 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 u10-20020a05622a198a00b0041cb8947ed2sm4306338qtc.26.2023.10.25.08.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 08:36:29 -0700 (PDT)
Date: Wed, 25 Oct 2023 11:36:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 06/29] migration: Add auto-pause capability
Message-ID: <ZTk1++TzE+SiT3UH@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-7-farosas@suse.de>
 <ZTjWV9wQ5obKTpOG@redhat.com> <87y1fqerev.fsf@suse.de>
 <ZTkkICSD6j6Xf/KK@redhat.com> <ZTktCM/ccipYaJ80@x1n>
 <ZTkzY0nKtdeZJojP@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTkzY0nKtdeZJojP@redhat.com>
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

On Wed, Oct 25, 2023 at 04:25:23PM +0100, Daniel P. Berrangé wrote:
> > Libvirt will still use fixed-ram for live snapshot purpose, especially for
> > Windows?  Then auto-pause may still be useful to identify that from what
> > Fabiano wants to achieve here (which is in reality, non-live)?
> > 
> > IIRC of previous discussion that was the major point that libvirt can still
> > leverage fixed-ram for a live case - since Windows lacks efficient live
> > snapshot (background-snapshot feature).
> 
> Libvirt will use fixed-ram for all APIs it has that involve saving to
> disk, with CPUs both running and paused.

There are still two scenarios.  How should we identify them, then?  For
sure we can always make it live, but QEMU needs that information to make it
efficient for non-live.

Considering when there's no auto-pause, then Libvirt will still need to
know the scenario first then to decide whether pausing VM before migration
or do nothing, am I right?

If so, can Libvirt replace that "pause VM" operation with setting
auto-pause=on here?  Again, the benefit is QEMU can benefit from it.

I think when pausing Libvirt can still receive an event, then it can
cooperate with state changes?  Meanwhile auto-pause=on will be set by
Libvirt too, so Libvirt will even have that expectation that QMP migrate
later on will pause the VM.

> 
> > From that POV it sounds like auto-pause is a good knob for that.
> 
> From libvirt's POV auto-pause will create extra work for integration
> for no gain.

Yes, I agree for Libvirt there's no gain, as the gain is on QEMU's side.
Could you elaborate what is the complexity for Libvirt to support it?

Thanks,

-- 
Peter Xu


