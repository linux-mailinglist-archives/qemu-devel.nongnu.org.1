Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF41D7B9B29
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 08:47:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoI7p-0001tD-SX; Thu, 05 Oct 2023 02:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoI7k-0001sr-6D
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:46:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoI7g-0001Rm-W9
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 02:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696488371;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=I9xyqp5g78lEp1vY0wkaw8CQ0PWJOazPVzsJw+O1nIc=;
 b=H4wi6F32HqBYLF+fU2iB1X0zH53uFSQ0ovAEZKSCVNKgCEb3qmZjRVOfvC3RMc5rfFFZsM
 V1tWqxV70OIFTcZVqEfSn+0pzrxv7XHirvITAxqJSGIG1974YQnWfCTBJoWyFNN01GXxfq
 /roNyPaT6EBqgJ6rxQN7Vwmwz6YX8z0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-Eqv5_mLFNvqgPUz9-uofRA-1; Thu, 05 Oct 2023 02:46:10 -0400
X-MC-Unique: Eqv5_mLFNvqgPUz9-uofRA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-317d5b38194so283770f8f.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 23:46:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696488369; x=1697093169;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I9xyqp5g78lEp1vY0wkaw8CQ0PWJOazPVzsJw+O1nIc=;
 b=OOdJRzaAc3sQMO+4qoLUAIIPgyE80/eQVaNKeUH8VwaM/e0txzzzJXjNuHZG20ECAF
 e2GQzecfv07sv72/Tid3Js7okThx2QNj5CPCG2i3uMrDMyoM0K4Hu2TzYyFNdu1v6rUY
 2r9ohSMjhz2JYOZkNVIDiXgH9fbvbnloCx9PL8Z0HvAS8FSrpK16zLQiwgvwV3fFW/5+
 ykUEGMyfXNepBlfTIvAc0lHMLVjIlavp1/AE6W1XeW0FH8IndwUO0X9BKcDeR7/NUE8k
 a1sR2qEKIds2dNe/Iks5h/GY57W4APEtjbmZPJTRFXQ/GO1ChM7SgVTClCv8uQ0elRkb
 Cp9A==
X-Gm-Message-State: AOJu0YxT1+vi58N54T3bIUlE4MzCIDrCSxGYfqeY+fyCR2PK1V1js4PO
 /2LfCtWAR6TDoDzgVCcwWv8Pv6Wni/v1hNZu4Uu5tglM/1/Vt2yJH5AtHOr/SfHUiolo429GEQk
 gVLN7X/IWlIuGDk8=
X-Received: by 2002:a5d:660c:0:b0:31f:a15f:2cdc with SMTP id
 n12-20020a5d660c000000b0031fa15f2cdcmr346055wru.29.1696488369285; 
 Wed, 04 Oct 2023 23:46:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNwA9y+VpoGCfXgUmgvmZfhGyVSCTW9oZy7VSn0Xxr6p35SbftYc3I9E+3/oplKZU3SXyHKg==
X-Received: by 2002:a5d:660c:0:b0:31f:a15f:2cdc with SMTP id
 n12-20020a5d660c000000b0031fa15f2cdcmr346036wru.29.1696488368933; 
 Wed, 04 Oct 2023 23:46:08 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 j14-20020a5d448e000000b0032196c508e3sm982742wrq.53.2023.10.04.23.46.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 23:46:08 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,  peterx@redhat.com,  leobras@redhat.com,
 farosas@suse.de,  lizhijian@fujitsu.com,  eblake@redhat.com
Subject: Re: [PATCH v2 16/53] migration/rdma: Fix or document problematic
 uses of errno
In-Reply-To: <20230928132019.2544702-17-armbru@redhat.com> (Markus
 Armbruster's message of "Thu, 28 Sep 2023 15:19:42 +0200")
References: <20230928132019.2544702-1-armbru@redhat.com>
 <20230928132019.2544702-17-armbru@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 08:46:07 +0200
Message-ID: <871qe9r2hc.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Markus Armbruster <armbru@redhat.com> wrote:
> We use errno after calling Libibverbs functions that are not
> documented to set errno (manual page does not mention errno), or where
> the documentation is unclear ("returns [...] the value of errno on
> failure").  While this could be read as "sets errno and returns it",
> a glance at the source code[*] kills that hope:
>
>     static inline int ibv_post_send(struct ibv_qp *qp, struct ibv_send_wr *wr,
>                                     struct ibv_send_wr **bad_wr)
>     {
>             return qp->context->ops.post_send(qp, wr, bad_wr);
>     }
>
> The callback can be
>
>     static int mana_post_send(struct ibv_qp *ibqp, struct ibv_send_wr *wr,
>                               struct ibv_send_wr **bad)
>     {
>             /* This version of driver supports RAW QP only.
>              * Posting WR is done directly in the application.
>              */
>             return EOPNOTSUPP;
>     }
>
> Neither of them touches errno.
>
> One of these errno uses is easy to fix, so do that now.  Several more
> will go away later in the series; add temporary FIXME commments.
> Three will remain; add TODO comments.  TODO, not FIXME, because the
> bug might be in Libibverbs documentation.
>
> [*] https://github.com/linux-rdma/rdma-core.git
>     commit 55fa316b4b18f258d8ac1ceb4aa5a7a35b094dcf
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

And here I am, re-merging from this patch O:-)


