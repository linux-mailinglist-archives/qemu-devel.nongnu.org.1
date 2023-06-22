Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9261773A3C4
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 16:55:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCLhx-0003y8-HN; Thu, 22 Jun 2023 10:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCLhu-0003xo-B2
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qCLhs-000892-PO
 for qemu-devel@nongnu.org; Thu, 22 Jun 2023 10:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687445683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ObDWspMSNdfg3ZOnk4bSEeAWEpYFOenjNw3IJHjNLnQ=;
 b=YHESo6lmLkz111yjSJF3cZ/0R0MXJM7OQhOYlFj57gTyWXoQAMCZhodi26cedq5izgS4Cl
 WtF07rl4+vIEJo8jAj0eg6ULdWN7FGfWzdiCwGB4dkNR5I9CR59yKXtgWVhIGVr1zUvxjf
 vsEVGvaaZvLATrEsf/yBohe+VzINF84=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-LBZNJ9ftNJu4VffO3vtrVg-1; Thu, 22 Jun 2023 10:54:36 -0400
X-MC-Unique: LBZNJ9ftNJu4VffO3vtrVg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7606a134623so128417785a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jun 2023 07:54:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687445676; x=1690037676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObDWspMSNdfg3ZOnk4bSEeAWEpYFOenjNw3IJHjNLnQ=;
 b=UPpWkohjM0JB3Yz/wYaKFeX/lNjB2djTZGLSw+qUtPFpDfif3eN730xjCUSiC/qUcm
 UeCkwDyHQeZhyNOrV7GwmBijDY4Yzc8P8vyB2S3rpXTO1afhCN/BlXCWO1eS3jGiKc9r
 rZZ2iUzuW+5//loAymA+aQavO8ZHaQNZvWl0s0kXAOiNohCh7G/bWRuGxf6fwisO/Ag3
 5O2oZkAlXFCx70bOblHROAeL8YxcZ1SFZ+9y3NiFb1mnl0TzuULV8GF/wJyDyqqPaOXm
 MMMJh/RLNkCsn29aX1wJ8KfvuNtw+XhqzrcR30Rhn6uZJuyXqtevGFb9/NFFu0wQsyEq
 Lf+A==
X-Gm-Message-State: AC+VfDxh92wXOAfQK9Kd8oumqBV9OVW+ZosmeTprswGUe6iHpdY2f8KU
 k9dotyefxF0V069jmiFHEA6mwxYistpfNJ/Ss0pDpHOhBtWeVVBKVzod6qap9kk++Xt3mbOdVMp
 DT1wGC1FD5WVuBVk=
X-Received: by 2002:a05:620a:8fcc:b0:763:a95d:b578 with SMTP id
 rj12-20020a05620a8fcc00b00763a95db578mr7857709qkn.3.1687445676366; 
 Thu, 22 Jun 2023 07:54:36 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7guzVSU7rCCdHhWp/3uJ4QqAKqSWEzRLkQBWdQXnt5omT9Ptki2vGl2zWJv43UE8ytZD+uTw==
X-Received: by 2002:a05:620a:8fcc:b0:763:a95d:b578 with SMTP id
 rj12-20020a05620a8fcc00b00763a95db578mr7857695qkn.3.1687445676011; 
 Thu, 22 Jun 2023 07:54:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z5-20020ae9c105000000b0076077538b0esm3500746qki.17.2023.06.22.07.54.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jun 2023 07:54:35 -0700 (PDT)
Date: Thu, 22 Jun 2023 10:54:34 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peng Tao <tao.peng@linux.alibaba.com>
Subject: Re: [PATCH v1 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
Message-ID: <ZJRgqqzNFjqO6kqh@x1n>
References: <20230620130354.322180-1-david@redhat.com>
 <20230620130354.322180-2-david@redhat.com> <ZJMdZRoeu9BVm0z8@x1n>
 <9f7afce0-ff7f-33f8-4f39-bba77f2b2ba4@redhat.com>
 <ZJMrhgEbzYUyt1KH@x1n>
 <0c2d7680-4aa4-9d88-7cc7-62dc3b9535a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c2d7680-4aa4-9d88-7cc7-62dc3b9535a1@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 22, 2023 at 03:10:47PM +0200, David Hildenbrand wrote:
> Maybe ... depends also on the uffd semantics as in 3).

UFFDIO_COPY|ZEROPAGE bypasses page cache for private file mappings, afaict.
We'll still got a limit on the inode size (so we can't COPY|ZEROPAGE over
that offset of vma) but the rest should be all fine.

Feel free to have a quick skim over 5b51072e97d5 ("userfaultfd: shmem:
allocate anonymous memory for MAP_PRIVATE shmem").

Thanks,

-- 
Peter Xu


