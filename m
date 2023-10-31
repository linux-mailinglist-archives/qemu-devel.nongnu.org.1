Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7A7DD67E
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 20:04:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxu1z-0004BG-Ae; Tue, 31 Oct 2023 15:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxu1w-00041p-HM
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:04:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxu1t-0006zj-9h
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 15:03:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698779034;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2wj7CWIceOKXeNvxsiWqZKr/WPVpo6gS+cdtnjJkqao=;
 b=JxrHosh7R+UfxGHUIHQXFxgRONwFJ9fYe/KtMyVYN5fxoU+sDkQhQ8mjmgIVCfzt16PX/K
 s4W9RfuGtrU9uOzvYytM5f/UP8fL6K0ne2gxDsgbmqw7s0E6F5YV+RW0dk6Mdj671pKfI2
 j7s77CFgOxkkjySFg4kKPW4tm2sCR9M=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-z83DZo8eOqWnskO-6f93VA-1; Tue, 31 Oct 2023 15:03:53 -0400
X-MC-Unique: z83DZo8eOqWnskO-6f93VA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41e1899175eso14221641cf.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 12:03:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698779033; x=1699383833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2wj7CWIceOKXeNvxsiWqZKr/WPVpo6gS+cdtnjJkqao=;
 b=ONe+74Tv8bwqUWRNGxEqZm41skxJFBpQMWBp5rBRUy0bSTJoMIqFEifmsXWn8cv5pi
 3dPd7GBWd5dSD8myBbpcH1BW/aUe/DSNvT+ELWrrf2OV0lm+FyrMaEZJG0Gwk6unqt2C
 7TU1im0J9SXpdyID5jIF5P0cSHBQlbZ6Wurf6+h0fyWMD7lfP2txgyuNmdM6vF0Ua38q
 Ls2NBJjFriWbBavhL/CloR6lJ3stUIB4nhjoOeQk8K7ALaR+3ueKzO/UA2Y2XzxSLeIe
 vGmzSkjF4ww9Lgvwc6evENb1Xz9XvS80L0G8dEcPawmukSdYVv+FizdisZENrJontFVh
 NDyg==
X-Gm-Message-State: AOJu0YxsDVlpZ4dcBiJIab1KhSp5FToV3UTTxC9Y3OL4ivNvzLrH0Jwy
 9WzNtqmm1ZpJJSxuROAGmVBB169vyG739E5zyrutmvBOZ+D+Hzret7qjjkrLGSBZiM6gufTvz4V
 S7GRwOIvGWgFLmVs=
X-Received: by 2002:ac8:6652:0:b0:41e:531f:1abf with SMTP id
 j18-20020ac86652000000b0041e531f1abfmr11476289qtp.6.1698779032943; 
 Tue, 31 Oct 2023 12:03:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEoFTiE8XpBA6uZck2cRWWT0zJMFgYY6psWvIUByaANtsrNTWb0wZYx3YK+P1g84iP7pEA/Q==
X-Received: by 2002:ac8:6652:0:b0:41e:531f:1abf with SMTP id
 j18-20020ac86652000000b0041e531f1abfmr11476272qtp.6.1698779032666; 
 Tue, 31 Oct 2023 12:03:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 k22-20020ac84796000000b0041b016faf7esm736613qtq.58.2023.10.31.12.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 12:03:52 -0700 (PDT)
Date: Tue, 31 Oct 2023 15:03:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>, Nikolay Borisov <nborisov@suse.com>
Subject: Re: [PATCH v2 16/29] migration/ram: Add support for 'fixed-ram'
 migration restore
Message-ID: <ZUFPlqgFx/2MeCj8@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-17-farosas@suse.de>
 <ZTjjMiMkmnPMccjq@redhat.com> <87r0lieqxm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r0lieqxm.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
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

On Wed, Oct 25, 2023 at 11:07:33AM -0300, Fabiano Rosas wrote:
> >> +static int parse_ramblock_fixed_ram(QEMUFile *f, RAMBlock *block, ram_addr_t length)
> >> +{
> >> +    g_autofree unsigned long *bitmap = NULL;
> >> +    struct FixedRamHeader header;
> >> +    size_t bitmap_size;
> >> +    long num_pages;
> >> +    int ret = 0;
> >> +
> >> +    ret = fixed_ram_read_header(f, &header);
> >> +    if (ret < 0) {
> >> +        error_report("Error reading fixed-ram header");
> >> +        return -EINVAL;
> >> +    }
> >> +
> >> +    block->pages_offset = header.pages_offset;
> >
> > Do you think it is worth sanity checking that 'pages_offset' is aligned
> > in some way.
> >
> > It is nice that we have flexibility to change the alignment in future
> > if we find 1 MB is not optimal, so I wouldn't want to force 1MB align
> > check htere. Perhaps we could at least sanity check for alignment at
> > TARGET_PAGE_SIZE, to detect a gross data corruption problem ?
> >
> 
> I don't see why not. I'll add it.

Is there any explanation on why that 1MB offset, and how the number is
chosen?  Thanks,

-- 
Peter Xu


