Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2407DE24F
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 15:22:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyC6E-00071b-MB; Wed, 01 Nov 2023 10:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyC6C-000715-MP
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyC6A-00006J-Vh
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 10:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698848493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7pT7S5cVZeHm6sOpL+y463PuBWeps4cRVSy5AWsxe88=;
 b=DGHmRyDD3qJKUGAbpHER8LY8VRDf3Cr3MHjF9mitBvsFLRqfYKym3ZC1GhPCzf/ZCRaVk8
 fELeHAownH5yF1uyxpOPYaEcOz1JuJn9UZTBLaXYrozkk8sEcMUh7wLVBQNfXlUihGOYSi
 3lYXTAlKBxeVxe++Rv8J9l+0x5oS+6Q=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-9iqPbXueOuurSRLQZTc8_Q-1; Wed, 01 Nov 2023 10:21:32 -0400
X-MC-Unique: 9iqPbXueOuurSRLQZTc8_Q-1
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6716c2696c7so14622816d6.1
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 07:21:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698848492; x=1699453292;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7pT7S5cVZeHm6sOpL+y463PuBWeps4cRVSy5AWsxe88=;
 b=aZsMzhK4aor3YIilGatteWq8Y4u6OPMU+vJ7O6EeUqBjYMti2Ho+ktpgIG2zOZTVna
 mcJB0RzbhT0sV6APs7eqX3wVAiErJMWVBhn3SUNlAsf2KODuSFCTdWfWUP1UqhcXmlkk
 CaHDiY/ZENhPL/XyyENOG7PnP3MKo56NapQ9RbC6/cK9v+OJQqe55oOYZMJVth9MXR37
 F8fnrUNPW5Pg5Jn7hzyWJPKAyM2Acy91rkeU4vKae0kgZLcfzWbpR+hukhY4Be9n81U+
 gyl9YVm2p2MURNYLJUavonuUj218jD0oaJdLj5GCVPkTdf/jGnZRuSxxt11iNIBesIoF
 Ve0w==
X-Gm-Message-State: AOJu0Yw0hgcfXruIrTbsbBcsHlgDntDcOYTjPojcYojkrojOQSuW/xad
 nLi6QhrimXAv4fJ3bzwT8AZLg3v9p6xo92i+pPmS5ugJ8BR/jkIJkN5hPe4uXpLJbT6hXLNXjib
 f7QwYZpolKj5tfig=
X-Received: by 2002:a0c:c707:0:b0:66a:d2d2:59b6 with SMTP id
 w7-20020a0cc707000000b0066ad2d259b6mr16458837qvi.5.1698848491788; 
 Wed, 01 Nov 2023 07:21:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7quVaau5q56wHFBn0/BJksQElEYKf45eFbvfnsUpLsePFsFMCQFVUKA//SgTvBLBMppmVbg==
X-Received: by 2002:a0c:c707:0:b0:66a:d2d2:59b6 with SMTP id
 w7-20020a0cc707000000b0066ad2d259b6mr16458818qvi.5.1698848491471; 
 Wed, 01 Nov 2023 07:21:31 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j18-20020ac84412000000b003f6ac526568sm1425240qtn.39.2023.11.01.07.21.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 07:21:31 -0700 (PDT)
Date: Wed, 1 Nov 2023 10:21:07 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 16/29] migration/ram: Add support for 'fixed-ram'
 migration restore
Message-ID: <ZUJe0xb2Q0HgzBX+@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-17-farosas@suse.de>
 <ZTjjMiMkmnPMccjq@redhat.com> <87r0lieqxm.fsf@suse.de>
 <ZUFPlqgFx/2MeCj8@x1n> <ZUIZ1g5UahLu4pXh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUIZ1g5UahLu4pXh@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.393,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 01, 2023 at 09:26:46AM +0000, Daniel P. Berrangé wrote:
> On Tue, Oct 31, 2023 at 03:03:50PM -0400, Peter Xu wrote:
> > On Wed, Oct 25, 2023 at 11:07:33AM -0300, Fabiano Rosas wrote:
> > > >> +static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block, ram_addr_t length)
> > > >> +{
> > > >> +    g_autofree unsigned long *bitmap = NULL;
> > > >> +    struct FixedRamHeader header;
> > > >> +    size_t bitmap_size;
> > > >> +    long num_pages;
> > > >> +    int ret = 0;
> > > >> +
> > > >> +    ret = fixed_ram_read_header(f, &header);
> > > >> +    if (ret < 0) {
> > > >> +        error_report("Error reading fixed-ram header");
> > > >> +        return -EINVAL;
> > > >> +    }
> > > >> +
> > > >> +    block->pages_offset = header.pages_offset;
> > > >
> > > > Do you think it is worth sanity checking that 'pages_offset' is aligned
> > > > in some way.
> > > >
> > > > It is nice that we have flexibility to change the alignment in future
> > > > if we find 1 MB is not optimal, so I wouldn't want to force 1MB align
> > > > check htere. Perhaps we could at least sanity check for alignment at
> > > > TARGET_PAGE_SIZE, to detect a gross data corruption problem ?
> > > >
> > > 
> > > I don't see why not. I'll add it.
> > 
> > Is there any explanation on why that 1MB offset, and how the number is
> > chosen?  Thanks,
> 
> The fixed-ram format is anticipating the use of O_DIRECT.
> 
> With O_DIRECT both the buffers in memory, and the file handle offset
> have alignment requirements. The buffer alignments are usually page
> sized, and QEMU RAM blocks will trivially satisfy those.
> 
> The file handle offset alignment varies per filesystem. While you can
> query the alignment for the FS holding the file with statx(), that is
> not appropriate todo. If a user saves/restores QEMU state to file, we
> must assume there is a chance the user will copy the saved state to a
> different filesystem.
> 
> IOW, we want alignment to satisfy the likely worst case.
> 
> Picking 1 MB is a nice round number that is large enough that it is
> almost certainly going to satisfy any filesystem alignment. In fact
> it is likely massive overkill. None the less 1 MB is also still tiny

Is that calculated by something like max of possible host (small) page
sizes?  I've no idea what's it for all archs, the max small page size I'm
aware of is 64K, but I don't know a lot archs.

> in the context of guest RAM sizes, so no one is going to notice the
> padding holes in the file from this.
> 
> IOW, the 1 MB choice is an arbitrary, but somewhat informed choice.

I see, thanks.  Shall we document it clearly?  Then if there's a need to
adjust that value we will know what to reference.

-- 
Peter Xu


