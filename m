Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B645D7DE2F4
	for <lists+qemu-devel@lfdr.de>; Wed,  1 Nov 2023 16:25:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyD5T-0007sr-7K; Wed, 01 Nov 2023 11:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyD5R-0007sh-G6
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 11:24:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qyD5N-0002TU-Mz
 for qemu-devel@nongnu.org; Wed, 01 Nov 2023 11:24:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698852288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ubN8OTH/1qpbYWIkuHmbl04Hb++gl5J5HIzlvWSLdTg=;
 b=ijDS0pufB6xGclGTzuvu8DDW1tK7JSrelpSRg+68aSK2+jzXVJmULYHn8abmfkpxDSiQJO
 9Cp4bjBD4jfdgmyGklRajF7Wf/TwytpMtde/NdBsz3IT0opw5wXhPu1RZwwpcJNATNeGe9
 y3jWrEaRjamRRNIPFsDj3bl2Coc7kNs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-_CUNYYQeMUm1if_rNbv8kg-1; Wed, 01 Nov 2023 11:24:46 -0400
X-MC-Unique: _CUNYYQeMUm1if_rNbv8kg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41e352779d5so13511761cf.0
 for <qemu-devel@nongnu.org>; Wed, 01 Nov 2023 08:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698852286; x=1699457086;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ubN8OTH/1qpbYWIkuHmbl04Hb++gl5J5HIzlvWSLdTg=;
 b=n03aklJ7KdkIXXBjJGtzmo88Ueyx45hq2LTEJn0LUdDVorNTstbVrr5Y+JeHK/FAHy
 80WxvWzHOZn6n7UfN43J3Gyb7tvp4QcAks5kplyT27G1j5/wMI5NpH7kTZSkA0B67+Nj
 mGUKdvmVonDtz5suCTVFS8sEWOIlyJpgpmT1Ki5d/QmPiVi6e3G3xSp803R7TJCPfzNU
 gj9/tVA0ZCw1DbVyDul7k9vJV42UoO7KvvwyFtSlKNbYDEbfFHuDESx75DvdTR7c3fil
 t1f/XzqF49v/e61YnO1NiQ4umu5oHwyKVpx5/LkKD9xxqgFB5kcJ+6lrcnO3uoKLYISQ
 GPhA==
X-Gm-Message-State: AOJu0Yx9stsUOyeDNmGhTbku0b755qHX5lYiYL1ScCi1/vJJxJZBE5sK
 Mu26HAcc4XTaIcSnd+KVP580QRQe3CX4qiRJWfmCzqwGe+PlpqxZxCmi9QNkoEQHGM12IMN0sCw
 4+dhYb++KYe8aKOk=
X-Received: by 2002:ac8:5c56:0:b0:417:944a:bcd0 with SMTP id
 j22-20020ac85c56000000b00417944abcd0mr19213841qtj.3.1698852286285; 
 Wed, 01 Nov 2023 08:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHn7f20mnHStRxvLaSLFVC6L64f+YYaq1Teq2Zch2iJ+sFkq2uxpN/eqRZrAWRBq6Yr29XvvQ==
X-Received: by 2002:ac8:5c56:0:b0:417:944a:bcd0 with SMTP id
 j22-20020ac85c56000000b00417944abcd0mr19213814qtj.3.1698852285970; 
 Wed, 01 Nov 2023 08:24:45 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c17-20020ac85191000000b004033c3948f9sm1489214qtn.42.2023.11.01.08.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Nov 2023 08:24:45 -0700 (PDT)
Date: Wed, 1 Nov 2023 11:23:37 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Nikolay Borisov <nborisov@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v2 15/29] migration/ram: Add support for 'fixed-ram'
 outgoing migration
Message-ID: <ZUJteaz84IYy1LC6@x1n>
References: <20231023203608.26370-1-farosas@suse.de>
 <20231023203608.26370-16-farosas@suse.de>
 <ZTjiblfeOCTY56e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTjiblfeOCTY56e4@redhat.com>
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

On Wed, Oct 25, 2023 at 10:39:58AM +0100, Daniel P. Berrangé wrote:
> If I'm reading the code correctly the new format has some padding
> such that each "ramblock pages" region starts on a 1 MB boundary.
> 
> eg so we get:
> 
>  --------------------------------
>  | ramblock 1 header            |
>  --------------------------------
>  | ramblock 1 fixed-ram header  |
>  --------------------------------
>  | padding to next 1MB boundary |
>  | ...                          |
>  --------------------------------
>  | ramblock 1 pages             |
>  | ...                          |
>  --------------------------------
>  | ramblock 2 header            |
>  --------------------------------
>  | ramblock 2 fixed-ram header  |
>  --------------------------------
>  | padding to next 1MB boundary |
>  | ...                          |
>  --------------------------------
>  | ramblock 2 pages             |
>  | ...                          |
>  --------------------------------
>  | ...                          |
>  --------------------------------
>  | RAM_SAVE_FLAG_EOS            |
>  --------------------------------
>  | ...                          |
>  -------------------------------

When reading the series, I was thinking one more thing on whether fixed-ram
would like to leverage compression in the future?

To be exact, not really fixed-ram as a feature, but non-live snapshot as
the real use case.  More below.

I just noticed that compression can be a great feature to have for such use
case, where the image size can be further shrinked noticeably.  In this
case, speed of savevm may not matter as much as image size (as compression
can take some more cpu overhead): VM will be stopped anyway.

With current fixed-ram layout, we probably can't have compression due to
two reasons:

  - We offset each page with page alignment in the final image, and that's
    where fixed-ram as the term comes from; more fundamentally,

  - We allow src VM to run (dropping auto-pause as the plan, even if we
    plan to guarantee it not run; QEMU still can't take that as
    guaranteed), then we need page granule on storing pages, and then it's
    hard to know the size of each page after compressed.

If with the guarantee that VM is stopped, I think compression should be
easy to get?  Because right after dropping the page-granule requirement, we
can compress in chunks, storing binary in the image, one page written once.
We may lose O_DIRECT but we can consider the hardware accelerators on
[de]compress if necessary.

I'm just raising this up to discuss to make sure we're on the same page.
Again, maybe that's not a concern to anyone, but I want to double check
with all of us, because it will affect the whole design including the image
layout.  I want to make sure we don't introduce another totally different
image layout in the near future just to support compression.

Thanks,

-- 
Peter Xu


