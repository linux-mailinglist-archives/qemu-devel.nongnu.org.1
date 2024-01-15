Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D66F82D606
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 10:32:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPJK9-0001s7-8h; Mon, 15 Jan 2024 04:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPJK0-0001rg-BH
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:31:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPJJy-0007Kz-Pv
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 04:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705311113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=klRY3qmzMI9lfKgVg+XkE+P9xHyXLm+yTnqmXo63QVM=;
 b=YXGc2SSnk89BFG49oFpy26N1e/n1EomxYS96/s97uqctof4HYO4ake5bAEAXw+dxu1T6oF
 +g6VmBolM1XYE21L92F1Cgbgai/RBC8zOssPTpHL3a3pfRKPS7lNfcizfnP5XSKJPZdabM
 H2nalhkSks9dg3LW/vEUCOT9cCxI6H8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-3EmhoCneNh6XZAAx6yqwMA-1; Mon, 15 Jan 2024 04:31:51 -0500
X-MC-Unique: 3EmhoCneNh6XZAAx6yqwMA-1
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-6da4d130a82so2242928b3a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 01:31:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705311110; x=1705915910;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=klRY3qmzMI9lfKgVg+XkE+P9xHyXLm+yTnqmXo63QVM=;
 b=FAI3+b2h5/WBZlLZBZSB6iaXfc0SEj1ZCZQXscSRLZJJfQ17syviGRBl66LdVvhGnX
 3DZCKGLn1TZLaPvztjpAIs/3/RiglDQNHwcfLehc/bgvdyguwomlOzg4aJq8SuvTMo+9
 fXfARZ68D5yu7M883yk87dzI70PnXBFTUkVEyHu7GXipTNk2ZDv3bxgPL9/0udwLJVXQ
 9Oiuz8SDvxxzaeK/uUC51qq5tgCjTX1bCYF5UQ/CXS3xJKNT8FvNotFvOlGbkY/WvTly
 WVEsjJPO6bkR2FUFoZ4CC6+j6tnTXwxOR3Gvs/e99b9mM1LaZ3tbltW8UP539L2JE4Y7
 EcQA==
X-Gm-Message-State: AOJu0YyqZHS4pOukzkDi9IwO1aa3VQCAb0UjKOiyiH4VAxQ82wxFWF8X
 9geCjcQWsLBkfUwxtBl7JKvreP1gNlz2U6rbM8/N6xz13d19i9RJmZzuhq3P+hn+Wssz6fCOQ5m
 1fFcANJ+8qtekt2ejxfNldYI=
X-Received: by 2002:a05:6a21:3942:b0:19a:bffa:f28b with SMTP id
 ac2-20020a056a21394200b0019abffaf28bmr8093268pzc.2.1705311110625; 
 Mon, 15 Jan 2024 01:31:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFpSTsgHJAomCx+lTb+e/awo0oYaGUrx6Erw9TA31/+TwbG4cZoBYUe09ss5fbDZK1oOK0iOw==
X-Received: by 2002:a05:6a21:3942:b0:19a:bffa:f28b with SMTP id
 ac2-20020a056a21394200b0019abffaf28bmr8093251pzc.2.1705311110330; 
 Mon, 15 Jan 2024 01:31:50 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 db11-20020a17090ad64b00b00286da7407f2sm11671189pjb.7.2024.01.15.01.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 01:31:49 -0800 (PST)
Date: Mon, 15 Jan 2024 17:31:41 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 04/30] io: fsync before closing a file channel
Message-ID: <ZaT7fTF7sonZZtG4@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-5-farosas@suse.de> <ZZ-qbom2UqEX0uS7@x1n>
 <87wmsfn1xx.fsf@suse.de> <ZaTzhhOqESTH42Jd@x1n>
 <ZaT02OxpzC973cNm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaT02OxpzC973cNm@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
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

On Mon, Jan 15, 2024 at 09:03:20AM +0000, Daniel P. Berrangé wrote:
> On Mon, Jan 15, 2024 at 04:57:42PM +0800, Peter Xu wrote:
> > On Thu, Jan 11, 2024 at 03:46:02PM -0300, Fabiano Rosas wrote:
> > > > (2) Why metadata doesn't matter (v.s. fsync(), when CONFIG_FDATASYNC=y)?
> > > 
> > > Syncing the inode information is not critical, it's mostly timestamp
> > > information (man inode). And fdatasync makes sure to sync any metadata
> > > that would be relevant for the retrieval of the data.
> > 
> > I forgot to reply to this one in the previous reply..
> > 
> > Timestamps look all fine to be old.  What about file size?  That's also in
> > "man inode" as metadata, but I'm not sure whether data will be fully valid
> > if e.g. size enlarged but not flushed along with the page caches.
> 
> If the size wasn't updated, then syncing of the data would be pointless.
> The man page confirms that size is synced:
> 
> [quote]
>        fdatasync() is similar to fsync(), but does not flush modified metadata
>        unless  that metadata is needed in order to allow a subsequent data re‐
>        trieval to be correctly handled.  For example, changes to  st_atime  or
>        st_mtime  (respectively, time of last access and time of last modifica‐
>        tion; see inode(7)) do not require flushing because they are not neces‐
>        sary for a subsequent data read to be handled correctly.  On the  other
>        hand, a change to the file size (st_size, as made by say ftruncate(2)),
>        would require a metadata flush.
> [/quote]

I should have read more carefully, sorry for the noise.

-- 
Peter Xu


