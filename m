Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85ABD7AF59B
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 23:03:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlFCJ-0005uz-9E; Tue, 26 Sep 2023 17:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlFCG-0005ue-Uh
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 17:02:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qlFCC-0000hi-7Y
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 17:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695762135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rBRiuxFl3Rmx3ncMjJVTBDJ0YR16sQPNXRva674EGg4=;
 b=B9XZHYyokIFDlHx/Q28/7Or9bpCQ02SL0T+YgM39iN5UMM9tyQSzKN0r0ciWv4ouYgeD3l
 7G7CSdZM7yNrwnKs2lq4SVqBgIQze32rpiH+DcADaSozLtGQamOdD6lGB4UkwzOhGpRcjr
 gS9PS2Mj8AAaISdvZ+T356n+pa9/n7w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-WHuA2eKONdKHYeo3xQZvag-1; Tue, 26 Sep 2023 17:02:12 -0400
X-MC-Unique: WHuA2eKONdKHYeo3xQZvag-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7742bd869e4so231652785a.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 14:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695762132; x=1696366932;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rBRiuxFl3Rmx3ncMjJVTBDJ0YR16sQPNXRva674EGg4=;
 b=ZVgWF/LdupSqOeBXIJUaXang7Kf0VwkCFF0RtaE4i8CJwbG1qItINSux6Y6I7T+Moc
 XcXx9RGxXzxbmdsjZSpRDeOwQe5i4Drb7tp8fTpAAgO0OSvP66IiccGB6ey/OS3yiGf7
 UgP4i2mqTLI3DsA+guSoVaYWNTtyfwrSxN7cvfysbEK4jE0rTCJxV2BTbY2ueif8Zi67
 uW4TpGj8wmQbJYha1VnRfl9rtdj30yVQnT8BWku3YRhmYG0tdN9AqXlofNjcPW2JtLqj
 Wkl9GXvk9Qv7biQ+eX1rQ+tixkqjiF+F5YZi85A/p0pCh6/qeztj1icr9iGCL/JZqwMC
 hyLg==
X-Gm-Message-State: AOJu0YzubUXALZxr2ZFrMndh8UoZ8Qb+FBh1PwM7HB58FQQIfDScJ6KO
 tLLpgaPmM3wBQWtCWQxR9B56XJ7/q456cAgaKKoT1RaoN9a8C7C8zuSyZ1zspb8FM0jia2B7BfZ
 o2LWDSs7MDFIppz4=
X-Received: by 2002:a05:620a:1920:b0:774:17d6:31f1 with SMTP id
 bj32-20020a05620a192000b0077417d631f1mr11670755qkb.4.1695762132363; 
 Tue, 26 Sep 2023 14:02:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy/VWrNYS/k4VtFTPFppXAqGdPvBoYpU/wDpoP8WWD/KnLqOZc9fugAsydu6Apoqln6104BQ==
X-Received: by 2002:a05:620a:1920:b0:774:17d6:31f1 with SMTP id
 bj32-20020a05620a192000b0077417d631f1mr11670731qkb.4.1695762132055; 
 Tue, 26 Sep 2023 14:02:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 j30-20020a05620a001e00b0076d74da4481sm1761525qki.23.2023.09.26.14.02.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 14:02:11 -0700 (PDT)
Date: Tue, 26 Sep 2023 17:01:38 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru
Subject: Re: [PATCH 0/2] i386/a-b-bootblock: zero the first byte of each page
 on start
Message-ID: <ZRNGspuTX84gStfe@x1n>
References: <20230907192944.1609099-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230907192944.1609099-1-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Sep 07, 2023 at 10:29:42PM +0300, Daniil Tatianin wrote:
> This series fixes an issue where the outcome of the migration qtest
> relies on the initial memory contents all being the same across the
> first 100MiB of RAM, which is a very fragile invariant.
> 
> We fix this by making sure we zero the first byte of every testable page
> in range beforehand.

What's the difference between this one and:

https://lore.kernel.org/r/20230907193051.1609310-1-d-tatianin@yandex-team.ru

?

Thanks,

-- 
Peter Xu


