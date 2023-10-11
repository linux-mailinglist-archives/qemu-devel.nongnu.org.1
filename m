Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EBB7C5ED4
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 23:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqgJo-0006K5-Ps; Wed, 11 Oct 2023 17:00:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qqgJh-0006Ja-9V
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 17:00:31 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qqgJY-0000Xa-96
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 17:00:27 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-57b5f0d658dso163949eaf.0
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 14:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697058004; x=1697662804; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=za/ebOMiRKrc1Z3gteYUevrsi1HMalUD0oqgEJzlgVg=;
 b=NkaVOMgOh6HoiSITCV4xSZnWuVZfvJC2hn+jUe85b2iIQvWfUZql123BO6j49Av3IO
 nDOORTlXj+HAa7FK2MHnjtHt/d+LWZpj3nqe/7g31FacE9v7M7zRpfWXEn0HCUTRBiKU
 UrUmnZYvjrMHtUyWf53Z/1pJiZZjyPA9me6DwvX4fQLfusK4M3cCcxPsITT2BjtpVfNQ
 0GGMWkEYdniTOZdL+QpvSqFiJGVl82KVk5wj7KBPFOSa8Huu2w4USPtN9NqQrG2lLupC
 FbpglDc6bB6JOejIeWj1sgoAlhaYtNTzBOpeerwpvJCJhdd9WBCSrrjEn/U2tSGk732k
 SUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697058004; x=1697662804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=za/ebOMiRKrc1Z3gteYUevrsi1HMalUD0oqgEJzlgVg=;
 b=O6RPqoA5ucXLtAZzbt4nCSqG0VKPOYruD0W+U6+PUg9f0bF3h+3lRLyu6EjQDIiomN
 8FMshebBbtEPzQS1u4beL7QarfvThI+OvdiT5nPGmTT87Ud3n83lDxDZ5oq64Ogi9rbG
 +mWI5NJFuX0WziX84g6z9S/Qpf4rCacEssf5WQcktBL293dsYXInuz0Q2EyTcrrtq7WU
 mRYaB5bnBXNr8yduovz1KrpldUlDRFa3PHlvKYJ0bgemI6qR4X3S7FXV43VFfSx4/KBZ
 mfNsUqf2szU82J0SnhWDINw1nigPohD1kjjoD+bkvOAfqdDkWENasmOSvyng+rk6tG6I
 qYuQ==
X-Gm-Message-State: AOJu0Yyp0e7PSAvdksa+P1Dg+xNeRBrNWU7R+s4ibinYU6e0rwM3ebtU
 Y6o9e+qFt7Vd5ugiAGyoNzGk1Ixf8svWmXeGZa8=
X-Google-Smtp-Source: AGHT+IHrKNKZOZsIMWPc9FeJgoRDDFVGXhT5wrPY/1JTYWa35nFy7w9DXPcC5EMs/0DcjdJvS/3yImJfbJwQ+O79NBI=
X-Received: by 2002:a4a:921b:0:b0:571:1fad:ebe0 with SMTP id
 f27-20020a4a921b000000b005711fadebe0mr23299388ooh.3.1697058004322; Wed, 11
 Oct 2023 14:00:04 -0700 (PDT)
MIME-Version: 1.0
References: <20231009104322.3085887-1-i.maximets@ovn.org>
In-Reply-To: <20231009104322.3085887-1-i.maximets@ovn.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 11 Oct 2023 16:59:51 -0400
Message-ID: <CAJSP0QULQ3EGuypp0M_MSRR7fMeifaCxhqUBwzcPQuKeKYMacQ@mail.gmail.com>
Subject: Re: [PATCH] memory: initialize 'fv' in MemoryRegionCache to make
 Coverity happy
To: Ilya Maximets <i.maximets@ovn.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 9 Oct 2023 at 06:44, Ilya Maximets <i.maximets@ovn.org> wrote:
>
> Coverity scan reports multiple false-positive "defects" for the
> following series of actions in virtio.c:
>
>   MemoryRegionCache indirect_desc_cache;
>   address_space_cache_init_empty(&indirect_desc_cache);
>   address_space_cache_destroy(&indirect_desc_cache);
>
> For some reason it's unable to recognize the dependency between 'mrs.mr'
> and 'fv' and insists that '!mrs.mr' check in address_space_cache_destroy
> may take a 'false' branch, even though it is explicitly initialized to
> NULL in the address_space_cache_init_empty():
>
>   *** CID 1522371:  Memory - illegal accesses  (UNINIT)
>   /qemu/hw/virtio/virtio.c: 1627 in virtqueue_split_pop()
>   1621         }
>   1622
>   1623         vq->inuse++;
>   1624
>   1625         trace_virtqueue_pop(vq, elem, elem->in_num, elem->out_num);
>   1626     done:
>   >>>     CID 1522371:  Memory - illegal accesses  (UNINIT)
>   >>>     Using uninitialized value "indirect_desc_cache.fv" when
>   >>>     calling "address_space_cache_destroy".
>   1627         address_space_cache_destroy(&indirect_desc_cache);
>   1628
>   1629         return elem;
>   1630
>   1631     err_undo_map:
>   1632         virtqueue_undo_map_desc(out_num, in_num, iov);
>
>   ** CID 1522370:  Memory - illegal accesses  (UNINIT)
>
> Instead of trying to silence these false positive reports in 4
> different places, initializing 'fv' as well, as this doesn't result
> in any noticeable performance impact.
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> ---
>  include/exec/memory.h | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

