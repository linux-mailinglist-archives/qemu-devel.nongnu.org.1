Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE6C7B9B72
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 09:43:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoJ1K-00043m-Aa; Thu, 05 Oct 2023 03:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoJ1H-00042B-Fp
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qoJ1E-0003tc-IR
 for qemu-devel@nongnu.org; Thu, 05 Oct 2023 03:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696491815;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=uRqTlCXZ7hP7IUhfQgXV92RFGFzv02bQ+S8bo90olZY=;
 b=HyWq81aRj/9A+Vgc6hyYkVsgJzvC57tllT0IZY6g5oTBRo9KVtHuj8JAPLvas8weXVQLwj
 uUgbHDAFX7fxMk2/BOd2d60651w+2WYQKFLcCzw3+sEAd3OJOqWNWhwepFW2amVteviPjp
 r+XzzzowEm+XAKkfdJbOSnZC2AXPf3U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-fHmVKdgYOC2JGnRNl_8azA-1; Thu, 05 Oct 2023 03:43:32 -0400
X-MC-Unique: fHmVKdgYOC2JGnRNl_8azA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3172a94b274so499143f8f.0
 for <qemu-devel@nongnu.org>; Thu, 05 Oct 2023 00:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696491811; x=1697096611;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uRqTlCXZ7hP7IUhfQgXV92RFGFzv02bQ+S8bo90olZY=;
 b=CyZhY1SHEvRA/PR1y60STtozWD9Dar1falhQCGK4SdNl8J1FTE+bJJUg7XKrKDRZfz
 YFJ/Dn74XBBAafuBIWOdquUj7cuExXK0Uk26UVV9aFMX/Wspn4ctfOzalE0bjGfxZV41
 3L/jNRzOtvn7LeXBFPlLL4BSa73xyeunRh/+U45txprL26krCI8wl/Hi9+MgZrEt35HF
 d15MHjIJMe+hAvuznyFywFuP8kiN3RbXWAL/N1qomxYOree548Yop+OTrphyT+re+CSe
 ptoDtA+BZLh02jVnLISAm1WLCqX9RqlNK2WAsOgkuaKLwrQhsURspyvFopF+9pD0LLa9
 2Y8g==
X-Gm-Message-State: AOJu0YyoMINEHQ5fyVJ5iYVZj13JFrWvGS4tUVy+3WbZVfSDIjgWSOD7
 Jx9VTDZfjq8FNU19GNRTv0WHWGP2+CBWS2Xh8CacnI96EgGAItLlsyYrryLmolPRIt4igvlsosP
 XVdK3J3boAxMMwn0=
X-Received: by 2002:a05:6000:1b09:b0:31f:e534:2d6f with SMTP id
 f9-20020a0560001b0900b0031fe5342d6fmr4239221wrz.11.1696491811514; 
 Thu, 05 Oct 2023 00:43:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkT3NI5dvoEj5yp2Dc12YHoGUQ7JDaKhLWbC5j8E2c7ksoowDjWahUhxEUypxSB1DpGf3Sow==
X-Received: by 2002:a05:6000:1b09:b0:31f:e534:2d6f with SMTP id
 f9-20020a0560001b0900b0031fe5342d6fmr4239210wrz.11.1696491811210; 
 Thu, 05 Oct 2023 00:43:31 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 s4-20020adff804000000b00327db11731csm1104817wrp.22.2023.10.05.00.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 00:43:30 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v3 06/10] migration: Remember num of ramblocks to sync
 during recovery
In-Reply-To: <20231004220240.167175-7-peterx@redhat.com> (Peter Xu's message
 of "Wed, 4 Oct 2023 18:02:36 -0400")
References: <20231004220240.167175-1-peterx@redhat.com>
 <20231004220240.167175-7-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Thu, 05 Oct 2023 09:43:30 +0200
Message-ID: <87a5sxpl99.fsf@secure.mitica>
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

Peter Xu <peterx@redhat.com> wrote:
> Instead of only relying on the count of rp_sem, make the counter be part of
> RAMState so it can be used in both threads to synchronize on the process.
>
> rp_sem will be further reused in follow up patches, as a way to kick the
> main thread, e.g., on recovery failures.
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

queued.


