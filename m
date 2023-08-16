Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D4F77E4D9
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:15:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWIEu-00088o-A1; Wed, 16 Aug 2023 11:15:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWIEr-00088e-Ot
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:15:14 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qWIEp-0006oB-Fa
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:15:13 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B929D21904;
 Wed, 16 Aug 2023 15:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692198909; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1HuRkH8/ZmYHZach2Ph7adLUSBylN3Is2Lnabca8CEA=;
 b=N4KRnfgHWTc6e/xSj/sxV2ySSJqj1h49TbBqgV9fMZevrnxmaP+GVCjMgoAOspXTezR0yq
 osP89Ym9Xx2WYL3hpos4CaUNrINDQR6XsA2svLCogsfWGzdzQlIdAKj8/GvZF56ruc1Nvi
 CjSfmijUSimUqYshfD5ThFexeuYABUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692198909;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1HuRkH8/ZmYHZach2Ph7adLUSBylN3Is2Lnabca8CEA=;
 b=B9Z7m6zElIjeKBYc9glkSscwwiy+EUo+9BGM5tofu77FD4rs0iQ68/ihMxBg7cY+fra+5f
 CsUtdabmw0q0nYCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4AD121353E;
 Wed, 16 Aug 2023 15:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iqntBf3n3GRhEwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 16 Aug 2023 15:15:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Guoyi Tu <tugy@chinatelecom.cn>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return
 if qemu file got error
In-Reply-To: <ZNzhuF7fRUdaGthV@x1n>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
 <87h6p0mqk8.fsf@suse.de> <ZNv6ABLk7EjaX8dD@x1n> <87350klygf.fsf@suse.de>
 <ZNzhuF7fRUdaGthV@x1n>
Date: Wed, 16 Aug 2023 12:15:06 -0300
Message-ID: <87o7j7kohx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Tue, Aug 15, 2023 at 07:42:24PM -0300, Fabiano Rosas wrote:
>> Yep, I see that. I meant explicitly move the code into the loop. Feels a
>> bit weird to check the QEMUFile for errors first thing inside the
>> function when nothing around it should have touched the QEMUFile.
>
> Valid point.  This reminded me that now we have one indirection into
> ->ram_save_target_page() which is a hook now.  Putting in the caller will
> work for all hooks, even though they're not yet exist.
>
> But since we don't have any other hooks yet, it'll be the same for now.
>
> Acked-by: Peter Xu <peterx@redhat.com>
>
> For the long term: there's one more reason to rework qemu_put_byte()/... to
> return error codes.. Then things like save_normal_page() can simply already
> return negatives when hit an error.
>
> Fabiano - I see that you've done quite a few patches in reworking migration
> code.  I had that for a long time in my todo, but if you're interested feel
> free to look into it.
>
> IIUC the idea is introducing another similar layer of API for qemufile (I'd
> call it qemu_put_1|2|4|8(), or anything you can come up better with..) then
> let migration to switch over to it, with retval reflecting errors.  Then we
> should be able to drop this patch along with most of the explicit error
> checks for the qemufile spread all over.

I was just ranting about this situation in another thread! Yes, we need
something like that. QEMUFile errors should only be set by code doing
actual IO and if we want to store the error for other parts of the code
to use, that should be another interface.

While reviewing this patch I noticed we have stuff like this:

pages = ram_find_and_save_block()
...
if (pages < 0) {
    qemu_file_set_error(f, pages);
    break;
}

So the low-level code sets the error, ram_save_target_page_legacy() sees
it and returns -1, and this^ code loses all track of the initial error
and inadvertently turns it into -EPERM!

I'll try to find some time to start cleaning this up.

