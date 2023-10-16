Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9887CA072
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 09:25:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsHwq-0003VP-S5; Mon, 16 Oct 2023 03:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsHwk-0003VG-Kl
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qsHwj-0005EP-1G
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 03:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697441003;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=TsFJJDxiFUm5Gl2M+QXmNI4+ApCOQ3IBH+CS1wcbshU=;
 b=MmsM0R4P5b3J1glbMNgSdFIN6NGTpdR9r9w9yw40ma6zcPKRSiQ56ni0rCZ77fwrfiaCCa
 4lNNzpJmizdQXYt07zo7mBqsdeIdQ+/7BD4NSDajPxqBsB6LURCZVTe7aidB5JdIbhA5Fd
 LVL8BbUF8wKHkiZ9J1zFDGXKVPGykdk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-TPCvUln_McG0o_d14N0eEw-1; Mon, 16 Oct 2023 03:23:19 -0400
X-MC-Unique: TPCvUln_McG0o_d14N0eEw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c51a7df557so10240651fa.0
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 00:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697440998; x=1698045798;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TsFJJDxiFUm5Gl2M+QXmNI4+ApCOQ3IBH+CS1wcbshU=;
 b=IXjVq1CIle7Jx5/F3OFMrEBU2ymVTnuCfTng3oxOQg5rphN1Q/u5Yalj0tGMvqfxbR
 HJyzDeHEZBriQNbLBVvM+xutNYYEFL6keu9z//9qzZAZXOtU8RjJwWEIT+//Y8/UF7/e
 +G2MtHlOVYiAqH7kpfSAWydUjFOc7SRtxl4fTEF5K4sVQNC1ONUEg4g1Om88Migb912P
 RFCHhwCjyaeTFIXNdltCLNPhetaSdzGpPRrx4T89T8kr/7crO211OfaNlrRQxsqvKtc6
 tYZqXI8r2+NP/pqcZUkB4msARva0u1+qJE06jidUm4bnTHLj0bfItCbsz4al7zl67LhP
 I0EQ==
X-Gm-Message-State: AOJu0YxvvkgQYNnMTjdsoIeX6kmLNZ5kBZC4J38cYrAybPly//hFK680
 EnXUoCXGhJGl6mR9gTKZ2Ii7q+jaIY4OLvi3IFSQ3k+LPrPhWH09WjoNNp/q1XYpinDlAnWF/yM
 PdxkXlBSZ1qprq4g=
X-Received: by 2002:a2e:a789:0:b0:2c5:15dc:ba99 with SMTP id
 c9-20020a2ea789000000b002c515dcba99mr5117663ljf.51.1697440998426; 
 Mon, 16 Oct 2023 00:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjdMOQtFbB4phiYqM/Hq8Ooi7xGWAZaz2rQb0CONpwAhlmfKTNfCyqnDF/VWr1eVna6YsQlQ==
X-Received: by 2002:a2e:a789:0:b0:2c5:15dc:ba99 with SMTP id
 c9-20020a2ea789000000b002c515dcba99mr5117641ljf.51.1697440998091; 
 Mon, 16 Oct 2023 00:23:18 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s19-20020a05600c45d300b0040648217f4fsm6407011wmo.39.2023.10.16.00.23.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 00:23:17 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Cc: peterx@redhat.com,  farosas@suse.de,  leobras@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/4] migration: check for rate_limit_max for
 RATE_LIMIT_DISABLED
In-Reply-To: <20231011184358.97349-2-elena.ufimtseva@oracle.com> (Elena
 Ufimtseva's message of "Wed, 11 Oct 2023 11:43:55 -0700")
References: <20231011184358.97349-1-elena.ufimtseva@oracle.com>
 <20231011184358.97349-2-elena.ufimtseva@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 16 Oct 2023 09:23:16 +0200
Message-ID: <875y3758uz.fsf@secure.mitica>
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

Elena Ufimtseva <elena.ufimtseva@oracle.com> wrote:
> In migration rate limiting atomic operations are used
> to read the rate limit variables and transferred bytes and
> they are expensive. Check first if rate_limit_max is equal
> to RATE_LIMIT_DISABLED and return false immediately if so.
>
> Note that with this patch we will also will stop flushing
> by not calling qemu_fflush() from migration_transferred_bytes()
> if the migration rate is not exceeded.
> This should be fine since migration thread calls in the loop
> migration_update_counters from migration_rate_limit() that
> calls the migration_transferred_bytes() and flushes there.
>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


