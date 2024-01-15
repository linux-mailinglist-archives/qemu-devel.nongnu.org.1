Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A12B82D56F
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 09:59:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPInK-00015C-0a; Mon, 15 Jan 2024 03:58:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPIn9-00014x-Rt
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 03:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPIn8-00007H-8P
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 03:57:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705309076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ywIeENNpKNdaP9GZqLZCz0Z3wCtWTldDGU2SkNnLbBY=;
 b=X0o7tVjBLC4ylCWtgIt9Y7WqcqBqHXp3IxHp/jw0tTq/PvTqdJHE926wfs5FRgLMJM8B4m
 ov9twn0VunewXufkmBWU3spQjgup8SMLds7fhr31p/LguTj6Lm4fFtPgtvnjGuh54WjGKc
 7LBSJqar8RsWKO56ka73UJPJcM0eISM=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-QYccbDUwOiiMuptjjPEQjw-1; Mon, 15 Jan 2024 03:57:55 -0500
X-MC-Unique: QYccbDUwOiiMuptjjPEQjw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d5a4416df4so8570485ad.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 00:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705309074; x=1705913874;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ywIeENNpKNdaP9GZqLZCz0Z3wCtWTldDGU2SkNnLbBY=;
 b=X+aH5gNxQJBEbfbKWeGJ4hT2PfuQ9dNMcnnk8qFQPDWZqHz2aMh0oztDyxCsAEsQSm
 FbR2XNogFGfJu59MxG1EBtP379GlsU9yVLfA4QVXDIXeWhAFVBkjXpYu9pi2u1mUgh4L
 j5EoOY/LIJ6+k/mz+Qi6yPO0B7+y+A2gQrgcSTiwYXtRvcLaav0Y/srMvY3iUXkLVoRh
 1V/Aw/SM1CJemKdRHVSckqLK6lHGHV7psVyTtSwayAGOlpGYTcs8/zVw4ZxlTMRowuLH
 Jrumiuzr3CytUY6NYjoZvcZt/A66yYpkiKLeRnxooEJEDdST/Nw3XDaqaqUih2NMdA0s
 oEFw==
X-Gm-Message-State: AOJu0YxF69FqrQmp9u+S1vvJEfc4KIMnul/JWJDtfL0XPI85GKHMURUs
 3bDY0zeHHR47jezy7nqwcQ8yDYXADkNojPWOgTSGXXU/Z76c7+5uGdWosJRoyhNagj8BJF7Kp8Z
 XjKoyYoWPQVFajpN7iOhWFbM=
X-Received: by 2002:a17:902:ee05:b0:1d0:8f0d:b6e0 with SMTP id
 z5-20020a170902ee0500b001d08f0db6e0mr10449106plb.1.1705309074011; 
 Mon, 15 Jan 2024 00:57:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbM4aRjN+XmNxAA/ye0YOqQz5bhxAnfyUGIim3onFaFQCfjypFDFfaIU2fCEv9UXTbSsTyiQ==
X-Received: by 2002:a17:902:ee05:b0:1d0:8f0d:b6e0 with SMTP id
 z5-20020a170902ee0500b001d08f0db6e0mr10449100plb.1.1705309073756; 
 Mon, 15 Jan 2024 00:57:53 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 iy12-20020a170903130c00b001d536a910fasm7193487plb.77.2024.01.15.00.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 00:57:53 -0800 (PST)
Date: Mon, 15 Jan 2024 16:57:42 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 04/30] io: fsync before closing a file channel
Message-ID: <ZaTzhhOqESTH42Jd@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-5-farosas@suse.de> <ZZ-qbom2UqEX0uS7@x1n>
 <87wmsfn1xx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wmsfn1xx.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jan 11, 2024 at 03:46:02PM -0300, Fabiano Rosas wrote:
> > (2) Why metadata doesn't matter (v.s. fsync(), when CONFIG_FDATASYNC=y)?
> 
> Syncing the inode information is not critical, it's mostly timestamp
> information (man inode). And fdatasync makes sure to sync any metadata
> that would be relevant for the retrieval of the data.

I forgot to reply to this one in the previous reply..

Timestamps look all fine to be old.  What about file size?  That's also in
"man inode" as metadata, but I'm not sure whether data will be fully valid
if e.g. size enlarged but not flushed along with the page caches.

-- 
Peter Xu


