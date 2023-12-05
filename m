Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 048E180602E
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 22:09:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAceJ-0000VG-3v; Tue, 05 Dec 2023 16:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAceG-0000Uf-Ct
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:08:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rAceD-0000Zo-N5
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 16:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701810484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QK6ICQx/yNSOAbUaOYxai25OzQbojeilSN0mZV88dOk=;
 b=SKlKbCrNoV73pwAnLmJ9FktTK4cQWccFrrB+YVrvnBPstnm3OhABEDQLzknsIXJ6t5gzKI
 Fe3hAURPUXWRVTfKihkk1KZjm7LCwbw+stXwl1iyG8lnrKl6w3hjtlKnPNAdoiMxKbB51K
 CDOiGDKHNzWwtYSZoSMST5TjHYIADZM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-187-3cg0_NMhPzW2nZqWU_TnVg-1; Tue, 05 Dec 2023 16:08:02 -0500
X-MC-Unique: 3cg0_NMhPzW2nZqWU_TnVg-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-67aa3df8795so9960966d6.1
 for <qemu-devel@nongnu.org>; Tue, 05 Dec 2023 13:08:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701810482; x=1702415282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QK6ICQx/yNSOAbUaOYxai25OzQbojeilSN0mZV88dOk=;
 b=TrWHWBRSa9kC1MEdofB43dOAyLJ1eSkjl1PV/lK692G75wFV7iniMnlCUxAebYCXNS
 rwFB4mbnsW1XjdeCeCrGJOlJrgwgc8lB26Z3OGTO33RLeQL7ryH9tDH3rIj0ip0RohvD
 9So6PvZ9EyCHqQzx6OUd3M0ZD4fOSUEoqvUC+f4tBnHLJjw2cGes+V5+lru2JGi/JHp6
 fOtmqfZDzWr5g5vO6CpjntW+NRg36G1TvC2fF2Lmhg19xBknq8IeTdWRrkK1XJ21gBUU
 2XXpI6Z89mwcYsVOTLZiDNw4JN5DE/IbCIqnWHEqfjWPkZstWm1aArrJhp5cvjZu8olX
 XIZQ==
X-Gm-Message-State: AOJu0YxTxv33rpmbaEMbT6MTJBAPiSIQLeBI1ADfCVYF9gr/j8jCAa+/
 ruaeulOrwkpP+JotPd9oBK41gf9WdddFZK4To+SewGBDDhxKs11ylKT/J0jeXVmWyc5+pRmdr5z
 mYdxhYVL31HtiPw0=
X-Received: by 2002:a05:6214:94b:b0:67a:94bd:f7ee with SMTP id
 dn11-20020a056214094b00b0067a94bdf7eemr14028831qvb.2.1701810482216; 
 Tue, 05 Dec 2023 13:08:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERTxbxcQzdIDJfmX3zC5cvuOtAAJTpChU9mLO6uJnx9IV7M/r0WxHbonr3/w5dBKRy4nTcTg==
X-Received: by 2002:a05:6214:94b:b0:67a:94bd:f7ee with SMTP id
 dn11-20020a056214094b00b0067a94bdf7eemr14028815qvb.2.1701810481925; 
 Tue, 05 Dec 2023 13:08:01 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 c9-20020a0ce7c9000000b0067a97f6b0c6sm4557586qvo.32.2023.12.05.13.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Dec 2023 13:08:01 -0800 (PST)
Date: Tue, 5 Dec 2023 16:07:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V6 11/14] tests/qtest: precopy migration with suspend
Message-ID: <ZW-RL-vmz6a0uTyF@x1n>
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-12-git-send-email-steven.sistare@oracle.com>
 <ZW47TYtPP5uLNKsa@x1n>
 <22e3574f-9fb7-48a6-b5d3-0a016a93a804@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <22e3574f-9fb7-48a6-b5d3-0a016a93a804@oracle.com>
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

On Tue, Dec 05, 2023 at 11:14:43AM -0500, Steven Sistare wrote:
> Calling migrate_wait_for_dirty_mem proves that a source write is propagated
> to the dest, even for the suspended case.  We fully expect that, but a good 
> test verifies our expectations.  That is done in the first loop of 
> migrate_wait_for_dirty_mem.  After that, we must check for the suspended 
> state, because the second loop will not terminate.  Here is a more explicit
> version:
> 
> static void migrate_wait_for_dirty_mem(QTestState *from,
>                                        QTestState *to)
> {
>     uint64_t watch_address = start_address + MAGIC_OFFSET_BASE;
>     uint64_t marker_address = start_address + MAGIC_OFFSET;
>     uint8_t watch_byte;
> 
>     /*
>      * Wait for the MAGIC_MARKER to get transferred, as an
>      * indicator that a migration pass has made some known
>      * amount of progress.
>      */
>     do {
>         usleep(1000 * 10);
>     } while (qtest_readq(to, marker_address) != MAGIC_MARKER);
> 
> +    /* If suspended, src only iterates once, and watch_byte may never change */
> +    if (src_state.suspend_me) {
> +        return;
> +    }

Ok.

> Yes, it played that role.  I will delete all the existing calls to wait_for_suspended,
> and add them after wait_for_serial("src_serial") in test_precopy_common and
> migrate_postcopy_prepare.

Sounds good.

-- 
Peter Xu


