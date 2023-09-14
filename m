Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 302807A11BC
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 01:29:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgvke-0008Vd-A4; Thu, 14 Sep 2023 19:28:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgvkc-0008VL-1B
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 19:27:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgvka-0006KZ-Aw
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 19:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694734074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PRIJfVHditiBs/YWXVQcwA3mBfGF2V7GfxcNILAyETE=;
 b=fURtBTr/byuR8xGuaDb0z9SVPg7cxNTGWltX8fDuO3q3Jv84OqmXPQTElAuSN7/yxbcfh+
 YC2OFmpdwysZMqu2HMRRVkhrLSimIvgbghiIV1JeQXamZTwiYiIcUPK6obxMSVl34+d9VV
 K6SRlW6Ic998nPPARH9+bF3p/++3i3o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-XkP2gMszPSKM2qXRGFr_ww-1; Thu, 14 Sep 2023 19:27:52 -0400
X-MC-Unique: XkP2gMszPSKM2qXRGFr_ww-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76efdcb7be4so33714685a.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 16:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694734072; x=1695338872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRIJfVHditiBs/YWXVQcwA3mBfGF2V7GfxcNILAyETE=;
 b=eGCTaYPRT/86he44dcXP9JuPDZrTa7XQXj8A206VGWuWsFOGcHUM5cU/yFbtkTqKyb
 oV5c9s0XMMflIRiXZMzIFCJ6d6dc38MUanU9V31lkrhliUdK6u2zDNMGgCzhjLL9BuT4
 0Uf4D6vuhKX7jLlWs6GwUvimMClALrMgyv8cPdFIY39SMlQF5KfkGhg7wDKOuke0XDkN
 tzNeIKF/HKyJk4tQYH+Cnr6I8MbIdQbUMioKx2yjVPHg/h2LhsQ3fB5Kd6ZXBLz45+MY
 fJ1xyu4juQBcFOn9BuDa9yjKn+IVUO6gHtCtT12r0OcpjekOJ6bo2PzFujow0Oc8u8Kv
 a2OQ==
X-Gm-Message-State: AOJu0Yyu+f9WQ68CnBlflyiKvahEhbsQ1OQm+78lyiiEX4nJ2It6PU6B
 hENjMSEia/ZHWd0lKtww3KL4r7uafXRxEPb3/4aIUkMfh/1jOPQfLKq+XW3c0TstAehAvMR6W+R
 THN9lp2+jM39GcYc=
X-Received: by 2002:a05:620a:2485:b0:76d:1339:e871 with SMTP id
 i5-20020a05620a248500b0076d1339e871mr7046794qkn.5.1694734072349; 
 Thu, 14 Sep 2023 16:27:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6tZC7M9RIcVatKr5Q3HvM+9NUIGdlnWbQJ9wrKLmNsP22jJNqVaphFyB3+7A0f+oIHOsmMg==
X-Received: by 2002:a05:620a:2485:b0:76d:1339:e871 with SMTP id
 i5-20020a05620a248500b0076d1339e871mr7046782qkn.5.1694734072024; 
 Thu, 14 Sep 2023 16:27:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ou19-20020a05620a621300b0076cf49bcb50sm828342qkn.37.2023.09.14.16.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 16:27:51 -0700 (PDT)
Date: Thu, 14 Sep 2023 19:27:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
Message-ID: <ZQOW4BS1ZcDTN7tK@x1n>
References: <20230913192301.GA917052@fedora> <87r0n1kggo.fsf@suse.de>
 <ZQMfIO3oiqTsawtU@x1n> <87edj0kcz7.fsf@suse.de>
 <ZQMoUzRH1BZKs39g@x1n> <87bke4kasr.fsf@suse.de>
 <ZQM3SV4eqSltoQSe@x1n> <87led8e9vv.fsf@suse.de>
 <87r0n0nz6u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0n0nz6u.fsf@suse.de>
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

On Thu, Sep 14, 2023 at 07:54:17PM -0300, Fabiano Rosas wrote:
> Fabiano Rosas <farosas@suse.de> writes:
> 
> > Peter Xu <peterx@redhat.com> writes:
> >
> >> On Thu, Sep 14, 2023 at 12:57:08PM -0300, Fabiano Rosas wrote:
> >>> I managed to reproduce it. It's not the return path error. In hindsight
> >>> that's obvious because that error happens in the 'recovery' test and this
> >>> one in the 'plain' one. Sorry about the noise.
> >>
> >> No worry.  It's good to finally identify that.
> >>
> >>> 
> >>> This one reproduced with just 4 iterations of preempt/plain. I'll
> >>> investigate.
> >
> > It seems that we're getting a tcp disconnect (ECONNRESET) on when doing
> > that shutdown() on postcopy_qemufile_src. The one from commit 6621883f93
> > ("migration: Fix potential race on postcopy_qemufile_src").
> >
> > I'm trying to determine why that happens when other times it just
> > returns 0 as expected.
> >
> > Could this mean that we're kicking the dest too soon while it is still
> > receiving valid data?
> 
> Looking a bit more into this, what's happening is that
> postcopy_ram_incoming_cleanup() is shutting the postcopy_qemufile_dst
> while ram_load_postcopy() is still running.
> 
> The postcopy_ram_listen_thread() function waits for the
> main_thread_load_event, but that only works when not using preempt. With
> the preempt thread, the event is set right away and we proceed to do the
> cleanup without waiting.
> 
> So the assumption of commit 6621883f93 that the incoming side knows when
> it has finished migrating is wrong IMO. Without the EOS we're relying on
> the chance that the shutdown() happens after the last recvmsg has
> returned and not during it.
> 
> Peter, what do you think?

That's a good point.

One thing to verify that (sorry, I still cannot reproduce it myself, which
is so weirdly... it seems loads won't really help reproducing this) is to
let the main thread wait for all requested pages to arrive:

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 29aea9456d..df055c51ea 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -597,6 +597,12 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     trace_postcopy_ram_incoming_cleanup_entry();
 
     if (mis->preempt_thread_status == PREEMPT_THREAD_CREATED) {
+        /*
+         * NOTE!  it's possible that the preempt thread is still handling
+         * the last pages to arrive which were requested by faults.  Making
+         * sure nothing is left behind.
+         */
+        while (qatomic_read(&mis->page_requested_count));
         /* Notify the fast load thread to quit */
         mis->preempt_thread_status = PREEMPT_THREAD_QUIT;
         if (mis->postcopy_qemufile_dst) {

If that can work solidly, we can figure out a better way than a dead loop
here.

Thanks,

-- 
Peter Xu


