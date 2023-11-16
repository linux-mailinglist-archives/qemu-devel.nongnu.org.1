Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 678617EE2BC
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 15:26:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3dJD-00016b-6N; Thu, 16 Nov 2023 09:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3dJ9-00015Y-1q
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:25:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1r3dJ5-00055x-EQ
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 09:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700144722;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=9Wqc4E+SeAwYIqfSAukcWD+ySCBrSbiPEqBz02d6V84=;
 b=bq0IJAEQH90Kit8FRM54+rtWq4//3zpS5qk93qlJzrt1BllqtZscv9iNSwRgKEIVgV2cHS
 UBqOTUcIQ9xYJzO1vTpb3w74PKFXLx0AnmK9svmYZ2czoSxJrA0CnxW00uDHdB7rpN6cw1
 gyeoyJ+0DVNIBd4YF9YiR6wlAEAabRc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-tuTReJvSOXqh6yjmHseejw-1; Thu, 16 Nov 2023 09:25:21 -0500
X-MC-Unique: tuTReJvSOXqh6yjmHseejw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32f790a39d2so392664f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 06:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700144719; x=1700749519;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Wqc4E+SeAwYIqfSAukcWD+ySCBrSbiPEqBz02d6V84=;
 b=wwzCkBmZfe+BOpam1Mi7Ii+NeJJsNCp0Uu1FpSWQVLwkfxLK4QztExY6i/dNoSzbaj
 l1+M1Fsm00Ed5wcWDoiCB4kVRkLHvulIrlNqKgfH9ZzRQGOOpMdjno79qiA1oUIk1sdO
 eNyo6Yo0toobr9yENe8NMY9DOxz8P6uXKsrK6Jzmx2HojV8YuYE1YwbvddwaZPx5I7Vs
 Jbo+CZVIFvBzu31U7fuJz/3hBmNaJTV4IMAVknEUxMmIwfLDhl30iUoi4LGR44MsPTcl
 pQMW82oFiNmipyUHwo653o68SpByNn1dX5iCcAmHrIgq5aOQQcun12WRCD82cLjYLlFT
 aXRA==
X-Gm-Message-State: AOJu0YxnEC+Yb9U2i1IWaIRfrZmYkSOuAS4P+ACA3ZapSJ6Qma1vyCL6
 B/D6ZXZdE1H53W22tqAvLLygq9yAzcT401Iyxus8ZwiCd0vYGtHCbBebGGdDRqFK0tE7yt06W5x
 sYqhcd8El/rvGvg4kza+IgcTM0w==
X-Received: by 2002:a05:6000:1202:b0:32d:9332:8168 with SMTP id
 e2-20020a056000120200b0032d93328168mr9553770wrx.54.1700144718929; 
 Thu, 16 Nov 2023 06:25:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2hJYbPl5LELqVowgZnw8wcrp+SpAt3TRIjwzAJRyt5kviG4OarmvmfXVtetLwwbRPzvxcxA==
X-Received: by 2002:a05:6000:1202:b0:32d:9332:8168 with SMTP id
 e2-20020a056000120200b0032d93328168mr9553760wrx.54.1700144718593; 
 Thu, 16 Nov 2023 06:25:18 -0800 (PST)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 d3-20020adfa403000000b00331424a1266sm13620210wra.84.2023.11.16.06.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 06:25:18 -0800 (PST)
From: Juan Quintela <quintela@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org,  qemu-trivial@nongnu.org
Subject: Re: [PATCH trivial 05/21] docs/about/deprecated.rst: spelling fix:
 becase
In-Reply-To: <20231114165834.2949011-6-mjt@tls.msk.ru> (Michael Tokarev's
 message of "Tue, 14 Nov 2023 19:58:18 +0300")
References: <20231114165834.2949011-1-mjt@tls.msk.ru>
 <20231114165834.2949011-6-mjt@tls.msk.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 16 Nov 2023 15:25:17 +0100
Message-ID: <87edgprd0y.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Michael Tokarev <mjt@tls.msk.ru> wrote:
> Fixes: 864128df465a "migration: Deprecate old compression method"
> Cc: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  docs/about/deprecated.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 78550c07bf..6c84db90b5 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -514,5 +514,5 @@ old compression method (since 8.2)
>  
>  Compression method fails too much.  Too many races.  We are going to
>  remove it if nobody fixes it.  For starters, migration-test
> -compression tests are disabled becase they fail randomly.  If you need
> +compression tests are disabled because they fail randomly.  If you need
>  compression, use multifd compression methods.

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


