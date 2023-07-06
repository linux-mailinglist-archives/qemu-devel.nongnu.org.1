Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5B874971F
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 10:11:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHK4D-000852-H9; Thu, 06 Jul 2023 04:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHK4A-00084i-MQ
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qHK48-0006JN-JC
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 04:10:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688631015;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XwJzwzdP06Db8PqqlrR3oNCpNv22nBriDam4kGhZ9+w=;
 b=ZcbLXgDhQw56hKCjgZAjosohiO/k7g7SsjSH08jb2ybnVTzL28KHC8hzhQKEYbXiWAxqDa
 SU002m0XBy29SO/KBAPJ9xDuQnDRGmg18cxNKDQa0csr3tRlt7r9IZUOnjK3aISXkws1qS
 R6E8Pex9BJTj7QRlJ4LhuI/nWADdS1o=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-Vo4zmmcuMSyZhR_DPzDOJw-1; Thu, 06 Jul 2023 04:10:13 -0400
X-MC-Unique: Vo4zmmcuMSyZhR_DPzDOJw-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b6f97c9d54so4239291fa.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 01:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688631012; x=1691223012;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwJzwzdP06Db8PqqlrR3oNCpNv22nBriDam4kGhZ9+w=;
 b=lz2RsVPFwUQpmv6WWCYdEl2/kGkb8fetB0juFaWQAxeGMBT1yCmUxghA5W+khM3rZZ
 lD/CEBt+75Y3GGOTVfONgqioxiqeR9Rr5226wM9y7iOI7cFNCixbz2zncvTfV2L7K3iR
 MmnDoK1kkzY2sbHyXvfW++M8Ad/QMX6J0+j04EQCiTNIHBsaZC+hpx+wlR4B5LXMyHp0
 t+O6rmthg5QL6deRChL4z/I7FWAax5NFVAqOrdJzuVydbG9uCnNHHwF3K9kEJqhpZPcr
 Ognd4NIt9A1J35Qi3IdQDuqM0CNTcdCaB+CD3ltPl0xZtPf4WU6v8dQLDcbeFgi7rq1x
 vNew==
X-Gm-Message-State: ABy/qLZcN92XOP66N1nkkxyAgbWYV0GXNHa1J8EIxYFiI427skwF0TRs
 8fOnhsKdR+7ohaTBHggL321Rp35IDzhOJuLFnTTyyr3KzlK9RyNIvJk0BW+PuZmBG/1hbuSu1Sc
 wvaFdcK2oqzrooWI=
X-Received: by 2002:a2e:700b:0:b0:2b1:c1ae:73e3 with SMTP id
 l11-20020a2e700b000000b002b1c1ae73e3mr783481ljc.15.1688631012135; 
 Thu, 06 Jul 2023 01:10:12 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGETaRIL7gIiZgtDIefeh0jAVElq6H/QMx5Y4wCGfURqZAzHtRXu4BsLMOCrDXnUrLDmnOMow==
X-Received: by 2002:a2e:700b:0:b0:2b1:c1ae:73e3 with SMTP id
 l11-20020a2e700b000000b002b1c1ae73e3mr783466ljc.15.1688631011797; 
 Thu, 06 Jul 2023 01:10:11 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 k1-20020a7bc301000000b003f9bd9e3226sm1354090wmj.7.2023.07.06.01.10.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 01:10:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org,  "Michael S. Tsirkin" <mst@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Leonardo Bras <leobras@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peng
 Tao <tao.peng@linux.alibaba.com>,  Mario Casquero <mcasquer@redhat.com>
Subject: Re: [PATCH v2 1/4] softmmu/physmem: Warn with
 ram_block_discard_range() on MAP_PRIVATE file mapping
In-Reply-To: <20230706075612.67404-2-david@redhat.com> (David Hildenbrand's
 message of "Thu, 6 Jul 2023 09:56:06 +0200")
References: <20230706075612.67404-1-david@redhat.com>
 <20230706075612.67404-2-david@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Thu, 06 Jul 2023 10:10:10 +0200
Message-ID: <87jzvdbgv1.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

David Hildenbrand <david@redhat.com> wrote:
> ram_block_discard_range() cannot possibly do the right thing in
> MAP_PRIVATE file mappings in the general case.
>
> To achieve the documented semantics, we also have to punch a hole into
> the file, possibly messing with other MAP_PRIVATE/MAP_SHARED mappings
> of such a file.
>
> For example, using VM templating -- see commit b17fbbe55cba ("migration:
> allow private destination ram with x-ignore-shared") -- in combination with
> any mechanism that relies on discarding of RAM is problematic. This
> includes:
> * Postcopy live migration
> * virtio-balloon inflation/deflation or free-page-reporting
> * virtio-mem
>
> So at least warn that there is something possibly dangerous is going on
> when using ram_block_discard_range() in these cases.
>
> Acked-by: Peter Xu <peterx@redhat.com>
> Tested-by: Mario Casquero <mcasquer@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

(at least we give a warning)

But I wonder if we can do better and test that:
 * Postcopy live migration

   We can check if we are on postcopy, or put a marker so we know that
   postcopy can have problems when started.

 * virtio-balloon inflation/deflation or free-page-reporting

   We can check if we have ever used virtio-balloon.

 * virtio-mem

   We can check if we have used virtio-men


I am just wondering if that is even possible?

Thanks, Juan.


