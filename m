Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6AB79DD36
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 02:40:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgDtn-0004Kl-KD; Tue, 12 Sep 2023 20:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgDtj-0004DO-Mr
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 20:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgDte-0002P7-HF
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 20:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694565500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ljl7rMJ/mgITEWn0AaaCaoVjpcvaXvw8X5zvqFvLq0E=;
 b=ciGfX+11CNlMCDls8PyHL4vGi/LetRzD0bzgvLh3NfVqxjDeKxdKjWULH7hMeFNiFrsm45
 vdaUNzr4QhlRGbfNP6Y9W+nRBK++siFrr0Ttj1F9LNsTSwCLd8Tu/T/kmUh8MIUnRX30r4
 Os+r7pXlwiKDThoVa8vA3j3N4uLL7QU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-5S7JRnXpPhKloBOBd9qW4w-1; Tue, 12 Sep 2023 20:38:19 -0400
X-MC-Unique: 5S7JRnXpPhKloBOBd9qW4w-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-64726969c8bso12999236d6.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 17:38:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694565498; x=1695170298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ljl7rMJ/mgITEWn0AaaCaoVjpcvaXvw8X5zvqFvLq0E=;
 b=c9dZ+k7I3JJeC8vE1/MqM/cQyZk6488/kzoU86n/gFoiEDPuLv1p6JuDiJ7+QupqUW
 J6ptWLSqjbfLEcKcT/r/KekZa1IWgJQ3lC2q8TmzGnUbcR9jU9y8PEryyfr5wX22WLHR
 25KGiWdjhFgo3EKipSa3v+4Xv1P7GD2NvTa3k79bse5/SahUB5pNUIwBhqhapPc/4Yl9
 /2Ebo6v6GWm1vOxoEMGxzdHGR/OnQCesQ7cSKf4jioXX+nLphXnwLeVVsRXrih59Pote
 KtGo89RzCvDSQ34PHOF2faHQBP4dLp09NoViYudVjRERiZIAH9Vvs0Z8ooLeQu6MSlM2
 N/+w==
X-Gm-Message-State: AOJu0YyNFG6HunnT2NMAkzvDqDFptpKG8Gw7YfOiXJb8VoSS845bu+AO
 VwUncWKBcD45EhZb0D5jLc+qET/JUga3+U0VTyqPUh620FAClLoXI5XrZEUYPAfKGAXiGN2ehnW
 qofYHRCYlo4u2FBQ=
X-Received: by 2002:a05:6214:20ee:b0:63c:f852:aa30 with SMTP id
 14-20020a05621420ee00b0063cf852aa30mr1242022qvk.0.1694565498703; 
 Tue, 12 Sep 2023 17:38:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/49S2KqrRuxI4XTOl1QwXdEczBMWcMqpCV+S4KIEjIpDvBc46f/6/nuHg2FdoANCrCtsHSA==
X-Received: by 2002:a05:6214:20ee:b0:63c:f852:aa30 with SMTP id
 14-20020a05621420ee00b0063cf852aa30mr1242010qvk.0.1694565498359; 
 Tue, 12 Sep 2023 17:38:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 q6-20020a0ce206000000b00631ecb1052esm4067234qvl.74.2023.09.12.17.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 17:38:17 -0700 (PDT)
Date: Tue, 12 Sep 2023 20:38:15 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Xiaohui Li <xiaohli@redhat.com>
Subject: Re: [PATCH 9/9] migration/postcopy: Allow network to fail even
 during recovery
Message-ID: <ZQEEd/W+mxpow80k@x1n>
References: <20230829214235.69309-1-peterx@redhat.com>
 <20230829214235.69309-10-peterx@redhat.com>
 <877cowmdu0.fsf@suse.de> <ZQDEh85X2IcC+o8M@x1n>
 <87a5trknwe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a5trknwe.fsf@suse.de>
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

On Tue, Sep 12, 2023 at 07:49:37PM -0300, Fabiano Rosas wrote:
> I figured what is going on here (test #1). At postcopy_pause_incoming()
> the state transition is ACTIVE -> PAUSED, but when the first recovery
> fails on the incoming side, the transition would have to be RECOVER ->
> PAUSED.
> 
> Could you add that change to this patch?

Yes, and actually, see:

https://lore.kernel.org/qemu-devel/20230912222145.731099-11-peterx@redhat.com/

> > -bool migration_postcopy_is_alive(void)
> > +bool migration_postcopy_is_alive(int state)
> >  {
> >      MigrationState *s = migrate_get_current();
> >  
> 
> Note there's a missing hunk here to actually use the 'state'.

Yes.. I fixed it in the version I just posted, here:

https://lore.kernel.org/qemu-devel/20230912222145.731099-10-peterx@redhat.com/

+bool migration_postcopy_is_alive(int state)
+{
+    switch (state) {
+    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
+        return true;
+    default:
+        return false;
+    }
+}

[...]

> >> Here, with this patch the migration gets stuck unless we call
> >> migrate_pause() one more time. After another round of migrate_pause +
> >> recover, it finishes properly.
> 
> Here (test #2), the issue is that the sockets are unpaired, so there's
> no G_IO_IN to trigger the qio_channel watch callback. The incoming side
> never calls fd_accept_incoming_migration() and the RP hangs waiting for
> something. I think there's no other way to unblock aside from the
> explicit qmp_migrate_pause().

Exactly, that's the "trick" I mentioned. :)

Sorry when replying just now I seem to have jumped over some sections.
See:

https://lore.kernel.org/qemu-devel/20230912222145.731099-12-peterx@redhat.com/

I put a rich comment for that:

+    /*
+     * Write the 1st byte as QEMU_VM_COMMAND (0x8) for the dest socket, to
+     * emulate the 1st byte of a real recovery, but stops from there to
+     * keep dest QEMU in RECOVER.  This is needed so that we can kick off
+     * the recover process on dest QEMU (by triggering the G_IO_IN event).
+     *
+     * NOTE: this trick is not needed on src QEMUs, because src doesn't
+     * rely on an pre-existing G_IO_IN event, so it will always trigger the
+     * upcoming recovery anyway even if it can read nothing.
+     */
+#define QEMU_VM_COMMAND              0x08
+    c = QEMU_VM_COMMAND;
+    ret = send(pair2[1], &c, 1, 0);
+    g_assert_cmpint(ret, ==, 1);

> We could give them both separate files and the result would be more
> predictable.

Please have a look at the test patch I posted (note!  it's still under your
name but I changed it quite a lot with my sign-off).  I used your 2nd
method to create socket pairs, and hopefully that provides very reliable
way to put both src/dst sides into RECOVER state, then kick it out of it
using qmp migrate-pause on both sides.

> You can take it. Or drop it if it ends being too artificial.

I like your suggestion on having the test case, and I hope the new version
in above link I posted isn't so artificial; the only part I don't like
about that was the "write 1 byte" trick for dest qemu, but that seems still
okay.  Feel free to go and have a look.

Thanks a lot,

-- 
Peter Xu


