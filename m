Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 482CB7E6027
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 22:47:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0qMy-0007Cm-96; Wed, 08 Nov 2023 16:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r0qMw-0007CM-LC
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:45:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r0qMu-0007Xx-VU
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 16:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699479946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HkAhhAYITXnUt5yHjAr0bXFQsidVVYaHI46yFpgyXas=;
 b=Kg/kAXUOFgsH8FR2ACiWEe9qgi3AhaQ6ZNdZRRSXcqiske4xFcaHutPs9kGwHHEDjSwDan
 k/6w3koTYSvYaA+YA+b0fgK+vnpXH1bgEtGU/Fsx2B181GWur88R9dWOTog6trJXcAkKKQ
 Z1X+jeJixI1d578Pz2eNj6UK8iHLgm8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-eYMtVxoXPbSPyWNEX4-48Q-1; Wed, 08 Nov 2023 16:45:42 -0500
X-MC-Unique: eYMtVxoXPbSPyWNEX4-48Q-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-778b5c628f4so2825685a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Nov 2023 13:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699479942; x=1700084742;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HkAhhAYITXnUt5yHjAr0bXFQsidVVYaHI46yFpgyXas=;
 b=dWE1iTbO2d8D6X7eMyOVcxULZs1k7LbgJqsfD97j8RMYuE6L0ExuwTx0L8Xzml7Tg+
 YYQDrDFqR0CPoTs2sa1mHquPCqozKVWWC4Yp3ZcdGkStkI9bWyRisfg6NWS+RUMROn9t
 +pLe53xTEfG8gI4vHao/p9eZB80hW0SIiyfSGyrqqURUqMnSpFfcAg65BD6NwmChOH4n
 jIR+3+XW2vPTZPDWcCDVM6rsVtkXu8dVu9Kc6poNWoTC/s9aC2OMMidKLn7iN00cfPbE
 GCg6TJlvaThAXMtUkBJdUigYOiDjrm4p1/kZ4z2jk3vx5SvwHXKK+IStG7yC8sBRbN76
 04dA==
X-Gm-Message-State: AOJu0YyuMGN7bbvDk48CgItFxn6PoBejOHdnkigLrhq5Rx2b1rWITCmc
 3aV9yFyIiHagJb98UWQTihKvGfw2ywFoKMGJ/JirjmE4zwVWBDPLwHryHJlZ1fCsK0G8EFNGw6k
 qbhaL+OEUCd1EDcY=
X-Received: by 2002:a05:620a:3951:b0:77a:69a1:b6a3 with SMTP id
 qs17-20020a05620a395100b0077a69a1b6a3mr3362976qkn.1.1699479941963; 
 Wed, 08 Nov 2023 13:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHQZCt63TxcQQRrnBi6Rri6BCjXUfFmFInm5lCtky1D74wqauPEsHpWGyplbktaKel2b8dTFA==
X-Received: by 2002:a05:620a:3951:b0:77a:69a1:b6a3 with SMTP id
 qs17-20020a05620a395100b0077a69a1b6a3mr3362964qkn.1.1699479941687; 
 Wed, 08 Nov 2023 13:45:41 -0800 (PST)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w2-20020a05620a0e8200b007789a3499casm1449632qkm.115.2023.11.08.13.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Nov 2023 13:45:41 -0800 (PST)
Date: Wed, 8 Nov 2023 16:45:39 -0500
From: Peter Xu <peterx@redhat.com>
To: William Roche <william.roche@oracle.com>
Cc: qemu-devel@nongnu.org, lizhijian@fujitsu.com, pbonzini@redhat.com,
 quintela@redhat.com, leobras@redhat.com, joao.m.martins@oracle.com,
 lidongchen@tencent.com
Subject: Re: [PATCH v4 2/2] migration: prevent migration when a poisoned page
 is unknown from the VM
Message-ID: <ZUwBgzr1GcSIy0sJ@x1n>
References: <20230920235301.1622672-1-william.roche@oracle.com>
 <20231013150839.867164-1-william.roche@oracle.com>
 <20231013150839.867164-3-william.roche@oracle.com>
 <ZS1pSeL3hj4/73lk@x1n>
 <c0af41b7-56dd-4395-8c79-d630ece3b589@oracle.com>
 <ZS6ksf8o7dJ8mzUe@x1n>
 <d0c6b2b9-ab95-4b29-969a-85edcac3f8af@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0c6b2b9-ab95-4b29-969a-85edcac3f8af@oracle.com>
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

On Mon, Nov 06, 2023 at 10:38:14PM +0100, William Roche wrote:
> Note also that large pages are taken into account too for our live
> migration, but the poisoning of a qemu large page requires more work
> especially for VM using standard 4k pages on top of these qemu large
> pages -- and this is a completely different issue. I'm mentioning this
> aspect here because even on Intel platforms, underlying large pages
> poisoning needs to be reported better to the running VM as a large
> section of its memory is gone (not just a single head 4k page), and
> adding live migration to this problem will not make things any better...

Good point.. Yes, huge poisoned pages seem all broken.

> I did that in a self content test program: memory allocation,
> UFFDIO_REGISTER and use of UFFDIO_POISON.  The register mode has to be
> given but MISSING or WP both works. This gives the possibility to inject
> poison in a much easier and better way than using
> madvise(... MADV_HWPOISON, ...) for example.

Indeed, I should have left a comment if I noticed that when reviewing the
POISON changes; I overlooked that find_dst_vma(), even named like that,
will check the vma uffd context existed.  Doesn't really be necessary to
UFFDIO_POISON.

I can consider proposing a patch to allow that, which should be
trivial.. but it won't help with old kernels, so QEMU may still need to
better always register to make it always work as long as
UFFD_FEATURE_POISON reported.. sad.

> 
> But it implies a lot of other changes:
>     - The source has to flag the error pages to indicate a poison
>       (new flag in the exchange protocole)
>     - The destination has to be able to deal with the new protocole

IIUC these two can be simply implemented by migrating hwpoison_page_list
over to dest.  You need to have a compat bit for doing this, ignoring the
list on old machine types, because old QEMUs will not recognize this vmsd.

QEMU should even support migrating a list object in VMSD, feel free to have
a look at VMSTATE_QLIST_V().

>     - The destination has to be able to mark the pages as poisoned
>       (authorized to use userfaultfd)

Note: userfaultfd is actually available without any privilege if to use
UFFDIO_POISON only, as long as to open the uffd (either via syscall or
/dev/userfaultfd) using UFFD_FLAG_USER_ONLY.

A trick is we can register with UFFD_WP mode (not MISSING; because when a
kernel accesses a missing page it'll cause SIGBUS then with USER_ONLY),
then inject whatever POISON we want.  As long as UFFDIO_WRITEPROTECT is not
invoked, UFFD_WP does nothing (unlike MISSING).

>     - So both source and destination have to be upgraded (of course
>       qemu but also an appropriate kernel version providing
>       UFFDIO_POISON on the destination)

True.  Unfortunately this is not avoidable.

>     - we may need to be able to negotiate a fall back solution
>     - an indication of the method to use could belong to the
>       migration capabilities and parameters

For above two points: it's a common issue with migration compatibility.  As
long as you can provide above VMSD to migrate hwpoison_page_list, marking
all old QEMU machine types skipping that, then it should just work.

You can have a closer look at anything in hw_compat_* as an example.

>     - etc...

I think you did summarize mostly all the points I can think of; is there
really anything more? :)

It'll be great if you can, or plan to, fix that for good.

Thanks,

-- 
Peter Xu


