Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 618C5831302
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 08:12:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQMYw-0005vN-Lf; Thu, 18 Jan 2024 02:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQMYu-0005vB-Vi
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:11:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQMYt-0005Uw-GT
 for qemu-devel@nongnu.org; Thu, 18 Jan 2024 02:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705561898;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgFWVVSB1OFuZQEMR7wT/9ElvdBfEdHFbhgTtH3wfx4=;
 b=OeGZiklz+IGuS+JfPOc66VCHkkDH5xTiaWJUNs263D5NYdkVdjp17EPPa6JOBlKVmWOL9P
 rbtCq5gx8QvEsWM4q/n1zIaXoSHzQ8kKiFoqQRoxJWF1M5l1ENGHOwJUY8023c2uWMAEug
 6tffmkmli2LV6QuWkN0N5jK5FlRYK80=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-DGtY5EdkPJCYyMUSlL24EQ-1; Thu, 18 Jan 2024 02:11:36 -0500
X-MC-Unique: DGtY5EdkPJCYyMUSlL24EQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6da5a9defd5so3231064b3a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 23:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705561895; x=1706166695;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HgFWVVSB1OFuZQEMR7wT/9ElvdBfEdHFbhgTtH3wfx4=;
 b=ZNFg9tWXb/74KwxumEILgylDjc/6y3Y5+pXuno4qhf8YPub6PnMEScLJZNDNDpLArR
 /4S+l5az3hpC0R92D3f7om+nToYB7xaki27fhkPHtqEiKBRUeH3JuEnyYlQoKVaBDxmM
 kJmNZ17pQ+UXBTHwHVdNa1mJuiBr7sN8ZmLfjfAFY1oUkcOY9FvFAM2btwWASyCsDlRa
 EKzZrhopSw+TRSXD8KsI67hX3FQExmaXeF/hO04Lw3GYRqllSK2uBSJDk3ug7GG9PK65
 71IWKXXr4a56siIRl4q5jmKLmTxUdn6s0+sZVv3toIR8WbvidzmgTyRG1g83kAfhuGQU
 /fpg==
X-Gm-Message-State: AOJu0YwqnDCNPqs5KfLCdJdYZKZ6BbWyI0sthNqXuEzmoFPUueBNFgpO
 xpbTjadBgrC/ZTY0gLYDheydWUB2/e8/KD9dtpvsgKB2/rHzo6T7D0s2yfCLbCXMIRhFWXBVK5k
 Qms2giMg8eoud4aHgZ6WkTSrxg+xwGLbmf3ABUCcK5m0F69USerTgl4QdBiC1
X-Received: by 2002:a05:6a00:3909:b0:6d8:f420:da04 with SMTP id
 fh9-20020a056a00390900b006d8f420da04mr931607pfb.0.1705561895676; 
 Wed, 17 Jan 2024 23:11:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAwub4Hmnhlv0O5J0ZErdYFDl8EJhttf5UksBh8cGVMPjdI2CsKpCNkWkwpjCzwPLJYN/39Q==
X-Received: by 2002:a05:6a00:3909:b0:6d8:f420:da04 with SMTP id
 fh9-20020a056a00390900b006d8f420da04mr931595pfb.0.1705561895431; 
 Wed, 17 Jan 2024 23:11:35 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 y15-20020a62f24f000000b006d93ca7f8f3sm2551701pfl.150.2024.01.17.23.11.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 23:11:35 -0800 (PST)
Date: Thu, 18 Jan 2024 15:11:29 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 13/30] migration/multifd: Add outgoing
 QIOChannelFile support
Message-ID: <ZajPIcseQjpJ5GUs@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-14-farosas@suse.de> <ZaYApbyD5iexbYYW@x1n>
 <87bk9lxutv.fsf@suse.de> <ZaePsW2Q90se0gi3@x1n>
 <87il3rdftx.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87il3rdftx.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Wed, Jan 17, 2024 at 02:34:18PM -0300, Fabiano Rosas wrote:
> Well this sequence:
> 
> multifd_new_send_channel_async() -> multifd_channel_connect() ->
> multifd_tls_channel_connect() -> new thread ->
> multifd_tls_handshake_thread() -> new task ->
> multifd_tls_outgoing_handshake() -> multifd_channel_connect()
> 
> ...is not what I would call intuitive. Specifically with
> multifd_channel_connect() being called more than the number of multifd
> channels.
> 
> This would be "not a mess" IMO:
> 
> for (i = 0; i < migrate_multifd_channels(); i++) {
>     multifd_tls_channel_connect();
>     multifd_channel_connect() -> 
>         qemu_thread_create(..., multifd_send_thread);
> }

Ah, I see what you meant now, yes I agree.  Let's see whether we can have a
simple procedure for file first, then the possibility to make the socket
path closer to file.

TLS could be another story, I'm guessing Dan could have good reasons to do
it like that, but we can rethink after we settle the file specific paths.

-- 
Peter Xu


