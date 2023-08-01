Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2976BA05
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 18:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQsci-00024z-4C; Tue, 01 Aug 2023 12:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQscg-00024m-9Z
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qQsce-0003hB-KR
 for qemu-devel@nongnu.org; Tue, 01 Aug 2023 12:53:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690908803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X0zM0CSfrI9V/h3q/hDOZ57T9Q8t/7s2ZxcJntYjHlQ=;
 b=TVQ+OCLiRfNt7FVEeB+qtfp9BbS60oW3soPR5Ty2sVO0V5kAruXDPJ7eWsZCM0+4as1vcm
 qiFHlB4BqDfClzTY3yaSfiVjzmTNZ1KvqKkOk0d8E6vBZt/MToufA1UEazSalb45n+eoD7
 JasLZHi+Tms4JUfr4KcmDjg3RUCma+U=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-dJh66iWtN5G_MVfWg_UTeA-1; Tue, 01 Aug 2023 12:53:22 -0400
X-MC-Unique: dJh66iWtN5G_MVfWg_UTeA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76ca010274dso55781585a.0
 for <qemu-devel@nongnu.org>; Tue, 01 Aug 2023 09:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690908786; x=1691513586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0zM0CSfrI9V/h3q/hDOZ57T9Q8t/7s2ZxcJntYjHlQ=;
 b=Xtog5DfGM2NGKCGo1XaPdnnCsBGuP7fwHhZEVpzos0hON/w3ibrPyub8LSxXkBCKeD
 GAnyuB9fqNkVQnh+jN8uNH0nznwFxGpHw8DnhF2hnqoaRs9ZNlAesrmMqjnuNmw2qwwG
 5eC+Wvv4SbYxB8qeo3vKclXBZk0rngZp70qKMTPKfhVQxtG2/HPDMMMKfZ+Vyi/U3dF5
 10Bm3MDT2+WqNiSLWP34WAW2qBOXFzb7qicRH+sjahhUngUAfb+JWWkdnBqgphY7fZ7Q
 4BTY0Fz/vXLI0aGKp0nHEfyGs4x2tkNYX/Sw/eSBSXOP7pzDDUclJRLUwcq+BPfJVc1j
 3eZg==
X-Gm-Message-State: ABy/qLaTxEXtH/v+X8M+yVYifPgS7E5JgYaLGqY73HuvrU0Sk2HS9uCD
 5JTHIiIdvhbqqfDH878WUY79alPiY8zYIIScK/S5DUXkYruEwHdO0/cFzT3+5N6snvOBMgR9Rox
 x6RElAS12m8VQhp0=
X-Received: by 2002:a05:620a:bd5:b0:76a:f689:dff2 with SMTP id
 s21-20020a05620a0bd500b0076af689dff2mr11218541qki.7.1690908786261; 
 Tue, 01 Aug 2023 09:53:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEbApwVFn+52TccpYXpLK12hqNe5cuLUWCzokF8ZGMkYWfFSXvUvhY20sYX4hCIasSav5s8tA==
X-Received: by 2002:a05:620a:bd5:b0:76a:f689:dff2 with SMTP id
 s21-20020a05620a0bd500b0076af689dff2mr11218527qki.7.1690908785940; 
 Tue, 01 Aug 2023 09:53:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b4-20020a05620a118400b0076c71c1d2f5sm3609147qkk.34.2023.08.01.09.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Aug 2023 09:53:05 -0700 (PDT)
Date: Tue, 1 Aug 2023 12:53:03 -0400
From: Peter Xu <peterx@redhat.com>
To: gudkov.andrei@huawei.com
Cc: qemu-devel@nongnu.org, quintela@redhat.com, leobras@redhat.com,
 eblake@redhat.com, armbru@redhat.com, Yong Huang <huangy81@chinatelecom.cn>
Subject: Re: [PATCH] migration/calc-dirty-rate: millisecond precision period
Message-ID: <ZMk4bxl+JhDFcYLS@x1n>
References: <8571da37847f9bb39b84e62ef4998e68ef3c10d1.1688028297.git.gudkov.andrei@huawei.com>
 <ZKcUv1Ge/RVBHJKT@x1n>
 <ZK1NOmUVc/eUivhV@DESKTOP-0LHM7NF.china.huawei.com>
 <ZLWRtU3sXDreCFxO@x1n>
 <ZMfKhYPyeO74BJoP@DESKTOP-0LHM7NF.china.huawei.com>
 <ZMgUQGN+fOiSE5qE@x1n>
 <ZMkc4YTUNU3gcOwB@DESKTOP-0LHM7NF.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZMkc4YTUNU3gcOwB@DESKTOP-0LHM7NF.china.huawei.com>
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

On Tue, Aug 01, 2023 at 05:55:29PM +0300, gudkov.andrei@huawei.com wrote:
> Hmmm, such underestimation looks strange to me. I am willing to test
> page-sampling and see whether its quality can be improved. Do you have
> any specific suggestions on the application to use as a workload?

I could have had a wrong impression here, sorry.

I played again with the page sampling approach, and that's actually pretty
decent..

I had that impression probably based on the fact that by default we chose 2
pages out of 1000-ish (consider workloads having 100-ish memory updates
where no sample page falls into it), and I do remember in some cases of my
test setups quite some time ago, it shows totally wrong numbers. But maybe
I had a wrong test, or wrong memory.

Now thinking about it, for random/seq on not so small memory ranges, that
seems to all work.  For very small ones spread over it goes to the random
case.

> 
> If it turns out that page-sampling is not an option, then performance
> impact of the dirty-bitmap must be improved somehow. Maybe it makes
> sense to split memory into 4GiB chunks and measure dirty page rate
> independently for each of the chunks (without enabling page
> protections for memory outside of the currently processed chunk).
> But the downsides are that 1) total measurement time will increase
> proportionally by number of chunks 2) dirty page rate will be
> overestimated.
> 
> But actually I am still hoping on page sampling. Since my goal is to
> roughly predict what can be migrated and what cannot be, I would prefer
> to keep predictor as lite as possible, even at the cost of
> (overestimation) error.

Yes I also hope that works as you said.

Thanks,

-- 
Peter Xu


