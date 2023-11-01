Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CA27DE565
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 18:33:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyF43-0005t9-4S; Wed, 01 Nov 2023 13:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyF40-0005t0-JP
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 13:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyF3y-0002ph-RN
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 13:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698859889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jxRVxCEFpq3ca9V/3DEWKkwtBRcoOTYLnhUhDq54NdQ=;
 b=f/hG8jt8j0g6vDeQeDoC/9WrX/Et8MWw3JTpmidp3kzl4YR495tvQGyfJTEdwhzxJ4qlmF
 DkGNQudXMmCC+PD8tnRVPyFBJWkgcvL96vScpRWa+bgV9JgHT1kIt2Bm0fGody+ByB3mbi
 yZmbDeqrv8Ske+oZt054SMD/xh0ZKzs=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-a2bhd44aPyORmrP-laV0SQ-1; Wed, 01 Nov 2023 13:31:28 -0400
X-MC-Unique: a2bhd44aPyORmrP-laV0SQ-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-77a029ff1a9so94630085a.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 10:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698859888; x=1699464688;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jxRVxCEFpq3ca9V/3DEWKkwtBRcoOTYLnhUhDq54NdQ=;
 b=ap5gZSKESiyxlAj5iKG3Dv5xWHf3/jDFCVBuX5K3aEsGXmSUfPVJjZl51+sjlXlkr9
 CrCxvq2OGqRVrtuCuzQuI6N56VrLyun94XyWRxnb8hNJIXpV6kqltx/ZL0xSgfN63ATY
 fOYedhQwxD1jqpNiADkiSwwsT8+W0dxgr5JmVK9OQp0BP59x5Gb3S5fAoY3ou7aAXvhd
 T4wy2GPGttevTXGmjJH+ZJMFsjHttuDz2mBM5cTbcW5KhRe/gc74CVPMh6P5RpkwhfZP
 ERg7hIxOGX5dZkpHfFa5Kb/pNQIh7xzE6SVXWoqsn9tUyszm5BjWU43SrLYMIm5iGGoY
 ghQQ==
X-Gm-Message-State: AOJu0YwIN71ZIVLvyeJbotU40IcuqLW0JcdzoJPqBt7ym+f87qK4hsnT
 MbKhn2fiUtkkKamtrtI5iTKvqQLlaplubYS9EpRw+++hxpsoWms+w9T7gNNm3Q1FkzEl+LQVie9
 +mjhUEc6LMs9yDRE=
X-Received: by 2002:a05:620a:24c3:b0:76f:27af:2797 with SMTP id
 m3-20020a05620a24c300b0076f27af2797mr19139917qkn.0.1698859887848; 
 Wed, 01 Nov 2023 10:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFG+cFP9DmUSjIUHm9pm1JFmhXYZ/bc2DbR1LwXGx4IDAgpNQl1xVO8rn6+YHtHRuWWveLadQ==
X-Received: by 2002:a05:620a:24c3:b0:76f:27af:2797 with SMTP id
 m3-20020a05620a24c300b0076f27af2797mr19139893qkn.0.1698859887454; 
 Wed, 01 Nov 2023 10:31:27 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 d11-20020a05620a204b00b007742218dc42sm1615134qka.119.2023.11.01.10.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 10:31:27 -0700 (PDT)
Date: Wed, 1 Nov 2023 13:30:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 15/29] migration/ram: Add support for 'fixed-ram'
 outgoing migration
Message-ID: <ZUKDg1A0OF2mbjWu@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-16-farosas@suse.de>
 <ZTjiblfeOCTY56e4@redhat.com> <ZUJteaz84IYy1LC6@x1n>
 <ZUJ0MhujevGlKFbo@redhat.com> <ZUJ7tuCj3MTWFSKN@x1n>
 <ZUJ+uMRAnZFOoPID@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZUJ+uMRAnZFOoPID@redhat.com>
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

On Wed, Nov 01, 2023 at 04:37:12PM +0000, Daniel P. Berrangé wrote:
> It doesn't contain thread number information directly, but it can
> be implicit from the data layout.
> 
> If you want parallel I/O, each thread has to know it is the only
> one reading/writing to a particular region of the file. With the
> fixed RAM layout in this series, the file offset directly maps
> to the memory region. So if a thread has been given a guest page
> to save it knows it will be the only thing writing to the file
> at that offset. There is no relationship at all between the
> number of threads and the file layout.
> 
> If you can't directly map pages to file offsets, then you need
> some other way to lay out date such that each thread can safely
> write. If you split up a file based on fixed size chunks, then
> the number of chunks you end up with in the file is likely to be
> a multiple of the number of threads you had saving data.

What I was thinking is provision fixed size chunk in ramblock address
space, e.g. 64M pages for each thread.  It compresses with a local buffer,
then request the file offsets to write only after the compression
completed, because we'll need that to request file offset.

> 
> This means if you restore using a different number of threads,
> you can't evenly assign file chunks to each restore thread.
> 
> There's no info about thread IDs in the file, but the data layout
> reflects how mcuh threads were doing work.
> 
> > Assuming decompress can do the same by assigning different chunks to each
> > decompress thread, no matter how many are there.
> > 
> > Would that work?
> 
> Again you get uneven workloads if the number of restore threads is
> different than the save threads, as some threads will have to process
> more chunks than other threads. If the chunks are small this might
> not matter, if they are big it could matter.

Maybe you meant when the chunk size is only calculated from thread numbers,
and when chunk is very large?

If we have fixed size ramblock chunks, the number of chunks can be mostly
irrelevant, e.g. for 4G guest it can contain 4G/64M=128 chunks.  128 chunks
can easily be decompressed concurrently with mostly whatever number of recv
threads.

Parallel IO is not a problem either, afaict, if each thread can request its
file offset to read/write.  The write side is a bit tricky if with what I
said above, it can only be requested and exclusively assigned to the writer
thread after compression has finished and the thread knows how many bytes
it needs to put the results.  On read side we know the binary size of each
chunk, so we can already mark each chunk exclusive to the each reader
thread.

Thanks,

-- 
Peter Xu


