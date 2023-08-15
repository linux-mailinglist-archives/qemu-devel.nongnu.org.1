Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C480777D652
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:42:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2kE-0005H1-De; Tue, 15 Aug 2023 18:42:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qW2kD-0005Go-3P
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:42:33 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qW2kA-0007Cx-OP
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:42:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7B491F8C1;
 Tue, 15 Aug 2023 22:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692139347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGKFnjw+iNrgpGnYQAPT8KXAu6D1syDfG3efzbzeV3o=;
 b=iUmk1x0n9RRBcM8fApG+ZGyMT2qsDNK2z8kFOK91X41qQikCzrcDYseHvt7CR0ovvIE98b
 8BDuzGgr1OagRf9F4LhUMY+O+Eik3PiUzq5Z7Idvx6O03lVRa8whb7x753BDlvs3fM59wj
 xkU8+TMY77XePZk/jBUlCawETJ3yHcg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692139347;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lGKFnjw+iNrgpGnYQAPT8KXAu6D1syDfG3efzbzeV3o=;
 b=efGpKwLBjvJpUoQ7GaT6dfmzAxNdIfj5tdAjHjzj6Ue+G3hJTONKf1aElG29iU0bgUKT/p
 030INfnRicIuqABg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A4E41353E;
 Tue, 15 Aug 2023 22:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o0GdAVP/22TuMgAAMHmgww
 (envelope-from <farosas@suse.de>); Tue, 15 Aug 2023 22:42:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Guoyi Tu <tugy@chinatelecom.cn>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return
 if qemu file got error
In-Reply-To: <ZNv6ABLk7EjaX8dD@x1n>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
 <87h6p0mqk8.fsf@suse.de> <ZNv6ABLk7EjaX8dD@x1n>
Date: Tue, 15 Aug 2023 19:42:24 -0300
Message-ID: <87350klygf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Aug 15, 2023 at 09:35:19AM -0300, Fabiano Rosas wrote:
>> Guoyi Tu <tugy@chinatelecom.cn> writes:
>> 
>> > When the migration process of a virtual machine using huge pages is 
>> > cancelled,
>> > QEMU will continue to complete the processing of the current huge page
>> > through the qemu file object got an error set. These processing, such as
>> > compression and encryption, will consume a lot of CPU resources which may
>> > affact the the performance of the other VMs.
>> >
>> > To terminate the migration process more quickly and minimize unnecessary
>> > resource occupancy, it's neccessary to add logic to check the error status
>> > of qemu file object in the beginning of ram_save_target_page_legacy 
>> > function,
>> > and make sure the function returns immediately if qemu file got an error.
>> >
>> > Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
>> > ---
>> >   migration/ram.c | 4 ++++
>> >   1 file changed, 4 insertions(+)
>> >
>> > diff --git a/migration/ram.c b/migration/ram.c
>> > index 9040d66e61..3e2ebf3004 100644
>> > --- a/migration/ram.c
>> > +++ b/migration/ram.c
>> > @@ -2133,6 +2133,10 @@ static int ram_save_target_page_legacy(RAMState 
>> > *rs, PageSearchStatus *pss)
>> >       ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
>> >       int res;
>> >
>> > +    if (qemu_file_get_error(pss->pss_channel)) {
>> > +        return -1;
>> > +    }
>> 
>> Where was the error set? Is this from cancelling via QMP? Or something
>> from within ram_save_target_page_legacy? We should probably make the
>> check closer to where the error happens. At the very least moving the
>> check into the loop.
>
> Fabiano - I think it's in the loop (of all target pages within a same host
> page), and IIUC Guoyi mentioned it's part of cancelling.

Yep, I see that. I meant explicitly move the code into the loop. Feels a
bit weird to check the QEMUFile for errors first thing inside the
function when nothing around it should have touched the QEMUFile.

About cancelling, QMP is not the only way to cancel. I was trying to
probe whether the cancelling itself is what causes the perceived issue
or if something else went wrong that caused the migration code to cancel
itself. We might be missing an error check somewhere else.

