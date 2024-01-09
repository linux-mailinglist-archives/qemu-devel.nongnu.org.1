Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE528827D96
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 04:53:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN39s-0004XQ-W8; Mon, 08 Jan 2024 22:52:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN39r-0004XE-Ml
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 22:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rN39p-0006mO-Hb
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 22:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704772324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UiYH74U3nqfqV028eKWgM0m3xQ56k+Byf8CorbaMnEo=;
 b=TZHIagV2e+bOkgXDpx9xiyHAxgW1fo5F2uMWvqiSJkPv1pjB52mGQtzceSnVdAB+nl6z4T
 mu4sqY7OLLqgL0xsGRLmBDDFigXPrATCh97GZdbv8wdetc/d9EajG9/S/LzMx5qoQr4KJC
 MpTt7SGX+70sCvjPWh2OMw7yQYq5Bl8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-3kIKbqEiN-61ICrTRAni-Q-1; Mon, 08 Jan 2024 22:52:01 -0500
X-MC-Unique: 3kIKbqEiN-61ICrTRAni-Q-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28bea0ff98cso564492a91.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 19:52:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704772319; x=1705377119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiYH74U3nqfqV028eKWgM0m3xQ56k+Byf8CorbaMnEo=;
 b=SGgtc4O0gIsvkI8GZu2tdWt9AUf6AdpL2mUJNrrRQ5ol4ozw+viyOR5UtnOcqakWmb
 4PcDYJbwdVzjwBjkxQSjUWfxlAwSIVP8hNist9SbJSgT/RAkt6Uj59u0BazjR9gWALhj
 m9LW8Uf0N7QknAjfSNJabOuv8dAfPoKEvN6B8eO137kmVIdXmrhMO8lyeCs42QG2Y0Va
 hrKkJ6kebQSNVximBZJxroWQU80BaHRCR7EkJ6efBG4VEISJiUtYZX6RFpHF7iSbkGCI
 xgMQ9wfgYa0kpC4pyKGXtSCc1YGsjAdotIJM0thvAFK1wfQ64uBBuTDXnRKeA9/ZKmYj
 XCuw==
X-Gm-Message-State: AOJu0YyWKQa0KZJKhRDlKh5ptBmaXzlRljplXKjKR0+QUfGu9sAeD1IG
 j6ac+uGpw2rKmJpGQe+tUchMl1Lr+jM3nicQlUaXKD1NxGGtpAaY0oBa3JeQVh48ZgLOSIsPTi7
 0AxtF1fjbzSWb1k1ii2nc+jM=
X-Received: by 2002:a05:6a21:2706:b0:196:4d6a:ce0b with SMTP id
 rm6-20020a056a21270600b001964d6ace0bmr8625072pzb.5.1704772319482; 
 Mon, 08 Jan 2024 19:51:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF02yQQIo56XoLkn7hr45DKJWvocz2W+DNUXyiH+dYPDrtee4ss7YIlJFoaeo1yDD60gyd6Vw==
X-Received: by 2002:a05:6a21:2706:b0:196:4d6a:ce0b with SMTP id
 rm6-20020a056a21270600b001964d6ace0bmr8625056pzb.5.1704772319047; 
 Mon, 08 Jan 2024 19:51:59 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 h15-20020a056a00000f00b006da13bc46c0sm622132pfk.171.2024.01.08.19.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 19:51:58 -0800 (PST)
Date: Tue, 9 Jan 2024 11:51:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] [NOT FOR MERGE] tests/qtest/migration: Adapt
 tests to use older QEMUs
Message-ID: <ZZzC1n0GotQZukqJ@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-5-farosas@suse.de> <ZZuvDREDrQ07HsGs@x1n>
 <877ckj3kfp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877ckj3kfp.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jan 08, 2024 at 12:37:46PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Fri, Jan 05, 2024 at 03:04:49PM -0300, Fabiano Rosas wrote:
> >> [This patch is not necessary anymore after 8.2 has been released]
> >> 
> >> Add the 'since' annotations to recently added tests and adapt the
> >> postcopy test to use the older "uri" API when needed.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > You marked this as not-for-merge.  Would something like this still be
> > useful in the future?  IIUC it's a matter of whether we'd still want to
> > test those old binaries.
> >
> 
> Technically yes, but I fail to see what benefit testing old binaries
> would bring us. I'm thinking maybe it could be useful for bisecting
> compatibility issues, but I can't think of a scenario where we'd like to
> change the older QEMU instead of the newer.
> 
> I'm of course open to suggestions if you or anyone else has an use case
> that you'd like to keep viable.
> 
> So far, my idea is that once a new QEMU is released, all the "since:"
> annotations become obsolete. We could even remove them. This series is
> just infrastructure to make our life easier if a change is ever
> introduced that is incompatible with the n-1 QEMU. IMO we cannot have
> compatibility testing if a random change might break a test and make it
> more difficult to run the remaining tests. So we'd use 'since' or the
> vercmp function to skip/adapt the offending tests until the next QEMU is
> released.
> 
> I'm basing myself on this loosely worded support statement from our
> docs:
> 
>   "In general QEMU tries to maintain forward migration compatibility
>   (i.e. migrating from QEMU n->n+1) and there are users who benefit from
>   backward compatibility as well."

I think we could still have users migrating from e.g. 8.0 -> 9.0 as long as
with the same machine type, especially when upgrading upper level stack
(e.g. an openstack cluster upgrade), where IIUC can jump a few qemu major
versions.  That does sound like a common use case, and I suspect the doc
was only taking one example on why compatibility needs to be maintained,
rather than emphasizing "+1 only".

However then the question is whether those old binaries needs to be
convered.

Then I noticed that taking all these "since: XXX" and cmdline changes along
with migration-test may be yet another burden even if we want to cover old
binaries for whatever reason.  I am now more convinced myself that we
should try to get rid of as much burden as we can for migration, because we
already have enough, and it's not ideal to keep growing that unnecessarily.

One good thing with CI in this case (I still don't have enough knowledge on
CI, so I am hoping some CI people can review that patch, though) is that if
we can always guarantee n-1 -> n works for the test cases we enabled, it
most probably means when n boosts again to n+1, we keep making sure n ->
n+1 works perfectly, then n-1 -> n+1 should not fail either, considering
that we're testing the stream protocol matching each other.  There might be
outliers (especially if not described with VMSDs) but should be corner
cases.

So I tend to agree with you on that we drop this patch, keep it simple
until we're much more clear what we can get from that.

But then if so - do we need "since" at all to be expressed in versions?

Basically we keep qtest always be valid only on the latest qemu binary as
before (which actually works the same as Linux v.s. kselftests, which makes
sense), there's one exception now with "n-1" due to the CI we plan to add.
Dropping this patch means we don't yet plan to support n-2.  Then maybe
instead of a "since" we only need a boolean showing "whether one test needs
to be covered by a cross-binary test"?  Then we set it in incompatible
binaries (skip all cross-binary tests directly, rather than relying on any
qemu versions, no compare needed), and can also drop that when a new
release starts.

Thanks,

-- 
Peter Xu


