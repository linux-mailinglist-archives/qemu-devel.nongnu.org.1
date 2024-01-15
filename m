Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D17782D57D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:04:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPIsf-0003NN-5F; Mon, 15 Jan 2024 04:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rPIsV-0003KO-TW
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:03:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rPIsS-0001Yt-63
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705309407;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4koAEleevpUGFVp/2Jv6lDpz+nh8S/6yFRtb9MGYyRA=;
 b=VaUwHFNsb7raY8/vUfVMnFjp+8sfvCHVvSlCY9AD3zCwlpXwyXD+DWkmCBSeFnPJLbgyFD
 NdGcJVyjl1XcEpZb5OdvBM7fpGrYGXCaWfCJ0d12Cmtk0wWiho7TwK4pV35eNpN4RsPQFw
 MJQeBJIZbZZti8aglzO0aOfIbVtNce0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-rxfS8cm8MfGA0fIwtdad2w-1; Mon, 15 Jan 2024 04:03:23 -0500
X-MC-Unique: rxfS8cm8MfGA0fIwtdad2w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8741585A58F;
 Mon, 15 Jan 2024 09:03:23 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 849E73C25;
 Mon, 15 Jan 2024 09:03:22 +0000 (UTC)
Date: Mon, 15 Jan 2024 09:03:20 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 04/30] io: fsync before closing a file channel
Message-ID: <ZaT02OxpzC973cNm@redhat.com>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-5-farosas@suse.de> <ZZ-qbom2UqEX0uS7@x1n>
 <87wmsfn1xx.fsf@suse.de> <ZaTzhhOqESTH42Jd@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaTzhhOqESTH42Jd@x1n>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Jan 15, 2024 at 04:57:42PM +0800, Peter Xu wrote:
> On Thu, Jan 11, 2024 at 03:46:02PM -0300, Fabiano Rosas wrote:
> > > (2) Why metadata doesn't matter (v.s. fsync(), when CONFIG_FDATASYNC=y)?
> > 
> > Syncing the inode information is not critical, it's mostly timestamp
> > information (man inode). And fdatasync makes sure to sync any metadata
> > that would be relevant for the retrieval of the data.
> 
> I forgot to reply to this one in the previous reply..
> 
> Timestamps look all fine to be old.  What about file size?  That's also in
> "man inode" as metadata, but I'm not sure whether data will be fully valid
> if e.g. size enlarged but not flushed along with the page caches.

If the size wasn't updated, then syncing of the data would be pointless.
The man page confirms that size is synced:

[quote]
       fdatasync() is similar to fsync(), but does not flush modified metadata
       unless  that metadata is needed in order to allow a subsequent data re‐
       trieval to be correctly handled.  For example, changes to  st_atime  or
       st_mtime  (respectively, time of last access and time of last modifica‐
       tion; see inode(7)) do not require flushing because they are not neces‐
       sary for a subsequent data read to be handled correctly.  On the  other
       hand, a change to the file size (st_size, as made by say ftruncate(2)),
       would require a metadata flush.
[/quote]

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


