Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B93B47EF3E8
	for <lists+qemu-devel@lfdr.de>; Fri, 17 Nov 2023 14:57:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3zKg-0007VL-Ba; Fri, 17 Nov 2023 08:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r3zKc-0007UZ-BD
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 08:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r3zKY-0005Y6-7r
 for qemu-devel@nongnu.org; Fri, 17 Nov 2023 08:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700229379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1j5ShJdoj7pcT0FsRjKZLgEt0+dDUXgMotla5M9tB2o=;
 b=OZaUfS/OX2FXnFdJmHZwvZ2TCCNYfPe23JEXkKogywGL18+TLe+LI87U72AdyA09bB/nLG
 T5gzmAaHP2S2FuN1Rowg9CSTSORenfNelqyK43fseFH8ImU1GWQQHPqLZwr623Fn4TQeQK
 2Jtk0mqJ/yMFY9X1AjqdKoNTZwUikRI=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Ewm1kGuFNqS2L9-fixEr0w-1; Fri, 17 Nov 2023 08:56:16 -0500
X-MC-Unique: Ewm1kGuFNqS2L9-fixEr0w-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-5b35732bcc4so3022737b3.1
 for <qemu-devel@nongnu.org>; Fri, 17 Nov 2023 05:56:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700229376; x=1700834176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1j5ShJdoj7pcT0FsRjKZLgEt0+dDUXgMotla5M9tB2o=;
 b=dBPc2KMKypQ+EV1XUFiAVUxSeHEEKKOoBDF8lFnwtzP7Sv02YaHhf26M6sfiPb8shN
 vi4e+BSHIozQ2MmD1JqOzvQ0NEhGStYf8+e2a7Mi1vujndRrdyRMeW9EBrd6n+D1SvvF
 52WWfbJ2D1XTok9ZpE1LUrSntU113H+GsF+lL4PE1wijopn1RupfPpWo3wTZ3MesMIC8
 07w9DoXsfSbwqrWQMjS3LNRIpR+SCVc1L+MiqLGSB7Hr6JWhsXYfZ+A0JvRQ/foF2bse
 u9P3nLOF7BeLYuhtx8GyrSqVnr/tFfK6TGSGV8m2SPAeKpyyP6lamXZgm9QAJARv676m
 nUAQ==
X-Gm-Message-State: AOJu0YwoJhWjrm8Y5kov3GJdL2AKsIuB1V82bnon3fvpbKmZuuLWzUqd
 w/Vo0ynIHqrtiTUhiAPP6rVcOy0ckenkNj9KzEZDrvlOooc7uCVyb7kmFWNPGLC9Uu3S9Y4SGLP
 jkTaMhXk4OKoRC+8=
X-Received: by 2002:a81:7613:0:b0:5a7:a818:c398 with SMTP id
 r19-20020a817613000000b005a7a818c398mr9016084ywc.4.1700229376287; 
 Fri, 17 Nov 2023 05:56:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhRRhIYSB9ge7aTZZUZS8fQOUdYOPj2ok4stMKlJJCU/Rz6NOje0Prt+ZheNCdWL0SsXm+Zg==
X-Received: by 2002:a81:7613:0:b0:5a7:a818:c398 with SMTP id
 r19-20020a817613000000b005a7a818c398mr9016075ywc.4.1700229376036; 
 Fri, 17 Nov 2023 05:56:16 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 kh5-20020a056214514500b0064906cfe430sm639046qvb.135.2023.11.17.05.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:56:15 -0800 (PST)
Date: Fri, 17 Nov 2023 08:56:13 -0500
From: Peter Xu <peterx@redhat.com>
To: Zongmin Zhou <zhouzongmin@kylinos.cn>
Cc: quintela@redhat.com, berrange@redhat.com, farosas@suse.de,
 leobras@redhat.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] migration: free 'saddr' since be no longer used
Message-ID: <ZVdw_XMJ4mKMFejd@x1n>
References: <ZVT1c3Ptd_P3Nfb_@x1n>
 <20231116063448.2333616-1-zhouzongmin@kylinos.cn>
 <87il61rdab.fsf@secure.mitica>
 <6dab8a5d-4982-41b6-92a0-f06c561969c3@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6dab8a5d-4982-41b6-92a0-f06c561969c3@kylinos.cn>
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

On Fri, Nov 17, 2023 at 10:51:18AM +0800, Zongmin Zhou wrote:
> > As Peter said, putting a comment why we don't use
> > qapi_free_SocketAddress() will be a good idea.
> 
> I have put some comments on patch v2 to explain

Normally we use "comment" to represent direct comment in the code.  You
explained it in the "commit message". :)

That explanation is good enough to me, you can add a summary comment in the
code too.  Something like:

  /* Don't free the objects inside; their ownership moved to "addr" */

-- 
Peter Xu


