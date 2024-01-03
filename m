Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 876AF822871
	for <lists+qemu-devel@lfdr.de>; Wed,  3 Jan 2024 07:37:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKusT-0004Z3-9H; Wed, 03 Jan 2024 01:37:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rKusQ-0004YX-Lk
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 01:37:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rKusO-0002pV-O6
 for qemu-devel@nongnu.org; Wed, 03 Jan 2024 01:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704263835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xM3e1/VIg57HXRvd3saST/2mIKlgqva7fT2+R/qjAeU=;
 b=TOm2449BpPbArfq0GnB+ImFAosEGZz5h1Lzh2uT3kelE5EcffwDz/38LFovMO+hrmQGxEQ
 mlOKCuyZixuSERx8STxjapKDRtOerdwIt95DT4Ttqhi+P18mSdXTCONeoyPiJTBvK3tImo
 mhfPbEDTG/47PQSSrgz4XM0tkPkoURM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-jF9DTe9XNCqgpFyL7MlJrA-1; Wed, 03 Jan 2024 01:37:14 -0500
X-MC-Unique: jF9DTe9XNCqgpFyL7MlJrA-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28c0765415eso1988914a91.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 22:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704263833; x=1704868633;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xM3e1/VIg57HXRvd3saST/2mIKlgqva7fT2+R/qjAeU=;
 b=ApuM/ufKISvQ6+0r/6RGzjCCGNNMhBmrjg5Kyh4xcrmE7C6DSuw1TbYhgnFaV+h89e
 felnZy3mMT6YghZefnJ9AOAfZjLRw+ICpGvZkaXzTnqdxugHWQ7JkHd2aGZ2+aJw9BBl
 gmK5fwJ7JKuh03w7CiWHL626J9x7cqZ77ZYLAuyzuCeSbqvUE5yuR6tBs0HMb7JOeLwF
 ibgKLENf22LUAfU9Dw3CYusrrMb09hLYvU1CYUCCqeFv3vSyzH3xSS/rwCmAM/4GxFqe
 SVzWNNzUs5YOZm1qKNt3/UgC1q7DUi4xPcIxpNG9JxyTeQH5D+NkxyiVt04XJ0usf0ye
 WgZw==
X-Gm-Message-State: AOJu0Yx6CKFWm5BwLcANlCkvHa104U0arg+U9SO5IxcvItcvvuhYF+eT
 cZ9zqn6RIs/5tR//1CBG0SDOaAgzUGd2Lmy9s7yqa5EcpJP/NEcRzNMTIEZSHPZSH5MMrc51Kqh
 QmW2cNum5YBzlrsNqKYozQN4=
X-Received: by 2002:a17:902:d389:b0:1d4:f1c:6363 with SMTP id
 e9-20020a170902d38900b001d40f1c6363mr37118761pld.3.1704263833460; 
 Tue, 02 Jan 2024 22:37:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFiEvvV2pmvRgxexprvMhlAf/kRtO4Mfn0XAic96655R/8yAS9kUh5s1M7tP696bgaqO2Jww==
X-Received: by 2002:a17:902:d389:b0:1d4:f1c:6363 with SMTP id
 e9-20020a170902d38900b001d40f1c6363mr37118746pld.3.1704263833151; 
 Tue, 02 Jan 2024 22:37:13 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 m7-20020a170902bb8700b001d486882d79sm11655836pls.179.2024.01.02.22.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 22:37:12 -0800 (PST)
Date: Wed, 3 Jan 2024 14:37:06 +0800
From: Peter Xu <peterx@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@trasno.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 1/1] Leaving Migration
Message-ID: <ZZUAkgpHmo0TL1WX@x1n>
References: <20240102201908.1987-1-quintela@redhat.com>
 <20240102201908.1987-2-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240102201908.1987-2-quintela@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.178,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jan 02, 2024 at 09:19:07PM +0100, Juan Quintela wrote:
> I am leaving Red Hat, and as part of that I am leaving Migration
> maintenarship.
> 
> You are left in good hands with Peter and Fabiano.
> 
> Thanks for all the fish.
> 
> Signed-off-by: Juan Quintela <quintela@redhat.com>

We lose two entries for migration in just a few days.  That's always sad.

Since I joined QEMU late, so I don't know much for the past, but besides
those many migration patches that I already saw, you're also the first room
mate for my first KVM forum visit.  I just need more English KongFu to
digest all the jokes, and I'm still trying to improve (even not much. :-).

Thanks for all the work and help, and it's my honor to have worked with you
and also Dave. I wish QEMU can have a CREDITS file, but I didn't yet find
one.  This will be in the next pull, no matter from Fabiano or myself.

Thanks,

-- 
Peter Xu


